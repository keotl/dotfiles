(defun snake-to-camel (text)
  (let ((cased (replace-regexp-in-string "_." 'upcase (downcase text) t t)))
    (let ((underscores-removed (replace-regexp-in-string "_" "" cased t t)))
      underscores-removed)))

(defun upcase-first (text)
  (replace-regexp-in-string "^." 'upcase text t t))

(defun downcase-first (text)
  (replace-regexp-in-string "^." 'downcase text t t))

(defun camel-to-snake (text)
  (let ((case-fold-search nil))
    (replace-regexp-in-string "[A-Z]"
                              (lambda (match) (concat "_" (downcase match) ))
                              (downcase-first text) t t)
    )
  )

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun regexp-match (text regexp num)
  "Get a match group in a string."
  (string-match regexp text)
  (match-string num text))


(defun cs-find-test-file (filename)
(interactive)
  (concat (projectile-project-root (replace-regexp-in-string "test/[^/]*" (lambda (x) (concat x ".Tests"))
   (replace-regexp-in-string ".cs$" "Tests.cs"
                             (replace-regexp-in-string "src" "test"
                                                       (replace-regexp-in-string (projectile-project-root) "" filename)
                                                       )))))
  )

(defun cs-namespace (buffer-file-name)
  (replace-regexp-in-string "\\/" "."
      (replace-regexp-in-string "^.*\\(src\\|test\\)\\/" ""
           (replace-regexp-in-string "\\/$" ""
                (file-name-directory buffer-file-name))))
    )

(defun buffer-text ()
  (buffer-substring-no-properties 1 (buffer-size)))
