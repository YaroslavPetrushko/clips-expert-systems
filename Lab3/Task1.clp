(deftemplate MAIN::family-relation
   (slot relation (allowed-values father mother))
   (slot parent)
   (slot child))

(deftemplate MAIN::parents
   (slot child)
   (multislot parent-list))

(deftemplate MAIN::has-role
   (slot person)
   (slot role (allowed-values father mother son daughter)))

(deftemplate MAIN::has-gender
   (slot person)
   (slot gender (allowed-values male female)))

(deffacts MAIN::family-short
   (family-relation (relation father) (parent Tom) (child John))
   (family-relation (relation mother) (parent Susan) (child John))
   (has-gender (person John) (gender male)))

(defrule MAIN::father-role
   (family-relation (relation father) (parent ?x) (child ?y))
   (not (has-role (person ?x) (role father)))
   =>
   (assert (has-role (person ?x) (role father)))
   (printout t ?x " is a father." crlf))

(defrule MAIN::mother-role
   (family-relation (relation mother) (parent ?x) (child ?y))
   (not (has-role (person ?x) (role mother)))
   =>
   (assert (has-role (person ?x) (role mother)))
   (printout t ?x " is a mother." crlf))

(defrule MAIN::gender-from-role
   (has-role (person ?p) (role ?r))
   (test (or (eq ?r father) (eq ?r mother)))
   (not (has-gender (person ?p)))
   =>
   (if (eq ?r father)
      then
      (assert (has-gender (person ?p) (gender male)))
      else
      (assert (has-gender (person ?p) (gender female)))))

(defrule MAIN::are-parents
   (family-relation (relation father) (parent ?f) (child ?c))
   (family-relation (relation mother) (parent ?m) (child ?c))
   (not (parents (child ?c)))
   =>
   (assert (parents (child ?c) (parent-list ?f ?m)))
   (printout t "The parents of " ?c " are " ?f " and " ?m "." crlf))

(defrule MAIN::child-role
   (family-relation (relation father|mother) (child ?c))
   (has-gender (person ?c) (gender ?g))
   (not (has-role (person ?c) (role son|daughter)))
   =>
   (if (eq ?g male)
      then
      (assert (has-role (person ?c) (role son)))
      else
      (assert (has-role (person ?c) (role daughter)))))

