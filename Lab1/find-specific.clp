(defrule find-specific-name
   (person (name Mark) (age ?age) (gender ?gender))
   =>
   (printout t "Found Mark: Age = " ?age ", Gender = " ?gender crlf))
   
(defrule find-by-age-20
   (person (name $?name) (age 20))
   =>
   (printout t "Person aged 20: " ?name crlf))
