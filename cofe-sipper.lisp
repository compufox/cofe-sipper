;;;; cofe-sipper.lisp

(in-package #:cofe-sipper)

(defun remove-subdomain (domain)
  (let* ((tld (search "." domain :from-end t :test #'string=))
         (subdomain (search "." (subseq domain 0 tld) :from-end t :test #'string=)))
    (if subdomain
        (subseq domain (1+ subdomain))
        domain)))

(defun format-domain (domain)
  (let* ((no-http (subseq domain 8))
         (formatted (remove-subdomain no-http)))
    (subseq formatted 0 (1- (length formatted)))))

(defun fetch-domains ()
  (let ((page (plump:parse (drakma:http-request "https://cofespace.com"))))
    (with-open-file (out "instances.txt" :direction :output
                                                   :if-does-not-exist :create
                                                   :if-exists :overwrite)
      (format out "~{~A~%~}"
              (remove-duplicates
               (loop for element across (clss:select "li .instance-link" page)
                     collect (format-domain (plump:get-attribute element "href")))
               :test #'string=)))))

(defun main ()
  (format t "fetching list of instances...~&")
  (fetch-domains)
  (format t "saved to instances.txt~&"))
