; This function converts an OCanada code block to a Lisp S-expression.
(defun create-block (start init)
  (let ((l (list init)))
    (setf i start)
    (loop
      (when (>= i (length code-string))(progn (format t "Sorry buddy, looks like you're missing an 'eh?' statement!")(exit)))
      (cond ((equal "EH?" (elt code-string i))(return))
            (t (nconc l (list (interpret-commands i))))
      )
      (setf i (+ i 1))
    )
    l
  )
)

; These functions are for creating blocks for OOT and ABOOT statements.
(defun create-if-block (start init)
  (let ((l (list init)))
    (setf i start)
    (loop
      (when (>= i (length code-string))(progn (format t "Sorry buddy, looks like you're missing an 'eh?' statement!")(exit)))
      (cond ((equal "EH?" (elt code-string i))(progn (setf i (- i 1))(return)))
            ((equal "ABOOT" (elt code-string i))(progn (setf i (- i 1))(return)))
            (t (nconc l (list (interpret-commands i))))
      )
      (setf i (+ i 1))
    )
    l
  )
)

(defun make-ifs (start)
  (let ((l (list 'if)) (elsed 0))
    (setf i start)
    (nconc l (list (interpret-commands i)))
    (loop
      (when (>= i (length code-string))(progn (format t "Sorry buddy, looks like you're missing an 'eh?' statement!")(exit)))
      (cond ((equal "EH?" (elt code-string i))(return))
            ((equal "ABOOT" (elt code-string i))(progn (setf elsed 1)(nconc l (list (make-ifs (+ i 1))))))
            (t (nconc l (list (create-if-block i 'progn))))
      )
      (when (= elsed 0)
        (setf i (+ i 1))
      )
    )
    l
  )
)