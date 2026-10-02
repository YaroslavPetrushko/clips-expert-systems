(deffacts MAIN::what-day-is-it
   (Today is Thursday)
   (Tomorrow is Friday))

(defrule MAIN::check-today
   (Today is ?day)
   =>
   (printout t "Today is " ?day crlf))

