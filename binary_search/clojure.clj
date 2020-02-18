(ns solution
  (:require [clojure.test :refer :all]))

(defn b-search [arr value]
  (loop [slice arr, slice-index 0]
    (case (count slice)
      0 nil
      1 (when (= value (first slice)) slice-index)

      (let [mid (quot (count slice) 2)]
        (if (> (slice mid) value)
          (recur (subvec slice 0 mid) slice-index)
          (recur (subvec slice mid) (+ slice-index mid)))))))





(deftest b-search-test
  (is (= 0 (b-search [3] 3)))
  (is (nil? (b-search [3] 5)))
  (is (= 2 (b-search [1 2 3] 3)))
  (is (= 1 (b-search [4 5 6] 5)))
  (is (nil? (b-search [4 5 6] 1)))
  (is (nil? (b-search [4 5 6] 9)))
  (is (nil? (b-search [4 5 10] 7))))

(run-tests)
