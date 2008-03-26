;; half-life (jrhb)

(let* ((t-half 3.92)
       (n-atoms 1e+5)
       (n (u:max 0 (sub n-atoms (pulse-count (local-in 2 ar) 0))))
       (activity (dust ar (mul n (fdiv (log 2) t-half)))))
  (audition (mrg2 (local-out activity)
                  (out 0 activity))))
