/**
 * Operating Mode Switcher Extension
 *
 * Three operating modes cycled with /mode command:
 *
 *   auto   – Default mode. Full tool access (read, edit, write, bash). Do what the user asks.
 *   ask    – Read-only mode. Investigate and answer questions. No file modifications.
 *   plan   – Planning mode. Create a detailed implementation plan in a temporary markdown file.
 *            Ask clarifying questions, then present a plan the user can accept or refine.
 *            Accepting the plan switches to auto mode to implement it.
 *
 * Usage:
 *   /mode            – cycle through auto → ask → plan → auto
 *   /mode auto       – switch to auto mode
 *   /mode ask        – switch to ask mode
 *   /mode plan       – switch to plan mode
 *
 * Plan mode features:
 *   Maintains a PLAN.md file in the project root (.pi/PLAN.md).
 *   On plan completion, shows a dialog: accept (→ auto) or refine.
 *   On refine, prompts for feedback, then re-generates the plan.
 */

import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

// ── Constants ──────────────────────────────────────────────────────────

export type OperatingMode = "auto" | "ask" | "plan";

const MODE_ORDER: OperatingMode[] = ["auto", "ask", "plan"];

const MODE_CONFIG: Record<OperatingMode, {
  label: string;
  icon: string;
  tools: string[];
  instructions: string;
  color: string;
  description: string;
}> = {
  auto: {
    label: "Auto",
    icon: "▶",
    tools: ["read", "bash", "edit", "write", "grep", "find", "ls"],
    description: "Full access – build what you're asked",
    color: "success",
    instructions:
      "You are in AUTO MODE. Execute the user's requests efficiently and end-to-end. " +
      "Use all available tools (read, edit, write, bash) to implement changes. " +
      "Make decisions and act. Run tests or checks when appropriate. Be thorough and independent.",
  },
  ask: {
    label: "Ask",
    icon: "🔍",
    tools: ["read", "grep", "find", "ls"],
    description: "Read-only – investigate and answer questions",
    color: "accent",
    instructions:
      "You are in ASK MODE. This is a read-only mode. " +
      "You CANNOT use edit, write, or bash commands that modify files. " +
      "Investigate the codebase and answer the user's questions. " +
      "Read files fully, search for relevant code, explain what you find. " +
      "Do NOT make any changes. Just investigate and report.",
  },
  plan: {
    label: "Plan",
    icon: "📋",
    tools: ["read", "grep", "find", "ls"],
    description: "Planning – create a detailed implementation plan",
    color: "warning",
    instructions:
      "You are in PLAN MODE. This is a read-only mode. " +
      "You CANNOT use edit, write, or bash commands that modify files. " +
      "Your goal is to create a detailed implementation plan for the user's task. " +
      "Read the codebase thoroughly, ask clarifying questions if needed, " +
      "then produce a structured plan covering:\n" +
      "- What needs to be done and why\n" +
      "- Step-by-step implementation instructions\n" +
      "- Files that will be modified and how\n" +
      "- Potential risks, edge cases, and dependencies\n" +
      "- Tests or checks that should be run\n" +
      "\n" +
      "Write your plan to a file at .pi/PLAN.md in the project root. " +
      "Include a '## Status' section with a TODO list at the top. " +
      "Each TODO item should be on its own line as a markdown checkbox: [ ] Step description\n" +
      "After writing the plan, present it to the user and ask if they want to accept or refine it.",
  },
};

const PLAN_FILE = ".pi/PLAN.md";

// ── State ──────────────────────────────────────────────────────────────

let currentMode: OperatingMode = "auto";
let planAcceptRequested = false; // set to true when we should prompt user after plan is written

// ── Helpers ────────────────────────────────────────────────────────────

/** Get the absolute path to the plan file */
function getPlanFilePath(cwd: string): string {
  return join(cwd, PLAN_FILE);
}

