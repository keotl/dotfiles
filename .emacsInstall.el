(defvar packages '(ac-c-headers ac-clang ace-window auto-complete avy company-anaconda anaconda-mode company-go company-irony company-irony-c-headers company-shell company-web company gh-md go-mode irony magit git-commit magit-popup popup pos-tip pythonic f spaceline s powerline sublimity web-completion-data with-editor dash async xresources-theme yasnippet))

(mapcar 'package-install packages)
