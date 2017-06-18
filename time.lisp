(defpackage :time
  (:use cl)
  (:export :minus-time
           :time-of
           :format-date
           :today))

(in-package :time)

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

(defun time-of (&key second minute hour day month year)
  (multiple-value-bind (s mm h d m y) (get-decoded-time)
    (encode-universal-time
     (or second s)
     (or minute mm)
     (or hour h)
     (or day d)
     (or month m)
     (or year y))))

(defun format-date (timestamp)
  (multiple-value-bind
      (second minute hour day month year) 
      (decode-universal-time timestamp)
    (format nil "~a.~a.~a" day month year)))

(defun today ()
  (time-of :second 0 :minute 0 :hour 0))