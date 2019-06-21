function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color --bold red)"#"

    # Main
    echo -n (set_color --bold white)(prompt_pwd) (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '(set_color normal)
    # echo -n (set_color --bold green)(prompt_pwd) (set_color yellow)'❯ '
end

set orange --bold ffa322

set fish_color_autosuggestion cyan
set fish_color_command normal
set fish_color_comment black
set fish_color_cwd magenta
set fish_color_cwd_root magenta
set fish_color_end $orange
set fish_color_error red
set fish_color_escape $orange
set fish_color_history_current cyan
set fish_color_host normal
set fish_color_match --bold blue
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param blue
set fish_color_quote green
set fish_color_redirection yellow
set fish_color_search_match $orange --background=black
set fish_color_selection $orange #blue
set fish_color_status red
set fish_color_user red
set fish_pager_color_completion blue
set fish_pager_color_description yellow
set fish_pager_color_prefix cyan
set fish_pager_color_progress cyan
