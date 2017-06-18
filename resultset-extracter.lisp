(defpackage :rs-extracter
  (:use :cl :data :utils)
  (:export :get-basic-resultset))

(in-package :rs-extracter)

(defun get-basic-resultset (order-list &key headers)
  (cons headers (get-index+values order-list)))

(defun get-resulset (&rest predicates)
  (make-resultset ))

(defun get-index+values (order-list)
  (let ((index 0))
  (mapcar (lambda (order) 
            (cons  (write-to-string (incf index)) (data:values-of order))) 
          order-list)))

