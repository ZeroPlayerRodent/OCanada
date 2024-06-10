; Shortcut macro
(defmacro next ()
  '(interpret-commands (+ i 1))
)

; Function that converts OCanada code into Lisp S-expressions.
(defun interpret-commands (start)
  (setf i start)
  (setf code (elt code-string i))
  (cond
        ((>= i (length code-string))())
        ((equal #\# (char code 0))(string-left-trim "#" code))
	((equal "(" code)(infix (+ i 1)))
        ((member code (list ")" "+" "-" "*" "/" "^" "%" "]" "}") :test #'equalp)())
	((equal "[" code)(interpret-list (+ i 1) ()))
	((equal "{" code)`(elt locals (+ (position (quote ,(get-variable i)) locals) 1)))
	((equal "HOSER" code)'nil)
	((equal "CANUCK" code)'t)
	((equal "NOT" code)`(not ,(next)))
        ((equal "SYRUP" code)
          (if (equal "{" (elt code-string (+ i 1)))
             (let ((x (get-variable (+ i 1)))(y (next)))
              `(progn
                 (unless (position (quote ,x) locals)(nconc locals (list (quote ,x)))(nconc locals (list nil)))
                 (setf (elt locals (+ (position (quote ,x) locals) 1)) ,y)
               )
             )
             `(setf ,(next) ,(next))
          )
        )
        ((equal "ASK_POLITELY" code)'(progn (finish-output)(read-line t)))
        ((equal "TOONIE" code)`(parse-float-error ,(next)))
        ((equal "APOLOGIZE" code)`(output ,(next)))
        ((equal "MAPLE_LEAF" code)`(random ,(next) (make-random-state t)))
        ((equal "NANAIMO" code)`(remove 'list (slice ,(next))))
        ((equal "PUCK" code)
          (let ((x (next)))
            `(if (typep ,x 'string)(character ,x)(code-char ,x))
          )
        )
        ((equal "CAD" code)`(char-code ,(next)))
        ((equal "THANKS" code)'(return))
        ((equal "SORRY" code)
          `(handler-case ,(next) (error () nil))
        )
        ((equal "STAND_ON_GUARD_FOR_THEE" code)
        `(sb-ext:save-lisp-and-die (next) :toplevel #'main-var :executable t))
        ((equal "MOOSE" code)`(length ,(next)))
        ((equal "BEAVER" code)`(truncate ,(next)))
        ((equal "ICE" code)(create-block (+ i 1) 'defstruct))
        ((equal "PLAY_LACROSSE" code)(create-block (+ i 1) 'progn))
        ((equal "BUDDY" code)`(,(read-from-string (concatenate 'string "MAKE-" (string (next))))))
        ((equal "DONAIR" code)
          (let ((x nil)(y nil))
            (setf x (next))
            (setf y (next))
            `(slot-value ,y (quote ,x))
          )
        )
        ((equal "LOONIE" code)
          (let ((x (next)) (y (next)))
            `(elt ,y (mod ,x (length ,y)))
          )
        )
        ((equal "TUQUE" code)
          (let ((x (next)) (y (next)))
            (when (equal x '(progn (finish-output t)(read-line t)))(setf x (eval x)))
            (when (equal y '(progn (finish-output t)(read-line t)))(setf y (eval y)))
            (if (or (typep x 'string) (typep y 'string))
              `(concatenate 'string ,x ,y)
              `(concatenate 'list ,x (list ,y))
            )
          )
        )
        ((equal "FREEZE" code)`(progn(finish-output t)(sleep ,(next))))
        ((equal "O_CANADA" code)
          (let ((x nil)(y nil))
             (setf x (next))
             (setf y `(defun ,x ,(remove 'list (interpret-lambda-list (+ i 2) ())) (let ((locals (list 0))),(create-block (+ i 1) 'progn))))
            y
          )
        )

        ((equal "PLEASE" code)`(apply (quote ,(next)) ,(interpret-lambda-list (+ i 2)()) ))
        ((equal "MOUNTIE" code)
          (let ((x nil))
            (setf x (interpret-lambda-list (+ i 2)()))
            `(every #'equalp ,x (rest ,x))
          )
        )
        ((equal "OOT" code)(make-ifs (+ i 1)))
        ((equal "POUTINE" code)`(pop ,(next)))
        ((equal "GOOSE" code)`(evaluate ,(next)))
        ((equal "SNOW" code)`(get-file-contents ,(next)))
        ((equal "PLAY_HOCKEY" code)
          (let ((x nil))
            (setf x (next))
            (concatenate 'list (list 'loop) (list `(unless ,x (return))) (remove 'remove (create-block (+ i 1) 'remove)))
          )
        )
        (t (if (parse-integer code :junk-allowed t)
               (parse-float code)
               (read-from-string (concatenate 'string (elt code-string i) "-var"))
           )
        )
  )
)
