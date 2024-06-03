; These are stacks that hold the last program and instruction pointer position.
(defvar code-string-q (list 'remove))
(defvar i-q (list 'remove))

; This function saves the program and instruction pointer position.
(defun save-code ()
  (nconc code-string-q (list code-string))
  (nconc i-q (list i))
)

; Function for popping value from stacks
(defun pop-top (l)
  (reverse (cdr (reverse l)))
)


; Function that loads the last program and instruction pointer position.
(defun load-code ()
  (setf code-string (first (last code-string-q)))
  (setf i (first (last i-q)))
  (setf code-string-q (pop-top code-string-q))
  (setf i-q (pop-top i-q))
)

(defvar code-string "")

; Function for evaluating string as OCanada code.
(defun evaluate-no-errors (foo)
  (declaim (sb-ext:muffle-conditions cl:warning))
  (save-code)
  (setf i 0)
  (setf code-string (split-string foo))
  (let ((x nil)) 
    (loop
      (when (>= i (length code-string)) (return))
      (setf x (eval (interpret-commands i)))
      (setf i (+ i 1))
    )
    (load-code)
    x
  )
)

; Evaluate but with error handling.
(defun evaluate (foo)
  (handler-case (evaluate-no-errors foo) 
    (error (c)
      (format t "Sorry buddy, something went wrong with your code!" c)
      (terpri)
      (format t "~a~%" c)
      (exit)
    )
  )
)

; Function that interprets an OCanada program.
(defun interpret-no-errors (foo)
  (declaim (sb-ext:muffle-conditions cl:warning))
  (setf code-string (split-string (get-file-contents foo)))
  (loop
    (when (>= i (length code-string)) (return))
    (eval (interpret-commands i))
    (setf i (+ i 1))
  )
)

; Interpret but with error handling.
(defun interpret (foo)
  (handler-case (interpret-no-errors foo) 
    (error (c)
      (format t "Sorry buddy, something went wrong with your code!" c)
      (terpri)
      (format t "~a~%" c)
      (exit)
    )
  )
)