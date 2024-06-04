; Function for parsing a float from a string.
(defun parse-float (foo) ; Function that parses floats from strings
  (let ((str "")(counting 0)(count 0))
    (loop for c across foo
      do (when (= counting 1) (setf count (+ count 1)))
      do (when (not (equal c #\.)) (setf str (concatenate 'string str (list c))))
      do (when (equal c #\.) (setf counting 1))
    )
    (if (= counting 1)
      (coerce (* (parse-integer str) (expt 10 (- count))) 'double-float)
      (if (parse-integer str :junk-allowed t)
        (parse-integer str)
        str
      )
    )
  )
)

; Function that parses a float from a string, and returns an error if it failed.
(defun parse-float-error (foo) ; Function that parses floats from strings
  (let ((str "")(counting 0)(count 0))
    (loop for c across foo
      do (when (= counting 1) (setf count (+ count 1)))
      do (when (not (equal c #\.)) (setf str (concatenate 'string str (list c))))
      do (when (equal c #\.) (setf counting 1))
    )
    (if (= counting 1)
      (coerce (* (parse-integer str) (expt 10 (- count))) 'double-float)
      (when (parse-integer str)
        (parse-integer str)
      )
    )
  )
)

; Function that parses an OCanada list into a Lisp list.
(defvar i 0)
(defun interpret-list (start full)
  (let ((l (list 'list)))
    (setf i start)
    (loop
      (when (>= i (length code-string))(progn (format t "Sorry buddy, there's a list missing a closing bracket!")(exit)))
      (cond ((equal "]" (elt code-string i))(return))
            ((equal "[" (elt code-string i))(nconc l (list (interpret-list (+ i 1) ()))))
            (t (nconc l (list (interpret-commands i))))
      )
      (setf i (+ i 1))
    )
    (if full
      (progn (pop l) (elt l 0))
      l
    )
  )
)

; Function that parses an OCanada list into a Lisp lambda list.
(defun interpret-lambda-list (start &optional (full nil))
  (let ((l (list 'list)))
    (setf i start)
    (loop
      (when (>= i (length code-string))(progn (format t "Sorry buddy, there's a list missing a closing bracket!")(exit)))
      (cond ((equal "]" (elt code-string i))(return))
            ((equal "[" (elt code-string i))(nconc l (list (interpret-lambda-list (+ i 1) ()))))
            (t (nconc l (list (interpret-commands i))))
      )
      (setf i (+ i 1))
    )
    (if full
      (progn
        (pop l)
        (if l
          (elt l 0)
          nil
        )
      )
      l
    )
  )
)

; Function that gets a variable.
(defun get-variable (start)
  (setf i start)
  (let ((x (read-from-string (concatenate 'string (elt code-string (+ i 1)) "-var"))))
    (setf i (+ i 2))
    x
  )
)
