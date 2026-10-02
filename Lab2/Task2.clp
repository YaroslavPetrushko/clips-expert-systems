(deftemplate MAIN::AKO
   (slot subclass)
   (slot superclass))

(deftemplate MAIN::IS-A
   (slot instance)
   (slot class))

(deffacts MAIN::computer-classification-network
   (AKO (subclass general-purpose-computer) (superclass computing-system))
   (AKO (subclass dedicated-computer) (superclass computing-system))
   (AKO (subclass supercomputer) (superclass computing-system))
   (AKO (subclass mainframe) (superclass computing-system))
   (AKO (subclass microcomputer) (superclass computing-system))
   (AKO (subclass single-board-computer) (superclass microcomputer))
   (AKO (subclass single-chip-computer) (superclass microcomputer))
   (AKO (subclass uniprocessor-system) (superclass computing-system))
   (AKO (subclass multiprocessor-system) (superclass computing-system))
   (IS-A (instance Frontier-HPE) (class supercomputer))
   (IS-A (instance IBM-z16) (class mainframe))
   (IS-A (instance Raspberry-Pi-4) (class single-board-computer))
   (IS-A (instance Arduino-Uno-ATmega328) (class single-chip-computer))
   (IS-A (instance Apple-MacBook-Pro-M3) (class multiprocessor-system))
   (IS-A (instance IBM-PC-XT-Intel8088) (class uniprocessor-system))
   (IS-A (instance Dell-Tower-Desktop) (class general-purpose-computer)))

