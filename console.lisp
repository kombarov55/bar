(defpackage :console
  (:use :cl :data :time)
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
  (let* ((yesterday (time:minus-time (time:today) :days 1))
         (3-days-ago (time:minus-time (time:today) :days 3))
         (week-ago (time:minus-time (time:today) :days 7))
         (date-list (list yesterday 3-days-ago week-ago))
         (prompt-result (console:prompt "0. За сегодня 1. За 3 дня 2. За Неделю. Выбор")))
    (elt date-list (parse-integer prompt-result))))

(setf *code-value* nil)
(setf *code-value* (acons "1" :add *code-value*))
(setf *code-value* (acons "2" :display *code-value*))
(setf *code-value* (acons "3" :exit *code-value*))