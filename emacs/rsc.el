;; emacs/rsc.el - (c) rohan drape, 2000-2006

;; This mode is implemented as a derivation of `scheme' mode,
;; indentation and font locking is courtesy that mode.  The
;; inter-process communication is courtesy `comint'.  The symbol at
;; point acquisition is courtesy `thingatpt'.  The display of
;; definitions in an info manual is courtesy `info'.  The directory
;; search facilities are courtesy `find-lisp'.

(require 'scheme)
(require 'comint)
(require 'thingatpt)
(require 'info)
(require 'find-lisp)


;; Common

(defun line-at-point ()
  "Return the line at point as a string."
  (let (beg end)
    (save-excursion
      (beginning-of-line)
      (setq beg (point))
      (end-of-line)
      (setq end (point)))
    (buffer-substring-no-properties beg end)))

(defun locate-plt-library (name)
  "Locate the directory for the PLT library `name'.
An error is raised if the directory cannot be located."
  (defun iter (prefixes)
    (if (null prefixes)
	(error "Cannot locate PLT library: %s" name)
      (let* ((dir (concat (car prefixes) "/" name))
	     (dir* (file-expand-wildcards dir)))
	(if dir*
	    (expand-file-name (car dir*))
	  (iter (cdr prefixes))))))
  (iter (list "/usr/local/plt/collects"
	      "/usr/plt/collects"
	      "/Applications/PLT Scheme*/collects"
	      "~/.plt-scheme/*/collects"
	      "~/Library/PLT Scheme*/*/collects")))

;; Open info documentation at `manual' and search the indices for
;; `query'.

(defun lookup-info-manual (manual query)
  (interactive "fManual: \nsQuery: ")
  (message "Looking up %s in the manual %s." query manual)
  (info-other-window manual)
  (Info-index query))


;; Scheme.

(defvar rsc-shared-directory
  (locate-plt-library "rsc")
  "*The location of the rsc directory.

This directory contains the rsc distribution.  This includes all
source and documentation files.  The initial value is found by
executing the procedure `locate-plt-library'.  This variable can
be set by the user to use a different set of library files.")

(defvar rsc-buffer
  "*rsc*"
  "*The name of the rsc scheme process buffer.")

(defvar rsc-interpreter
  (if (display-graphic-p) "mred" "mzscheme")
  "*The name of the PLT scheme interpreter to use.

The initial value is 'mred' if Emacs is operating under a
graphical display and 'mzscheme' otherwise.")

(defun rsc-see-output ()
  "Arrange so that the frame has two windows, the current buffer is
placed in the upper window and the `rsc-buffer' in the lower window."
  (interactive)
  (when (comint-check-proc rsc-buffer)
    (delete-other-windows)
    (split-window-vertically)
    (with-current-buffer rsc-buffer
      (let ((window (display-buffer (current-buffer))))
	(goto-char (point-max))
	(save-selected-window
	  (set-window-point window (point-max)))))))

(defun rsc-make-interpreter-command ()
  "Generate a command to start the rsc interpreter."
  (interactive)
  (let ((dot-rsc (concat (getenv "HOME") "/.rsc.scm"))
	(hack (if (equal rsc-interpreter "mred") "--stdio" "-A")))
    (if (file-exists-p dot-rsc)
	(list rsc-interpreter
	      hack
	      "-f"
	      dot-rsc)
      (list rsc-interpreter hack))))

(defun rsc-start-scheme ()
  "Start the rsc scheme process.

If `rsc-interpreter' is not already running as a subprocess it is
started and a new window is created to display the results of
evaluating rsc expressions.  Input and output is via `rsc-buffer'."
  (interactive)
  (if (comint-check-proc rsc-buffer)
      (error "An rsc scheme process is already running")
    (let ((command (rsc-make-interpreter-command)))
      (apply
       'make-comint
       "rsc"
       (car command)
       nil
       (cdr command))
      (rsc-see-output))))

(defun rsc-clear-schedule ()
  "Clear the schedule (Q)."
  (interactive)
  (rsc-evaluate-expression "(schedule-clear Q)"))

(defun rsc-quit-scheme ()
  "Quit scheme.

Quit the scheme interpreter and delete the associated buffer."
  (interactive)
  (kill-buffer rsc-buffer)
  (delete-other-windows))


;; Evaluate.

;; Collects the string containing the text from point back to the
;; start of the preceding expression.

(defun rsc-expression-before-point ()
  (buffer-substring-no-properties
   (save-excursion (backward-sexp) (point))
   (point)))

