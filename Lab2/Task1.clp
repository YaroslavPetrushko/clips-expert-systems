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

(deffacts MAIN::family
   (family-relation (relation father) (parent Tom) (child John))
   (family-relation (relation mother) (parent Susan) (child John))
   (parents (child John) (parent-list Tom Susan))
   (has-role (person Tom) (role father))
   (has-role (person Susan) (role mother))
   (has-role (person John) (role son))
   (has-gender (person Tom) (gender male))
   (has-gender (person Susan) (gender female))
   (has-gender (person John) (gender male)))

