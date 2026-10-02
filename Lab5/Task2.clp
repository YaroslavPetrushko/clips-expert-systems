;;; Завдання 2: дерево рішень "Яка це тварина?"

(deftemplate question
   (slot query-string)
   (slot answer))

;; Ставить питання (printout), зчитує відповідь (read) і перевіряє,
;; що відповідь yes/no (регістр не важливий). Повертає yes або no.
(deffunction ask-yes-no (?query)
   (printout t ?query " (yes/no): ")
   (bind ?answer (sym-cat (lowcase (str-cat (read)))))
   (while (and (neq ?answer yes) (neq ?answer no)) do
      (printout t "Please answer yes or no: ")
      (bind ?answer (sym-cat (lowcase (str-cat (read))))))
   (return ?answer))

;; Допоміжна функція: новий сеанс діагностики + вивід накопичених фактів
(deffunction play ()
   (reset)
   (run)
   (printout t crlf "--- Facts in working memory ---" crlf)
   (facts))

;; ==================== ПРАВИЛА-ПИТАННЯ ====================

(defrule ask-very-big
   (not (question (query-string "Is it very big?")))
   =>
   (assert (question (query-string "Is it very big?")
                     (answer (ask-yes-no "Is it very big?")))))

(defrule ask-squeak
   (question (query-string "Is it very big?") (answer no))
   (not (question (query-string "Does it squeak?")))
   =>
   (assert (question (query-string "Does it squeak?")
                     (answer (ask-yes-no "Does it squeak?")))))

(defrule ask-long-neck
   (question (query-string "Is it very big?") (answer yes))
   (not (question (query-string "Does it have a long neck?")))
   =>
   (assert (question (query-string "Does it have a long neck?")
                     (answer (ask-yes-no "Does it have a long neck?")))))

(defrule ask-trunk
   (question (query-string "Does it have a long neck?") (answer no))
   (not (question (query-string "Does it have a trunk?")))
   =>
   (assert (question (query-string "Does it have a trunk?")
                     (answer (ask-yes-no "Does it have a trunk?")))))

(defrule ask-water
   (question (query-string "Does it have a trunk?") (answer no))
   (not (question (query-string "Does it like to be in water?")))
   =>
   (assert (question (query-string "Does it like to be in water?")
                     (answer (ask-yes-no "Does it like to be in water?")))))

;; ==================== ПРАВИЛА-ВИСНОВКИ ====================

(defrule guess-squirrel
   (question (query-string "Is it very big?") (answer no))
   (question (query-string "Does it squeak?") (answer no))
   =>
   (printout t "I guess it is a squirrel." crlf))

(defrule guess-mouse
   (question (query-string "Is it very big?") (answer no))
   (question (query-string "Does it squeak?") (answer yes))
   =>
   (printout t "I guess it is a mouse." crlf))

(defrule guess-giraffe
   (question (query-string "Is it very big?") (answer yes))
   (question (query-string "Does it have a long neck?") (answer yes))
   =>
   (printout t "I guess it is a giraffe." crlf))

(defrule guess-elephant
   (question (query-string "Does it have a long neck?") (answer no))
   (question (query-string "Does it have a trunk?") (answer yes))
   =>
   (printout t "I guess it is an elephant." crlf))

(defrule guess-hippopotamus
   (question (query-string "Does it have a trunk?") (answer no))
   (question (query-string "Does it like to be in water?") (answer yes))
   =>
   (printout t "I guess it is a hippopotamus." crlf))

(defrule guess-rhinoceros
   (question (query-string "Does it have a trunk?") (answer no))
   (question (query-string "Does it like to be in water?") (answer no))
   =>
   (printout t "I guess it is a rhinoceros." crlf))