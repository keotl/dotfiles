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
  (string-match regexp text)
  (match-string num text))
