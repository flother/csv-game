(ns csv.core
  (:gen-class))

(require '[clojure.data.csv :as csv]
         '[clojure.java.io :as io])

(defn -main
  "Read from stdin and count the number of fields."
  [& args]
  (with-open [in-file (io/reader "/dev/stdin")]
      (println (reduce + (map count (csv/read-csv in-file))))))
