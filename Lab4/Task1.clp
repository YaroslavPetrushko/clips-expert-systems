;; Лічильник кількості виявлених дефіцитів 
(defglobal ?*deficiency-count* = 0)

; Шаблон для фіксації симптомів рослини (вхідні дані)
(deftemplate symptom
   (slot name (type SYMBOL)))

; Шаблон для висновку про дефіцит (вихідні дані)
(deftemplate deficiency
   (slot nutrient (type SYMBOL) (allowed-values nitrogen phosphorus potassium)))

;; ФУНКЦІЇ 
;; Повертає текстову рекомендацію щодо добрива для заданої поживної речовини
(deffunction get-recommendation (?nutrient)
   (switch ?nutrient
      (case nitrogen then
         "Apply a nitrogen-rich fertilizer (e.g. urea, ammonium nitrate).")
      (case phosphorus then
         "Apply a phosphorus-rich fertilizer (e.g. bone meal, superphosphate).")
      (case potassium then
         "Apply a potassium-rich fertilizer (e.g. potash, wood ash).")
      (default "No recommendation available.")))

;; Друкує повне діагностичне повідомлення та рекомендацію;
;; оновлює глобальний лічильник дефіцитів
(deffunction print-diagnosis (?nutrient)
   (printout t "Diagnosis: The plant has a " ?nutrient " deficiency." crlf)
   (printout t "  -> Recommendation: " (get-recommendation ?nutrient) crlf)
   (bind ?*deficiency-count* (+ ?*deficiency-count* 1)))

;; Друкує заголовок звіту (функція без параметрів)
(deffunction print-header ()
   (printout t "----" crlf)
   (printout t " PLANT NUTRIENT DEFICIENCY DIAGNOSIS REPORT" crlf)
   (printout t "----" crlf))

;; Друкує підсумок роботи системи
(deffunction print-summary ()
   (printout t "=====" crlf)
   (if (= ?*deficiency-count* 0)
       then (printout t "Result: No nutrient deficiencies detected." crlf)
       else (printout t "Total deficiencies detected: " ?*deficiency-count* crlf)))

;; ДОВІДКОВА ФУНКЦІЯ (МАНУАЛ)

(deffunction show-help ()
   (printout t "----" crlf)
   (printout t " PLANT DIAGNOSIS SYSTEM - AVAILABLE COMMANDS" crlf)
   (printout t "----" crlf)
   (printout t "(show-help)     - display this manual" crlf)
   (printout t "(load-test-1)   - load test case 1: phosphorus deficiency" crlf)
   (printout t "(load-test-2)   - load test case 2: nitrogen deficiency (dedup test)" crlf)
   (printout t "(load-test-3)   - load test case 3: multiple deficiencies" crlf)
   (printout t "(load-test-4)   - load test case 4: healthy plant (no deficiency)" crlf)
   (printout t "(run)           - execute the rule engine on loaded facts" crlf)
   (printout t "(reset)         - clear all facts manually" crlf)
   (printout t "----" crlf)
   (printout t "Valid symptom names:" crlf)
   (printout t "  stunted-growth, pale-yellow-color, reddish-brown-leaf-edges" crlf)
   (printout t "  stunted-root-growth, spindly-stalk, purplish-color, delayed-maturing" crlf)
   (printout t "  scorched-leaf-edges, weakened-stems, shriveled-seeds-or-fruits" crlf)
   (printout t "====" crlf))

(deffunction reset-counter ()
   (bind ?*deficiency-count* 0))

;; Тест 1: дефіцит фосфору (базовий варіант з лаб 3)
(deffunction load-test-1 ()
   (reset)
   (reset-counter)
   (assert (symptom (name stunted-root-growth)))
   (assert (symptom (name purplish-color)))
   (printout t ">> Test case 1 loaded: expected result - phosphorus deficiency." crlf))

;; Тест 2: дефіцит азоту, 2 симптоми одночасно (перевірка дедуплікації)
(deffunction load-test-2 ()
   (reset)
   (reset-counter)
   (assert (symptom (name stunted-growth)))
   (assert (symptom (name pale-yellow-color)))
   (printout t ">> Test case 2 loaded: expected result - nitrogen deficiency (single message)." crlf))

;; Тест 3: одночасний дефіцит двох елементів
(deffunction load-test-3 ()
   (reset)
   (reset-counter)
   (assert (symptom (name scorched-leaf-edges)))    ; potassium
   (assert (symptom (name weakened-stems)))         ; potassium
   (assert (symptom (name delayed-maturing)))       ; phosphorus
   (printout t ">> Test case 3 loaded: expected result - potassium + phosphorus deficiency." crlf))

;; Тест 4: здорова рослина, симптомів немає
(deffunction load-test-4 ()
   (reset)
   (reset-counter)
   (printout t ">> Test case 4 loaded: expected result - no deficiencies (healthy plant)." crlf))

; ПРАВИЛА ДІАГНОСТИКИ (по одному на кожну поживну речовину)
(defrule check-nitrogen
   (or (symptom (name stunted-growth))
       (symptom (name pale-yellow-color))
       (symptom (name reddish-brown-leaf-edges)))
   (not (deficiency (nutrient nitrogen)))
   =>
   (assert (deficiency (nutrient nitrogen))))

(defrule check-phosphorus
   (or (symptom (name stunted-root-growth))
       (symptom (name spindly-stalk))
       (symptom (name purplish-color))
       (symptom (name delayed-maturing)))
   (not (deficiency (nutrient phosphorus)))
   =>
   (assert (deficiency (nutrient phosphorus))))

(defrule check-potassium
   (or (symptom (name scorched-leaf-edges))
       (symptom (name weakened-stems))
       (symptom (name shriveled-seeds-or-fruits)))
   (not (deficiency (nutrient potassium)))
   =>
   (assert (deficiency (nutrient potassium))))

; ПРАВИЛО ВИВЕДЕННЯ РЕЗУЛЬТАТУ
(defrule start-report
   (declare (salience 100))
   =>
   (print-header))

(defrule report-deficiency
   (deficiency (nutrient ?nutrient))
   =>
   (print-diagnosis ?nutrient))

(defrule end-report
   (declare (salience -100))
   =>
   (print-summary))
