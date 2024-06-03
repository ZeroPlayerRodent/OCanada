; This script will build OCanada into an executable file.
(declaim (sb-ext:muffle-conditions cl:warning))
(declaim (sb-ext:muffle-conditions cl:style-warning))
(load "ocanada.lisp")
(sb-ext:save-lisp-and-die "ocanada.exe" :toplevel #'main :executable t)