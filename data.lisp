(defpackage :data
  (:use :cl :utils)
  (:export :*orders*
           :order
           :add-order
           :values-of
           :order->list
           :calculate-sum))

(in-package :data)

(defvar *orders* nil)

(defclass order ()
  ((name :accessor name-of
         :initarg :name)
   (amount :accessor amount-of
           :initarg :amount)
   (timestamp :accessor timestamp-of
         :initform (get-universal-time)
         :initarg :timestamp)))

(defun make-order (name amount &optional timestamp)
  (make-instance 'order :name name :amount amount :timestamp (or timestamp (get-universal-time))))

(defun add-order (name amount &optional timestamp)
  (setf *orders* (cons (make-order name amount timestamp) *orders*)))

(defmethod values-of ((obj order))
  (list (name-of obj) (int->str (amount-of obj)) (time:format-date (timestamp-of obj))))

(defun order->list (order)
  (list (name-of order) 
        (int->str (amount-of order))
        (>> order #'timestamp-of #'time:format-date)))

(defun generate-orders (amount)
  (let* ((names '("Николай" "Дарья" "Евгений" "Матвей" "Анастасия" "Дмитрий" "Миша"))
        (names-length (length names)))
    (dotimes (i amount)
      (add-order 
       (elt names (random names-length)) 
       (random 1000) 
       (time:minus-time (time:today)
                        :seconds (random 60) 
                        :minutes (random 60) 
                        :hours (random 24) 
                        :days (random 31))))))

(defun int->str (val)
  (if (stringp val) val (write-to-string val)))

(defun calculate-sum (order-list)
  (reduce #'+ order-list :key #'amount-of))