;; Send the string `expression' to the inferior rsc process for
;; evaluation.  If there is not an active sub-process one is started
;; and the text sent.  The message is terminated with a newline
;; character.

(defun rsc-evaluate-expression (expression)
  "Evaluate an arbitrary expression."
  (interactive "sString to evaluate: ")
  (if (not (comint-check-proc rsc-buffer))
      (rsc-start-scheme))
  (comint-send-string rsc-buffer expression)
  (comint-send-string rsc-buffer "\n"))

(defun rsc-evaluate ()
  "Evaluate the complete s-expression that precedes point."
  (interactive)
  (rsc-evaluate-expression (rsc-expression-before-point)))

(defun rsc-play ()
  "Rewrite and evaluate the s-expression that precedes point."
  (interactive)
  (rsc-evaluate-expression
   (concat "(play s " (rsc-expression-before-point) ")")))

(defun rsc-draw ()
  "Draw the UGen graph at point using draw*."
  (interactive)
  (rsc-evaluate-expression
   (concat "(draw* " (rsc-expression-before-point) ")")))


;; scsynth

(defun rsc-boot-scsynth ()
  "Start the current SCSYNTH server and establish a connection."
  (interactive)
  (rsc-evaluate-expression "(boot*)"))

(defun rsc-reset-scsynth ()
  "Free all nodes running at the current SCSYNTH server."
  (interactive)
  (rsc-evaluate-expression "(reset s)"))

(defun rsc-status-scsynth ()
  "Show status at server."
  (interactive)
  (rsc-evaluate-expression "(->< s /status)"))

(defun rsc-quit-scsynth ()
  "Shutdown the current SCSYNTH server."
  (interactive)
  (rsc-evaluate-expression "(->< s /quit)"))


;; Help

(defun rsc-cleanup-symbol (input)
  "Prepare the string `input' for further processing.

If the string `input' has a trailing '.ar' or '.kr' or '.ir' or
'.dr' or '.xr' or '.gr' drop it, this is required to locate UGen
helps files.  Else if it has a leading '/' drop it, this is
required to find the Server-Command help files.  Else return
`input'."
  (if (string-match ".*\\.[akidxg]r" input)
      (substring input 0 (- (length input) 3))
    (if (string-match "/.*" input)
	(substring input 1)
      input)))

