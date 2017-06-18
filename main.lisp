(defpackage :main
  (:use :cl 
        :data
        :console 
        :rs-extracter
        :print))

(in-package :main)

(defmethod proceed (command)
  (format t "Такой команды не существует. Введите ещё раз."))

(defmethod proceed ((commmand (eql :exit)))
  (format t "До встречи!"))

(defmethod proceed ((command (eql :add)))
  (data:add-order (console:prompt "Имя") (parse-integer (console:prompt "Сумма")))
  (format t "Запись добавлена.~%"))

(defmethod proceed ((command (eql :display))) ; сделать такой же пункт меню, как и в главном: спрашивать имя, дату
  (let* ((from (console:ask-date))
        (result-set (rs-extracter:get-resultset '("#" "Имя" "Сумма" "Дата") (after from))))
    (print:print-rs result-set)))

(defun main-loop ()
  (let ((command (console:parse-command (console:prompt "1. Добавить 2. Отчёт 3. Выйти. Ваше решение"))))
    (proceed command)
    (unless (console:exit-command? command)
      (main-loop))))