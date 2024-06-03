; Function that slices a string into a list.
(defun slice (foo)
  (let ((i 0)(l (list 'list)))
    (loop
      (when (>= i (length foo))(return))
      (setf l (concatenate 'list l (list (string (char foo i)))))
      (setf i (+ i 1))
    )
    l
  )
)

; Output function.
(defun output (foo)
  (cond ((typep foo 'integer)(format t "~d" foo))
        ((typep foo 'character)(format t "~c" foo))
        ((typep foo 'float)(format t "~,f" foo))
        ((typep foo 'string)(format t foo))
        (t (print foo))
  )
  (finish-output t)
)

; Function that gets the contents of a file as a string.
(defun get-file-contents (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents)
    )
)