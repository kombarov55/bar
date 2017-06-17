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
  (data:add-order (console:prompt "Имя") (console:prompt "Сумма"))
  (format t "Запись добавлена.~%"))

(defmethod proceed ((command (eql :display)))
  (let ((from (console:ask-date))
        (result-set (rs-extracter:get-basic-resultset 
                    *orders* :headers '("#" "Имя" "Сумма" "Дата"))))
    (print:print-rs result-set)))

(defun main-loop ()
  (let ((command (console:parse-command (console:prompt "1. Добавить 2. Отчёт 3. Выйти. Ваше решение"))))
    (proceed command)
    (unless (console:exit-command? command)
      (main-loop))))

;(main-loop)