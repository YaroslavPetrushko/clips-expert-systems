(deftemplate MAIN::symptom
   (slot name))

(deftemplate MAIN::deficiency
   (slot nutrient (allowed-values nitrogen phosphorus potassium)))

(deffacts MAIN::plant-test-case
   (symptom (name stunted-root-growth))
   (symptom (name purplish-color)))

(defrule MAIN::check-nitrogen
   (or  (symptom (name stunted-growth))
        (symptom (name pale-yellow-color))
        (symptom (name reddish-brown-leaf-edges)))
   (not (deficiency (nutrient nitrogen)))
   =>
   (assert (deficiency (nutrient nitrogen))))

(defrule MAIN::check-phosphorus
   (or  (symptom (name stunted-root-growth))
        (symptom (name purplish-color))
        (symptom (name spindly-stalk))
        (symptom (name delayed-maturing)))
   (not (deficiency (nutrient phosphorus)))
   =>
   (assert (deficiency (nutrient phosphorus))))

(defrule MAIN::check-potassium
   (or  (symptom (name scorched-leaf-edges))
        (symptom (name weakened-stems))
        (symptom (name shriveled-seeds-or-fruits)))
   (not (deficiency (nutrient potassium)))
   =>
   (assert (deficiency (nutrient potassium))))

(defrule MAIN::report-deficiency
   (deficiency (nutrient ?nutrient))
   =>
   (printout t "Diagnosis: The plant has a " ?nutrient " deficiency." crlf))