/** Extract TODO items from the Status section of a plan file */
function extractPlanStatus(planContent: string): string[] {
  const statusMatch = planContent.match(/## Status\s*\n([\s\S]*?)(?=\n## |\n*$)/);;
  if (!statusMatch) return [];
  const lines = statusMatch[1].split("\n");
  return lines
    .map((l) => l.trim())
    .filter((l) => l.startsWith("[ ]") || l.startsWith("[x]") || l.startsWith("[X]"));
}

/** Check if a bash command is safe (read-only) */
function isSafeCommand(command: string): boolean {
  // Allowed: cat, head, tail, less, grep, find, ls, pwd, echo, wc, sort, diff, file, stat, du, df,
  //          which, whereis, env, uname, whoami, id, date, ps, top, htop, free, git status/log/diff/show/branch/remote/config --get,
  //          npm list/ls/view/info/search/outdated/audit, rg, fd, bat, jq, awk, sed -n, curl, wget
  const safePatterns = [
    /^\s*cat\b/,
    /^\s*head\b/,
    /^\s*tail\b/,
    /^\s*less\b/,
    /^\s*more\b/,
    /^\s*grep\b/,
    /^\s*find\b/,
    /^\s*ls\b/,
    /^\s*pwd\b/,
    /^\s*echo\b/,
    /^\s*printf\b/,
    /^\s*wc\b/,
    /^\s*sort\b/,
    /^\s*uniq\b/,
    /^\s*diff\b/,
    /^\s*file\b/,
    /^\s*stat\b/,
    /^\s*du\b/,
    /^\s*df\b/,
    /^\s*which\b/,
    /^\s*whereis\b/,
    /^\s*env\b/,
    /^\s*printenv\b/,
    /^\s*uname\b/,
    /^\s*whoami\b/,
    /^\s*id\b/,
    /^\s*date\b/,
    /^\s*uptime\b/,
    /^\s*ps\b/,
    /^\s*top\b/,
    /^\s*htop\b/,
    /^\s*free\b/,
    /^\s*npm\s+(list|ls|view|info|search|outdated|audit)\b/i,
    /^\s*yarn\s+(list|info|why|audit)\b/i,
    /^\s*rg\b/,
    /^\s*fd\b/,
    /^\s*bat\b/,
    /^\s*eza\b/,
    /^\s*jq\b/,
    /^\s*sed\s+-n\b/i,
    /^\s*awk\b/,
    /^\s*curl\s/i,
    /^\s*wget\s+-O\s*-/i,
    /^\s*npx\s+(list|ls|view|info|search|outdated|audit)\b/i,
    /^\s*node\s+--version\b/i,
    /^\s*python\s+--version\b/i,
  ];

  const isSafe = safePatterns.some((p) => p.test(command));

  if (isSafe) return true;

  // Block anything obviously write-y
  const dangerousPatterns = [
    /\brm\b/i,
    /\brmdir\b/i,
    /\bmv\b/i,
    /\bcp\b/i,
    /\bmkdir\b/i,
    /\btouch\b/i,
    /\bchmod\b/i,
    /\bchown\b/i,
    /\bsudo\b/i,
    /\bsu\b/i,
    /\bkill\b/i,
    /\breboot\b/i,
    /\bshutdown\b/i,
    /\b(vim?|nano|emacs|code|subl)\b/i,
    /(?:^|[^<])(?!>)>/,
    />>/,
    /\bnpm\s+(install|uninstall|update|ci|link|publish)\b/i,
    /\byarn\s+(add|remove|install|publish)\b/i,
    /\bpnpm\s+(add|remove|install|publish)\b/i,
    /\bpip\s+(install|uninstall)\b/i,
    /\bapt(-get)?\s+(install|remove|purge|update|upgrade)\b/i,
    /\bbrew\s+(install|uninstall|upgrade)\b/i,
    /\bgit\s+(add|commit|push|pull|merge|rebase|reset|checkout|branch\s+-[dD]|stash|cherry-pick|revert|tag|init|clone)\b/i,
    /\bsystemctl\s+(start|stop|restart|enable|disable)\b/i,
  ];

  return !dangerousPatterns.some((p) => p.test(command));
}

// ── Extension factory ──────────────────────────────────────────────────

export default function modeSwitcherExtension(pi: ExtensionAPI): void {
  function applyMode(mode: OperatingMode, ctx: ExtensionContext): void {
    const config = MODE_CONFIG[mode];

    pi.setActiveTools(config.tools);
    planAcceptRequested = false;

    ctx.ui.setStatus("mode", ctx.ui.theme.fg(config.color as any, `${config.icon} ${config.label}`));
    currentMode = mode;

    // Persist state
    pi.appendEntry("mode-switcher-state", { mode });
  }

  function cycleMode(ctx: ExtensionContext): void {
    const idx = MODE_ORDER.indexOf(currentMode);
    const next = MODE_ORDER[(idx + 1) % MODE_ORDER.length];
    applyMode(next, ctx);
  }

  // ── Register /mode command ──────────────────────────────────────────

  pi.registerCommand("mode", {
    description: "Switch operating mode (auto | ask | plan)",
    getArgumentCompletions: (prefix: string) => {
      const items = MODE_ORDER.map((m) => ({ value: m, label: `${m} – ${MODE_CONFIG[m].description}` }));
      return prefix ? items.filter((i) => i.value.startsWith(prefix)) : items;
    },
    handler: async (args, ctx) => {
      if (!args || !args.trim()) {
        // No argument: cycle through modes
        cycleMode(ctx);
        const config = MODE_CONFIG[currentMode];
        ctx.ui.notify(`Mode: ${config.icon} ${config.label} – ${config.description}`, "info");
        return;
      }

      const mode = args.trim().toLowerCase() as OperatingMode;
      if (!(mode in MODE_CONFIG)) {
        const available = MODE_ORDER.join(", ");
        ctx.ui.notify(`Unknown mode "${mode}". Available: ${available}`, "error");
        return;
      }

      applyMode(mode, ctx);
      const config = MODE_CONFIG[mode];
      ctx.ui.notify(`Mode: ${config.icon} ${config.label} – ${config.description}`, "info");
    },
  });

  // ── Inject per-mode instructions into system prompt ─────────────────

  pi.on("before_agent_start", async (event) => {
    const config = MODE_CONFIG[currentMode];
    return {
      systemPrompt: `${event.systemPrompt}\n\n${config.instructions}`,
    };
  });

  // ── Gate destructive operations in ask and plan modes ───────────────

  pi.on("tool_call", async (event) => {
    // Block edit/write tool entirely in ask/plan modes
    if ((currentMode === "ask" || currentMode === "plan") && (event.toolName === "edit" || event.toolName === "write")) {
      return {
        block: true,
        reason: `Blocked: ${currentMode} mode is read-only. Use /mode auto to enable file modifications.`,
      };
    }

    // Block destructive bash commands in ask/plan modes
    if ((currentMode === "ask" || currentMode === "plan") && event.toolName === "bash") {
      const command = event.input.command as string;
      if (!isSafeCommand(command)) {
        return {
          block: true,
          reason: `Blocked: ${currentMode} mode only allows read-only commands. Use /mode auto to enable full bash access.`,
        };
      }
    }
  });

  // ── Handle plan mode: detect plan file writes and prompt user ───────
  // We detect when the agent writes to .pi/PLAN.md, then after the turn
  // completes, show a dialog to accept, refine, or keep planning.

  function promptForPlan(ctx: ExtensionContext, planContent: string, steps: string[]): void {
    ctx.ui.notify(`Plan saved to ${PLAN_FILE} – ${steps.length} steps`, "info");

    // Show dialog to accept or refine
    ctx.ui.select("Plan mode", [
      "Accept plan and switch to auto mode",
      "Refine the plan",
      "Keep planning (ask more questions)",
    ]).then(async (choice) => {
      if (!choice) return;

      if (choice === "Accept plan and switch to auto mode") {
        applyMode("auto", ctx);
        const config = MODE_CONFIG["auto"];
        ctx.ui.notify(
          `Mode: ${config.icon} ${config.label} – ${config.description}`,
          "info",
        );

        // Queue implementation message
        const todoList = steps.map((s, i) => `${i + 1}. ${s}`).join("\n");
        pi.sendMessage(
          {
            customType: "mode-switcher",
            content: `**Plan accepted.** Implementing the following plan:\n\n${todoList}\n\nStart with step 1.`,
            display: true,
          },
          { triggerTurn: true, deliverAs: "steer" },
        );
      } else if (choice === "Refine the plan") {
        const planAbsPath = getPlanFilePath(ctx.cwd);
        const refined = await ctx.ui.editor(
          "Refine the plan:\n\n---\n" + planContent.slice(0, 5000) + (planContent.length > 5000 ? "\n...(truncated)..." : ""),
          "",
        );

        if (refined && refined.trim()) {
          writeFileSync(planAbsPath, refined.trim(), "utf8");
          // Let the agent continue with the refined plan
          pi.sendMessage(
            {
              customType: "mode-switcher",
              content: `Plan refined. Please regenerate the plan based on the updates above.`,
              display: true,
            },
            { triggerTurn: true, deliverAs: "steer" },
          );
        }
      } else {
        // Keep planning – prompt the agent to ask clarifying questions
        pi.sendMessage(
          {
            customType: "mode-switcher",
            content: `Please continue exploring and refine the plan. Ask clarifying questions if needed.`,
            display: true,
          },
          { triggerTurn: true, deliverAs: "steer" },
        );
      }
    });
  }

  pi.on("tool_result", async (event) => {
    if (currentMode !== "plan") return;
    if (planAcceptRequested) return;
    if (event.toolName !== "write") return;

    const path = event.input?.path as string | undefined;
    if (!path) return;

    // Check if this was a write to PLAN.md
    const absPath = join(ctx.cwd, path);
    const planAbsPath = getPlanFilePath(ctx.cwd);

    if (absPath !== planAbsPath) return;

    planAcceptRequested = true;

    // Read the plan file
    let planContent: string;
    try {
      planContent = readFileSync(planAbsPath, "utf8");
    } catch {
      planAcceptRequested = false;
      return;
    }

    const steps = extractPlanStatus(planContent);
    promptForPlan(ctx, planContent, steps);
  });

  // ── Restore state on session start ──────────────────────────────────

  pi.on("session_start", async (_event, ctx) => {
    const entries = ctx.sessionManager.getEntries();
    const stateEntry = entries
      .filter(
        (e: { type: string; customType?: string }) =>
          e.type === "custom" && e.customType === "mode-switcher-state",
      )
      .pop() as { data?: { mode: OperatingMode } } | undefined;

    if (stateEntry?.data?.mode && MODE_ORDER.includes(stateEntry.data.mode)) {
      currentMode = stateEntry.data.mode;
    } else {
      currentMode = "auto";
    }

    applyMode(currentMode, ctx);
  });
}
