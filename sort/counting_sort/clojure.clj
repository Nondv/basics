(ns solution
  (:require [clojure.test :refer :all]))

(defn counting-sort [arr]
  (let [min-val (apply min arr)
        max-val (apply max arr)
        counters (frequencies arr)]
    (loop [number min-val, result '()]
      (if (> number max-val)
        result
        (let [quantity (counters number)]
          (recur (inc number)
                 (concat result (repeat quantity number))))))))

(defn benchmark-for-coll [f arr]
  (time (f arr)))

(def ten-k 10000)

(defn sort-benchmark [f]
  (let [random-coll (repeatedly #(rand-int 100))
        range-coll (iterate inc 0)]
    (println "[Random]")
    (benchmark-for-coll f (take ten-k random-coll))
    (benchmark-for-coll f (take (* 100 ten-k) random-coll))
    (benchmark-for-coll f (take (* 500 ten-k) random-coll))

    (println "[Reverse]")
    (benchmark-for-coll f (reverse (take ten-k range-coll)))
    (benchmark-for-coll f (reverse (take (* 100 ten-k) range-coll)))
    (benchmark-for-coll f (reverse (take (* 500 ten-k) range-coll)))))

(deftest counting-sort-test
  (is (= (range 10) (counting-sort (shuffle (range 10)))))
  (is (= (range 10) (counting-sort (reverse (range 10))))))

(run-tests)


(sort-benchmark counting-sort)
(sort-benchmark sort)
