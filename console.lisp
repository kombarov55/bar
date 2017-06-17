(defpackage :console
  (:use :cl)
  (:export :prompt
           :parse-command
           :exit-command?))

(in-package :console)

(defvar *code-value* nil)

(defun prompt (value)
	(format *query-io* "~a? " value)
	(read-line *query-io*))

(defun exit-command? (keyword)
  (eq keyword :exit))

(defun parse-command (str)
               (cdr (assoc str *code-value* :test #'equal)))

(setf *code-value* (acons "1" :add *code-value*))
(setf *code-value* (acons "2" :display *code-value*))
(setf *code-value* (acons "3" :exit *code-value*))