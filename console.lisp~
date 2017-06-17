(defpackage :console
  (:use :cl)
  (:export :prompt
           :parse-command
           :exit-command?
           :ask-date))

(in-package :console)

(defvar *code-value* nil)

(defun prompt (value)
	(format *query-io* "~a? " value)
	(read-line *query-io*))

(defun exit-command? (keyword)
  (eq keyword :exit))

(defun parse-command (str)
               (cdr (assoc str *code-value* :test #'equal)))

(defun ask-date ()
  (let* ((now (get-universal-time))
         (yesterday (minus-time now :days 1))
         (3-days-ago (minus-time now :days 3))
         (week-ago (minus-time now :days 7))
         (date-list (list yesterday 3-days-ago week-ago))
         (prompt-result (console:prompt "0. За сегодня 1. За 3 дня 2. За Неделю. Выбор")))
    (elt date-list (parse-integer prompt-result))))

(defun minus-time (timestamp &key (seconds 0) (minutes 0) (hours 0) (days 0) (months 0) (years 0))
  (multiple-value-bind (s mm h d m y) (decode-universal-time timestamp) 
    (encode-universal-time 
     (positive-or-one (- s seconds))
     (positive-or-one (- mm minutes))
     (positive-or-one (- h hours))        
     (positive-or-one (- d days)) 
     (positive-or-one (- m months)) 
     (positive-or-one (- y years)))))

(defun positive-or-one (value)
  (if (> value 0) value 1))


(setf *code-value* (acons "1" :add *code-value*))
(setf *code-value* (acons "2" :display *code-value*))
(setf *code-value* (acons "3" :exit *code-value*))