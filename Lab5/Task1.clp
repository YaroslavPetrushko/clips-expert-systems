;;; Завдання 1: префіксні вирази та їх обчислення в CLIPS

(deffunction show-expression (?label ?infix ?prefix ?value)
   (printout t ?label " infix : " ?infix crlf)
   (printout t "   prefix: " ?prefix crlf)
   (printout t "   value : " ?value crlf crlf))

(deffunction task-1 ()
   (show-expression "a)"
      "(3 + 4) * (5 + 6) + 7"
      "(+ (* (+ 3 4) (+ 5 6)) 7)"
      (+ (* (+ 3 4) (+ 5 6)) 7))

   (show-expression "b)"
      "(5 * (5 + 6 + 7)) - ((3 * (4/9) + 2) / 8)"
      "(- (* 5 (+ 5 6 7)) (/ (+ (* 3 (/ 4 9)) 2) 8))"
      (- (* 5 (+ 5 6 7)) (/ (+ (* 3 (/ 4 9)) 2) 8)))

   (show-expression "c)"
      "6 - 9 * 8/3 + 4 - (8 - 2 - 3) * 6/7"
      "(- (+ (- 6 (/ (* 9 8) 3)) 4) (/ (* (- (- 8 2) 3) 6) 7))"
      (- (+ (- 6 (/ (* 9 8) 3)) 4) (/ (* (- (- 8 2) 3) 6) 7))))