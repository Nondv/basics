(ns main
  (:require [clojure.test :refer :all]))

(defn sleep-sort [multiplier coll]
  (let [result-atom (atom [])
        futures (doall (map
                        #(future (Thread/sleep (* % multiplier))
                                 (swap! result-atom conj %))
                        coll))]
    (run! deref futures)
    @result-atom))





(deftest sleep-sort-test
  (is (= (range 10) (sleep-sort 1 (shuffle (range 10)))))
  (is (= (range 10) (sleep-sort 1 (shuffle (range 10)))))

  (is (= (range 50) (sleep-sort 1 (shuffle (range 50)))))
  (is (= (range 50) (sleep-sort 1 (shuffle (range 50)))))

  (is (= (range 20) (sleep-sort 10 (shuffle (range 20)))))
  (is (= (range 20) (sleep-sort 10 (shuffle (range 20)))))

  (is (= (range 50) (sleep-sort 10 (shuffle (range 50)))))
  (is (= (range 50) (sleep-sort 10 (shuffle (range 50))))))

(run-tests)
(shutdown-agents)
