(defrule MAIN::find-woman
   (person (name $?name) (gender female))
   =>
   (printout t "Found woman: " ?name crlf))

