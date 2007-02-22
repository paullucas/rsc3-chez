; /b_query

; [
;  int - buffer number
; ] * N

; Responds to the sender with a /b_info message.  The arguments to
; /b_info are as follows:

; [
;  int - buffer number
;  int - number of frames
;  int - number of channels
;  float - sample rate
; ] * N

(->< s (/b_alloc 10 6 1))

(->< s (/b_query 10))
