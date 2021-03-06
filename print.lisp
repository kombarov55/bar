(defpackage :print
  (:use :cl :console :rs-extracter)
  (:export :print-rs))

(in-package :print)

(defmethod print-rs (result-set)
    (let* ((length-list (max-lengthes-of result-set))
           (length-list (mapcar (lambda (each) (+ 2 each)) length-list))
           (spacer (build-spacer length-list)))
      (loop for row in result-set do
        (let ((value_length (reverse (pairlis row length-list))))
          (format t "~a~%~a~%"
                  spacer
                  (join "|" (mapcar #'make-cell value_length)))))
      (format t "~a~%" spacer)))

(defun max-lengthes-of (tree-list)
  (let ((result (make-list (length (car tree-list)) :initial-element 0)))
    (loop for branch in tree-list do 
      (let ((branch-size_result (reverse (pairlis (mapcar #'size-of branch) result))))
        (setf result (mapcar #'max-pair branch-size_result))))
      result))

(defun build-spacer (max-lengthes)
  (join "+" (mapcar (lambda (x) (make-str x "-")) max-lengthes)))

(defun make-cell (pair)
  (let ((str (car pair))
        (length (cdr pair)))
    (str+ " " str (make-str (- length (length str) 1) " "))))

(defun make-str (length initial-element)
  (let ((result))
    (dotimes (i length)
      (setf result (concat initial-element result)))
    result))

(defun max-pair (pair)
  (max (car pair) (cdr pair)))

(defun join (appender list)
	(concat 
         appender 
         (reduce #'concat list :key (lambda (each) (concat each appender)))))

(defmethod size-of ((item number))
	(labels ((tail-rec (item counter)
                   (if (> (/ item 10) 1)
                       (tail-rec (/ item 10) (+ 1 counter))
                       counter))) 
          (tail-rec item 1)))				

(defmethod size-of ((item string))
	(length item))

(defmethod size-of ((item (eql nil))) 0)

(defmethod size-of ((item keyword))
  (length (string item)))

(defun concat (v1 v2)
	(concatenate 'string (to-str v1) (to-str v2)))

(defun to-str (val)
	(if (numberp val)
		(write-to-string val)
		val))

(defun str+ (&rest strings)
  (reduce #'concat strings))
