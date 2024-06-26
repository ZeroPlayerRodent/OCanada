; Function for converting math expressions into Lisp S-expressions.
; TODO: Make it more efficient and less horrible.
(defvar nested 0)
(defun infix (start)
  (setf i start)
  (incf nested)
  (let ((result (list 'progn)))
    (nconc result (list `(setf temp ,(interpret-commands i))))
    (loop
      (setf i (+ i 1))
      (when (>= i (length code-string))(progn (format t "Sorry buddy, there's a math statement missing a parenthesis!")(exit)))
      (cond ((equal "+" (elt code-string i))
            (nconc result (list `(setf temp (+ temp ,(interpret-commands (+ i 1)))))))
            ((equal "-" (elt code-string i))
            (nconc result (list `(setf temp (- temp ,(interpret-commands (+ i 1)))))))
            ((equal "*" (elt code-string i))
            (nconc result (list `(setf temp (* temp ,(interpret-commands (+ i 1)))))))
            ((equal "/" (elt code-string i))
            (nconc result (list `(setf temp (/ temp ,(interpret-commands (+ i 1)))))))
            ((equal "^" (elt code-string i))
            (nconc result (list `(setf temp (expt temp ,(interpret-commands (+ i 1)))))))
            ((equal "%" (elt code-string i))
            (nconc result (list `(setf temp (mod temp ,(interpret-commands (+ i 1)))))))
            ((equal ")" (elt code-string i))(return))
      )
    )
    (nconc result 
      (list '(if (typep temp 'float)(coerce temp 'double-float)temp))
    )
    result
  )
)