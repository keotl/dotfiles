
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq inhibit-startup-screen t)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(set-face-attribute 'default nil :font "Fira Mono-11")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ac-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key (kbd "C-x o") 'ace-window)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-à") 'company-complete) 








;;; xresources-theme.el --- Use your .Xresources as your emacs theme

;; Copyright (C) 2014-2014 Marten Lienen <marten.lienen@gmail.com>

;; Author: Marten Lienen <marten.lienen@gmail.com>
;; Keywords: xresources, theme
;; Package-Version: 20160331.702
;; Version: 0.2.0

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation; either version 3, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.
;;
;; You should have received a copy of the GNU General Public License along with
;; GNU Emacs; see the file COPYING.  If not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
;; USA.

;;; Commentary:

;; Use the colors defined in your .Xresources as your emacs theme

;;; Code:

(defun xresources-theme-color (name)
  "Read the color NAME (e.g. color5) from the X resources."
  (x-get-resource name ""))

(deftheme xresources "~/.Xresources as a theme")

(let* ((foreground "#d9d8d8")
       (background "#1D1F21")
       (black "#231f20")
       (red "#ff4f4f")
       (green "#17de4c")
       (yellow "#ffd212")
       (blue "#10a5e1")
       (magenta "#f84ed0" )
       (cyan "#6dd8d1")
       (gray "#d9d8d8")

       (light-gray "#231f20")
       (light-red "#ff4f4f")
       (light-green "#17de4c")
       (light-yellow "#ffd212")
       (light-blue "#10a5e1")
       (light-magenta "#f84ed0" )
       (light-cyan "#6dd8d1")
       (white "#ffffff"))
  (custom-theme-set-faces
   'xresources

   ;; Built-in
   ;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,yellow :underline t :weight normal))))
   `(default ((t (:foreground ,foreground :background ,background))))
   `(cursor ((t (:foreground ,foreground :background ,foreground))))
   `(escape-glyph ((t (:foreground ,yellow :bold t))))
   `(fringe ((t (:foreground ,foreground :background ,background))))
   `(header-line ((t (:foreground ,yellow
                                  :background ,background
                                  :box (:line-width -1 :style released-button)))))
   `(highlight ((t (:background ,background))))
   `(success ((t (:foreground ,green :weight bold))))
   `(warning ((t (:foreground ,red :weight bold))))

   ;; compilation
   `(compilation-column-face ((t (:foreground ,yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,green))))
   `(compilation-error-face ((t (:foreground ,red :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,foreground))))
   `(compilation-info-face ((t (:foreground ,blue))))
   `(compilation-info ((t (:foreground ,green :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,green))))
   `(compilation-line-face ((t (:foreground ,yellow))))
   `(compilation-line-number ((t (:foreground ,yellow))))
   `(compilation-message-face ((t (:foreground ,blue))))
   `(compilation-warning-face ((t (:foreground ,red :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,green :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,yellow :weight bold))))

   ;; grep
   `(grep-context-face ((t (:foreground ,foreground))))
   `(grep-error-face ((t (:foreground ,red :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,blue))))
   `(grep-match-face ((t (:foreground ,red :weight bold))))
   `(match ((t (:background ,background :foreground ,red :weight bold))))

   ;; isearch
   `(isearch ((t (:foreground ,yellow :weight bold :background ,background))))
   `(isearch-fail ((t (:foreground ,foreground :background ,red))))
   `(lazy-highlight ((t (:foreground ,yellow :weight bold :background ,background))))

   `(menu ((t (:foreground ,foreground :background ,background))))
   `(minibuffer-prompt ((t (:foreground ,yellow))))
   `(mode-line
     ((t (:foreground ,green
                      :background ,background
                      :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,green
                      :background ,background
                      :box (:line-width -1 :style released-button)))))
   `(region ((t (:background ,"#0C0037"))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,background))))
   `(trailing-whitespace ((t (:background ,red))))
   `(vertical-border ((t (:foreground ,foreground))))

   ;; font lock
   `(font-lock-builtin-face ((t (:foreground ,foreground :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,green))))
   `(font-lock-constant-face ((t (:foreground ,green))))
   `(font-lock-doc-face ((t (:foreground ,green))))
   `(font-lock-function-name-face ((t (:foreground ,cyan))))
   `(font-lock-keyword-face ((t (:foreground ,yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,yellow :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,blue))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,yellow :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,red))))
   `(font-lock-type-face ((t (:foreground ,blue))))
   `(font-lock-variable-name-face ((t (:foreground ,red))))
   `(font-lock-warning-face ((t (:foreground ,yellow :weight bold))))
   `(c-annotation-face ((t (:inherit font-lock-constant-face))))

   ;; which-function-mode
   `(which-func ((t (:foreground ,blue))))

   ;; Third-party

   ;; ace-jump
   `(ace-jump-face-background
     ((t (:foreground ,foreground :background ,background :inverse-video nil))))
   `(ace-jump-face-foreground
     ((t (:foreground ,green :background ,background :inverse-video nil))))

   ;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-warning-face ((t (:foreground nil :inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((t (:foreground ,red :weight bold ))))
   `(font-latex-sedate-face ((t (:foreground ,yellow))))
   `(font-latex-italic-face ((t (:foreground ,cyan :slant italic))))
   `(font-latex-string-face ((t (:inherit ,font-lock-string-face))))
   `(font-latex-math-face ((t (:foreground ,red))))

   ;; auto-complete
   `(ac-candidate-face ((t (:background ,foreground :foreground ,background))))
   `(ac-selection-face ((t (:background ,blue :foreground ,foreground))))
   `(popup-tip-face ((t (:background ,yellow :foreground ,background))))
   `(popup-scroll-bar-foreground-face ((t (:background ,blue))))
   `(popup-scroll-bar-background-face ((t (:background ,background))))
   `(popup-isearch-match ((t (:background ,background :foreground ,foreground))))

   ;; company-mode
   `(company-tooltip ((t (:foreground ,foreground :background ,background))))
   `(company-tooltip-selection ((t (:foreground ,foreground :background ,background))))
   `(company-tooltip-mouse ((t (:background ,background))))
   `(company-tooltip-common ((t (:foreground ,green))))
   `(company-tooltip-common-selection ((t (:foreground ,green))))
   `(company-scrollbar-fg ((t (:background ,background))))
   `(company-scrollbar-bg ((t (:background ,background))))
   `(company-preview ((t (:background ,green))))
   `(company-preview-common ((t (:foreground ,green :background ,background))))

   ;; clojure-test-mode
   `(clojure-test-failure-face ((t (:foreground ,red :weight bold :underline t))))
   `(clojure-test-error-face ((t (:foreground ,red :weight bold :underline t))))
   `(clojure-test-success-face ((t (:foreground ,green :weight bold :underline t))))

   ;; cperl-mode
   `(cperl-array-face ((t (:foreground ,yellow))))
   `(cperl-hash-face ((t (:foreground ,cyan))))
   `(cperl-nonoverridable-face ((t (:foreground ,light-magenta))))

   ;; diff
   `(diff-added ((t (:foreground ,green :background nil))
                 (t (:foreground ,green :background nil))))
   `(diff-changed ((t (:foreground ,yellow))))
   `(diff-removed ((t (:foreground ,red :background nil))
                   (t (:foreground ,red :background nil))))
   `(diff-refine-added ((t (:inherit diff-added :weight bold))))
   `(diff-refine-change ((t (:inherit diff-changed :weight bold))))
   `(diff-refine-removed ((t (:inherit diff-removed :weight bold))))
   `(diff-header ((t (:background ,background))
                  (t (:background ,foreground :foreground ,background))))
   `(diff-file-header
     ((t (:background ,background :foreground ,foreground :bold t))
      (t (:background ,foreground :foreground ,background :bold t))))

   ;; diff-hl
   `(diff-hl-change ((t (:foreground ,blue :background ,background))))
   `(diff-hl-delete ((t (:foreground ,red :background ,background))))
   `(diff-hl-insert ((t (:foreground ,green :background ,background))))
   `(diff-hl-unknown ((t (:foreground ,yellow :background ,background))))

   ;; dired+
   `(diredp-display-msg ((t (:foreground ,blue))))
   `(diredp-compressed-file-suffix ((t (:foreground ,red))))
   `(diredp-date-time ((t (:foreground ,magenta))))
   `(diredp-deletion ((t (:foreground ,yellow))))
   `(diredp-deletion-file-name ((t (:foreground ,red))))
   `(diredp-dir-heading ((t (:foreground ,blue :background ,background))))
   `(diredp-dir-priv ((t (:foreground ,cyan))))
   `(diredp-exec-priv ((t (:foreground ,red))))
   `(diredp-executable-tag ((t (:foreground ,green))))
   `(diredp-file-name ((t (:foreground ,blue))))
   `(diredp-file-suffix ((t (:foreground ,green))))
   `(diredp-flag-mark ((t (:foreground ,yellow))))
   `(diredp-flag-mark-line ((t (:foreground ,red))))
   `(diredp-ignored-file-name ((t (:foreground ,red))))
   `(diredp-link-priv ((t (:foreground ,yellow))))
   `(diredp-mode-line-flagged ((t (:foreground ,yellow))))
   `(diredp-mode-line-marked ((t (:foreground ,red))))
   `(diredp-no-priv ((t (:foreground ,foreground))))
   `(diredp-number ((t (:foreground ,green))))
   `(diredp-other-priv ((t (:foreground ,yellow))))
   `(diredp-rare-priv ((t (:foreground ,red))))
   `(diredp-read-priv ((t (:foreground ,green))))
   `(diredp-symlink ((t (:foreground ,yellow))))
   `(diredp-write-priv ((t (:foreground ,magenta))))

   ;; ediff
   `(ediff-current-diff-A ((t (:foreground ,foreground :background ,red))))
   `(ediff-current-diff-Ancestor ((t (:foreground ,foreground :background ,red))))
   `(ediff-current-diff-B ((t (:foreground ,foreground :background ,green))))
   `(ediff-current-diff-C ((t (:foreground ,foreground :background ,blue))))
   `(ediff-even-diff-A ((t (:background ,background))))
   `(ediff-even-diff-Ancestor ((t (:background ,background))))
   `(ediff-even-diff-B ((t (:background ,background))))
   `(ediff-even-diff-C ((t (:background ,background))))
   `(ediff-fine-diff-A ((t (:foreground ,foreground :background ,red :weight bold))))
   `(ediff-fine-diff-Ancestor ((t (:foreground ,foreground :background ,red weight bold))))
   `(ediff-fine-diff-B ((t (:foreground ,foreground :background ,green :weight bold))))
   `(ediff-fine-diff-C ((t (:foreground ,foreground :background ,blue :weight bold ))))
   `(ediff-odd-diff-A ((t (:background ,background))))
   `(ediff-odd-diff-Ancestor ((t (:background ,background))))
   `(ediff-odd-diff-B ((t (:background ,background))))
   `(ediff-odd-diff-C ((t (:background ,background))))

   ;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning-face))))
   `(erc-default-face ((t (:foreground ,foreground))))
   `(erc-direct-msg-face ((t (:inherit erc-default))))
   `(erc-error-face ((t (:inherit font-lock-warning-face))))
   `(erc-fool-face ((t (:inherit erc-default))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,yellow))))
   `(erc-keyword-face ((t (:foreground ,blue :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,yellow :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default))))
   `(erc-notice-face ((t (:foreground ,green))))
   `(erc-pal-face ((t (:foreground ,red :weight bold))))
   `(erc-prompt-face ((t (:foreground ,red :background ,background :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,green))))
   `(erc-underline-face ((t (:underline t))))

   ;; ert
   `(ert-test-result-expected ((t (:foreground ,green :background ,background))))
   `(ert-test-result-unexpected ((t (:foreground ,red :background ,background))))

   ;; eshell
   `(eshell-prompt ((t (:foreground ,yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,red :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,blue :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,red :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,foreground))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,cyan :weight bold))))

   ;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,red) :inherit unspecified))
      (t (:foreground ,red :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,yellow) :inherit unspecified))
      (t (:foreground ,yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,cyan) :inherit unspecified))
      (t (:foreground ,cyan :weight bold :underline t))))
   `(flycheck-fringe-error ((t (:foreground ,red :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,yellow :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,cyan :weight bold))))

   ;; git-rebase-mode
   `(git-rebase-hash ((t (:foreground, red))))

   ;; helm
   `(helm-header
     ((t (:foreground ,green
                      :background ,background
                      :underline nil
                      :box nil))))
   `(helm-source-header
     ((t (:foreground ,yellow
                      :background ,background
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)))))
   `(helm-selection ((t (:background ,green :underline nil))))
   `(helm-selection-line ((t (:background ,background))))
   `(helm-visible-mark ((t (:foreground ,background :background ,yellow))))
   `(helm-candidate-number ((t (:foreground ,green :background ,background))))
   `(helm-separator ((t (:foreground ,red :background ,background))))
   `(helm-time-zone-current ((t (:foreground ,green :background ,background))))
   `(helm-time-zone-home ((t (:foreground ,red :background ,background))))
   `(helm-bookmark-addressbook ((t (:foreground ,red :background ,background))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,magenta :background ,background))))
   `(helm-bookmark-info ((t (:foreground ,green :background ,background))))
   `(helm-bookmark-man ((t (:foreground ,yellow :background ,background))))
   `(helm-bookmark-w3m ((t (:foreground ,magenta :background ,background))))
   `(helm-buffer-not-saved ((t (:foreground ,red :background ,background))))
   `(helm-buffer-process ((t (:foreground ,cyan :background ,background))))
   `(helm-buffer-saved-out ((t (:foreground ,foreground :background ,background))))
   `(helm-buffer-size ((t (:foreground ,foreground :background ,background))))
   `(helm-ff-directory ((t (:foreground ,cyan :background ,background :weight bold))))
   `(helm-ff-file ((t (:foreground ,foreground :background ,background :weight normal))))
   `(helm-ff-executable ((t (:foreground ,green :background ,background :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,red :background ,background :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,yellow :background ,background :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,background :background ,yellow :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,cyan :background ,background))))
   `(helm-grep-file ((t (:foreground ,foreground :background ,background))))
   `(helm-grep-finish ((t (:foreground ,green :background ,background))))
   `(helm-grep-lineno ((t (:foreground ,foreground :background ,background))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,red :background ,background))))
   `(helm-moccur-buffer ((t (:foreground ,cyan :background ,background))))
   `(helm-mu-contacts-address-face ((t (:foreground ,foreground :background ,background))))
   `(helm-mu-contacts-name-face ((t (:foreground ,foreground :background ,background))))

   ;; hl-line-mode
   `(hl-line-face ((t (:background ,background))
                   (t :weight bold)))
   `(hl-line ((t (:background ,background)) ; old emacsen
              (t :weight bold)))

   ;; ido-mode
   `(ido-first-match ((t (:foreground ,yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,red :weight bold))))
   `(ido-subdir ((t (:foreground ,yellow))))
   `(ido-indicator ((t (:foreground ,yellow :background ,red))))

   ;; js2-mode
   `(js2-warning ((t (:underline ,red))))
   `(js2-error ((t (:foreground ,red :weight bold))))
   `(js2-jsdoc-tag ((t (:foreground ,green))))
   `(js2-jsdoc-type ((t (:foreground ,green))))
   `(js2-jsdoc-value ((t (:foreground ,green))))
   `(js2-function-param ((t (:foreground, green))))
   `(js2-external-variable ((t (:foreground ,red))))

   ;; linum-mode
   `(linum ((t (:foreground ,'"#7F7F96" :background ,'"#22262E"))))

   ;; magit
   `(magit-item-highlight ((t (:background ,background))))
   `(magit-section-title ((t (:foreground ,yellow :weight bold))))
   `(magit-process-ok ((t (:foreground ,green :weight bold))))
   `(magit-process-ng ((t (:foreground ,red :weight bold))))
   `(magit-branch ((t (:foreground ,blue :weight bold))))
   `(magit-log-author ((t (:foreground ,red))))
   `(magit-log-sha1 ((t (:foreground, red))))

   ;; org-mode
   `(org-agenda-date-today
     ((t (:foreground ,foreground :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,foreground :weight bold))))
   `(org-checkbox ((t (:background ,background :foreground ,foreground
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,red))))
   `(org-done ((t (:bold t :weight bold :foreground ,green))))
   `(org-formula ((t (:foreground ,yellow))))
   `(org-headline-done ((t (:foreground ,green))))
   `(org-hide ((t (:foreground ,background))))
   `(org-level-1 ((t (:foreground ,red))))
   `(org-level-2 ((t (:foreground ,green))))
   `(org-level-3 ((t (:foreground ,blue))))
   `(org-level-4 ((t (:foreground ,yellow))))
   `(org-level-5 ((t (:foreground ,cyan))))
   `(org-level-6 ((t (:foreground ,green))))
   `(org-level-7 ((t (:foreground ,red))))
   `(org-level-8 ((t (:foreground ,blue))))
   `(org-link ((t (:foreground ,yellow :underline t))))
   `(org-scheduled ((t (:foreground ,green))))
   `(org-scheduled-previously ((t (:foreground ,red))))
   `(org-scheduled-today ((t (:foreground ,blue))))
   `(org-sexp-date ((t (:foreground ,blue :underline t))))
   `(org-special-keyword ((t (:inherit font-lock-comment-face))))
   `(org-table ((t (:foreground ,green))))
   `(org-tag ((t (:bold t :weight bold))))
   `(org-time-grid ((t (:foreground ,red))))
   `(org-todo ((t (:bold t :foreground ,red :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:bold t :foreground ,red :weight bold :underline nil))))
   `(org-column ((t (:background ,background))))
   `(org-column-title ((t (:background ,background :underline t :weight bold))))
   `(org-mode-line-clock ((t (:foreground ,foreground :background ,background))))
   `(org-mode-line-clock-overrun ((t (:foreground ,background :background ,red))))
   `(org-ellipsis ((t (:foreground ,yellow :underline t))))
   `(org-footnote ((t (:foreground ,cyan :underline t))))

   ;; outline
   `(outline-1 ((t (:foreground ,red))))
   `(outline-2 ((t (:foreground ,green))))
   `(outline-3 ((t (:foreground ,blue))))
   `(outline-4 ((t (:foreground ,yellow))))
   `(outline-5 ((t (:foreground ,cyan))))
   `(outline-6 ((t (:foreground ,green))))
   `(outline-7 ((t (:foreground ,red))))
   `(outline-8 ((t (:foreground ,blue))))

   ;; powerline
   `(powerline-active1 ((t (:background ,background :inherit mode-line))))
   `(powerline-active2 ((t (:background ,background :inherit mode-line))))
   `(powerline-inactive1 ((t (:background ,background :inherit mode-line-inactive))))
   `(powerline-inactive2 ((t (:background ,background :inherit mode-line-inactive))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,foreground))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,yellow))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,blue))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,yellow))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,blue))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,red))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,blue))))

   ;; sh-mode
   `(sh-heredoc     ((t (:foreground ,yellow :bold t))))
   `(sh-quoted-exec ((t (:foreground ,red))))

   ;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,red :background ,background :weight bold))))
   `(sp-show-pair-match-face ((t (:background ,background :weight bold))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory
                (file-name-directory load-file-name))))

(provide-theme 'xresources)

;;; xresources-theme.el ends here







;; Easy Indentation setup

(defun my-setup-indent (n)
  ;; java/c/c++
  (setq-local c-basic-offset n)
  ;; web development
  (setq-local coffee-tab-width n) ; coffeescript
  (setq-local javascript-indent-level n) ; javascript-mode
  (setq-local js-indent-level n) ; js-mode
  (setq-local js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq-local web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq-local web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq-local web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq-local css-indent-offset n) ; css-mode
  )

(defun my-office-code-style ()
  (interactive)
  (message "Office code style!")
  ;; use tab instead of space
  (setq-local indent-tabs-mode t)
  ;; Use spaces:
  ;; (setq-local indent-tabs-mode nil)
  ;; indent 4 spaces width
  (my-setup-indent 4))

(defun my-glo2003-code-style ()
  (interactive)
  (message "glo2003 code style!")
  ;; use space instead of tab
  (setq indent-tabs-mode nil)
  ;; indent 2 spaces width
  (my-setup-indent 2))

(defun my-setup-develop-environment ()
  (interactive)
  (let ((proj-dir (file-name-directory (buffer-file-name))))
    ;; if hobby project path contains string "glo2003"
    (if (string-match-p "glo2003" proj-dir)
        (my-glo2003-code-style))

    ;; if commericial project path contains string "commerical-proj"
    (if (string-match-p "commerical-proj" proj-dir)
        (my-office-code-style))))

;; prog-mode-hook requires emacs24+
;; (add-hook 'prog-mode-hook 'my-setup-develop-environment)
;; a few major-modes does NOT inherited from prog-mode
;; (add-hook 'lua-mode-hook 'my-setup-develop-environment)
;; (add-hook 'web-mode-hook 'my-setup-develop-environment)
























(setq sublimity-scroll-weight 6
      sublimity-scroll-drift-length 3)

(require 'sublimity)
(require 'sublimity-scroll)

(require 'iso-transl)

;; (require 'sublimity-map)

(sublimity-mode 1)


(require 'spaceline-config)
(spaceline-emacs-theme)


(tool-bar-mode -1) 

(global-linum-mode 1)


(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
	 (1+ (current-column))))))


(defun toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
	      (hs-toggle-hiding)
	    (error t))
	  (hs-show-all))
    (toggle-selective-display column)))


(load-library "hideshow")
(global-set-key (kbd "C-+") 'toggle-hiding)
(global-set-key (kbd "C-\\") 'toggle-selective-display)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)



(setq-default cursor-type 'bar) 

(show-paren-mode 1)

(require 'paren)
;; (set-face-background 'show-paren-match (face-background 'region))
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "magenta")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)


(require 'dashboard)
(dashboard-setup-startup-hook)
;; Set the title
(setq dashboard-banner-logo-title "")
;; Set the banner
;; (setq dashboard-startup-banner "~/foo.png")
(setq dashboard-startup-banner "~/logo.svg")




;; Buffer-related defuns

(require 'imenu)

(defvar buffer-local-mode nil)
(make-variable-buffer-local 'buffer-local-mode)

(defun mode-keymap (mode-sym)
  (symbol-value (intern (concat (symbol-name mode-sym) "-map"))))

(defun buffer-local-set-key (key action)
  (when buffer-local-mode
    (define-key (mode-keymap buffer-local-mode)
      key action)
    (return-from set-key-buffer-local))
  (let* ((mode-name-loc (gensym "-blm")))
    (eval `(define-minor-mode ,mode-name-loc nil nil nil (make-sparse-keymap)))
    (setq buffer-local-mode mode-name-loc)
    (funcall mode-name-loc 1)
    (define-key (mode-keymap mode-name-loc) key action)))

(defun create-scratch-buffer nil
  "create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)
    ))

(defun split-window-right-and-move-there-dammit ()
  (interactive)
  (split-window-right)
  (windmove-right))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark (point))
      (goto-char position))))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

(defun file-name-with-one-directory (file-name)
  (concat (cadr (reverse (split-string file-name "/"))) "/"
          (file-name-nondirectory file-name)))

(require 's)

(defvar user-home-directory (concat (expand-file-name "~") "/"))

(defun shorter-file-name (file-name)
  (s-chop-prefix user-home-directory file-name))

(defun recentf--file-cons (file-name)
  (cons (shorter-file-name file-name) file-name))

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let* ((recent-files (mapcar 'recentf--file-cons recentf-list))
         (files (mapcar 'car recent-files))
         (file (completing-read "Choose recent file: " files)))
    (find-file (cdr (assoc file recent-files)))))



(global-set-key (kbd "C-x \"") 'toggle-window-split)
(global-set-key (kbd "C-x «") 'rotate-windows)
(global-set-key (kbd "C-x »") 'rotate-windows)
