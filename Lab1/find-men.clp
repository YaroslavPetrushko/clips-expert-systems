(defrule MAIN::find-men
   (person (name $?name) (gender male))
   =>
   (printout t "Found men: " ?name crlf))