(defun rsc-find-definition ()
  "Lookup up the symbol at point in the rsc TAGS file.  If the
search fails any trailing hyphenated words are dropped and the
search attempted again recursively until the base work is
searched for.  This finds a record definition when an accessor or
setter function is searched for."
  ;; If the string `input' has a trailing hyphenated word drop it,
  ;; else raise an error.
  (defun drop-trailing-hyphenated-word (input)
    (let ((index (string-match "-[^-]*$" input)))
      (if index
	  (substring input 0 index)
	(error "No trailing hyphenated word, search terminated"))))
  ;; Recursive finder.
  (defun find-it (s)
    (condition-case nil
	(find-tag s)
      (error (find-it (drop-trailing-hyphenated-word s)))))
  (interactive)
  (setq tags-file-name (concat rsc-shared-directory "/scheme/TAGS"))
  (find-it (thing-at-point 'symbol)))

(defun rsc-help ()
  "Lookup up the symbol at point in the set of Help files
distributed with rsc.

The symbol at point is preprocessed by `rsc-cleanup-symbol'."
  (interactive)
  (mapc (lambda (filename)
	  (find-file-other-window filename))
	(find-lisp-find-files (concat rsc-shared-directory "/help")
			      (concat "^"
				      (rsc-cleanup-symbol
				       (thing-at-point 'symbol))
				      "\\.help\\.scm"))))


;; Mode

(defvar rsc-mode-map nil
  "Keymap for rsc mode.")

(defun rsc-mode-keybindings (map)
  "Install rsc keybindings into `map'."
  ;; Scheme
  (define-key map "\C-c\C-s" 'rsc-start-scheme)
  (define-key map "\C-c\C-g" 'rsc-see-output)
  (define-key map "\C-c\C-q" 'rsc-clear-schedule)
  (define-key map "\C-c\C-x" 'rsc-quit-scheme)
  ;; scsynth
  (define-key map "\C-c\C-o" 'rsc-quit-scsynth)
  (define-key map "\C-c\C-k" 'rsc-reset-scsynth)
  (define-key map "\C-c\C-w" 'rsc-status-scsynth)
  (define-key map "\C-c\C-b" 'rsc-boot-scsynth)
  ;; Expression.
  (define-key map "\C-c\C-e" 'rsc-evaluate)
  (define-key map "\C-c\C-p" 'rsc-play)
  (define-key map "\C-c\C-d" 'rsc-draw)
  ;; Help.
  (define-key map "\C-c\C-h" 'rsc-help)
  (define-key map "\C-c\C-c" 'rsc-find-definition))

(defun rsc-mode-menu (map)
  "Install rsc menu into `map'."

  ;; rsc
  (define-key map [menu-bar rsc]
    (cons "Rsc" (make-sparse-keymap "Rsc")))

  ;; Help
  (define-key map [menu-bar rsc help]
    (cons "Help" (make-sparse-keymap "Help")))
  (define-key map [menu-bar rsc help rsc]
    '("Rsc help" . rsc-help))
  (define-key map [menu-bar rsc help source]
    '("Find definition" . rsc-find-definition))

  ;; Expression
  (define-key map [menu-bar rsc expression]
    (cons "Expression" (make-sparse-keymap "Expression")))
  (define-key map [menu-bar rsc expression draw]
    '("Draw" . rsc-draw))
  (define-key map [menu-bar rsc expression play]
    '("Play" . rsc-play))
  (define-key map [menu-bar rsc expression evaluate]
    '("Evaluate" . rsc-evaluate))

  ;; Scsynth
  (define-key map [menu-bar rsc scsynth]
    (cons "SCSynth" (make-sparse-keymap "SCSynth")))
  (define-key map [menu-bar rsc scsynth quit]
    '("Quit scsynth" . rsc-quit-scsynth))
  (define-key map [menu-bar rsc scsynth status]
    '("Display status" . rsc-status-scsynth))
  (define-key map [menu-bar rsc scsynth reset]
    '("Reset scsynth" . rsc-reset-scsynth))
  (define-key map [menu-bar rsc scsynth start]
    '("Boot scsynth" . rsc-boot-scsynth))

  ;; Scheme
  (define-key map [menu-bar rsc scheme]
    (cons "Scheme" (make-sparse-keymap "Scheme")))
  (define-key map [menu-bar rsc scheme quit-scheme]
    '("Quit scheme" . rsc-quit-scheme))
  (define-key map [menu-bar rsc scheme clear-schedule]
    '("Clear schedule (Q)" . rsc-clear-schedule))
  (define-key map [menu-bar rsc scheme see-output]
    '("See scheme output" . rsc-see-output))
  (define-key map [menu-bar rsc scheme start-scheme]
    '("Start scheme" . rsc-start-scheme)))

;; If there is no exitsing map create one and install the keybindings
;; and menu.
(if rsc-mode-map
    ()
  (let ((map (make-sparse-keymap "rsc")))
    (rsc-mode-keybindings map)
    (rsc-mode-menu map)
    (setq rsc-mode-map map)))

(defun rsc-font-lock-special-forms ()
  "Rules to font lock special forms."
  (interactive)
  (font-lock-add-keywords
   'rsc-mode
   (list
    (list (concat "(\\(define[-a-zA-Z/\*]*\\)\\>"
		  "[ \t]*(?"
		  "\\(\\sw+\\)?")
	  '(1 font-lock-keyword-face)
	  '(2 (cond ((match-beginning 1) font-lock-function-name-face)
		    ((match-beginning 3) font-lock-variable-name-face)
		    (t font-lock-warning-face))
	      nil t))
    (cons "\\<[akid]r\\>" font-lock-builtin-face)
    (cons "\\<[KID]R\\>" font-lock-builtin-face)
    (cons "\\<[A-Z][-\\*_a-zA-Z0-9]*\\>" font-lock-type-face)
    (cons "\\<[a-z0-9]*U\\>" font-lock-type-face)
    (cons "\\<\\sw+H\\>" font-lock-keyword-face)
    (cons "\\<\\sw+!\\>" font-lock-warning-face)
    (cons "\\<r[0-9]+\\>" font-lock-warning-face)
    (cons "\\<\\sw+:\\>" font-lock-builtin-face))))



(define-derived-mode
  rsc-mode
  scheme-mode
  "rsc-mode"
  "Major mode for interacting with an inferior rsc process.
Derived from `scheme-mode' and requiring `comint-mode' mode.

The following keys are bound:
\\{rsc-mode-map}

Customisation: Entry to this mode runs the hooks on `scheme-mode-hook'
and `rsc-mode-hook' (in that order).
"
  ;; Set up font locking.  This duplicates what scheme.el does, but
  ;; set case-fold to nil instead of t.  This is required for the math
  ;; UGen names, which include Not and Abs.
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
	'((scheme-font-lock-keywords
	   scheme-font-lock-keywords-1 scheme-font-lock-keywords-2)
	  nil nil (("+-*/.<>=!?$%_&~^:" . "w")) beginning-of-defun
	  (font-lock-mark-block-function . mark-defun)))
  (put 'letc 'scheme-indent-function 'scheme-let-indent)
  (put 'letL* 'scheme-indent-function 'scheme-let-indent)
  (put 'lambdaH 'scheme-indent-function 1)
  (rsc-font-lock-special-forms)
  (setq-default font-lock-keywords-case-fold-search nil))

;; Declare this mode to emacs.

(add-to-list 'auto-mode-alist '("\\.scm$" . rsc-mode))
(add-to-list 'interpreter-mode-alist '("rsc" . rsc-mode))

(provide 'rsc)
