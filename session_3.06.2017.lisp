(defvar *orders* nil)
(defvar *code-value* nil)

(defclass order ()
	((customer-name :initarg :name :accessor name-of)
	(amount :initarg :amount :accessor amount-of)))


(defun main-loop ()
		(let ((command (parse-command-code (prompt "1. Создать 2. Вывести отчёт 3. Выйти. Ваше решение"))))
			(unless (exit-command? command)
					(proceed command)
					(main-loop))))
					
(defmethod proceed ((symbol (eql :add)))
		(add (make-instance 'order :name (prompt "Имя") :amount (prompt "Сумма"))))	

(defmethod proceed ((symbol (eql nil)))
	(format t "Неверная комманда, введите ещё раз.~%"))


(defun prompt (value)
	(format *query-io* "~a? " value)
	(read-line *query-io*))
		
(defun add (value)
	(setf *orders* (cons value *orders*)))

(defun exit-command? (keyword)
	(eq keyword :exit))

(defun add-command (code keyword)
	(setf *code-value* (acons code keyword *code-value*)))
		
(defun parse-command-code (code-str)
	(cdr (assoc code-str *code-value* :test #'equal)))

	
;;;;;;;;;;;;;;;;;;;;;;;display;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod proceed ((symbol (eql :display)))
	(let* ((length-list (make-length-list))
					(spacer (get-spacer length-list)))
		(print-head spacer length-list)
		(loop for each in *orders* do 
			(format t "~a~%~a~%"
				(make-row (list (name-of each) (amount-of each)) length-list) 
				spacer))
		(print-sum)))

(defun get-spacer (length-list)
		(join-list "+" (mapcar #'build-line length-list)))		
		
(defun make-length-list () 
	(list 
		(+ 2 (max-length-of (cons "Имя" (mapcar #'name-of *orders*))))
		(+ 2 (max-length-of (cons "Сумма" (mapcar #'amount-of *orders*))))))
		
(defun print-head (spacer length-list)
	(format t "~a~%~a~%~a~%" 
		spacer 
		(make-row '("Имя" "Сумма") length-list) 
		spacer))
		
(defun print-sum ()
	(format t "Сумма за день: ~a P.~%"
		(reduce #'+ *orders* 
		:key (lambda (order) (parse-integer (amount-of order))))))
		
(defun make-row (val-list length-list) 
	(let* ((val-to-length (reverse (pairlis val-list length-list)))
				(cells (mapcar (lambda (pair) (cell-value (car pair) (cdr pair))) val-to-length)))
		(join-list "|" cells)))
								
(let ((list (pairlis '("Николай" 150) '(9 5))))
	(mapc (lambda (pair) (format t "~a:~a~%" (car pair) (cdr pair))) list))
		
(defun cell-value (str max-length)
	(concat 
		(concat " " str) 
		(make-seq (- max-length 1 (size-of str)) :arg " " :fun #'concat)))
  	
(defun build-line (length)
	(make-seq length :arg "-" :fun #'concat))
	
(defun make-seq (length &key (arg " ") (fun #'cons))
	(labels ((tail-rec (length &optional (result ""))
						(if (= 0 length)
								result
								(tail-rec (- length 1) (funcall fun arg result)))))
		(tail-rec length)))
										
(defun join (appender &rest args) 
	(join-list appender args))
	
(defun join-list (appender list)
	(concat 
		appender 
		(reduce #'concat list :key (lambda (each) (concat each appender)))))

(defmacro str+ (&rest strings)
	`(concatenate 'string ,@strings))
	
(defun to-str (val)
	(if (numberp val)
		(write-to-string val)
		val))
		
(defun concat (v1 v2)
	(concatenate 'string (to-str v1) (to-str v2)))

(defun max-length-of (list)
	(reduce #'max list :key #'size-of))
	
(defmethod size-of ((item number))
	(labels ((tail-rec (item counter)
						(if (> (/ item 10) 1)
								(tail-rec (/ item 10) (+ 1 counter))
								counter))) 
		(tail-rec item 1)))				

(defmethod size-of ((item string))
	(length item))

;;;;;;;;;;;;;;;;;;;;display;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

(defun add-initial-commands ()
	(add-command "1" :add)
	(add-command "2" :display)
	(add-command "3" :exit))
				
(add-initial-commands)
(main-loop)