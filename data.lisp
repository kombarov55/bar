(defpackage :data
  (:use :cl)
  (:export :*orders*
           :order
           :add-order
           :values-of))

(in-package :data)

(defvar *orders* nil)

(defclass order ()
  ((name :accessor name-of
         :initarg :name)
   (amount :accessor amount-of
           :initarg :amount)
   (timestamp :accessor timestamp-of
         :initform (get-universal-time))))

(defun make-order (name amount)
  (make-instance 'order :name name :amount amount))

(defun add-order (name amount)
  (setf *orders* (cons (make-order name amount) *orders*)))

(defmethod values-of ((obj order))
  (list (name-of obj) (write-to-string (amount-of obj)) (format-date (timestamp-of obj))))

(defun format-date (timestamp)
  (multiple-value-bind
      (second minute hour day month year) 
      (decode-universal-time timestamp)
    (format nil "~a.~a.~a" day month year)))

(defun generate-orders (amount)
  (let* ((names '("Николай" "Дарья" "Евгений" "Матвей" "Анастасия" "Дмитрий" "Миша"))
        (names-length (length names)))
    (dotimes (i amount)
      (add-order (elt names (random names-length)) (random 1000)))))
