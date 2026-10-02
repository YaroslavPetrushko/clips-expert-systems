(deftemplate MAIN::person
   (slot name)
   (slot age)
   (slot gender))

(deffacts MAIN::people
   (person (name John) (age 30) (gender male))
   (person (name Alice) (age 22) (gender female))
   (person (name Mark) (age 20) (gender male)))

