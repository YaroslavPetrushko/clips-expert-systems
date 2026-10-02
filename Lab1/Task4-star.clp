(deftemplate person
   (multislot name)
   (slot age (type INTEGER))
   (slot gender (allowed-values male female)))

(deffacts people-extended
   (person (name John Smith) (age 33) (gender male))
   (person (name Alice) (age 22) (gender female))
   (person (name Mark) (age 20) (gender male)))

