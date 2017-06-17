(defpackage :rs-extracter
  (:use :cl :data)
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


(defun >> (arg &rest functions)
  (loop for fun in functions do
    (setf arg (funcall (eval fun) arg)))
  arg)
