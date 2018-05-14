(library (rsc3)
  (export thread-sleep utcr b-alloc b-alloc-read b-alloc-read-channel b-close b-fill1 b-free b-gen1 b-get1 b-getn1 b-query1 b-read b-set1 b-setn1
          b-write b-zero c-fill1 c-get1 c-getn1 c-set1 c-setn1 d-free1 d-load d-load-dir d-recv g-deep-free1 g-free-all1 g-head1 g-new1 g-tail1
          n-before n-fill1 n-free1 n-map n-mapn1 n-query n-run1 n-set n-set1 n-setn1 n-trace s-get1 s-getn1 s-new s-new0 s-new1 s-new2 s-noid
          clear-sched dump-osc notify quit status sync dinf e pi two-pi half-pi add-to-head add-to-tail add-before add-after add-replace gen-normalize
          gen-wavetable gen-clear do-nothing pause-synth remove-synth remove-group no-loop loop linear exponential uid make-uid uid? uid-n incr-uid
          unique-uid control make-control control? control-name control-index control* make-control* control*? control*-name control*-default control*-rate
          control*-lag letc graphdef make-graphdef graphdef? graphdef-name graphdef-constants graphdef-defaults graphdef-controls graphdef-ugens graphdef-ugen
          graphdef-control graphdef-constant input make-input input? input-ugen input-port mce make-mce mce? mce-proxies mrg make-mrg mrg? mrg-left mrg-right
          output make-output output? output-rate proxy make-proxy proxy? proxy-ugen proxy-port rate make-rate rate? rate-value ir kr ar dr rate->symbol rate-of
          rate-to-ordinal rate-select* rate-select ugen make-ugen ugen? ugen-name ugen-rate ugen-inputs ugen-outputs ugen-special ugen-id ugen-output ugen-transform
          input*? ugen-valid? clone* clone encode-control encode-input encode-output scgf encode-ugen encode-graphdef proxify construct-ugen mk-ugen graph-nodes
          graph-constants graph-controls* graph-ugens ugen-close prepare-root count-local-buf implicit-max-local-bufs synthdef synthdef-write implicit-ugen
          calculate-index number-to-input control*-to-control control*-to-input ugen-to-input proxy-to-input input*-to-input mce* mce-channels mce-degree mce-required?
          mce-extend mce-transform mce-expand async reset with-udp-sc3 with-tcp-sc3 with-sc3 status-fields status-format server-status display-server-status
          server-status-field server-sample-rate-nominal server-sample-rate-actual send-synth play-at audition-using audition random i-random utc add3 add4 as-local-buf
          buf-rd-c buf-rd-l buf-rd-n cps-midi dcons dyn-klank* dyn-klank fdiv fft* freq-shift* hear ifft* klang-data klank-data klank-data-mce l-choose lin-lin mce2 mce3
          mce4 mce5 mce-channel mce-edit mce-fill mce-map mce-reverse mce-transpose midi-cps mix mix-fill mouse-r mouse-x* mouse-y* mouse-button* mrg2 mrg3 mrg4 mrg5 mrg-n
          mul3 mul4 packfft-data packfft-data* pause-thread pause-thread-until play pm-osc pvcollect rand* set-buf* sound-in t-choose tw-choose tw-index unpack-fft with-sc3*
          exp-random choose curve-to-shape curve-to-value env env-coord env-coord-linear mk-coord env-bp env-bp-linear env-trapezoid env-triangle env-sine env-perc env-adsr
          env-asr env-linen exp-rand-n i-rand-n lin-rand-n rand-n t-scramble pack-fft unpack1-fft mk-unary-operator mk-binary-operator mk-filter mk-filter-n mk-filter-mce
          mk-filter-id mk-filter-k mk-oscillator mk-oscillator-n mk-oscillator-mce mk-oscillator-id mk-specialized mk-specialized-c mk-specialized-mce mk-specialized-n
          mk-specialized-id mk-specialized-n-id mk-specialized-mce-id extend take-cycle differentiate-with differentiate integrate-with integrate d->dx without consecutive?
          s:lt s:le s:ge s:gt s:round s:clip s:squared s:cubed s:recip s:log2 s:log10 s:amp-db s:db-amp s:pow-db s:db-pow s:midi-cps s:cps-midi s:midi-ratio s:ratio-midi
          s:oct-cps s:cps-oct s:degree-to-key s:l-choose a2k apf allpass-c allpass-l allpass-n amp-comp amp-comp-a amplitude audio-control b-all-pass b-band-pass b-band-stop
          b-hi-pass b-hi-shelf b-low-pass b-low-shelf bpf bpz2 b-peak-eq brf brz2 balance2 ball beat-track beat-track2 bi-pan-b2 binary-op-ugen blip block-size brown-noise
          buf-allpass-c buf-allpass-l buf-allpass-n buf-channels buf-comb-c buf-comb-l buf-comb-n buf-delay-c buf-delay-l buf-delay-n buf-dur buf-frames buf-rate-scale buf-rd
          buf-sample-rate buf-samples buf-wr c-osc check-bad-values clip clip-noise coin-gate comb-c comb-l comb-n compander compander-d control-dur control-rate convolution
          convolution2 convolution2l convolution3 crackle cusp-l cusp-n dc dbrown dbufrd dbufwr decay decay2 decode-b2 degree-to-key del-tap-rd del-tap-wr delay1 delay2
          delay-c delay-l delay-n demand demand-env-gen detect-index detect-silence dgeom dibrown disk-in disk-out diwhite donce done dpoll drand dreset dseq dser dseries
          dshuf dstutter dswitch dswitch1 dunique dust dust2 dust-r duty dwhite dwrand dxrand env-gen exp-rand fb-sine-c fb-sine-l fb-sine-n fft fos f-sin-osc fold formant
          formlet free free-self free-self-when-done free-verb free-verb2 freq-shift g-verb gate gbman-l gbman-n gendy1 gendy2 gendy3 grain-buf grain-fm grain-in grain-sin
          gray-noise hpf hpz1 hpz2 hasher henon-c henon-l henon-n hilbert hilbert-fir i-env-gen ifft i-rand impulse in in-feedback in-range in-rect in-trig index index-in-between
          index-l info-ugen-base integrator k2a key-state key-track klang klank lf-clip-noise lf-cub lfd-clip-noise lfd-noise0 lfd-noise1 lfd-noise3 lf-gauss lf-noise0 lf-noise1
          lf-noise2 lf-par lf-pulse lf-saw lf-tri lpf lpz1 lpz2 lag lag2 lag2ud lag3 lag3ud lag-control lag-in lag-ud last-value latch latoocarfian-c latoocarfian-l latoocarfian-n
          leak-dc least-change limiter lin-cong-c lin-cong-l lin-cong-n lin-exp lin-pan2 lin-rand lin-x-fade2 line linen local-buf local-in local-out logistic lorenz-l loudness
          mfcc mantissa-mask max-local-bufs median mid-eq mod-dif moog-ff most-change mouse-button mouse-x mouse-y n-rand normalizer num-audio-buses num-buffers num-control-buses
          num-input-buses num-output-buses num-running-synths offset-out one-pole one-zero onsets osc osc-n out p-sin-grain pv-add pv-bin-scramble pv-bin-shift pv-bin-wipe
          pv-brick-wall pv-chain-ugen pv-conformal-map pv-conj pv-copy pv-copy-phase pv-diffuser pv-div pv-hainsworth-foote pv-jensen-andersen pv-local-max pv-mag-above
          pv-mag-below pv-mag-clip pv-mag-div pv-mag-freeze pv-mag-mul pv-mag-noise pv-mag-shift pv-mag-smear pv-mag-squared pv-max pv-min pv-mul pv-phase-shift pv-phase-shift270
          pv-phase-shift90 pv-rand-comb pv-rand-wipe pv-rect-comb pv-rect-comb2 pv-split pan2 pan4 pan-az pan-b pan-b2 part-conv pause pause-self pause-self-when-done peak
          peak-follower phasor pink-noise pitch pitch-shift play-buf pluck poll pulse pulse-count pulse-divider quad-c quad-l quad-n r-delay-map r-delay-set r-delay-set-b
          r-freezer rhpf rlpf r-loop-set r-play-trace r-shuffler-b r-shuffler-l r-trace-rd r-trace-rd-x r-trace-rd-y r-trace-rd-z radians-per-sample ramp rand rand-id rand-seed
          record-buf replace-out resonz ringz rotate2 running-max running-min running-sum sos sample-dur sample-rate saw schmidt scope-out scope-out2 select send-trig set-reset-ff
          shaper sin-osc sin-osc-fb slew slope spec-centroid spec-flatness spec-pcile spring standard-l standard-n stepper stereo-convolution2l subsample-offset sum3 sum4 sweep
          sync-saw t2a t2k t-ball t-delay t-duty t-exp-rand t-grains ti-rand t-rand t-windex tap timer toggle-ff trig trig1 trig-control two-pole two-zero unary-op-ugen v-disk-in
          v-osc v-osc3 var-lag var-saw vibrato warp1 white-noise width-first-ugen wrap wrap-index x-fade2 x-line x-out zero-crossing mul-add set-buf neg u:not is-nil not-nil bit-not
          u:abs as-float as-int ceil u:floor frac sign squared cubed u:sqrt u:exp recip midicps cpsmidi midi-ratio ratio-midi db-amp amp-db oct-cps cps-oct u:log log2 log10 u:sin
          u:cos u:tan arc-sin arc-cos arc-tan sin-h cos-h tan-h rand- rand2 lin-rand- bi-lin-rand sum3rand distort soft-clip coin digit-value silence thru rect-window han-window
          welch-window tri-window ramp- s-curve add sub mul i-div f-div u:mod u:eq ne u:lt u:gt le ge u:min u:max bit-and bit-or bit-xor u:lcm u:gcd u:round round-up trunc atan2
          hypot hypotx pow shift-left shift-right unsigned-shift fill ring1 ring2 ring3 ring4 dif-sqr sum-sqr sqr-sum sqr-dif abs-dif thresh am-clip scale-neg clip2 excess fold2
          wrap2 first-arg rand-range exp-rand-range

          ;; rsc3-lang

          series* series shuffle w-index w-choose normalize-sum p-choose vector-choose pi2 pi32 twopi rtwopi
          log001 log01 log1 rlog2 sqrt2 rsqrt2 extend-all dt-rescheduler mk-env with-env overlap-texture-iot
          from-maybe-closure generalised-texture spawn-u overlap-texture overlap-texture-u xfade-texture-iot
          xfade-texture xfade-texture-u post-process-u random-linear random-inverse-linear random-triangular
          random-exponential random-bilinear-exponential random-gaussian random-cauchy random-beta random-weibull
          random-poisson unipolar? range exp-range recv* encode-score au-magic au-unspecified au-mulaw8 au-linear8
          au-linear16 au-linear24 au-linear32 au-float au-double au-size-of au-mk-hdr au-f32 au-f64 write-snd-file
          spec make-spec spec? spec-minima spec-maxima spec-warp spec-range spec-ratio make-spec* r:clip spec-map
          spec-unmap symbol->spec splice warp-fwd? warp-linear warp-linear-integer warp-exponential warp-make-warp-curve
          warp-cosine warp-sine warp-fader warp-db-fader symbol->warp number->warp segment wavetable->signal signal->wavetable)

  (import (rnrs)
          (rhs)
          (sosc)
          (prefix (srfi :9 records) srfi:)
          (prefix (srfi :19 time) srfi:)
          (prefix (srfi :27 random-bits) srfi:)
          ;; (only (chezscheme) sleep time-nanosecond time-second current-time)
          (only (chezscheme) sleep))

  ;;
  ;; Sys
  ;; 

  ;; float -> void
  (define thread-sleep sleep)

  ;; void -> float
  (define (utcr)
    (let* ((t (srfi:current-time))
           (s (srfi:time-second t))
           (n (srfi:time-nanosecond t)))
      (+ s (/ n 1000000000.0))))

  ;;
  ;; Command
  ;; 
  
  (define (b-alloc b nf nc)
    (message "/b_alloc" (list b nf nc)))
  
  (define (b-alloc-read b fn f0 n)
    (message "/b_allocRead" (list b fn f0 n)))
  
  (define (b-alloc-read-channel nid p f n cs)
    (message "/b_allocReadChannel" (append (list nid p f n) cs)))
  
  (define (b-close i)
    (message "/b_close" (list i)))
  
  (define (b-fill1 i j k f)
    (message "/b_fill" (list i j k f)))
  
  (define (b-free i)
    (message "/b_free" (list i)))
  
  (define (b-gen1 i s fs)
    (message "/b_gen" (cons i (cons s fs))))
  
  (define (b-get1 i j)
    (message "/b_get" (list i j)))
  
  (define (b-getn1 i j k)
    (message "/b_getn" (list i j k)))
  
  (define (b-query1 i)
    (message "/b_query" (list i)))
  
  (define (b-read id path frame n bframe flag)
    (message "/b_read" (list id path frame n bframe flag)))
  
  (define (b-set1 i j f)
    (message "/b_set" (list i j f)))
  
  (define (b-setn1 i j fs)
    (message "/b_setn" (cons i (cons j (cons (length fs) fs)))))
  
  (define (b-write id path header type frames start flag)
    (message "/b_write" (list id path header type frames start flag)))
  
  (define (b-zero i)
    (message "/b_zero" (list i)))
  
  (define (c-fill1 i j f)
    (message "/c_fill" (list i j f)))
  
  (define (c-get1 i)
    (message "/c_get" (list i)))
  
  (define (c-getn1 i j)
    (message "/c_getn" (list i j)))
  
  (define (c-set1 i f)
    (message "/c_set" (list i f)))
  
  (define (c-setn1 i fs)
    (message "/c_setn" (cons i (cons (length fs) fs))))
  
  (define (d-free1 s)
    (message "/d_free" (list s)))
  
  (define (d-load s)
    (message "/d_load" (list s)))
  
  (define (d-load-dir s)
    (message "/d_loadDir" (list s)))
  
  (define (d-recv b)
    (message "/d_recv" (list b)))
  
  (define (g-deep-free1 i)
    (message "/g_deepFree" (list i)))
  
  (define (g-free-all1 i)
    (message "/g_freeAll" (list i)))
  
  (define (g-head1 i j)
    (message "/g_head" (list i j)))
  
  (define (g-new1 i j k)
    (message "/g_new" (list i j k)))
  
  (define (g-tail1 i j)
    (message "/g_tail" (list i j)))
  
  (define (n-before i j)
    (message "/n_before" (list i j)))
  
  (define (n-fill1 i s j f)
    (message "/n_fill" (list i s j f)))
  
  (define (n-free1 i)
    (message "/n_free" (list i)))
  
  (define (n-map i s j)
    (message "/n_map" (list i s j)))
  
  (define (n-mapn1 i s j k)
    (message "/n_mapn" (list i s j k)))
  
  (define (n-query i)
    (message "/n_query" (list i)))
  
  (define (n-run1 i j)
    (message "/n_run" (list i j)))
  
  (define (n-set i xys)
    (let ((z (concat-map (lambda (xy)
                           (list (car xy) (cdr xy)))
                         xys)))
      (message "/n_set" (cons i z))))
  
  (define (n-set1 i s f)
    (message "/n_set" (list i s f)))
  
  (define (n-setn1 i s fs)
    (message "/n_setn" (cons i (cons s (cons (length fs) fs)))))
  
  (define (n-trace i)
    (message "/n_trace" (list i)))
  
  (define (s-get1 i j)
    (message "/s_get" (list i j)))
  
  (define (s-getn1 i s j)
    (message "/s_getn" (list i s j)))
  
  (define (s-new s i j k cs)
    (message "/s_new" (append (list s i j k) cs)))
  
  (define (s-new0 s i j k)
    (message "/s_new" (list s i j k)))
  
  (define (s-new1 s i j k t f)
    (message "/s_new" (list s i j k t f)))
  
  (define (s-new2 s i j k t1 f1 t2 f2)
    (message "/s_new" (list s i j k t1 f1 t2 f2)))
  
  (define (s-noid i)
    (message "/s_noid" (list i)))
  
  (define clear-sched (message "/clearSched" nil))
  
  (define (dump-osc i)
    (message "/dumpOSC" (list i)))
  
  (define (notify i)
    (message "/notify" (list i)))
  
  (define quit (message "/quit" nil))
  
  (define status (message "/status" nil))
  
  (define (sync i)
    (message "/sync" (list i)))

  ;;
  ;; Constant - Math
  ;; 
  
  (define dinf 900000000.0)
  (define e 2.718281828459045)
  (define pi 3.141592653589793)
  (define two-pi (* 2 pi))
  (define half-pi (* 0.5 pi))

  ;;
  ;; Constant - Enumeration
  ;; 
  
  (define add-to-head 0)
  (define add-to-tail 1)
  (define add-before 2)
  (define add-after 3)
  (define add-replace 4)
  
  (define gen-normalize 1)
  (define gen-wavetable 2)
  (define gen-clear 4)
  
  (define do-nothing 0)
  (define pause-synth 1)
  (define remove-synth 2)
  (define remove-group 14)
  
  (define no-loop 0)
  (define loop 1)
  
  (define linear 0)
  (define exponential 1)

  ;; 
  ;; Core - UID
  ;; 

  ;; int -> uid
  (define-record-type uid
    (fields n))

  ;; () -> uid
  (define incr-uid
    (let ((n 0))
      (lambda (i)
        (set! n (+ n i))
        (make-uid n))))
  
  (define (unique-uid)
    (incr-uid 1))

  ;; Core - Control

  ;; string -> int -> control
  (define-record-type control
    (fields name index))

  ;; string -> float -> rate -> float -> control*
  (define-record-type control*
    (fields name default rate lag))

  ;; syntax for binding control values
  (define-syntax letc
    (syntax-rules ()
      ((_ () expr)
       expr)
      ((_ ((name default) ...) expr)
       (let ((name (make-control*
                    (symbol->string (quote name)) default kr 0))
             ...)
         expr))))

  ;; Core - Graphdef

  ;; string -> [float] -> [float] -> [controls] -> [ugens] -> graphdef
  (define-record-type graphdef
    (fields name constants defaults controls ugens))

  ;; graphdef -> int -> ugen
  (define (graphdef-ugen g n)
    (list-ref (graphdef-ugens g) n))

  ;; graphdef -> int -> control
  (define (graphdef-control g n)
    (list-ref (graphdef-controls g) n))

  ;; graphdef -> int -> float
  (define (graphdef-constant g n)
    (list-ref (graphdef-constants g) n))

  ;; Core - UGen

  ;; int -> int -> input
  (define-record-type input
    (fields ugen port))
  
  ;; [ugen] -> mce
  (define-record-type mce
    (fields proxies))
  
  ;; ugen -> ugen -> mrg
  (define-record-type mrg
    (fields left right))
  
  ;; rate -> output
  (define-record-type output
    (fields rate))

  ;; ugen -> int -> proxy
  (define-record-type proxy
    (fields ugen port))

  ;; int -> rate
  (define-record-type rate
    (fields value))
  
  ;; rate
  (define ir (make-rate 0))
  (define kr (make-rate 1))
  (define ar (make-rate 2))
  (define dr (make-rate 3))

  ;; rate -> symbol
  ;;
  ;; (map rate->symbol (list ir kr ar dr))
  (define (rate->symbol r)
    (case (rate-value r)
      ((0) (quote ir))
      ((1) (quote kr))
      ((2) (quote ar))
      ((3) (quote dr))
      (else (error "rate->symbol" "unknown rate"))))

  ;; any -> rate
  (define (rate-of o)
    (cond ((number? o) ir)
          ((control*? o) (control*-rate o))
          ((ugen? o) (ugen-rate o))
          ((proxy? o) (rate-of (proxy-ugen o)))
          ((mce? o) (rate-select (map rate-of (mce-proxies o))))
          ((mrg? o) (rate-of (mrg-left o)))
          (else (error "rate-of" "illegal value" o))))

  ;; rate -> int
  (define (rate-to-ordinal r)
    (cond ((eq? r ir) 0)
          ((eq? r kr) 1)
          ((eq? r ar) 2)
          ((eq? r dr) 3)
          (else (error "rate-to-ordinal" "illegal rate"))))

  ;; rate -> rate -> rate
  (define (rate-select* a b)
    (let ((a* (rate-to-ordinal a))
          (b* (rate-to-ordinal b)))
      (if (> a* b*) a b)))

  ;; [rate] -> rate
  (define (rate-select l)
    (foldl1 rate-select* l))

  ;; string -> rate -> [ugen] -> [output] -> int -> uid -> ugen
  (define-record-type ugen
    (fields name rate inputs outputs special id))

  ;; ugen -> int -> output
  (define (ugen-output u n)
    (list-ref (ugen-outputs u) n))

  ;; ugen -> (ugen -> any) -> any
  (define (ugen-transform u f)
    (let ((n (ugen-name u))
          (r (ugen-rate u))
          (i (ugen-inputs u))
          (o (ugen-outputs u))
          (s (ugen-special u))
          (d (ugen-id u)))
      (f n r i o s d)))

  ;; any -> bool
  (define (input*? i)
    (or (number? i)
        (control*? i)
        (ugen? i)
        (proxy? i)
        (mce? i)
        (mrg? i)))

  ;; ugen -> bool
  (define (ugen-valid? u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (and (string? n)
            (rate? r)
            (and (list? i) (all input*? i))
            (and (list? o) (all output? o))
            (integer? s)
            (uid? d)))))

  ;; int -> (() -> ugen) -> mce
  (define (clone* n f)
    (make-mce (replicate-m* n f)))
  
  (define-syntax clone
    (syntax-rules ()
      ((_ n u) (make-mce (replicate-m n u)))))

  ;; control -> [bytevector]
  (define (encode-control c)
    (list2 (encode-pstr (control-name c))
           (encode-i16 (control-index c))))

  ;; input -> [bytevector]
  (define (encode-input i)
    (list2 (encode-i16 (input-ugen i))
           (encode-i16 (input-port i))))

  ;; output -> [bytevector]
  (define (encode-output o)
    (encode-u8 (rate-value (output-rate o))))

  ;; [bytevector]
  (define scgf
    (map encode-u8 (map char->integer (string->list "SCgf"))))

  ;; ugen -> [bytevector]
  (define (encode-ugen u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (list (encode-pstr n)
             (encode-u8 (rate-value r))
             (encode-i16 (length i))
             (encode-i16 (length o))
             (encode-i16 s)
             (map encode-input i)
             (map encode-output o)))))

  ;; graphdef -> bytevector
  (define (encode-graphdef g)
    (flatten-bytevectors
     (let ((n (graphdef-name g))
           (c (graphdef-constants g))
           (d (graphdef-defaults g))
           (k (graphdef-controls g))
           (u (graphdef-ugens g)))
       (list scgf
             (encode-i32 0)
             (encode-i16 1)
             (encode-pstr n)
             (encode-i16 (length c))
             (map encode-f32 c)
             (encode-i16 (length d))
             (map encode-f32 d)
             (encode-i16 (length k))
             (map encode-control k)
             (encode-i16 (length u))
             (map encode-ugen u)))))

  ;; node = ugen | proxy | control* | float

  ;; node -> mce
  (define (proxify u)
    (cond ((mce? u) (make-mce (map proxify (mce-proxies u))))
          ((mrg? u) (make-mrg (proxify (mrg-left u)) (mrg-right u)))
          ((ugen? u) (let* ((o (ugen-outputs u))
                            (n (length o)))
                       (if (< n 2)
                           u
                           (make-mce (map (lambda (i) (make-proxy u i))
                                          (enum-from-to 0 (- n 1)))))))
          (else (error "proxify" "illegal ugen" u))))

  ;; string -> rate|list -> [node] -> node|nil -> int -> int -> uid -> ugen
  (define (construct-ugen name rate inputs mce outputs special id)
    (let* ((inputs* (if (null? mce)
                        inputs
                        (append inputs (mce-channels mce))))
           (rate* (if (rate? rate)
                      rate
                      (rate-select
                       (map (lambda (ix) (rate-of (list-ref inputs* ix)))
                            rate))))
           (special* (if (null? special) 0 special))
           (id* (if (null? id) (make-uid 0) id))
           (u (make-ugen name
                         rate*
                         inputs*
                         (replicate outputs (make-output rate*))
                         special*
                         id*)))
      (proxify (mce-expand u))))
  
  (define (mk-ugen param)
    (apply construct-ugen param))

  ;; ugen -> [node]
  (define (graph-nodes u)
    (cond ((ugen? u) (cons u (concat-map graph-nodes (ugen-inputs u))))
          ((proxy? u) (cons u (graph-nodes (proxy-ugen u))))
          ((control*? u) (list1 u))
          ((number? u) (list1 u))
          ((mce? u) (concat (map graph-nodes (mce-proxies u))))
          ((mrg? u) (append (graph-nodes (mrg-left u)) (graph-nodes (mrg-right u))))
          (else (error "graph-nodes" "illegal value" u))))

  ;; ugen -> [float]
  (define (graph-constants u)
    (nub (filter number? (graph-nodes u))))

  ;; ugen -> [control*]
  (define (graph-controls* u)
    (nub (filter control*? (graph-nodes u))))

  ;; ugen -> [ugen]
  (define (graph-ugens u)
    (nub (reverse (filter ugen? (graph-nodes u)))))

  ;; ugen -> [node] -> [control] -> [ugen] -> ugen
  (define (ugen-close u nn cc uu)
    (if (not (ugen-valid? u))
        (error "ugen-close" "invalid ugen" u)
        (make-ugen (ugen-name u)
                   (ugen-rate u)
                   (map (lambda (i) (input*-to-input i nn cc uu))
                        (ugen-inputs u))
                   (ugen-outputs u)
                   (ugen-special u)
                   (ugen-id u))))

  ;; ugen -> ugen
  (define (prepare-root u)
    (cond ((mce? u) (mrg-n (mce-proxies u)))
          ((mrg? u) (make-mrg (prepare-root (mrg-left u))
                              (prepare-root (mrg-right u))))
          (else u)))

  ;; Core - Synthdef

  ;; [ugen] -> int
  (define (count-local-buf uu)
    (length (filter (lambda (u) (equal? (ugen-name u) "LocalBuf"))
                    uu)))

  ;; ugen|#f
  (define (implicit-max-local-bufs uu)
    (let ((n (count-local-buf uu)))
      (if (> n 0)
          (cons n (max-local-bufs n))
          #f)))

  ;; string -> ugen -> graphdef
  (define (synthdef name pre-u)
    (let* ((u (prepare-root pre-u))
           (nn (graph-constants u))
           (cc (graph-controls* u))
           (uu (graph-ugens u))
           (uu* (if (null? cc)
                    uu
                    (cons (implicit-ugen cc) uu)))
           (mx (implicit-max-local-bufs uu))
           (nn* (if mx
                    (cons (car mx) nn)
                    nn))
           (uu** (if mx
                     (cons (cdr mx) uu*)
                     uu*)))
      (make-graphdef name
                     nn*
                     (map control*-default cc)
                     (map (lambda (c) (control*-to-control c cc))
                          cc)
                     (map (lambda (u) (ugen-close u nn* cc uu**))
                          uu**))))
  
  (define (synthdef-write sy fn)
    (let ((fd (open-file-output-port fn)))
      (put-bytevector fd (encode-graphdef sy))
      (close-port fd)))

  ;; [control] -> ugen
  (define (implicit-ugen cc)
    (make-ugen "Control"
               kr
               nil
               (map make-output (replicate (length cc) kr))
               0
               (make-uid 0)))

  ;; node -> [node] -> int
  (define (calculate-index n nn)
    (let ((i (find-index (lambda (e) (equal? e n)) nn)))
      (if (not i)
          (error "calculate-index" "not located" n nn)
          i)))

  ;; float -> [node] -> input
  (define (number-to-input n nn)
    (make-input -1 (calculate-index n nn)))
  
  ;; control* -> [control*] -> control
  (define (control*-to-control c cc)
    (make-control (control*-name c) (calculate-index c cc)))

  ;; control* -> [control*] -> input
  (define (control*-to-input c cc)
    (make-input 0 (calculate-index c cc)))

  ;; ugen -> [ugen] -> input
  (define (ugen-to-input u uu)
    (make-input (calculate-index u uu) 0))

  ;; proxy -> [ugen] -> input
  (define (proxy-to-input p uu)
    (make-input (calculate-index (proxy-ugen p) uu)
                (proxy-port p)))

  ;; node -> [node] -> [control] -> [ugen] -> input
  (define (input*-to-input i nn cc uu)
    (cond ((number? i) (number-to-input i nn))
          ((control*? i) (control*-to-input i cc))
          ((ugen? i) (ugen-to-input i uu))
          ((proxy? i) (proxy-to-input i uu))
          ((mrg? i) (input*-to-input (mrg-left i) nn cc uu))
          ((mce? i) (error "input*-to-input" "mce?" i))
          (else (error "input*-to-input" "illegal input" i))))

  ;; Core - MCE
  
  (define (mce* l)
    (make-mce l))
  
  ;; node -> [ugen]
  (define (mce-channels u)
    (cond ((mce? u) (mce-proxies u))
          ((mrg? u) (let ((rs (mce-channels (mrg-left u))))
                      (cons (make-mrg (head rs) (mrg-right u))
                            (tail rs))))
          (else (list1 u))))

  ;; mce|mrg -> int
  (define (mce-degree m)
    (cond ((mce? m) (length (mce-proxies m)))
          ((mrg? m) (mce-degree (mrg-left m)))
          (else (error "mce-degree" "illegal input" m))))

  ;; ugen -> bool
  (define (mce-required? u)
    (not (null? (filter mce? (ugen-inputs u)))))

  ;; int -> node -> [node]
  (define (mce-extend n i)
    (cond ((mce? i) (extend (mce-proxies i) n))
          ((mrg? i) (let ((rs (mce-extend n (mrg-left i))))
                      (cons (make-mrg (head rs) (mrg-right i))
                            (tail rs))))
          (else (replicate n i))))

  ;; ugen -> mce
  (define (mce-transform u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (let* ((f (lambda (i*) (make-ugen n r i* o s d)))
              (m (maximum (map mce-degree (filter mce? i))))
              (e (lambda (i) (mce-extend m i)))
              (i* (transpose (map e i))))
         (make-mce (map f i*))))))

  ;; node -> node|mce
  (define (mce-expand u)
    (cond ((mce? u) (make-mce (map mce-expand (mce-proxies u))))
          ((mrg? u) (make-mrg (mce-expand (mrg-left u)) (mrg-right u)))
          (else (if (mce-required? u)
                    (mce-transform u)
                    u))))

  ;; Core - Transport

  ;; port -> osc -> ()
  (define (async fd m)
    (send fd m)
    (wait fd "/done"))

  ;; port -> ()
  (define (reset fd)
    (send fd (bundle -1 (list (g-free-all1 0)
                              clear-sched
                              (g-new1 1 0 0)))))

  ;; (socket -> a) -> a
  (define (with-udp-sc3 f)
    (let* ((fd (udp:open "127.0.0.1" 57110))
           (r (f fd)))
      (udp:close fd)
      r))

  ;; (socket -> a) -> a
  (define (with-tcp-sc3 f)
    (let* ((fd (tcp:open "127.0.0.1" 57110))
           (r (f fd)))
      (tcp:close fd) r))

  ;; (socket -> a) -> a
  (define with-sc3 with-udp-sc3)

  ;; Core - Status

  ;; [string]
  (define status-fields
    (list "# UGens                     "
          "# Synths                    "
          "# Groups                    "
          "# Instruments               "
          "% CPU (Average)             "
          "% CPU (Peak)                "
          "Sample Rate (Nominal)       "
          "Sample Rate (Actual)        "))

  ;; osc -> [string]
  (define (status-format r)
    (cons "***** SuperCollider Server Status *****"
          (zip-with string-append
                    status-fields
                    (map number->string (tail (tail r))))))

  ;; port -> [string]
  (define (server-status fd)
    (send fd status)
    (let ((r (wait fd "/status.reply")))
      (status-format r)))

  ;; port -> ()
  (define (display-server-status fd)
    (newline)
    (for-each display (intersperse "\n" (server-status fd)))
    (newline))

  ;; port -> int -> number
  (define (server-status-field fd n)
    (send fd status)
    (let ((r (wait fd "/status.reply")))
      (list-ref r n)))

  ;; port -> float
  (define (server-sample-rate-nominal s)
    (server-status-field s 8))

  ;; port -> float
  (define (server-sample-rate-actual s)
    (server-status-field s 9))

  ;; port -> string -> ugen -> ()
  (define (send-synth fd n u)
    (async fd
           (d-recv (encode-graphdef (synthdef n u)))))
  
  (define (play-at fd u nid act grp)
    (send-synth fd "anonymous" u)
    (send fd (s-new0 "anonymous" nid act grp)))

  ;; ((socket -> a) -> a) -> (ugen -> ())
  (define (audition-using f)
    (lambda (u)
      (f
       (lambda (fd)
         (play fd u)))))

  ;; ugen -> ()
  (define audition (audition-using with-udp-sc3))

  ;; Core - Random

  ;; float -> float -> float
  (define (random a b)
    (+ (* (srfi:random-real)
          (- b a))
       a))

  ;; int -> int -> int
  (define (i-random l r)
    (+ (srfi:random-integer (- r l))
       l))

  ;; Core - Time

  ;; () -> float
  (define (utc)
    (let ((t (srfi:current-time srfi:time-utc)))
      (+ (srfi:time-second t)
         (/ (srfi:time-nanosecond t)
            1000000000.0))))


  ;; UGen
  
  (define (a2k input)
    (mk-ugen (list "A2K"
                   kr
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (apf input freq radius)
    (mk-ugen (list "APF"
                   (list 0)
                   (list input freq radius)
                   nil
                   1
                   nil
                   nil)))
  
  (define (allpass-c input maxdelaytime delaytime decaytime)
    (mk-ugen (list "AllpassC"
                   (list 0)
                   (list input maxdelaytime delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (allpass-l input maxdelaytime delaytime decaytime)
    (mk-ugen (list "AllpassL"
                   (list 0)
                   (list input maxdelaytime delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (allpass-n input maxdelaytime delaytime decaytime)
    (mk-ugen (list "AllpassN"
                   (list 0)
                   (list input maxdelaytime delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (amp-comp rt freq root exp_)
    (mk-ugen (list "AmpComp"
                   rt
                   (list freq root exp_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (amp-comp-a rt freq root minAmp rootAmp)
    (mk-ugen (list "AmpCompA"
                   rt
                   (list freq root minAmp rootAmp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (amplitude rt input attackTime releaseTime)
    (mk-ugen (list "Amplitude"
                   rt
                   (list input attackTime releaseTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (audio-control rt values)
    (mk-ugen (list "AudioControl"
                   rt
                   (list values)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-all-pass input freq rq)
    (mk-ugen (list "BAllPass"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-band-pass input freq bw)
    (mk-ugen (list "BBandPass"
                   (list 0)
                   (list input freq bw)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-band-stop input freq bw)
    (mk-ugen (list "BBandStop"
                   (list 0)
                   (list input freq bw)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-hi-pass input freq rq)
    (mk-ugen (list "BHiPass"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-hi-shelf input freq rs db)
    (mk-ugen (list "BHiShelf"
                   (list 0)
                   (list input freq rs db)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-low-pass input freq rq)
    (mk-ugen (list "BLowPass"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-low-shelf input freq rs db)
    (mk-ugen (list "BLowShelf"
                   (list 0)
                   (list input freq rs db)
                   nil
                   1
                   nil
                   nil)))
  
  (define (bpf input freq rq)
    (mk-ugen (list "BPF"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (bpz2 input)
    (mk-ugen (list "BPZ2"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (b-peak-eq input freq rq db)
    (mk-ugen (list "BPeakEQ"
                   (list 0)
                   (list input freq rq db)
                   nil
                   1
                   nil
                   nil)))
  
  (define (brf input freq rq)
    (mk-ugen (list "BRF"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (brz2 input)
    (mk-ugen (list "BRZ2"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (balance2 rt left right pos level)
    (mk-ugen (list "Balance2" rt
                   (list left right pos level)
                   nil
                   2
                   nil
                   nil)))
  
  (define (ball rt input g damp friction)
    (mk-ugen (list "Ball"
                   rt
                   (list input g damp friction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (beat-track rt chain lock)
    (mk-ugen (list "BeatTrack"
                   rt
                   (list chain lock)
                   nil
                   1
                   nil
                   nil)))
  
  (define (beat-track2 rt busindex numfeatures windowsize phaseaccuracy lock weightingscheme)
    (mk-ugen (list "BeatTrack2"
                   rt
                   (list busindex numfeatures windowsize phaseaccuracy lock weightingscheme)
                   nil
                   6
                   nil
                   nil)))
  
  (define (bi-pan-b2 rt inA inB azimuth gain)
    (mk-ugen (list "BiPanB2" rt
                   (list inA inB azimuth gain)
                   nil
                   3
                   nil
                   nil)))
  
  (define (binary-op-ugen a b)
    (mk-ugen (list "BinaryOpUGen"
                   (list 0 1)
                   (list a b)
                   nil
                   1
                   nil
                   nil)))
  
  (define (blip rt freq numharm)
    (mk-ugen (list "Blip"
                   rt
                   (list freq numharm)
                   nil
                   1
                   nil
                   nil)))
  
  (define (block-size rt)
    (mk-ugen (list "BlockSize"
                   rt
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (brown-noise rt)
    (mk-ugen (list "BrownNoise"
                   rt
                   nil
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (buf-allpass-c rt buf input delaytime decaytime)
    (mk-ugen (list "BufAllpassC"
                   rt
                   (list buf input delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-allpass-l rt buf input delaytime decaytime)
    (mk-ugen (list "BufAllpassL"
                   rt
                   (list buf input delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-allpass-n rt buf input delaytime decaytime)
    (mk-ugen (list "BufAllpassN"
                   rt
                   (list buf input delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-channels rt bufnum)
    (mk-ugen (list "BufChannels"
                   rt
                   (list bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-comb-c rt buf input delaytime decaytime)
    (mk-ugen (list "BufCombC"
                   rt
                   (list buf input delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-comb-l rt buf input delaytime decaytime)
    (mk-ugen (list "BufCombL"
                   rt
                   (list buf input delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-comb-n rt buf input delaytime decaytime)
    (mk-ugen (list "BufCombN"
                   rt
                   (list buf input delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-delay-c rt buf input delaytime)
    (mk-ugen (list "BufDelayC"
                   rt
                   (list buf input delaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-delay-l rt buf input delaytime)
    (mk-ugen (list "BufDelayL"
                   rt
                   (list buf input delaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-delay-n rt buf input delaytime)
    (mk-ugen (list "BufDelayN"
                   rt
                   (list buf input delaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-dur rt bufnum)
    (mk-ugen (list "BufDur"
                   rt
                   (list bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-frames rt bufnum)
    (mk-ugen (list "BufFrames"
                   rt
                   (list bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-rate-scale rt bufnum)
    (mk-ugen (list "BufRateScale"
                   rt
                   (list bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-rd nc rt bufnum phase loop interpolation)
    (mk-ugen (list "BufRd"
                   rt
                   (list bufnum phase loop interpolation)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (buf-sample-rate rt bufnum)
    (mk-ugen (list "BufSampleRate"
                   rt
                   (list bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-samples rt bufnum)
    (mk-ugen (list "BufSamples"
                   rt
                   (list bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (buf-wr bufnum phase loop inputArray)
    (mk-ugen (list "BufWr"
                   (list 3)
                   (list bufnum phase loop)
                   inputArray
                   1
                   nil
                   nil)))
  
  (define (c-osc rt bufnum freq beats)
    (mk-ugen (list "COsc"
                   rt
                   (list bufnum freq beats)
                   nil
                   1
                   nil
                   nil)))
  
  (define (check-bad-values input id_ post)
    (mk-ugen (list "CheckBadValues"
                   (list 0)
                   (list input id_ post)
                   nil
                   1
                   nil
                   nil)))
  
  (define (clip input lo hi)
    (mk-ugen (list "Clip"
                   (list 0)
                   (list input lo hi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (clip-noise rt)
    (mk-ugen (list "ClipNoise"
                   rt
                   nil
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (coin-gate prob input)
    (mk-ugen (list "CoinGate"
                   (list 1)
                   (list prob input)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (comb-c input maxdelaytime delaytime decaytime)
    (mk-ugen (list "CombC"
                   (list 0)
                   (list input maxdelaytime delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (comb-l input maxdelaytime delaytime decaytime)
    (mk-ugen (list "CombL"
                   (list 0)
                   (list input maxdelaytime delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (comb-n input maxdelaytime delaytime decaytime)
    (mk-ugen (list "CombN"
                   (list 0)
                   (list input maxdelaytime delaytime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (compander input control_ thresh slopeBelow slopeAbove clampTime relaxTime)
    (mk-ugen (list "Compander"
                   (list 0)
                   (list input control_ thresh slopeBelow slopeAbove clampTime relaxTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (compander-d rt input thresh slopeBelow slopeAbove clampTime relaxTime)
    (mk-ugen (list "CompanderD"
                   rt
                   (list input thresh slopeBelow slopeAbove clampTime relaxTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define control-dur
    (mk-ugen (list "ControlDur"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define control-rate
    (mk-ugen (list "ControlRate"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (convolution rt input kernel framesize)
    (mk-ugen (list "Convolution"
                   rt
                   (list input kernel framesize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (convolution2 rt input kernel trigger framesize)
    (mk-ugen (list "Convolution2"
                   rt
                   (list input kernel trigger framesize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (convolution2l rt input kernel trigger framesize crossfade)
    (mk-ugen (list "Convolution2L"
                   rt
                   (list input kernel trigger framesize crossfade)
                   nil
                   1
                   nil
                   nil)))
  
  (define (convolution3 rt input kernel trigger framesize)
    (mk-ugen (list "Convolution3"
                   rt
                   (list input kernel trigger framesize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (crackle rt chaosParam)
    (mk-ugen (list "Crackle"
                   rt
                   (list chaosParam)
                   nil
                   1
                   nil
                   nil)))
  
  (define (cusp-l rt freq a b xi)
    (mk-ugen (list "CuspL"
                   rt
                   (list freq a b xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (cusp-n rt freq a b xi)
    (mk-ugen (list "CuspN"
                   rt
                   (list freq a b xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (dc rt input)
    (mk-ugen (list "DC"
                   rt
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (dbrown length_ lo hi step)
    (mk-ugen (list "Dbrown"
                   dr
                   (list length_ lo hi step)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dbufrd bufnum phase loop)
    (mk-ugen (list "Dbufrd"
                   dr
                   (list bufnum phase loop)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dbufwr bufnum phase loop input)
    (mk-ugen (list "Dbufwr"
                   dr
                   (list bufnum phase loop input)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (decay input decayTime)
    (mk-ugen (list "Decay"
                   (list 0)
                   (list input decayTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (decay2 input attackTime decayTime)
    (mk-ugen (list "Decay2"
                   (list 0)
                   (list input attackTime decayTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (decode-b2 nc rt w x y orientation)
    (mk-ugen (list "DecodeB2"
                   rt
                   (list w x y orientation)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (degree-to-key bufnum input octave)
    (mk-ugen (list "DegreeToKey"
                   (list 1)
                   (list bufnum input octave)
                   nil
                   1
                   nil
                   nil)))
  
  (define (del-tap-rd buffer phase delTime interp)
    (mk-ugen (list "DelTapRd"
                   (list 1)
                   (list buffer phase delTime interp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (del-tap-wr buffer input)
    (mk-ugen (list "DelTapWr"
                   (list 1)
                   (list buffer input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (delay1 input)
    (mk-ugen (list "Delay1"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (delay2 input)
    (mk-ugen (list "Delay2"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (delay-c input maxdelaytime delaytime)
    (mk-ugen (list "DelayC"
                   (list 0)
                   (list input maxdelaytime delaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (delay-l input maxdelaytime delaytime)
    (mk-ugen (list "DelayL"
                   (list 0)
                   (list input maxdelaytime delaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (delay-n input maxdelaytime delaytime)
    (mk-ugen (list "DelayN"
                   (list 0)
                   (list input maxdelaytime delaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (demand trig reset demandUGens)
    (mk-ugen (list "Demand"
                   (list 0)
                   (list trig reset)
                   demandUGens
                   (length (mce-channels demandUGens))
                   nil
                   nil)))
  
  (define (demand-env-gen rt level dur shape curve gate reset levelScale levelBias timeScale doneAction)
    (mk-ugen (list "DemandEnvGen"
                   rt
                   (list level dur shape curve gate reset levelScale levelBias timeScale doneAction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (detect-index bufnum input)
    (mk-ugen (list "DetectIndex"
                   (list 1)
                   (list bufnum input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (detect-silence input amp time doneAction)
    (mk-ugen (list "DetectSilence"
                   (list 0)
                   (list input amp time doneAction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (dgeom length_ start grow)
    (mk-ugen (list "Dgeom"
                   dr
                   (list length_ start grow)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dibrown length_ lo hi step)
    (mk-ugen (list "Dibrown"
                   dr
                   (list length_ lo hi step)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (disk-in nc bufnum loop)
    (mk-ugen (list "DiskIn"
                   ar
                   (list bufnum loop)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (disk-out bufnum input)
    (mk-ugen (list "DiskOut"
                   ar
                   (list bufnum)
                   input
                   1
                   nil
                   nil)))
  
  (define (diwhite length_ lo hi)
    (mk-ugen (list "Diwhite"
                   dr
                   (list length_ lo hi)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (donce input)
    (mk-ugen (list "Donce"
                   dr
                   (list input)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (done rt src)
    (mk-ugen (list "Done"
                   rt
                   (list src)
                   nil
                   1
                   nil
                   nil)))
  
  (define (dpoll input label_ run trigid)
    (mk-ugen (list "Dpoll"
                   dr
                   (list input label_ run trigid)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (drand repeats list_)
    (mk-ugen (list "Drand"
                   dr
                   (list repeats)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dreset input reset)
    (mk-ugen (list "Dreset"
                   dr
                   (list input reset)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dseq repeats list_)
    (mk-ugen (list "Dseq"
                   dr
                   (list repeats)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dser repeats list_)
    (mk-ugen (list "Dser"
                   dr
                   (list repeats)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dseries length_ start step)
    (mk-ugen (list "Dseries"
                   dr
                   (list length_ start step)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dshuf repeats list_)
    (mk-ugen (list "Dshuf"
                   dr
                   (list repeats)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dstutter n input)
    (mk-ugen (list "Dstutter"
                   dr
                   (list n input)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dswitch index list_)
    (mk-ugen (list "Dswitch"
                   dr
                   (list index)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dswitch1 index list_)
    (mk-ugen (list "Dswitch1"
                   dr
                   (list index)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dunique source maxBufferSize protected)
    (mk-ugen (list "Dunique"
                   dr
                   (list source maxBufferSize protected)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dust rt density)
    (mk-ugen (list "Dust"
                   rt
                   (list density)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dust2 rt density)
    (mk-ugen (list "Dust2"
                   rt
                   (list density)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dust-r rt iot_min iot_max)
    (mk-ugen (list "DustR"
                   rt
                   (list iot_min iot_max)
                   nil
                   1
                   nil
                   nil)))
  
  (define (duty rt dur reset doneAction level)
    (mk-ugen (list "Duty"
                   rt
                   (list dur reset doneAction level)
                   nil
                   1
                   nil
                   nil)))
  
  (define (dwhite length_ lo hi)
    (mk-ugen (list "Dwhite"
                   dr
                   (list length_ lo hi)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dwrand repeats weights list_)
    (mk-ugen (list "Dwrand"
                   dr
                   (list repeats weights)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (dxrand repeats list_)
    (mk-ugen (list "Dxrand"
                   dr
                   (list repeats)
                   list_
                   1
                   nil
                   (incr-uid 1))))
  
  (define (env-gen rt gate levelScale levelBias timeScale doneAction envelope_)
    (mk-ugen (list "EnvGen"
                   rt
                   (list gate levelScale levelBias timeScale doneAction)
                   envelope_
                   1
                   nil
                   nil)))
  
  (define (exp-rand lo hi)
    (mk-ugen (list "ExpRand"
                   (list 0 1)
                   (list lo hi)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (fb-sine-c rt freq im fb a c xi yi)
    (mk-ugen (list "FBSineC"
                   rt
                   (list freq im fb a c xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (fb-sine-l rt freq im fb a c xi yi)
    (mk-ugen (list "FBSineL"
                   rt
                   (list freq im fb a c xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (fb-sine-n rt freq im fb a c xi yi)
    (mk-ugen (list "FBSineN"
                   rt
                   (list freq im fb a c xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (fft buffer input hop wintype active winsize)
    (mk-ugen (list "FFT"
                   kr
                   (list buffer input hop wintype active winsize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (fos input a0 a1 b1)
    (mk-ugen (list "FOS"
                   (list 0)
                   (list input a0 a1 b1)
                   nil
                   1
                   nil
                   nil)))
  
  (define (f-sin-osc rt freq iphase)
    (mk-ugen (list "FSinOsc"
                   rt
                   (list freq iphase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (fold input lo hi)
    (mk-ugen (list "Fold"
                   (list 0)
                   (list input lo hi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (formant rt fundfreq formfreq bwfreq)
    (mk-ugen (list "Formant"
                   rt
                   (list fundfreq formfreq bwfreq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (formlet input freq attacktime decaytime)
    (mk-ugen (list "Formlet"
                   (list 0)
                   (list input freq attacktime decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (free trig id_)
    (mk-ugen (list "Free"
                   (list 0)
                   (list trig id_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (free-self input)
    (mk-ugen (list "FreeSelf"
                   kr
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (free-self-when-done rt src)
    (mk-ugen (list "FreeSelfWhenDone"
                   rt
                   (list src)
                   nil
                   1
                   nil
                   nil)))
  
  (define (free-verb input mix room damp)
    (mk-ugen (list "FreeVerb"
                   (list 0)
                   (list input mix room damp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (free-verb2 input in2 mix room damp)
    (mk-ugen (list "FreeVerb2"
                   (list 0)
                   (list input in2 mix room damp)
                   nil
                   2
                   nil
                   nil)))
  
  (define (freq-shift rt input freq phase)
    (mk-ugen (list "FreqShift"
                   rt
                   (list input freq phase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (g-verb input roomsize revtime damping inputbw spread drylevel earlyreflevel taillevel maxroomsize)
    (mk-ugen (list "GVerb"
                   (list 0)
                   (list input roomsize revtime damping inputbw spread drylevel earlyreflevel taillevel maxroomsize)
                   nil
                   2
                   nil
                   nil)))
  
  (define (gate input trig)
    (mk-ugen (list "Gate"
                   (list 0)
                   (list input trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (gbman-l rt freq xi yi)
    (mk-ugen (list "GbmanL"
                   rt
                   (list freq xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (gbman-n rt freq xi yi)
    (mk-ugen (list "GbmanN"
                   rt
                   (list freq xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (gendy1 rt ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum)
    (mk-ugen (list "Gendy1"
                   rt
                   (list ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (gendy2 rt ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum a c)
    (mk-ugen (list "Gendy2"
                   rt
                   (list ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum a c)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (gendy3 rt ampdist durdist adparam ddparam freq ampscale durscale initCPs knum)
    (mk-ugen (list "Gendy3"
                   rt
                   (list ampdist durdist adparam ddparam freq ampscale durscale initCPs knum)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (grain-buf nc trigger dur sndbuf rate_ pos interp pan envbufnum maxGrains)
    (mk-ugen (list "GrainBuf"
                   ar
                   (list trigger dur sndbuf rate_ pos interp pan envbufnum maxGrains)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (grain-fm nc trigger dur carfreq modfreq index pan envbufnum maxGrains)
    (mk-ugen (list "GrainFM"
                   ar
                   (list trigger dur carfreq modfreq index pan envbufnum maxGrains)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (grain-in nc trigger dur input pan envbufnum maxGrains)
    (mk-ugen (list "GrainIn"
                   ar
                   (list trigger dur input pan envbufnum maxGrains)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (grain-sin nc trigger dur freq pan envbufnum maxGrains)
    (mk-ugen (list "GrainSin"
                   ar
                   (list trigger dur freq pan envbufnum maxGrains)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (gray-noise rt)
    (mk-ugen (list "GrayNoise"
                   rt
                   nil
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (hpf input freq)
    (mk-ugen (list "HPF"
                   (list 0)
                   (list input freq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (hpz1 input)
    (mk-ugen (list "HPZ1"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (hpz2 input)
    (mk-ugen (list "HPZ2"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (hasher input)
    (mk-ugen (list "Hasher"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (henon-c rt freq a b x0 x1)
    (mk-ugen (list "HenonC"
                   rt
                   (list freq a b x0 x1)
                   nil
                   1
                   nil
                   nil)))
  
  (define (henon-l rt freq a b x0 x1)
    (mk-ugen (list "HenonL"
                   rt
                   (list freq a b x0 x1)
                   nil
                   1
                   nil
                   nil)))
  
  (define (henon-n rt freq a b x0 x1)
    (mk-ugen (list "HenonN"
                   rt
                   (list freq a b x0 x1)
                   nil
                   1
                   nil
                   nil)))
  
  (define (hilbert input)
    (mk-ugen (list "Hilbert"
                   (list 0)
                   (list input)
                   nil
                   2
                   nil
                   nil)))
  
  (define (hilbert-fir rt input buffer)
    (mk-ugen (list "HilbertFIR"
                   rt
                   (list input buffer)
                   nil
                   2
                   nil
                   nil)))
  
  (define (i-env-gen rt index envelope_)
    (mk-ugen (list "IEnvGen"
                   rt
                   (list index)
                   envelope_
                   1
                   nil
                   nil)))
  
  (define (ifft buffer wintype winsize)
    (mk-ugen (list "IFFT"
                   ar
                   (list buffer wintype winsize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (i-rand lo hi)
    (mk-ugen (list "IRand"
                   ir
                   (list lo hi)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (impulse rt freq phase)
    (mk-ugen (list "Impulse"
                   rt
                   (list freq phase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (in nc rt bus)
    (mk-ugen (list "In"
                   rt
                   (list bus)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (in-feedback nc bus)
    (mk-ugen (list "InFeedback"
                   ar
                   (list bus)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (in-range input lo hi)
    (mk-ugen (list "InRange"
                   (list 0)
                   (list input lo hi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (in-rect rt x y rect)
    (mk-ugen (list "InRect"
                   rt
                   (list x y rect)
                   nil
                   1
                   nil
                   nil)))
  
  (define (in-trig nc rt bus)
    (mk-ugen (list "InTrig"
                   rt
                   (list bus)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (index bufnum input)
    (mk-ugen (list "Index"
                   (list 1)
                   (list bufnum input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (index-in-between rt bufnum input)
    (mk-ugen (list "IndexInBetween"
                   rt
                   (list bufnum input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (index-l rt bufnum input)
    (mk-ugen (list "IndexL"
                   rt
                   (list bufnum input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (info-ugen-base rt)
    (mk-ugen (list "InfoUGenBase"
                   rt
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (integrator input coef)
    (mk-ugen (list "Integrator"
                   (list 0)
                   (list input coef)
                   nil
                   1
                   nil
                   nil)))
  
  (define (k2a input)
    (mk-ugen (list "K2A"
                   ar
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (key-state rt keycode minval maxval lag)
    (mk-ugen (list "KeyState"
                   rt
                   (list keycode minval maxval lag)
                   nil
                   1
                   nil
                   nil)))
  
  (define (key-track rt chain keydecay chromaleak)
    (mk-ugen (list "KeyTrack"
                   rt
                   (list chain keydecay chromaleak)
                   nil
                   1
                   nil
                   nil)))
  
  (define (klang rt freqscale freqoffset specificationsArrayRef)
    (mk-ugen (list "Klang"
                   rt
                   (list freqscale freqoffset)
                   specificationsArrayRef
                   1
                   nil
                   nil)))
  
  (define (klank input freqscale freqoffset decayscale specificationsArrayRef)
    (mk-ugen (list "Klank"
                   (list 0)
                   (list input freqscale freqoffset decayscale)
                   specificationsArrayRef
                   1
                   nil
                   nil)))
  
  (define (lf-clip-noise rt freq)
    (mk-ugen (list "LFClipNoise"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lf-cub rt freq iphase)
    (mk-ugen (list "LFCub"
                   rt
                   (list freq iphase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lfd-clip-noise rt freq)
    (mk-ugen (list "LFDClipNoise"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lfd-noise0 rt freq)
    (mk-ugen (list "LFDNoise0"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lfd-noise1 rt freq)
    (mk-ugen (list "LFDNoise1"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lfd-noise3 rt freq)
    (mk-ugen (list "LFDNoise3"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lf-gauss rt duration width iphase loop doneAction)
    (mk-ugen (list "LFGauss"
                   rt
                   (list duration width iphase loop doneAction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lf-noise0 rt freq)
    (mk-ugen (list "LFNoise0"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lf-noise1 rt freq)
    (mk-ugen (list "LFNoise1"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lf-noise2 rt freq)
    (mk-ugen (list "LFNoise2"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lf-par rt freq iphase)
    (mk-ugen (list "LFPar"
                   rt
                   (list freq iphase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lf-pulse rt freq iphase width)
    (mk-ugen (list "LFPulse"
                   rt
                   (list freq iphase width)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lf-saw rt freq iphase)
    (mk-ugen (list "LFSaw"
                   rt
                   (list freq iphase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lf-tri rt freq iphase)
    (mk-ugen (list "LFTri"
                   rt
                   (list freq iphase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lpf input freq)
    (mk-ugen (list "LPF"
                   (list 0)
                   (list input freq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lpz1 input)
    (mk-ugen (list "LPZ1"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lpz2 input)
    (mk-ugen (list "LPZ2"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag input lagTime)
    (mk-ugen (list "Lag"
                   (list 0)
                   (list input lagTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag2 input lagTime)
    (mk-ugen (list "Lag2"
                   (list 0)
                   (list input lagTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag2ud input lagTimeU lagTimeD)
    (mk-ugen (list "Lag2UD"
                   (list 0)
                   (list input lagTimeU lagTimeD)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag3 input lagTime)
    (mk-ugen (list "Lag3"
                   (list 0)
                   (list input lagTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag3ud input lagTimeU lagTimeD)
    (mk-ugen (list "Lag3UD"
                   (list 0)
                   (list input lagTimeU lagTimeD)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag-control rt values lags)
    (mk-ugen (list "LagControl"
                   rt
                   (list values lags)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lag-in nc rt bus lag)
    (mk-ugen (list "LagIn"
                   rt
                   (list bus lag)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (lag-ud input lagTimeU lagTimeD)
    (mk-ugen (list "LagUD"
                   (list 0)
                   (list input lagTimeU lagTimeD)
                   nil
                   1
                   nil
                   nil)))
  
  (define (last-value input diff)
    (mk-ugen (list "LastValue"
                   (list 0)
                   (list input diff)
                   nil
                   1
                   nil
                   nil)))
  
  (define (latch input trig)
    (mk-ugen (list "Latch"
                   (list 0)
                   (list input trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (latoocarfian-c rt freq a b c d xi yi)
    (mk-ugen (list "LatoocarfianC"
                   rt
                   (list freq a b c d xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (latoocarfian-l rt freq a b c d xi yi)
    (mk-ugen (list "LatoocarfianL"
                   rt
                   (list freq a b c d xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (latoocarfian-n rt freq a b c d xi yi)
    (mk-ugen (list "LatoocarfianN"
                   rt
                   (list freq a b c d xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (leak-dc input coef)
    (mk-ugen (list "LeakDC"
                   (list 0)
                   (list input coef)
                   nil
                   1
                   nil
                   nil)))
  
  (define (least-change rt a b)
    (mk-ugen (list "LeastChange"
                   rt
                   (list a b)
                   nil
                   1
                   nil
                   nil)))
  
  (define (limiter input level dur)
    (mk-ugen (list "Limiter"
                   (list 0)
                   (list input level dur)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lin-cong-c rt freq a c m xi)
    (mk-ugen (list "LinCongC"
                   rt
                   (list freq a c m xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lin-cong-l rt freq a c m xi)
    (mk-ugen (list "LinCongL"
                   rt
                   (list freq a c m xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lin-cong-n rt freq a c m xi)
    (mk-ugen (list "LinCongN"
                   rt
                   (list freq a c m xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lin-exp input srclo srchi dstlo dsthi)
    (mk-ugen (list "LinExp"
                   (list 0)
                   (list input srclo srchi dstlo dsthi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lin-pan2 input pos level)
    (mk-ugen (list "LinPan2"
                   (list 0)
                   (list input pos level)
                   nil
                   2
                   nil
                   nil)))
  
  (define (lin-rand lo hi minmax)
    (mk-ugen (list "LinRand"
                   ir
                   (list lo hi minmax)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (lin-x-fade2 inA inB pan level)
    (mk-ugen (list "LinXFade2"
                   (list 0 1)
                   (list inA inB pan level)
                   nil
                   1
                   nil
                   nil)))
  
  (define (line rt start end dur doneAction)
    (mk-ugen (list "Line"
                   rt
                   (list start end dur doneAction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (linen gate attackTime susLevel releaseTime doneAction)
    (mk-ugen (list "Linen"
                   kr
                   (list gate attackTime susLevel releaseTime doneAction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (local-buf numChannels numFrames)
    (mk-ugen (list "LocalBuf"
                   ir
                   (list numChannels numFrames)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (local-in nc rt default_)
    (mk-ugen (list "LocalIn"
                   rt
                   nil
                   default_
                   nc
                   nil
                   nil)))
  
  (define (local-out input)
    (mk-ugen (list "LocalOut"
                   (list 0)
                   nil
                   input
                   1
                   nil
                   nil)))
  
  (define (logistic rt chaosParam freq init_)
    (mk-ugen (list "Logistic"
                   rt
                   (list chaosParam freq init_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (lorenz-l rt freq s r b h xi yi zi)
    (mk-ugen (list "LorenzL"
                   rt
                   (list freq s r b h xi yi zi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (loudness rt chain smask tmask)
    (mk-ugen (list "Loudness"
                   rt
                   (list chain smask tmask)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mfcc rt chain numcoeff)
    (mk-ugen (list "MFCC"
                   rt
                   (list chain numcoeff)
                   nil
                   13
                   nil
                   nil)))
  
  (define (mantissa-mask input bits)
    (mk-ugen (list "MantissaMask"
                   (list 0)
                   (list input bits)
                   nil
                   1
                   nil
                   nil)))
  
  (define (max-local-bufs count)
    (mk-ugen (list "MaxLocalBufs"
                   ir
                   (list count)
                   nil
                   1
                   nil
                   nil)))
  
  (define (median length_ input)
    (mk-ugen (list "Median"
                   (list 1)
                   (list length_ input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mid-eq input freq rq db)
    (mk-ugen (list "MidEQ"
                   (list 0)
                   (list input freq rq db)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mod-dif rt x y mod_)
    (mk-ugen (list "ModDif"
                   rt
                   (list x y mod_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (moog-ff input freq gain reset)
    (mk-ugen (list "MoogFF"
                   (list 0)
                   (list input freq gain reset)
                   nil
                   1
                   nil
                   nil)))
  
  (define (most-change a b)
    (mk-ugen (list "MostChange"
                   (list 0 1)
                   (list a b)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mouse-button rt minval maxval lag)
    (mk-ugen (list "MouseButton"
                   rt
                   (list minval maxval lag)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mouse-x rt minval maxval warp lag)
    (mk-ugen (list "MouseX"
                   rt
                   (list minval maxval warp lag)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mouse-y rt minval maxval warp lag)
    (mk-ugen (list "MouseY"
                   rt
                   (list minval maxval warp lag)
                   nil
                   1
                   nil
                   nil)))
  
  (define (n-rand lo hi n)
    (mk-ugen (list "NRand"
                   ir
                   (list lo hi n)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (normalizer input level dur)
    (mk-ugen (list "Normalizer"
                   (list 0)
                   (list input level dur)
                   nil
                   1
                   nil
                   nil)))
  
  (define num-audio-buses
    (mk-ugen (list "NumAudioBuses"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define num-buffers
    (mk-ugen (list "NumBuffers"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define num-control-buses
    (mk-ugen (list "NumControlBuses"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define num-input-buses
    (mk-ugen (list "NumInputBuses"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define num-output-buses
    (mk-ugen (list "NumOutputBuses"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define num-running-synths
    (mk-ugen (list "NumRunningSynths"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (offset-out bus input)
    (mk-ugen (list "OffsetOut"
                   (list 1)
                   (list bus)
                   input
                   1
                   nil
                   nil)))
  
  (define (one-pole input coef)
    (mk-ugen (list "OnePole"
                   (list 0)
                   (list input coef)
                   nil
                   1
                   nil
                   nil)))
  
  (define (one-zero input coef)
    (mk-ugen (list "OneZero"
                   (list 0)
                   (list input coef)
                   nil
                   1
                   nil
                   nil)))
  
  (define (onsets chain threshold odftype relaxtime floor_ mingap medianspan whtype rawodf)
    (mk-ugen (list "Onsets"
                   kr
                   (list chain threshold odftype relaxtime floor_ mingap medianspan whtype rawodf)
                   nil
                   1
                   nil
                   nil)))
  
  (define (osc rt bufnum freq phase)
    (mk-ugen (list "Osc"
                   rt
                   (list bufnum freq phase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (osc-n rt bufnum freq phase)
    (mk-ugen (list "OscN"
                   rt
                   (list bufnum freq phase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (out bus input)
    (mk-ugen (list "Out"
                   (list 1)
                   (list bus)
                   input
                   1
                   nil
                   nil)))
  
  (define (p-sin-grain rt freq dur amp)
    (mk-ugen (list "PSinGrain"
                   rt
                   (list freq dur amp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-add bufferA bufferB)
    (mk-ugen (list "PV_Add"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-bin-scramble buffer wipe width trig)
    (mk-ugen (list "PV_BinScramble"
                   kr
                   (list buffer wipe width trig)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (pv-bin-shift buffer stretch shift interp)
    (mk-ugen (list "PV_BinShift"
                   kr
                   (list buffer stretch shift interp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-bin-wipe bufferA bufferB wipe)
    (mk-ugen (list "PV_BinWipe"
                   kr
                   (list bufferA bufferB wipe)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-brick-wall buffer wipe)
    (mk-ugen (list "PV_BrickWall"
                   kr
                   (list buffer wipe)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-chain-ugen maxSize)
    (mk-ugen (list "PV_ChainUGen"
                   kr
                   (list maxSize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-conformal-map buffer areal aimag)
    (mk-ugen (list "PV_ConformalMap"
                   kr
                   (list buffer areal aimag)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-conj buffer)
    (mk-ugen (list "PV_Conj"
                   kr
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-copy bufferA bufferB)
    (mk-ugen (list "PV_Copy"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-copy-phase bufferA bufferB)
    (mk-ugen (list "PV_CopyPhase"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-diffuser buffer trig)
    (mk-ugen (list "PV_Diffuser"
                   kr
                   (list buffer trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-div bufferA bufferB)
    (mk-ugen (list "PV_Div"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-hainsworth-foote maxSize)
    (mk-ugen (list "PV_HainsworthFoote"
                   kr
                   (list maxSize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-jensen-andersen maxSize)
    (mk-ugen (list "PV_JensenAndersen"
                   kr
                   (list maxSize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-local-max buffer threshold)
    (mk-ugen (list "PV_LocalMax"
                   kr
                   (list buffer threshold)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-above buffer threshold)
    (mk-ugen (list "PV_MagAbove"
                   kr
                   (list buffer threshold)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-below buffer threshold)
    (mk-ugen (list "PV_MagBelow"
                   kr
                   (list buffer threshold)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-clip buffer threshold)
    (mk-ugen (list "PV_MagClip"
                   kr (list buffer threshold)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-div bufferA bufferB zeroed)
    (mk-ugen (list "PV_MagDiv"
                   kr
                   (list bufferA bufferB zeroed)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-freeze buffer freeze)
    (mk-ugen (list "PV_MagFreeze"
                   kr
                   (list buffer freeze)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-mul bufferA bufferB)
    (mk-ugen (list "PV_MagMul"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-noise buffer)
    (mk-ugen (list "PV_MagNoise"
                   kr
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-shift buffer stretch shift)
    (mk-ugen (list "PV_MagShift"
                   kr
                   (list buffer stretch shift)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-smear buffer bins)
    (mk-ugen (list "PV_MagSmear"
                   kr
                   (list buffer bins)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mag-squared buffer)
    (mk-ugen (list "PV_MagSquared"
                   kr
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-max bufferA bufferB)
    (mk-ugen (list "PV_Max"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-min bufferA bufferB)
    (mk-ugen (list "PV_Min"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-mul bufferA bufferB)
    (mk-ugen (list "PV_Mul"
                   kr
                   (list bufferA bufferB)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-phase-shift buffer shift integrate)
    (mk-ugen (list "PV_PhaseShift"
                   kr
                   (list buffer shift integrate)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-phase-shift270 buffer)
    (mk-ugen (list "PV_PhaseShift270"
                   kr
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-phase-shift90 buffer)
    (mk-ugen (list "PV_PhaseShift90"
                   kr
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-rand-comb buffer wipe trig)
    (mk-ugen (list "PV_RandComb"
                   kr
                   (list buffer wipe trig)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (pv-rand-wipe bufferA bufferB wipe trig)
    (mk-ugen (list "PV_RandWipe"
                   kr
                   (list bufferA bufferB wipe trig)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (pv-rect-comb buffer numTeeth phase width)
    (mk-ugen (list "PV_RectComb"
                   kr
                   (list buffer numTeeth phase width)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-rect-comb2 bufferA bufferB numTeeth phase width)
    (mk-ugen (list "PV_RectComb2"
                   kr
                   (list bufferA bufferB numTeeth phase width)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pv-split bufferA bufferB)
    (mk-ugen (list "PV_Split"
                   kr
                   (list bufferA bufferB)
                   nil
                   2
                   nil
                   nil)))
  
  (define (pan2 input pos level)
    (mk-ugen (list "Pan2"
                   (list 0)
                   (list input pos level)
                   nil
                   2
                   nil
                   nil)))
  
  (define (pan4 rt input xpos ypos level)
    (mk-ugen (list "Pan4"
                   rt
                   (list input xpos ypos level)
                   nil
                   4
                   nil
                   nil)))
  
  (define (pan-az nc input pos level width orientation)
    (mk-ugen (list "PanAz"
                   (list 0)
                   (list input pos level width orientation)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (pan-b rt input azimuth elevation gain)
    (mk-ugen (list "PanB"
                   rt
                   (list input azimuth elevation gain)
                   nil
                   4
                   nil
                   nil)))
  
  (define (pan-b2 rt input azimuth gain)
    (mk-ugen (list "PanB2"
                   rt
                   (list input azimuth gain)
                   nil
                   3
                   nil
                   nil)))
  
  (define (part-conv input fftsize irbufnum)
    (mk-ugen (list "PartConv"
                   ar
                   (list input fftsize irbufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pause rt gate id_)
    (mk-ugen (list "Pause"
                   rt
                   (list gate id_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pause-self rt input)
    (mk-ugen (list "PauseSelf"
                   rt
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pause-self-when-done rt src)
    (mk-ugen (list "PauseSelfWhenDone"
                   rt
                   (list src)
                   nil
                   1
                   nil
                   nil)))
  
  (define (peak input trig)
    (mk-ugen (list "Peak"
                   (list 0)
                   (list input trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (peak-follower input decay)
    (mk-ugen (list "PeakFollower"
                   (list 0)
                   (list input decay)
                   nil
                   1
                   nil
                   nil)))
  
  (define (phasor rt trig rate_ start end resetPos)
    (mk-ugen (list "Phasor"
                   rt
                   (list trig rate_ start end resetPos)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pink-noise rt)
    (mk-ugen (list "PinkNoise"
                   rt
                   nil
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (pitch input initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample clar)
    (mk-ugen (list "Pitch"
                   kr
                   (list input initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample clar)
                   nil
                   2
                   nil
                   nil)))
  
  (define (pitch-shift input windowSize pitchRatio pitchDispersion timeDispersion)
    (mk-ugen (list "PitchShift"
                   (list 0)
                   (list input windowSize pitchRatio pitchDispersion timeDispersion)
                   nil
                   1
                   nil
                   nil)))
  
  (define (play-buf nc rt bufnum rate_ trigger startPos loop doneAction)
    (mk-ugen (list "PlayBuf"
                   rt
                   (list bufnum rate_ trigger startPos loop doneAction)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (pluck input trig maxdelaytime delaytime decaytime coef)
    (mk-ugen (list "Pluck"
                   (list 0)
                   (list input trig maxdelaytime delaytime decaytime coef)
                   nil
                   1
                   nil
                   nil)))
  
  (define (poll trig input label_ trigid)
    (mk-ugen (list "Poll"
                   (list 1)
                   (list trig input label_ trigid)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pulse rt freq width)
    (mk-ugen (list "Pulse"
                   rt
                   (list freq width)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pulse-count trig reset)
    (mk-ugen (list "PulseCount"
                   (list 0)
                   (list trig reset)
                   nil
                   1
                   nil
                   nil)))
  
  (define (pulse-divider trig div_ start)
    (mk-ugen (list "PulseDivider"
                   (list 0)
                   (list trig div_ start)
                   nil
                   1
                   nil
                   nil)))
  
  (define (quad-c rt freq a b c xi)
    (mk-ugen (list "QuadC"
                   rt
                   (list freq a b c xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (quad-l rt freq a b c xi)
    (mk-ugen (list "QuadL"
                   rt
                   (list freq a b c xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (quad-n rt freq a b c xi)
    (mk-ugen (list "QuadN"
                   rt
                   (list freq a b c xi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-delay-map bufnum input dynamic spec)
    (mk-ugen (list "RDelayMap"
                   (list 1)
                   (list bufnum input dynamic)
                   spec
                   1
                   nil
                   nil)))
  
  (define (r-delay-set rt input spec)
    (mk-ugen (list "RDelaySet"
                   rt
                   (list input spec)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-delay-set-b rt bufnum input spec)
    (mk-ugen (list "RDelaySetB"
                   rt
                   (list bufnum input spec)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-freezer rt
                     bufnum
                     left
                     right
                     gain
                     increment
                     incrementOffset
                     incrementRandom
                     rightRandom
                     syncPhaseTrigger
                     randomizePhaseTrigger
                     numberOfLoops)
    (mk-ugen (list "RFreezer" rt
                   (list bufnum
                         left
                         right
                         gain
                         increment
                         incrementOffset
                         incrementRandom
                         rightRandom
                         syncPhaseTrigger
                         randomizePhaseTrigger
                         numberOfLoops)
                   nil
                   1
                   nil
                   nil)))
  
  (define (rhpf input freq rq)
    (mk-ugen (list "RHPF"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (rlpf input freq rq)
    (mk-ugen (list "RLPF"
                   (list 0)
                   (list input freq rq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-loop-set rt bufnum left right gain increment spec)
    (mk-ugen (list "RLoopSet"
                   rt
                   (list bufnum left right gain increment spec)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-play-trace rt bufnum degree rate_ axis)
    (mk-ugen (list "RPlayTrace"
                   rt
                   (list bufnum degree rate_ axis)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-shuffler-b bufnum
                        readLocationMinima
                        readLocationMaxima
                        readIncrementMinima
                        readIncrementMaxima
                        durationMinima
                        durationMaxima
                        envelopeAmplitudeMinima
                        envelopeAmplitudeMaxima
                        envelopeShapeMinima
                        envelopeShapeMaxima
                        envelopeSkewMinima
                        envelopeSkewMaxima
                        stereoLocationMinima
                        stereoLocationMaxima
                        interOffsetTimeMinima
                        interOffsetTimeMaxima
                        ftableReadLocationIncrement
                        readIncrementQuanta
                        interOffsetTimeQuanta)
    (mk-ugen (list "RShufflerB"
                   ar
                   (list bufnum
                         readLocationMinima
                         readLocationMaxima
                         readIncrementMinima
                         readIncrementMaxima
                         durationMinima
                         durationMaxima
                         envelopeAmplitudeMinima
                         envelopeAmplitudeMaxima
                         envelopeShapeMinima
                         envelopeShapeMaxima
                         envelopeSkewMinima
                         envelopeSkewMaxima
                         stereoLocationMinima
                         stereoLocationMaxima
                         interOffsetTimeMinima
                         interOffsetTimeMaxima
                         ftableReadLocationIncrement
                         readIncrementQuanta
                         interOffsetTimeQuanta)
                   nil
                   2
                   nil
                   nil)))
  
  (define (r-shuffler-l rt input fragmentSize maxDelay)
    (mk-ugen (list "RShufflerL"
                   rt
                   (list input fragmentSize maxDelay)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-trace-rd rt bufnum degree index axis)
    (mk-ugen (list "RTraceRd"
                   rt
                   (list bufnum degree index axis)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-trace-rd-x rt bufnum degree index)
    (mk-ugen (list "RTraceRdX"
                   rt
                   (list bufnum degree index)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-trace-rd-y rt bufnum degree index)
    (mk-ugen (list "RTraceRdY"
                   rt
                   (list bufnum degree index)
                   nil
                   1
                   nil
                   nil)))
  
  (define (r-trace-rd-z rt bufnum degree index)
    (mk-ugen (list "RTraceRdZ"
                   rt
                   (list bufnum degree index)
                   nil
                   1
                   nil
                   nil)))
  
  (define radians-per-sample
    (mk-ugen (list "RadiansPerSample"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (ramp input lagTime)
    (mk-ugen (list "Ramp"
                   (list 0)
                   (list input lagTime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (rand lo hi)
    (mk-ugen (list "Rand"
                   ir
                   (list lo hi)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (rand-id rt id_)
    (mk-ugen (list "RandID"
                   rt
                   (list id_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (rand-seed rt trig seed)
    (mk-ugen (list "RandSeed"
                   rt
                   (list trig seed)
                   nil
                   1
                   nil
                   nil)))
  
  (define (record-buf rt bufnum offset recLevel preLevel run loop trigger doneAction inputArray)
    (mk-ugen (list "RecordBuf"
                   rt
                   (list bufnum offset recLevel preLevel run loop trigger doneAction)
                   inputArray
                   1
                   nil
                   nil)))
  
  (define (replace-out bus input)
    (mk-ugen (list "ReplaceOut"
                   (list 1)
                   (list bus)
                   input
                   1
                   nil
                   nil)))
  
  (define (resonz input freq bwr)
    (mk-ugen (list "Resonz"
                   (list 0)
                   (list input freq bwr)
                   nil
                   1
                   nil
                   nil)))
  
  (define (ringz input freq decaytime)
    (mk-ugen (list "Ringz"
                   (list 0)
                   (list input freq decaytime)
                   nil
                   1
                   nil
                   nil)))
  
  (define (rotate2 x y pos)
    (mk-ugen (list "Rotate2"
                   (list 0 1)
                   (list x y pos)
                   nil
                   2
                   nil
                   nil)))
  
  (define (running-max input trig)
    (mk-ugen (list "RunningMax"
                   (list 0)
                   (list input trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (running-min input trig)
    (mk-ugen (list "RunningMin"
                   (list 0)
                   (list input trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (running-sum input numsamp)
    (mk-ugen (list "RunningSum"
                   (list 0)
                   (list input numsamp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (sos input a0 a1 a2 b1 b2)
    (mk-ugen (list "SOS"
                   (list 0)
                   (list input a0 a1 a2 b1 b2)
                   nil
                   1
                   nil
                   nil)))
  
  (define sample-dur
    (mk-ugen (list "SampleDur"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define sample-rate
    (mk-ugen (list "SampleRate"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (saw rt freq)
    (mk-ugen (list "Saw"
                   rt
                   (list freq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (schmidt rt input lo hi)
    (mk-ugen (list "Schmidt"
                   rt
                   (list input lo hi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (scope-out rt inputArray bufnum)
    (mk-ugen (list "ScopeOut"
                   rt
                   (list inputArray bufnum)
                   nil
                   1
                   nil
                   nil)))
  
  (define (scope-out2 rt inputArray scopeNum maxFrames scopeFrames)
    (mk-ugen (list "ScopeOut2"
                   rt
                   (list inputArray scopeNum maxFrames scopeFrames)
                   nil
                   1
                   nil
                   nil)))
  
  (define (select which array)
    (mk-ugen (list "Select"
                   (list 0 1)
                   (list which)
                   array
                   1
                   nil
                   nil)))
  
  (define (send-trig input id_ value)
    (mk-ugen (list "SendTrig"
                   (list 0)
                   (list input id_ value)
                   nil
                   1
                   nil
                   nil)))
  
  (define (set-reset-ff trig reset)
    (mk-ugen (list "SetResetFF"
                   (list 0)
                   (list trig reset)
                   nil
                   1
                   nil
                   nil)))
  
  (define (shaper bufnum input)
    (mk-ugen (list "Shaper"
                   (list 1)
                   (list bufnum input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (sin-osc rt freq phase)
    (mk-ugen (list "SinOsc"
                   rt
                   (list freq phase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (sin-osc-fb rt freq feedback)
    (mk-ugen (list "SinOscFB"
                   rt
                   (list freq feedback)
                   nil
                   1
                   nil
                   nil)))
  
  (define (slew input up dn)
    (mk-ugen (list "Slew"
                   (list 0)
                   (list input up dn)
                   nil
                   1
                   nil
                   nil)))
  
  (define (slope input)
    (mk-ugen (list "Slope"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (spec-centroid rt buffer)
    (mk-ugen (list "SpecCentroid"
                   rt
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (spec-flatness rt buffer)
    (mk-ugen (list "SpecFlatness"
                   rt
                   (list buffer)
                   nil
                   1
                   nil
                   nil)))
  
  (define (spec-pcile rt buffer fraction interpolate)
    (mk-ugen (list "SpecPcile"
                   rt
                   (list buffer fraction interpolate)
                   nil
                   1
                   nil
                   nil)))
  
  (define (spring rt input spring damp)
    (mk-ugen (list "Spring"
                   rt
                   (list input spring damp)
                   nil
                   1
                   nil
                   nil)))
  
  (define (standard-l rt freq k xi yi)
    (mk-ugen (list "StandardL"
                   rt
                   (list freq k xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (standard-n rt freq k xi yi)
    (mk-ugen (list "StandardN"
                   rt
                   (list freq k xi yi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (stepper trig reset min_ max_ step resetval)
    (mk-ugen (list "Stepper"
                   (list 0)
                   (list trig reset min_ max_ step resetval)
                   nil
                   1
                   nil
                   nil)))
  
  (define (stereo-convolution2l rt input kernelL kernelR trigger framesize crossfade)
    (mk-ugen (list "StereoConvolution2L"
                   rt
                   (list input kernelL kernelR trigger framesize crossfade)
                   nil
                   2
                   nil
                   nil)))
  
  (define subsample-offset
    (mk-ugen (list "SubsampleOffset"
                   ir
                   nil
                   nil
                   1
                   nil
                   nil)))
  
  (define (sum3 in0 in1 in2)
    (mk-ugen (list "Sum3"
                   (list 0 1 2)
                   (list in0 in1 in2)
                   nil
                   1
                   nil
                   nil)))
  
  (define (sum4 in0 in1 in2 in3)
    (mk-ugen (list "Sum4"
                   (list 0 1 2 3)
                   (list in0 in1 in2 in3)
                   nil
                   1
                   nil
                   nil)))
  
  (define (sweep trig rate_)
    (mk-ugen (list "Sweep"
                   (list 0)
                   (list trig rate_)
                   nil
                   1
                   nil
                   nil)))
  
  (define (sync-saw rt syncFreq sawFreq)
    (mk-ugen (list "SyncSaw"
                   rt
                   (list syncFreq sawFreq)
                   nil
                   1
                   nil
                   nil)))
  
  (define (t2a input offset)
    (mk-ugen (list "T2A"
                   ar
                   (list input offset)
                   nil
                   1
                   nil
                   nil)))
  
  (define (t2k rt input)
    (mk-ugen (list "T2K"
                   rt
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (t-ball rt input g damp friction)
    (mk-ugen (list "TBall"
                   rt
                   (list input g damp friction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (t-delay input dur)
    (mk-ugen (list "TDelay"
                   (list 0)
                   (list input dur)
                   nil
                   1
                   nil
                   nil)))
  
  (define (t-duty rt dur reset doneAction level gapFirst)
    (mk-ugen (list "TDuty"
                   rt
                   (list dur reset doneAction level gapFirst)
                   nil
                   1
                   nil
                   nil)))
  
  (define (t-exp-rand lo hi trig)
    (mk-ugen (list "TExpRand"
                   (list 2)
                   (list lo hi trig)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (t-grains nc trigger bufnum rate_ centerPos dur pan amp interp)
    (mk-ugen (list "TGrains"
                   ar
                   (list trigger bufnum rate_ centerPos dur pan amp interp)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (ti-rand lo hi trig)
    (mk-ugen (list "TIRand"
                   (list 2)
                   (list lo hi trig)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (t-rand lo hi trig)
    (mk-ugen (list "TRand"
                   (list 2)
                   (list lo hi trig)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (t-windex input normalize array)
    (mk-ugen (list "TWindex"
                   (list 0)
                   (list input normalize)
                   array
                   1
                   nil
                   (incr-uid 1))))
  
  (define (tap nc rt bufnum delaytime)
    (mk-ugen (list "Tap"
                   rt
                   (list bufnum delaytime)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (timer trig)
    (mk-ugen (list "Timer"
                   (list 0)
                   (list trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (toggle-ff trig)
    (mk-ugen (list "ToggleFF"
                   (list 0)
                   (list trig)
                   nil
                   1
                   nil
                   nil)))
  
  (define (trig input dur)
    (mk-ugen (list "Trig"
                   (list 0)
                   (list input dur)
                   nil
                   1
                   nil
                   nil)))
  
  (define (trig1 input dur)
    (mk-ugen (list "Trig1"
                   (list 0)
                   (list input dur)
                   nil
                   1
                   nil
                   nil)))
  
  (define (trig-control rt values)
    (mk-ugen (list "TrigControl"
                   rt
                   (list values)
                   nil
                   1
                   nil
                   nil)))
  
  (define (two-pole input freq radius)
    (mk-ugen (list "TwoPole"
                   (list 0)
                   (list input freq radius)
                   nil
                   1
                   nil
                   nil)))
  
  (define (two-zero input freq radius)
    (mk-ugen (list "TwoZero"
                   (list 0)
                   (list input freq radius)
                   nil
                   1
                   nil
                   nil)))
  
  (define (unary-op-ugen a)
    (mk-ugen (list "UnaryOpUGen"
                   (list 0)
                   (list a)
                   nil
                   1
                   nil
                   nil)))
  
  (define (v-disk-in nc bufnum rate_ loop sendID)
    (mk-ugen (list "VDiskIn"
                   ar
                   (list bufnum rate_ loop sendID)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (v-osc rt bufpos freq phase)
    (mk-ugen (list "VOsc"
                   rt
                   (list bufpos freq phase)
                   nil
                   1
                   nil
                   nil)))
  
  (define (v-osc3 rt bufpos freq1 freq2 freq3)
    (mk-ugen (list "VOsc3"
                   rt
                   (list bufpos freq1 freq2 freq3)
                   nil
                   1
                   nil
                   nil)))
  
  (define (var-lag rt input time curvature warp start)
    (mk-ugen (list "VarLag"
                   rt
                   (list input time curvature warp start)
                   nil
                   1
                   nil
                   nil)))
  
  (define (var-saw rt freq iphase width)
    (mk-ugen (list "VarSaw"
                   rt
                   (list freq iphase width)
                   nil
                   1
                   nil
                   nil)))
  
  (define (vibrato rt freq rate_ depth delay onset rateVariation depthVariation iphase)
    (mk-ugen (list "Vibrato"
                   rt
                   (list freq rate_ depth delay onset rateVariation depthVariation iphase)
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (warp1 nc bufnum pointer freqScale windowSize envbufnum overlaps windowRandRatio interp)
    (mk-ugen (list "Warp1"
                   ar
                   (list bufnum pointer freqScale windowSize envbufnum overlaps windowRandRatio interp)
                   nil
                   nc
                   nil
                   nil)))
  
  (define (white-noise rt)
    (mk-ugen (list "WhiteNoise"
                   rt
                   nil
                   nil
                   1
                   nil
                   (incr-uid 1))))
  
  (define (width-first-ugen rt maxSize)
    (mk-ugen (list "WidthFirstUGen"
                   rt
                   (list maxSize)
                   nil
                   1
                   nil
                   nil)))
  
  (define (wrap input lo hi)
    (mk-ugen (list "Wrap"
                   (list 0)
                   (list input lo hi)
                   nil
                   1
                   nil
                   nil)))
  
  (define (wrap-index bufnum input)
    (mk-ugen (list "WrapIndex"
                   (list 1)
                   (list bufnum input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (x-fade2 inA inB pan level)
    (mk-ugen (list "XFade2"
                   (list 0 1)
                   (list inA inB pan level)
                   nil
                   1
                   nil
                   nil)))
  
  (define (x-line rt start end dur doneAction)
    (mk-ugen (list "XLine"
                   rt
                   (list start end dur doneAction)
                   nil
                   1
                   nil
                   nil)))
  
  (define (x-out bus xfade input)
    (mk-ugen (list "XOut"
                   (list 2)
                   (list bus xfade)
                   input
                   1
                   nil
                   nil)))
  
  (define (zero-crossing input)
    (mk-ugen (list "ZeroCrossing"
                   (list 0)
                   (list input)
                   nil
                   1
                   nil
                   nil)))
  
  (define (mul-add input mul add)
    (mk-ugen (list "MulAdd"
                   (list 0)
                   (list input mul add)
                   nil
                   1
                   nil
                   nil)))
  
  (define (set-buf buf offset length_ array)
    (mk-ugen (list "SetBuf"
                   ir
                   (list buf offset length_)
                   array
                   1
                   nil
                   nil)))
  
  (define (neg a)
    (mk-ugen (list "UnaryOpUGen"
                   (list 0)
                   (list a)
                   nil
                   1
                   0
                   nil)))
  
  (define (u:not a)
    (mk-ugen (list "UnaryOpUGen"
                   (list 0)
                   (list a)
                   nil
                   1
                   1
                   nil)))
  
  (define (is-nil a)
    (mk-ugen (list "UnaryOpUGen"
                   (list 0)
                   (list a)
                   nil
                   1
                   2
                   nil)))
  
  (define (not-nil a)
    (mk-ugen (list "UnaryOpUGen"
                   (list 0)
                   (list a)
                   nil
                   1
                   3
                   nil)))
  
  (define (bit-not a)
    (mk-ugen (list "UnaryOpUGen"
                   (list 0)
                   (list a)
                   nil
                   1
                   4
                   nil)))
  
  ;; HW - UGen
  
  (define (u:abs a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 5 nil)))
  
  (define (as-float a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 6 nil)))
  
  (define (as-int a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 7 nil)))
  
  (define (ceil a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 8 nil)))
  
  (define (u:floor a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 9 nil)))
  
  (define (frac a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 10 nil)))
  
  (define (sign a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 11 nil)))
  
  (define (squared a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 12 nil)))
  
  (define (cubed a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 13 nil)))
  
  (define (u:sqrt a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 14 nil)))
  
  (define (u:exp a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 15 nil)))
  
  (define (recip a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 16 nil)))
  
  (define (midicps a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 17 nil)))
  
  (define (cpsmidi a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 18 nil)))
  
  (define (midi-ratio a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 19 nil)))
  
  (define (ratio-midi a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 20 nil)))
  
  (define (db-amp a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 21 nil)))
  
  (define (amp-db a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 22 nil)))
  
  (define (oct-cps a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 23 nil)))
  
  (define (cps-oct a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 24 nil)))
  
  (define (u:log a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 25 nil)))
  
  (define (log2 a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 26 nil)))
  
  (define (log10 a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 27 nil)))
  
  (define (u:sin a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 28 nil)))
  
  (define (u:cos a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 29 nil)))
  
  (define (u:tan a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 30 nil)))
  
  (define (arc-sin a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 31 nil)))
  
  (define (arc-cos a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 32 nil)))
  
  (define (arc-tan a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 33 nil)))
  
  (define (sin-h a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 34 nil)))
  
  (define (cos-h a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 35 nil)))
  
  (define (tan-h a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 36 nil)))
  
  (define (rand- a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 37 nil)))
  
  (define (rand2 a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 38 nil)))
  
  (define (lin-rand- a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 39 nil)))
  
  (define (bi-lin-rand a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 40 nil)))
  
  (define (sum3rand a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 41 nil)))
  
  (define (distort a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 42 nil)))
  
  (define (soft-clip a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 43 nil)))
  
  (define (coin a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 44 nil)))
  
  (define (digit-value a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 45 nil)))
  
  (define (silence a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 46 nil)))
  
  (define (thru a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 47 nil)))
  
  (define (rect-window a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 48 nil)))
  
  (define (han-window a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 49 nil)))
  
  (define (welch-window a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 50 nil)))
  
  (define (tri-window a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 51 nil)))
  
  (define (ramp- a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 52 nil)))
  
  (define (s-curve a)
    (mk-ugen (list "UnaryOpUGen" (list 0) (list a) nil 1 53 nil)))
  
  (define (add a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 0 nil)))
  
  (define (sub a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 1 nil)))
  
  (define (mul a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 2 nil)))
  
  (define (i-div a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 3 nil)))
  
  (define (f-div a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 4 nil)))
  
  (define (u:mod a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 5 nil)))
  
  (define (u:eq a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 6 nil)))
  
  (define (ne a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 7 nil)))
  
  (define (u:lt a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 8 nil)))
  
  (define (u:gt a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 9 nil)))
  
  (define (le a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 10 nil)))
  
  (define (ge a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 11 nil)))
  
  (define (u:min a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 12 nil)))
  
  (define (u:max a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 13 nil)))
  
  (define (bit-and a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 14 nil)))
  
  (define (bit-or a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 15 nil)))
  
  (define (bit-xor a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 16 nil)))
  
  (define (u:lcm a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 17 nil)))
  
  (define (u:gcd a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 18 nil)))
  
  (define (u:round a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 19 nil)))
  
  (define (round-up a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 20 nil)))
  
  (define (trunc a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 21 nil)))
  
  (define (atan2 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 22 nil)))
  
  (define (hypot a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 23 nil)))
  
  (define (hypotx a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 24 nil)))
  
  (define (pow a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 25 nil)))
  
  (define (shift-left a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 26 nil)))
  
  (define (shift-right a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 27 nil)))
  
  (define (unsigned-shift a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 28 nil)))
  
  (define (fill a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 29 nil)))
  
  (define (ring1 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 30 nil)))
  
  (define (ring2 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 31 nil)))
  
  (define (ring3 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 32 nil)))
  
  (define (ring4 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 33 nil)))
  
  (define (dif-sqr a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 34 nil)))
  
  (define (sum-sqr a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 35 nil)))
  
  (define (sqr-sum a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 36 nil)))
  
  (define (sqr-dif a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 37 nil)))
  
  (define (abs-dif a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 38 nil)))
  
  (define (thresh a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 39 nil)))
  
  (define (am-clip a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 40 nil)))
  
  (define (scale-neg a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 41 nil)))
  
  (define (clip2 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 42 nil)))
  
  (define (excess a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 43 nil)))
  
  (define (fold2 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 44 nil)))
  
  (define (wrap2 a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 45 nil)))
  
  (define (first-arg a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 46 nil)))
  
  (define (rand-range a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 47 nil)))
  
  (define (exp-rand-range a b)
    (mk-ugen (list "BinaryOpUGen" (list 0 1) (list a b) nil 1 48 nil)))
  

  ;; Derived
  
  (define add3 sum3)
  (define add4 sum4)
  
  (define (as-local-buf l)
    (let* ((b (local-buf (length l) 1))
           (s (set-buf* b 0 l)))
      (mrg2 b s)))
  
  (define (buf-rd-c nc r b p l)
    (buf-rd nc r b p l 4))

  (define (buf-rd-l nc r b p l)
    (buf-rd nc r b p l 2))

  (define (buf-rd-n nc r b p l)
    (buf-rd nc r b p l 1))
  
  (define cps-midi cpsmidi)

  ;; ugen -> ugen -> ugen
  (define (dcons x xs)
    (let ((i (dseq 1 (mce2 0 1)))
          (a (dseq 1 (mce2 x xs))))
      (dswitch i a)))

  ;; ugen -> ugen -> ugen -> ugen -> ugen -> ugen
  (define (dyn-klank* i fs fo ds l)
    (if (null? l)
        0
        (let ((f (list-ref l 0))
              (a (list-ref l 1))
              (d (list-ref l 2)))
          (add (mul (ringz i (mul-add f fs fo) (mul d ds)) a)
               (dyn-klank* i fs fo ds (drop 3 l))))))
  
  (define (dyn-klank i fs fo ds s)
    (dyn-klank* i fs fo ds (mce-channels s)))
  
  (define fdiv f-div)
  
  (define (fft* buf in)
    (fft buf in 0.5 0 1 0))

  ;; ugen -> ugen -> ugen -> ugen
  (define (freq-shift* i f p)
    (let ((o (sin-osc ar f (mce2 (add p (* 0.5 pi)) p)))
          (h (hilbert i)))
      (mix (mul h o))))
  
  (define (hear u)
    (audition (out 0 u)))
  
  (define (ifft* buf)
    (ifft buf 0 0))

  ;; [ugen] -> [ugen] -> [ugen] -> ugen
  (define (klang-data freqs amps phases)
    (make-mce (concat (zip-with3 list3
                                 freqs
                                 amps
                                 phases))))
  

  ;; [ugen] -> [ugen] -> [ugen] -> ugen
  (define klank-data klang-data)

  ;; ugen -> ugen -> ugen -> ugen
  (define (klank-data-mce f a p)
    (klank-data (mce-channels f)
                (mce-channels a)
                (mce-channels p)))
  
  (define (l-choose l)
    (select (i-rand 0 (length l))
            (make-mce l)))
  
  (define (lin-lin in srclo srchi dstlo dsthi)
    (let* ((scale (fdiv (sub dsthi dstlo) (sub srchi srclo)))
           (offset (sub dstlo (mul scale srclo))))
      (mul-add in scale offset)))
  
  (define (mce2 a b)
    (make-mce (list a b)))
  
  (define (mce3 a b c)
    (make-mce (list a b c)))
  
  (define (mce4 a b c d)
    (make-mce (list a b c d)))
  
  (define (mce5 a b c d e)
    (make-mce (list5 a b c d e)))
  
  ;; mce -> int -> ugen
  (define (mce-channel u n)
    (list-ref (mce-channels u) n))

  ;; ([ugen] -> [ugen]) -> (mce -> mce)
  (define (mce-edit f)
    (lambda (u)
      (make-mce (f (mce-channels u)))))

  ;; int -> (int -> ugen) -> mce
  (define (mce-fill n f)
    (make-mce (map f (enum-from-to 0 (- n 1)))))

  ;; (ugen -> ugen) -> mce -> mce
  (define (mce-map f u)
    (make-mce (map f (mce-channels u))))

  ;; mce -> mce
  (define mce-reverse (mce-edit reverse))
  
  ;; mce -> mce
  (define (mce-transpose u)
    (make-mce (map make-mce (transpose (map mce-channels (mce-channels u))))))
  
  (define midi-cps midicps)

  ;; ugen|mce -> ugen
  (define (mix u)
    (foldl add 0 (mce-channels u)))
  
  ;; int -> (int -> ugen) -> ugen
  (define (mix-fill n f)
    (mix (mce-fill n f)))
  
  ;; Rate -> UGen -> UGen -> Warp -> UGen -> UGen
  (define (mouse-r rt l r ty tm)
    (let ((f (if (= ty 0) lin-lin lin-exp)))
      (lag (f (lf-noise1 rt 1) -1 1 l r) tm)))
  
  (define mouse-x* mouse-r)
  
  (define mouse-y* mouse-r)
  
  (define (mouse-button* rt l r tm)
    (let ((o (lf-clip-noise rt 1)))
      (lag (lin-lin o -1 1 l r) tm)))
  
  (define mrg2 make-mrg)
  
  (define (mrg3 a b c)
    (mrg2 a (mrg2 b c)))
  
  (define (mrg4 a b c d)
    (mrg2 a (mrg3 b c d)))
  
  (define (mrg5 a b c d e)
    (mrg2 a (mrg4 b c d e)))

  ;; [ugen] -> mrg
  (define (mrg-n xs)
    (if (null? xs)
        (error "mrg-n" "nil input list" xs)
        (if (null? (tail xs))
            (head xs)
            (mrg2 (head xs)
                  (mrg-n (tail xs))))))
  
  (define (mul3 a b c)
    (mul (mul a b) c))
  
  (define (mul4 a b c d)
    (mul (mul (mul a b) c) d))
  
  ;; [m] -> [p] -> [#, m, p...]
  (define (packfft-data m p)
    (make-mce
     (cons (* 2 (length m))
           (concat (zip-with list m p)))))

  ;; [[m, p]] -> [#, m, p...]
  (define (packfft-data* mp)
    (make-mce
     (cons (* 2 (length mp))
           (concat mp))))

  ;; double -> void
  (define pause-thread thread-sleep)

  ;; double -> void
  (define (pause-thread-until t)
    (let ((c (utcr)))
      (when (> t c)
        (pause-thread (- t c)))))

  ;; port -> ugen -> ()
  (define (play fd u)
    (play-at fd u -1 add-to-tail 1))
  
  ;; rate -> ugen -> ugen -> ugen -> ugen -> ugen
  (define (pm-osc r cf mf pm mp)
    (sin-osc r cf (mul (sin-osc r mf mp) pm)))
  
  (define (pvcollect c nf f from to z?)
    (let* ((m (unpack-fft c nf from to 0))
           (p (unpack-fft c nf from to 1))
           (i (enum-from-to from to))
           (e (zip-with3 f m p i)))
      (pack-fft c nf from to z? (packfft-data* e))))
  
  (define rand* rand-)

  ; the cardinality input is derived from the values input...
  (define (set-buf* buf offset values)
    (set-buf buf offset (length values) (make-mce values)))

  ;; ugen -> ugen
  (define (sound-in n)
    (if (mce? n)
        (let ((l (mce-channels n)))
          (if (consecutive? l)
              (in (length l) ar (add num-output-buses (head l)))
              (in 1 ar (add num-output-buses n))))
        (in 1 ar (add num-output-buses n))))
  
  (define (t-choose trig array)
    (select (ti-rand 0 (length (mce-channels array)) trig) array))
  
  (define (tw-choose trig array weights normalize)
    (select (tw-index trig normalize weights) array))
  
  (define tw-index t-windex)
  
  (define (unpack-fft c nf from to mp?)
    (map (lambda (i) (unpack1-fft c nf i mp?)) (enum-from-to from to)))
  
  (define (with-sc3* l)
    (with-sc3
     (lambda (fd)
       (map (lambda (f) (f fd))
            l))))

  ;; Random

  ;; float -> float -> float
  (define (exp-random a b)
    (let ((r (/ b a)))
      (* (expt r (random 0 1)) a)))

  ;; [a] -> a
  (define (choose xs)
    (list-ref xs (i-random 0 (length xs))))

  ;; Envelope

  ;; symbol|number -> number
  (define (curve-to-shape c)
    (cond ((symbol? c)
           (cond ((equal? c (quote step)) 0.0)
                 ((equal? c (quote linear)) 1.0)
                 ((equal? c (quote exponential)) 2.0)
                 ((equal? c (quote sine)) 3.0)
                 ((equal? c (quote welch)) 4.0)
                 ((equal? c (quote squared)) 6.0)
                 ((equal? c (quote cubed)) 7.0)
                 (else (error "curve-to-shape" "symbol" c))))
          ((number? c)
           5.0)
          (else
           (error "curve-to-shape" "illegal curve" c))))

  ;; any -> number
  (define (curve-to-value c)
    (if (number? c) c 0.0))
  
  ;; Make a <list> for use with the EnvGen UGen. `levels' is a <list>
  ;; containing the left to right gain values for the envelope, it has
  ;; one more element than the <list> `times', having the delta times
  ;; for each envelope segment. `curve' is either a string or a number
  ;; or a <list> of such, in either case it is expanded to a list of the
  ;; same length as `times'. `release-node' is the index of the
  ;; 'release' stage of the envelope, `loop-node' is the index of the
  ;; 'loop' stage of the envelope. These indices are set as invalid, by
  ;; convention -1, to indicate there is no such node.
  (define (env levels times curves release-node loop-node)
    (make-mce
     (append (list (head levels)
                   (length times)
                   release-node
                   loop-node)
             (concat (zip-with3 (lambda (l t c)
                                  (list l
                                        t
                                        (curve-to-shape c)
                                        (curve-to-value c)))
                                (tail levels)
                                times
                                curves)))))

  ;; Co-ordinate based static envelope generator.
  ;; [(ugen . ugen)] -> ugen -> ugen -> [ugen] -> ugen
  (define (env-coord d dur amp curves)
    (env (map (lambda (e) (mul (cdr e) amp))
              d)
         (map (lambda (e) (mul e dur))
              (d->dx (map car d)))
         curves
         -1
         -1))
  
  (define (env-coord-linear d dur amp)
    (env-coord d dur amp (replicate (- (length d) 1) 1)))

  ;; (equal? (mk-coord (list 1 2 3 4)) (list (cons 1 2) (cons 3 4)))
  (define (mk-coord l)
    (if (null? l)
        (quote ())
        (let ((x (car l))
              (y (cadr l))
              (r (cddr l)))
          (cons (cons x y)
                (mk-coord r)))))
  
  (define (env-bp bp d a c)
    (env-coord (mk-coord bp) d a c))
  
  (define (env-bp-linear bp d a)
    (env-coord-linear (mk-coord bp) d a))

  ;; Design a standard trapezoidal envelope. `shape' determines the
  ;; sustain time as a proportion of `dur', zero is a triangular
  ;; envelope, one a rectangular envelope. `skew' determines the
  ;; attack/decay ratio, zero is an immediate attack and a slow decay,
  ;; one a slow attack and an immediate decay. This implementation
  ;; builds a zero one breakpoint data set and calls env-coord.
  (define (env-trapezoid shape skew dur amp)
    (let* ((x1 (mul skew (sub 1.0 shape)))
           (bp (list (cons 0 (le skew 0.0))
                     (cons x1 1.0)
                     (cons (add shape x1) 1.0)
                     (cons 1.0 (ge skew 1.0)))))
      (env-coord bp dur amp (replicate 3 (quote linear)))))
  
  (define (env-triangle dur level)
    (let ((half-dur (mul dur 0.5)))
      (env (list 0.0 level 0.0)
           (list half-dur half-dur)
           (list (quote linear) (quote linear))
           -1
           -1)))
  
  (define (env-sine dur level)
    (let ((half-dur (mul dur 0.5)))
      (env (list 0.0 level 0.0)
           (list half-dur half-dur)
           (list (quote sine) (quote sine))
           -1
           -1)))
  
  (define (env-perc attackTime releaseTime level curves)
    (env (list 0.0 level 0.0)
         (list attackTime releaseTime)
         curves
         -1
         -1))
  
  (define (env-adsr attackTime decayTime sustainLevel releaseTime peakLevel curves bias)
    (env (map (lambda (e) (mul e bias))
              (list 0.0
                    peakLevel
                    (mul peakLevel sustainLevel)
                    0.0))
         (list attackTime decayTime releaseTime)
         curves
         2
         -1))
  
  (define (env-asr attackTime sustainLevel releaseTime curves)
    (env (list 0.0 sustainLevel 0.0)
         (list attackTime releaseTime)
         curves
         1
         -1))
  
  (define (env-linen attackTime sustainTime releaseTime level curves)
    (env (list 0.0 level level 0.0)
         (list attackTime sustainTime releaseTime)
         (if (null? curves)
             (list (quote linear) (quote linear) (quote linear))
             curves)
         -1
         -1))

  ;; External
  
  (define exp-rand-n (mk-specialized-n-id "ExpRandN" (l r) ir))
  
  (define i-rand-n (mk-specialized-n-id "IRandN" (l r) ir))
  
  (define lin-rand-n (mk-specialized-n-id "LinRandN" (l r bias) ir))
  
  (define rand-n (mk-specialized-n-id "RandN" (l r) ir))
  
  (define t-scramble (mk-oscillator-mce "TScramble" (tr i) 1))

  ;; HW
  
  (define (pack-fft b sz fr to z mp)
    (mk-ugen (list "PackFFT" kr (list b sz fr to z) mp 1 nil nil)))
  
  (define (unpack1-fft c b bi wm)
    (mk-ugen (list "Unpack1FFT" dr (list c b bi wm) nil 1 nil nil)))

  ;; HW - Syntax

  ;; int -> maybe (float -> float) -> (node -> node)
  (define (mk-unary-operator s f)
    (lambda (a)
      (if (and (number? a) f)
          (f a)
          (construct-ugen "UnaryOpUGen"
                          (quote ())
                          (list1 a)
                          (quote ())
                          1
                          s
                          (make-uid 0)))))

  ;; int -> maybe (float -> float -> float) -> (node -> node -> node)
  (define (mk-binary-operator s f)
    (lambda (a b)
      (if (and (number? a)
               (number? b)
               f)
          (f a b)
          (construct-ugen "BinaryOpUGen"
                          (quote ())
                          (list2 a b)
                          (quote ())
                          1
                          s
                          (make-uid 0)))))

  ;; string -> [symbol] -> int ~> (ugen ... -> ugen)
  (define-syntax mk-filter
    (syntax-rules ()
      ((_ m (i ...) o)
       (lambda (i ...)
         (construct-ugen m
                         (quote ())
                         (list i ...)
                         (quote ())
                         o
                         0
                         (make-uid 0))))))

  ;; string -> [symbol] ~> (int -> ugen ... -> ugen)
  (define-syntax mk-filter-n
    (syntax-rules ()
      ((_ m (i ...))
       (lambda (nc i ...)
         (if (not (integer? nc))
             (error "mk-filter-n" "illegal channel count" (quote n) nc)
             (quote ()))
         (let ((l (list i ...)))
           (construct-ugen m
                           (quote ())
                           l
                           (quote ())
                           nc
                           0
                           (make-uid 0)))))))

  ;; string -> [symbol] -> int ~> (ugen ... -> ugen)
  (define-syntax mk-filter-mce
    (syntax-rules ()
      ((_ m (i ... v) o)
       (lambda (i ... v)
         (construct-ugen m
                         (quote ())
                         (list i ...)
                         v
                         o
                         0
                         (make-uid 0))))))

  ;; string -> [symbol] -> int ~> (ugen ... -> ugen)
  (define-syntax mk-filter-id
    (syntax-rules ()
      ((_ m (i ...) o)
       (lambda (i ...)
         (construct-ugen m
                         (quote ())
                         (list i ...)
                         (quote ())
                         o
                         0
                         (unique-uid))))))

  ;; string -> [symbol] -> int -> int ~> (ugen ... -> ugen)
  (define-syntax mk-filter-k
    (syntax-rules ()
      ((_ m (i ...) o k)
       (lambda (i ...)
         (let ((l (list i ...)))
           (construct-ugen m
                           (rate-of (list-ref l k))
                           l
                           (quote ())
                           o
                           0
                           (make-uid 0)))))))

  ;; string -> [symbol] -> int ~> (rate -> ugen ... -> ugen)
  (define-syntax mk-oscillator
    (syntax-rules ()
      ((_ m (i ...) o)
       (lambda (r i ...)
         (construct-ugen m
                         r
                         (list i ...)
                         (quote ())
                         o
                         0
                         (make-uid 0))))))

  ;; string -> [symbol] ~> (int -> rate -> ugen ... -> ugen)
  (define-syntax mk-oscillator-n
    (syntax-rules ()
      ((_ m (i ...))
       (lambda (nc r i ...)
         (if (not (integer? nc))
             (error "mk-oscillator-n" "illegal channel count:" (quote n) nc)
             (quote ()))
         (let ((l (list i ...)))
           (construct-ugen m
                           r
                           l
                           (quote ())
                           nc
                           0
                           (make-uid 0)))))))

  ;; string -> [symbol] -> int ~> (rate -> ugen ... -> ugen)
  (define-syntax mk-oscillator-mce
    (syntax-rules ()
      ((_ m (i ... v) o)
       (lambda (r i ... v)
         (construct-ugen m
                         r
                         (list i ...)
                         v
                         o
                         0
                         (make-uid 0))))))

  ;; string -> [symbol] -> int ~> (rate -> ugen ... -> ugen)
  (define-syntax mk-oscillator-id
    (syntax-rules ()
      ((_ m (i ...) o)
       (lambda (r i ...)
         (construct-ugen m
                         r
                         (list i ...)
                         (quote ())
                         o
                         0
                         (unique-uid))))))

  ;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
  (define-syntax mk-specialized
    (syntax-rules ()
      ((_ m (i ...) o r)
       (lambda (i ...)
         (construct-ugen m
                         r
                         (list i ...)
                         (quote ())
                         o
                         0
                         (make-uid 0))))))
  
  ;; string -> int -> rate ~> ugen
  (define-syntax mk-specialized-c
    (syntax-rules ()
      ((_ m o r)
       (construct-ugen m
                       r
                       nil
                       (quote ())
                       o
                       0
                       (make-uid 0)))))

  ;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
  (define-syntax mk-specialized-mce
    (syntax-rules ()
      ((_ m (i ... v) o r)
       (lambda (i ... v)
         (construct-ugen m
                         r
                         (list i ...)
                         v
                         o
                         0
                         (make-uid 0))))))

  ;; string -> [symbol] -> rate ~> (int -> ugen ... -> ugen)
  (define-syntax mk-specialized-n
    (syntax-rules ()
      ((_ m (i ...) r)
       (lambda (nc i ...)
         (if (not (integer? nc))
             (error "mk-specialized-n" "illegal channel count:" (quote n) nc)
             (quote ()))
         (let ((l (list i ...)))
           (construct-ugen m
                           r
                           l
                           (quote ())
                           nc
                           0
                           (make-uid 0)))))))

  ;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
  (define-syntax mk-specialized-id
    (syntax-rules ()
      ((_ m (i ...) o r)
       (lambda (i ...)
         (construct-ugen m
                         r
                         (list i ...)
                         (quote ())
                         o
                         0
                         (unique-uid))))))

  
  (define-syntax mk-specialized-n-id
    (syntax-rules ()
      ((_ m (i ...) r)
       (lambda (nc i ...)
         (if (not (integer? nc))
             (error "mk-specialized-n" "illegal channel count:" (quote n) nc)
             (quote ()))
         (let ((l (list i ...)))
           (construct-ugen m
                           r
                           l
                           (quote ())
                           nc
                           0
                           (unique-uid)))))))

  ;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
  (define-syntax mk-specialized-mce-id
    (syntax-rules ()
      ((_ m (i ... v) o r)
       (lambda (i ... v)
         (construct-ugen m
                         r
                         (list i ...)
                         v
                         o
                         0
                         (unique-uid))))))

  ;; List

  ;; [a] -> int -> [a]
  (define (extend l n)
    (let ((z (length l)))
      (cond ((= z n) l)
            ((> z n) (take n l))
            (else (extend (append l l) n)))))

  ;; [a] -> int -> [a]
  (define (take-cycle l n)
    (if (null? l)
        nil
        (cons (head l)
              (take-cycle (drop n l) n))))

  ;; (a -> a -> a) -> ([a] -> [a])
  (define (differentiate-with f)
    (lambda (l)
      (zip-with f l (cons 0 l))))

  ;; num a => [a] -> [a]
  ;;
  ;; (equal? (differentiate '(1 2 4 7 11)) '(1 1 2 3 4))
  (define differentiate (differentiate-with -))

  ;; (a -> a -> a) -> ([a] -> [a])
  (define integrate-with
    (lambda (f)
      (lambda (l)
        (let ((x (car l))
              (xs (cdr l))
              (g (lambda (a x)
                   (let ((y (f a x)))
                     (cons y y)))))
          (cons x
                (cdr (map-accum-l g x xs)))))))

  ;; num a => [a] -> [a]
  ;;
  ;; (equal? (integrate (list 3 4 1 1)) (list 3 7 8 9))
  ;; (equal? (integrate '(1 1 2 3 4)) '(1 2 4 7 11))
  (define integrate (integrate-with +))
  
  (define (d->dx l)
    (zip-with sub (drop 1 l) l))

  ;; int -> [any] -> [any]
  (define (without n l)
    (append (take n l) (drop (+ n 1) l)))

  ;; [int] -> bool
  (define (consecutive? l)
    (let ((x (head l))
          (xs (tail l)))
      (or (null? xs)
          (and (= (+ x 1) (head xs))
               (consecutive? xs)))))

  ;; SC3

  ;; scheme functions for scsynth operators and ugens

  ;; ord a => a -> a -> a
  (define (s:lt p q)
    (if (< p q) 1 0))

  ;; ord a => a -> a -> a
  (define (s:le p q)
    (if (<= p q) 1 0))

  ;; ord a => a -> a -> a
  (define (s:ge p q)
    (if (>= p q) 1 0))

  ;; ord a => a -> a -> a
  (define (s:gt p q)
    (if (> p q) 1 0))

  ;; real -> real -> real
  (define (s:round p q)
    (* (round (/ p q))
       q))
  
  ;; ord a => a -> a -> a -> a
  (define (s:clip a b n)
    (cond ((< n a) a)
          ((> n b) b)
          (else n)))

  ;; number a => a -> a
  (define (s:squared n)
    (* n n))
  
  ;; number a => a -> a
  (define (s:cubed n)
    (* n n n))
  
  ;; number a => a -> a
  (define (s:recip n)
    (/ 1 n))

  ;; float -> float
  (define (s:log2 x)
    (/ (log (abs x))
       (log 2)))

  ;; float -> float
  (define (s:log10 x)
    (/ (log x)
       (log 10)))

  ;; float -> float
  (define (s:amp-db x)
    (* (s:log10 x) 20))

  ;; float -> float
  (define (s:db-amp x)
    (expt 10 (* x 0.05)))

  ;; float -> float
  (define (s:pow-db x)
    (* (s:log10 x) 10))

  ;; float -> float
  (define (s:db-pow x)
    (expt 10 (* x 0.1)))

  ;; float -> float
  (define (s:midi-cps note)
    (* 440.0
       (expt 2.0 (* (- note 69.0)
                    (/ 1.0 12.0)))))

  ;; float -> float
  (define (s:cps-midi freq)
    (+ (* (s:log2 (* freq
                     (/ 1.0 440.0)))
          12.0)
       69.0))

  ;; float -> float
  (define (s:midi-ratio midi)
    (expt 2.0
          (* midi
             (/ 1.0 12.0))))

  ;; float -> float
  (define (s:ratio-midi ratio)
    (* 12.0 (s:log2 ratio)))

  ;; float -> float
  (define (s:oct-cps note)
    (* 440.0
       (expt 2.0 (- note 4.75))))

  ;; float -> float
  (define (s:cps-oct freq)
    (+ (s:log2 (* freq
                  (/ 1.0 440.0)))
       4.75))

  ;; float -> [float] -> int -> float
  (define (s:degree-to-key degree scale steps)
    (let ((scale-n (length scale)))
      (+ (* steps (div degree scale-n))
         (list-ref scale (exact (mod degree scale-n))))))

  ;; (s:l-choose (list 1 3 5 7 9))
  (define (s:l-choose l)
    (list-ref l (i-random 0 (length l))))

  ;; 
  ;; rsc3-lang
  ;;

  (define (series* plus)
    (letrec ((f (lambda (n i j)
                  (if (equal? n 0) (list)
                      (cons i (f (- n 1) (plus i j) j))))))
      f))
  
  ;; (equal? (series 5 10 2) (list 10 12 14 16 18))
  (define series (series* +))

  ;; [a] -> [a]
  ;;
  ;; (replicate-m 3 (shuffle '(1 2 3 4 5)))
  (define (shuffle l)
    (let ((q (map (lambda (e) (cons (random 0 1) e)) l))
          (c (lambda (a b) (compare (car a) (car b)))))
      (map cdr (sort-by c q))))

  ;; [float] -> float -> int
  (define (w-index w n)
    (find-index (lambda (e) (< n e))
                (integrate w)))

  ;; [a] -> [float] -> a
  ;;
  ;; (replicate-m 20 (w-choose '(1 2 3 4 5) '(0.4 0.2 0.2 0.1 0.1)))
  (define (w-choose l w)
    (list-ref l (w-index w (random 0 1))))

  ;; [float] -> [float]
  (define (normalize-sum l)
    (let ((n (foldl1 + l))) (map (lambda (e) (/ e n)) l)))

  ;; [a] -> [float] -> a
  (define (p-choose l p)
    (w-choose l (normalize-sum p)))

  ;; #[a] -> a
  (define (vector-choose v)
    (vector-ref v (i-random 0 (vector-length v))))
  
  (define pi2
    (/ pi 2))

  (define pi32
    (* pi 1.5))
  
  (define twopi
    (* pi 2))
  
  (define rtwopi
    (/ 1 twopi))
  
  (define log001
    (log 0.001))
  
  (define log01
    (log 0.01))
  
  (define log1
    (log 0.1))
  
  (define rlog2
    (/ 1.0 (log 2.0)))
  
  (define sqrt2
    (sqrt 2.0))
  
  (define rsqrt2
    (/ 1.0 sqrt2))

  ;; [[a]] -> [[a]]
  ;;
  ;; (equal? (extend-all '((1 2) (1 2 3) (1 2 3 4) (1 2 3 4 5)))
  ;;         '((1 2 1 2 1) (1 2 3 1 2) (1 2 3 4 1) (1 2 3 4 5)))
  (define (extend-all l)
    (let* ((f (lambda (x) (length x)))
           (n (maximum (map f l))))
      (map (lambda (e) (extend e n)) l)))

  ;; (time -> delta-time) -> time -> ()
  (define (dt-rescheduler f t)
    (begin (pause-thread-until t)
           (let ((r (f t)))
             (when (number? r)
               (dt-rescheduler f (+ t r))))))

  ;; ugen -> ugen -> ugen
  ;;
  ;; (hear (mul (sin-osc ar 440 0) (mul (mk-env 5 1) 0.1)))
  (define (mk-env s t)
    (let* ((c 4) (p (env-linen t s t 1 (list c c c))))
      (env-gen kr 1 1 0 1 remove-synth p)))

  ;; ugen -> ugen -> ugen -> ugen
  ;;
  ;; (audition (with-env (mul (sin-osc ar 440 0) 0.1) 1 0.5))
  (define (with-env g s t)
    (out 0 (mul g (mk-env s t))))

  ;; overlap-texture-t -> float
  (define (overlap-texture-iot s t o)
    (/ (+ (* t 2) s) o))

  ;; x|()->x -> x
  ;;
  ;; (from-maybe-closure (lambda () 1))
  (define (from-maybe-closure x)
    (if (procedure? x) (x) x))
  
  ;; real|#f -> real|#f -> real|()->real -> int -> ugen|()->ugen
  (define (generalised-texture s t iot n u)
    (lambda (fd)
      (let ((f (lambda (_)
                 (if (> n 0)
                     (begin (set! n (- n 1))
                            (let* ((u* (from-maybe-closure u))
                                   (u** (if (not s)
                                            (out 0 u*)
                                            (with-env u* s t))))
                              (play-at fd u** -1 add-to-head 1))
                            (from-maybe-closure iot)) #f))))
        (dt-rescheduler f (utcr)))))

  ;; [real|()->real,int] -> ugen|()->ugen -> fd->()
  (define (spawn-u k u)
    (let* ((iot (list-ref k 0)) (n (list-ref k 1))) (generalised-texture #f #f iot n u)))

  ;; overlap-texture-t -> (() -> ugen) -> (fd -> ())
  ;;
  ;; (let ((u (pan2 (sin-osc ar (rand 400 600) 0) (rand -1 1) 0.02)))
  ;;   (with-sc3 (overlap-texture (list 6 3 9 24) u)))
  (define (overlap-texture k u)
    (let* ((s (list-ref k 0))
           (t (list-ref k 1))
           (o (list-ref k 2))
           (n (list-ref k 3))
           (iot (overlap-texture-iot s t o)))
      (generalised-texture s t iot n u)))

  ;; overlap-texture-t -> ugen -> (fd -> ())
  (define (overlap-texture-u k u)
    (overlap-texture k (lambda () u)))

  ;; xfade-texture-t -> float
  (define (xfade-texture-iot s t o)
    (/ (+ (* t 2) s) o))

  ;; xfade-texture-t -> (() -> ugen) -> (fd -> ())
  (define (xfade-texture k u)
    (let* ((s (list-ref k 0))
           (t (list-ref k 1))
           (n (list-ref k 2))
           (iot (+ s t)))
      (generalised-texture s t (lambda () iot) n u)))

  ;; xfade-texture-t -> ugen -> (fd -> ())
  (define (xfade-texture-u k u)
    (xfade-texture k (lambda () u)))
  
  (define (post-process-u nc f)
    (lambda (fd)
      (let ((u (replace-out 0 (f (in nc ar 0)))))
        (play-at fd u -1 add-to-tail 1))))

  ;; () -> float
  (define (random-linear)
    (min (random 0 1) (random 0 1)))

  ;; () -> float
  (define (random-inverse-linear)
    (max (random 0 1) (random 0 1)))

  ;; () -> float
  (define (random-triangular)
    (* 0.5 (+ (random 0 1)
              (random 0 1))))

  ;; float -> float
  (define (random-exponential l)
    (let ((u (random 0 1)))
      (if (zero? u)
          (random-exponential l)
          (/ (- (log u)) l))))

  ;; float -> float
  (define (random-bilinear-exponential l)
    (let ((u (* 2 (random 0 1))))
      (if (zero? u)
          (random-bilinear-exponential l)
          (* (if (> u 1) -1 1)
             (log (if (> u 1) (- 2 u) u))))))
  
  ;; float -> float -> float
  ;;
  ;; (replicate-m 3 (random-gaussian 1 0))
  (define (random-gaussian sigma mu)
    (+ mu (* (sqrt (* -2 (log (random 0 1))))
             (sin (* 2 pi (random 0 1)))
             sigma)))

  ;; float -> float
  (define (random-cauchy alpha)
    (let ((u (random 0 1)))
      (if (= u 0.5)
          (random-cauchy alpha)
          (* alpha (tan (* u pi))))))

  ;; float -> float -> float
  (define (random-beta a b)
    (let ((u1 (random 0 1)))
      (if (zero? u1)
          (random-beta a b)
          (let ((u2 (random 0 1)))
            (if (zero? u2)
                (random-beta a b)
                (let* ((y1 (expt u1 (/ 1 a)))
                       (y2 (expt u2 (/ 1 b)))
                       (sum (+ y1 y2)))
                  (if (> sum 1)
                      (random-beta a b)
                      (/ y1 sum))))))))

  ;; float -> float -> float
  (define (random-weibull s t)
    (let ((u (random 0 1)))
      (if (or (zero? u) (= u 1))
          (random-weibull s t)
          (let ((a (/ 1 (- 1 u))))
            (* s (expt (log a) (/ 1 t)))))))

  ;; float -> float
  (define (random-poisson l)
    (let loop ((v (exp (- l)))
               (u (random 0 1))
               (n 0))
      (if (>= u v)
          (loop v
                (* u (random 0 1))
                (+ n 1))
          n)))

  ;; ugen -> bool
  (define (unipolar? u)
    (if (mce? u)
        (all unipolar? (mce-channels u))
        (member (ugen-name u)
                (list "Dust"
                      "Impulse"
                      "LFPulse"
                      "TPulse"
                      "Trig1"))))

  ;; ugen -> ugen -> ugen -> ugen
  (define (range u l r)
    (if (unipolar? u)
        (lin-lin u 0 1 l r)
        (lin-lin u -1 1 l r)))

  ;; ugen -> ugen -> ugen -> ugen
  (define (exp-range u l r)
    (if (unipolar? u)
        (lin-exp u 0 1 l r)
        (lin-exp u -1 1 l r)))

  ;; port -> float -> [osc]
  (define (recv* fd t)
    (let loop ((r (list)))
      (let ((p (recv fd t)))
        (if p
            (loop (cons p r))
            (reverse r)))))

  ;; A score is a list of osc bundles. The timestamps are given in
  ;; seconds where zero is the start of the score. An OSC file is a
  ;; binary file format understood by the SC3 synthesis server, and
  ;; consists of a sequence of length prefixed OSC bundles.
  
  ;; [osc] -> bytevector
  (define (encode-score l)
    (flatten-bytevectors
     (map (lambda (b)
            (let ((v (flatten-bytevectors (encode-bundle-ntp b))))
              (list (encode-i32 (bytevector-length v)) v)))
          l)))

  (define au-magic 779316836)           ; (define au-magic #x2e736e64)
  
  (define au-unspecified 0)
  (define au-mulaw8 1)
  (define au-linear8 2)
  (define au-linear16 3)
  (define au-linear24 4)
  (define au-linear32 5)
  (define au-float 6)
  (define au-double 7)

  (define (au-size-of e)
    (cond ((= e au-unspecified) (error (quote au-size-of) "unspecified encoding"))
          ((= e au-mulaw8) 1)
          ((= e au-linear8) 1)
          ((= e au-linear16) 2)
          ((= e au-linear24) 3)
          ((= e au-linear32) 4)
          ((= e au-float) 4)
          ((= e au-double) 8)
          (else (error "au-size-of: illegal encoding"))))

  (define (au-mk-hdr nf enc sr nc)
    (let ((nb (* nf nc (au-size-of enc))))
      (concat-map encode-i32 (list au-magic 28 nb enc sr nc 0))))

  (define au-f32 (list au-float encode-f32))
  (define au-f64 (list au-double encode-f64))

  (define (write-snd-file e sr nc fn d)
    (let ((enc (car e))
          (encdr (cadr e))
          (nf (/ (length d) nc)))
      (with-output-to-file fn
        (lambda ()
          (for-each write (au-mk-hdr nf enc sr nc))
          (for-each write (concat-map encdr d))))))

  (define-record-type spec (fields minima maxima warp range ratio))

  (define (make-spec* minima maxima warp)
    (let ((w (if (symbol? warp)
                 (symbol->warp warp)
                 warp)))
      (make-spec minima maxima
                 (w minima maxima)
                 (- maxima minima)
                 (/ maxima minima))))

  (define (r:clip l r n)
    (if (> n r)
        r
        (if (< n l) l n)))

  (define (spec-map s value)
    ((spec-warp s) (quote map) (r:clip 0.0 1.0 value)))

  (define (spec-unmap s value)
    (r:clip 0.0 1.0 ((spec-warp s) (quote unmap) value)))

  (define (symbol->spec s)
    (case s
      ((unipolar) (make-spec 0.0 1.0 (quote linear)))
      ((bipolar pan) (make-spec -1.0 1.0 (quote linear)))
      ((freq frequency) (make-spec 20.0 20000.0 (quote linear)))
      ((phase) (make-spec 0.0 (* 2 pi) (quote linear)))
      (else (error (quote symbol->spec) "illegal value" s))))

  ;; Tree a -> Tree a
  ;;
  ;; (splice '(1 (2 3) 4 (5 (6 7))))
  ;;
  ;; (flatten '(1 (2 3) 4 (5 (6 7))))
  (define (splice l)
    (let ((f (lambda (a b)
               (if (list? a)
                   (append a b)
                   (cons a b)))))
      (foldr f nil l)))

  ;; A warp is a procedure of two arguments. The first is the <symbol>
  ;; direction of the warp, which should be either 'map' or 'unmap'.
  ;; The second is a <real> number. Warps map from the space [0,1] to a
  ;; user defined space [minima,maxima]. A warp generator takes the
  ;; arguments `minima' and `maxima', even if it then ignores these
  ;; values.

  ;; Returns true iff the <symbol> `s' is 'map'.
  
  (define (warp-fwd? s)
    (eq? s (quote map)))

  ;; A linear real value map.
  
  (define (warp-linear minima maxima)
    (let ((range (- maxima minima)))
      (lambda (direction value)
        (if (warp-fwd? direction)
            (+ (* value range) minima)
            (/ (- value minima) range)))))

  ;; A linear integer value map.
  
  (define (warp-linear-integer minima maxima)
    (let ((w (warp-linear minima maxima)))
      (lambda (direction value)
        (round (w direction value)))))

  ;; The minima and maxima must both be non zero and have the same sign.
  
  (define (warp-exponential minima maxima)
    (let ((ratio (/ maxima minima)))
      (lambda (direction value)
        (if (warp-fwd? direction)
            (* (expt ratio value) minima)
            (/ (log (/ value minima)) (log ratio))))))

  ;; Evaluates to a warp generator for warps with an exponetial curve
  ;; given by `curve'.
  
  (define (warp-make-warp-curve curve)
    (lambda (minima maxima)
      (let ((range (- maxima minima)))
        (if (< (abs curve) 0.001)
            (warp-linear minima range)
            (let* ((grow (exp curve))
                   (a (/ range (- 1.0 grow)))
                   (b (+ minima a)))
              (lambda (direction value)
                (if (warp-fwd? direction)
                    (- b (* a (expt grow value)))
                    (/ (log (/ (- b value) a)) curve))))))))

  (define (warp-cosine minima maxima)
    (let* ((range (- maxima minima)) (linear (warp-linear minima range)))
      (lambda (direction value)
        (if (warp-fwd? direction)
            (linear (quote map) (- 0.5 (* (cos (* pi value)) 0.5)))
            (/ (acos (- 1.0 (* (linear (quote unmap) value) 2))) pi)))))

  (define (warp-sine minima maxima)
    (let* ((range (- maxima minima))
           (linear (warp-linear minima range)))
      (lambda (direction value)
        (if (warp-fwd? direction)
            (linear (quote map)
                    (sin (* (/ pi 2) value)))
            (/ (asin (linear (quote unmap) value))
               (/ pi 2))))))

  ;; The minima and maxima values are ignored, they are implicitly zero
  ;; and one.
  
  (define (warp-fader minima maxima)
    (lambda (direction value)
      (if (warp-fwd? direction)
          (* value value)
          (sqrt value))))

  ;; The minima and maxima values are ignored, they are implicitly
  ;; negative infinity and zero. An input value of zero gives -180.
  
  (define (warp-db-fader minima maxima)
    (lambda (direction value)
      (if (warp-fwd? direction)
          (if (zero? value)
              -180
              (amp-db (* value value)))
          (sqrt (db-amp value)))))

  ;; Translate a symbolic warp name to a warp procedure.
  
  (define (symbol->warp s)
    (case s
      ((lin linear) warp-linear)
      ((exp exponential) warp-exponential)
      ((sin) warp-sine)
      ((cos) warp-cosine)
      ((amp) warp-fader)
      ((db) warp-db-fader)
      (else (error (quote symbol->warp) "unknown symbol" s))))

  ;; Translate a number to a warp.
  
  (define (number->warp n)
    (warp-make-warp-curve n))

  ;; int -> int -> [a] -> [[a]]
  (define (segment n k l)
    (let ((s (take n l)))
      (if (null? s)
          s
          (cons s (segment n k (drop k l))))))

  ;; A Signal is half the size of a Wavetable, each element is the sum
  ;; of two adjacent elements of the Wavetable.
  (define (wavetable->signal l)
    (concat-map sum (segment 2 2 l)))

  ;; A Wavetable is twice the size of a Signal. Each element 'e0'
  ;; expands to {2*e0-e1, e1-e0} where e1 is the next element.
  (define (signal->wavetable l)
    (let ((f (lambda (e0 e1)
               (list (- (* 2.0 e0) e1)
                     (- e1 e0)))))
      (concat-map f (segment 1 2 (append l (list1 (head l))))))))
