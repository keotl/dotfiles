
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq inhibit-startup-screen t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (xresources)))
 '(custom-safe-themes
   (quote
    ("518a40fc517928e774d5b1a35ec6af668a0e0e1eda80d2e6f8ac77f6879bec2a" "b4641fe0d194dbd7cffede247877041c96b59863e0d48aacec21eb7537021722" "48f8da315de7fde5db54a5b47e4024d335d9c77711dc13f121b9d77c4f108478" "3cf11cb4dc09f61cbbd309a80e7badcb18918818d886ebca06e7528a9797c788" "9aa3423e406d7fea6badbffb0a0c2da49b3e8ab4466d607ceeea81f62688dcd3" "73b4137a14c8ceb5e4c0bdeb0c8a4ae84ba3371a37a98450c200991d6c52aa40" "13f2929056ba0bab3f54bb4ae1ff8293f0f11c092fe855c96012abededfa8f11" "824bf0bf763a599e4a950113eb72ad050850520a9de04195adb843a7feb53a18" "d11845291335a8185c58bc76726fbb83781c129ffd696d52c166d652f90affdc" "495b72d606fc7671207b2380fe2e9ef5a2fa6b43df097ef762b778804f1f28f2" "f6e8302d68ed79078eed9c41c8e62a4fe98ab7913f6eef590e02b5da0518641d" "cbbbf71f6114ed517a4b17558b24211e34f0539d36fafc7975889f1b56e1f6f4" "a998b8cf015bf7d5cb73fdead248c866ee3a0d3e8cdb54a5d8d084d73eb0fd61" "94b1096093f44d190e1c1600fee4551c126b27394dba0c7ef9f6a99b417eec40" "40d52627dd742e5c0173480a5a1b0875ce37562e94dc4d79a2aaa372e657c9a6" "74c0c0d2ab30031e13e1783bb880fc3efe8e10c31fbc2227f9d017094af02492" "d4fc9b592661bbbd60f5a451e814bd798e43bd10537c96f67169615b0e0d7b08" "8581bbe886659e961cb76fda1c75f5cdadd81bae4a3fd8454f96092221f9eefa" "ed5c57853e564ea1f4709daf25e841a97569803e60642dd31b931ed848dd7808" "62235f686efd5def45d99e84dede5306ec6aca76d1e8071f1077671b50b137ca" "065efdd71e6d1502877fd5621b984cded01717930639ded0e569e1724d058af8" default)))
 '(package-selected-packages
   (quote
    (sr-speedbar projectile dashboard org yasnippet async dash with-editor web-completion-data powerline s f pythonic pos-tip popup magit-popup git-commit irony go-mode company anaconda-mode avy auto-complete
		 (ac-c-headers ac-clang ace-window auto-complete avy company-anaconda anaconda-mode company-go company-irony company-irony-c-headers company-shell company-web company gh-md go-mode irony magit git-commit magit-popup popup pos-tip pythonic f spaceline s powerline sublimity web-completion-data with-editor dash async xresources-theme yasnippet)
		 spaceline sublimity xresources-theme gh-md ace-window ac-c-headers ac-clang company-anaconda company-go company-irony-c-headers company-web company-shell company-irony magit)))
 '(standard-indent 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key (kbd "C-x o") 'ace-window)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-à") 'company-complete) 






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

 (require 'sr-speedbar)
 (global-set-key (kbd "s-s") 'sr-speedbar-toggle)
(global-set-key (kbd "C-M-g") 'magit-status)

(add-to-list 'display-buffer-alist
             '("**" display-buffer-same-window))
