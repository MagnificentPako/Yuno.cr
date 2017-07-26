(defmacro λ (&args) `(lambda ,@args))

(defun repeat (x y)
    (if (= 0 y)
        '()
        (cons x
            (repeat x (- y 1)))))
            