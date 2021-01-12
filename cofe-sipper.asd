;;;; cofe-sipper.asd

(asdf:defsystem #:cofe-sipper
  :description "Describe cofe-sipper here"
  :author "ava fox"
  :license  "NPLv1+"
  :version "0.0.1"
  :serial t
  :depends-on (#:clss #:plump #:drakma)
  :components ((:file "package")
               (:file "cofe-sipper"))
  :entry-point "cofe-sipper::main"
  :build-operation "program-op"
  :build-pathname "bin/cofesipper")
