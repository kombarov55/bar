(defpackage :utils
  (:use :cl)
  (:export :>>
           :minus-time
           :time-of
           :format-date
           :int->str))

(in-package :utils)

(defun >> (arg &rest functions)
  (loop for fun in functions do
    (setf arg (funcall (eval fun) arg)))
  arg)

