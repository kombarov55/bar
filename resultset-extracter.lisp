(defpackage :rs-extracter
  (:use :cl :data :utils)
  (:export :get-basic-resultset
           :after
           :get-resultset))

(in-package :rs-extracter)

(defun get-basic-resultset (order-list &key headers)
  (cons headers (get-index+values order-list)))

(defun get-resultset (headers &rest predicates)
  (let* ((filtered-orders (remove-if-not (lambda (order) (test order predicates)) *orders*))
         (resultset (mapcar #'data:order->list filtered-orders ))
         (indexed-resultset (add-index-to-row resultset))
         (resultset-with-headers (cons headers indexed-resultset))
         (sum (data:calculate-sum filtered-orders))
         (resultset-with-sum-appended (reverse 
                                       (cons (list "" "Сумма:" (write-to-string sum) "")
                                             (reverse resultset-with-headers)))))
    resultset-with-sum-appended))

(defun test (arg predicates)
  (let ((result t))
    (loop for p in predicates do
      (setf result (and result (funcall p arg))))
    result))

(defun add-index-to-row (resultset)
  (let ((index 0))
      (mapcar (lambda (row) (cons (write-to-string (incf index)) row)) resultset)))

(defun after (timestamp)
  (lambda (order) (> (data::timestamp-of order) timestamp)))

(defun name-like (name)
  (lambda (order) (equal (data::name-of order) name)))



