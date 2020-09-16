;; Emacs Init File
;; "It's dangerous to go alone. Take this!"
;;
;; Inspired by Emacs Prelude, ErgoEmacs, Emacs Rocks and others

(setq user-full-name (getenv "GIT_AUTHOR_NAME"))
(setq user-mail-address (getenv "GIT_AUTHOR_EMAIL"))

;; Not needed yet!
;;(message "%s" "Emacs is powering up. Please be patient, Master...")

;; Define paths
(defconst my/emacs-custom "~/.emacs-custom.el"
  "Emacs custom file. UI Settings are automatically stored here")
(defconst my/emacs-dir "~/.emacs.d/lisp"
  "Personal emacs dir")
;; (defconst my/emacs-custom-light "~/emacs/emacs-custom-light.el"
;;   "Custom theme, light background")
;; (defconst my/emacs-custom-dark "~/emacs/emacs-custom-dark.el"
;;   "Custom theme, dark background")



;;;; CUSTOM APPEARANCE ;;;;


;; Don't show the GNU splash screen
(setq inhibit-startup-message t)
;; Blank scratch buffer
(setq initial-scratch-message "")

;(defconst my/mono-font "M+ 1mn regular-14")
;;(defconst my/mono-font "Luculent-14")
;;(defconst my/mono-font "Consolas-15")
;;(defconst my/serif-font "FiraCode Light-14") ; with ligatures
;(defconst my/mono-font "Input Mono Narrow Light-14")
(defconst my/mono-font "JetBrains Mono-14:light")
;;(defconst my/serif-font "DejaVu Serif-14")
(defconst my/serif-font "Input Serif Narrow Light-14")

;; Set font as soon as possible to avoid flickering
;;(set-frame-font "-DEC-Terminal-Medium-R-Normal--14-140-75-75-C-80-ISO8859-1")
;;(set-frame-font "Bitstream Vera Sans Mono-11")
;;(set-frame-font "Inconsolata-16")
(condition-case ex
    (set-face-font 'default my/mono-font);(set-frame-font my/mono-font)
  (error (message (format "Cannot set font, reverting to default. %s" ex))))

;; Window size in characters, scrollbar position
(if (window-system)
    (cond
     ((> (display-pixel-width) 1480)
      (set-frame-size (selected-frame) 160 46)
      (set-frame-position (selected-frame) (/ (- (display-pixel-width) 1480) 2) 24)))
     (t
      (set-frame-parameter (selected-frame) 'fullscreen nil)))
;; or set fullscreen
;(toggle-frame-fullscreen) ;; without window decorations
;(toggle-frame-maximized)

(setq current-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-input-method "rfc1345")
(setq read-quoted-char-radix 16)
(setq case-fold-search t)
(setq text-mode-hook (quote (text-mode-hook-identify)))
(transient-mark-mode t)
;; Transparently open compressed files
(auto-compression-mode t)
;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)
;; Death to the tabs!
(setq-default indent-tabs-mode nil)
;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)
;; smart indenting and pairing
;;(electric-pair-mode t)
(if (>= emacs-major-version 24)
    (progn
      (electric-indent-mode t)
      (electric-layout-mode t)))
;; Break lines at spaces
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)
;; syntax highlighting
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
;; European locale for dates
(setq european-calendar-style t)
;; Show column number
(column-number-mode t)
;; show line number the cursor is on in mode line
(line-number-mode t)
;; display line numbers in margin (fringe)
(global-linum-mode t)
;; Lines should be 80 characters wide, not 72
(setq fill-column 80)
;; turn autoindenting on
(global-set-key "\r" 'newline-and-indent)
;; disable audio bell
(setq visible-bell t)
;; show file size
(size-indication-mode t)
;; No toolbar with buttons
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; Hide menu bar
;;(setq menubar-visible-p nil)
;;(setq default-toolbar-visible-p nil)
;; hide the scroll bar
;;(scroll-bar-mode nil)
;; Scrollbar to the right
(menu-bar-right-scroll-bar)
;; No blinking cursor
(blink-cursor-mode -1)
;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
;; turn on highlighting current line
(global-hl-line-mode t)
;; line spacing (integer: pixels, decimal: percentage of font size) nil is default (see function for toggle)
(setq-default line-spacing nil)
;; show-paren-mode: subtle highlighting of matching parens
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
;; auto-completion in minibuffer
(icomplete-mode t)
(set-default 'imenu-auto-rescan t)

;; Custom-set-variables are defined in the auto-generated .emacs-custom.el
(setq custom-file my/emacs-custom)
(load custom-file)

;; global font-lock customizations 
(font-lock-add-keywords
 nil '(
       ("\\<\\(TODO\\)\\>" 1 font-lock-warning-face prepend)
       ))

;; Options menu
;; add a menu for toggling the visibility of spaces and tabs
(define-key-after menu-bar-options-menu [whitespace-mode]
  '(menu-item "Show/Hide Space, Tab" whitespace-mode
    :button (:toggle . whitespace-mode)) 'line-move-visual )
;; add a menu to toggle whether down arrow key move cursor by visual line.
(define-key-after menu-bar-options-menu [line-move-visual]
  '(menu-item "Move through wrapped lines" toggle-line-move-visual
    :button (:toggle . line-move-visual)) 'line-wrapping)
;; add a menu to toggle whether left/right cursor movement will move into camelCaseWords
(define-key-after menu-bar-options-menu [global-subword-mode]
  '(menu-item "Move through camelCaseWord" global-subword-mode
              :button (:toggle . global-subword-mode)) 'line-move-visual)

;; Context menu (from ErgoEmacs)
;; Right-click opens the context menu
(global-set-key [mouse-3] 'my-context-menu)
(defvar edit-popup-menu
  '(keymap
    (undo menu-item "Undo" undo
          :enable (and
                   (not buffer-read-only)
                   (not
                    (eq t buffer-undo-list))
                   (if
                       (eq last-command 'undo)
                       (listp pending-undo-list)
                     (consp buffer-undo-list)))
          :help "Undo last operation"
          :keys "Ctrl+Z")
    (separator-undo menu-item "--")
    (cut menu-item "Cut" clipboard-kill-region
         :help "Delete text in region and copy it to the clipboard"
         :keys "Ctrl+X")
    (copy menu-item "Copy" clipboard-kill-ring-save
          :help "Copy text in region to the clipboard"
          :keys "Ctrl+C")
    (paste menu-item "Paste" clipboard-yank
           :help "Paste text from clipboard"
           :keys "Ctrl+V")
    (paste-from-menu menu-item "Paste from Kill Menu" yank-menu
                     :enable (and
                              (cdr yank-menu)
                              (not buffer-read-only))
                     :help "Choose a string from the kill ring and paste it")
    (clear menu-item "Clear" delete-region
           :enable (and mark-active (not buffer-read-only))
           :help "Delete the text in region between mark and current position"
           :keys "Del")
    (separator-select-all menu-item "--")
    (mark-whole-buffer menu-item "Select All" mark-whole-buffer
                       :help "Mark the whole buffer")
    (separator-select-all menu-item "--")
    (eye-style-switch menu-item "Toggle theme" eye-style-switch
                      :help "Toggle visual themes")
    (text-scale-increase menu-item "Increase text size" text-scale-increase
                         :help "Increase text size")
    (text-scale-decrease menu-item "Decrease text size" text-scale-decrease
                         :help "Decrease text size")))

(defun my-context-menu (event)
  "Pop up context menu."
  (interactive "e")
  (popup-menu edit-popup-menu))



;;;; MISC SETTINGS ;;;;


;; Windows-like selection (CUA mode)
(cua-mode 1)
(delete-selection-mode 1)
;; Use the clipboard (t by default in 24)
(setq x-select-enable-clipboard t)
;; Enabling these will also put a selection in the main clipboard, making it impossible to overwrite selected text with the clipboard contents
;; (setq x-select-enable-primary t
;;       save-interprogram-paste-before-kill t)
;; prefer newer file version
(setq load-prefer-newer t)

;; bookmarks
(setq bookmark-default-file (concat user-emacs-directory "emacs.bmk")
      bookmark-save-flag 1)

;; Backup
(setq make-backup-files t)
(setq
 backup-by-copying t
 backup-directory-alist `((".*" . , temporary-file-directory))
 auto-save-file-name-transforms `((".*" , temporary-file-directory t))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;; saveplace remembers your location in a file when saving files
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace"))
;; activate it for all buffers
(setq-default save-place t)

;; savehist keeps track of some history
(setq savehist-additional-variables
      ;; search entries
      '(search ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (concat user-emacs-directory "savehist"))
(savehist-mode t)

;; save recent files
(setq recentf-save-file (concat user-emacs-directory "recentf")
      recentf-max-saved-items 32
      recentf-max-menu-items 16)
(recentf-mode t)

;; interactive name completion for describe-function, describe-variable, etc.
(icomplete-mode 1)


;;;; KEYBOARD CONTROLS ;;;;


(define-key global-map [f2] 'find-file) ;; default: find-file
(define-key global-map [f3] 'write-file) ;; default: close buffer
(define-key global-map [f4] 'save-buffer) ;; default: goto-line 

(define-key global-map [f5] 'kill-this-buffer)
;;(define-key global-map [f6] 'other-window) ;; place cursor in other window
(define-key global-map [f6] (lambda nil (interactive) (jump-to-next-file))) ;; open next numbered file 
(define-key global-map [f7] (lambda () ;; single window
                              (interactive)
                              (delete-other-windows)
                              (follow-mode nil)))
(define-key global-map [f8] (lambda () ;; two pages side-by-side (add (follow-mode t) to scroll both)
                              (interactive)
                              (split-window-horizontally)))

;; highlight current word (More convenient that C-s C-w C-w C-w... Requires highlight-symbol.el)
(define-key global-map [f9] (lambda () (interactive) (idle-highlight-mode)))
(define-key global-map [f10] 'highlight-symbol-at-point)
(define-key global-map [f11] 'highlight-symbol-prev)
(define-key global-map [f12] 'highlight-symbol-next)

(global-set-key (kbd "C-z") 'undo) ;; Standard undo
(global-set-key (kbd "C-S-z") (lambda () (interactive)
                                (message "%s" "To redo after undo, C-g (or any other command) then undo again")))

(global-set-key (kbd "<C-prior>") 'previous-user-buffer) ;; Ctrl+PageUp - switch to previous user buffer
(global-set-key (kbd "<C-next>") 'next-user-buffer) ;; Ctrl+PageDown - switch to next user buffer
(global-set-key (kbd "<C-S-prior>") 'previous-emacs-buffer) ;; Ctrl+Shift+PageUp
(global-set-key (kbd "<C-S-next>") 'next-emacs-buffer) ;; Ctrl+Shift+PageDown

;; Some redundant Meta/Alt bindings for frequently used operations (we are not on a Space Cadet keyboard anymore)
(global-set-key "\M-f" 'find-file) ;; default: forward-word
;;(global-set-key "\M-s" 'save-buffer) ;; default: center-line
(global-set-key "\M-z" 'undo) ;; default: zap-to-char
;;(global-set-key "\M-x" 'cua-cut) ;; default: command (can use Menu Key instead)
;;(global-set-key "\M-c" 'cua-copy) ;; default: capitalize
;;(global-set-key "\M-v" 'cua-paste) ;; default: cua-repeat-replace-region

;; Unicode char insert
;; « and » are already mapped to AltGr-< and AltGr->
;; Or use "C-x 8 <" and "C-x 8 >" (view all commands with C-x C-h)
;;(global-set-key (kbd "C-M-l") "λ")
(global-set-key (kbd "M-2") "“") ;;(ucs-insert #x201C 1 t)
(global-set-key (kbd "M-\"") "”") ;;(ucs-insert #x201D 1 t)
(global-set-key (kbd "M-\-") "—") ;;(ucs-insert #x2019 1 t)
(global-set-key (kbd "M-\'") "‘") ;;(ucs-insert #x2018 1 t)
(global-set-key (kbd "M-\?") "’") ;;(ucs-insert #x2019 1 t)

;; Fix 'home' and 'end' keys (obsolete)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
;; Set Meta + P to next error
;;(global-set-key "\M-p" 'next-error)

;; Make control+pageup/down scroll the other buffer
;;(global-set-key [C-next] 'scroll-other-window)
;;(global-set-key [C-prior] 'scroll-other-window-down)

;; Activate the mouse wheel (obsolete)
;;(mouse-wheel-mode)
;;(global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 5)))
;;(global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 5)))
;;(global-set-key [S-mouse-4] '(lambda () (interactive) (scroll-down 1)))
;;(global-set-key [S-mouse-5] '(lambda () (interactive) (scroll-up 1)))
;;(global-set-key [C-mouse-5] '(lambda () (interactive) (scroll-up (/ (window-height) 2))))
;;(global-set-key [C-mouse-4] '(lambda () (interactive) (scroll-down (/ (window-height) 2))))

;; Change font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)
;;(global-set-key [C-wheel-up] 'text-scale-increase)
;;(global-set-key [C-wheel-down] 'text-scale-decrease)
;;(global-set-key [C-down-mouse-2] 'text-scale-normal-size)

;; Activate occur easily inside isearch (C-s, type something to search, C-o: opens an occur buffer with list of matches)
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp
                 isearch-string
               (regexp-quote isearch-string))))))

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "<C-tab>") 'hippie-expand)

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)



;;;; EXTERNAL PACKAGES ;;;;

;; emacs-lisp packages directory. Should not be .emacs.d
;; To see what your load-path is, run inside emacs: C-h v load-path
(add-to-list 'load-path my/emacs-dir)

;; load all elisp files in the emacs dir
;;(when (file-exists-p my/emacs-dir)
;;  (mapc 'load (directory-files my/emacs-dir nil "^[^#].*el$")))

; add MELPA to package archives (package-install)
; list with package-list-packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/")
             t)
;;(package-initialize)

;; Magit GIT mode
(require 'magit nil 'noerror)

(autoload 'idle-highlight-mode "idle-highlight-mode"
  "Highlight each occurrence of the word under the cursor" t)

(require 'highlight-symbol nil 'noerror)

(autoload 'rainbow-mode "rainbow-mode"
  "Minor mode to display colors represented as hex or html strings" t)

;; A custom www-mode
(require 'www-mode nil 'noerror)

(require 'undo-tree nil 'noerror)

(require 'yaml-mode nil 'noerror)
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; NXML mode
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode))
(push '("<\\?xml" . nxml-mode) magic-mode-alist)

(setq nxml-slash-auto-complete-flag t)
(setq nxml-child-indent 2)
(setq nxml-attribute-indent 2)
(setq nxml-auto-insert-xml-declaration-flag nil)
(setq nxml-bind-meta-tab-to-complete-flag t)

;; (X)HTML5 Schema for nxml-mode (https://github.com/hober/html5-el)
;; (when (file-exists-p (concat my/emacs-dir "/html5-el"))
;;   (add-to-list 'load-path (concat my/emacs-dir "/html5-el"))
;;   (eval-after-load "rng-loc"
;;     '(add-to-list 'rng-schema-locating-files (concat my/emacs-dir "/html5-el/schemas.xml")))
;;   (require 'whattf-dt))


;; Soft word wrapping in text modes (longlines-mode obsoleted by visual-line-mode)
;;(add-hook 'text-mode-hook 'visual-line-mode)
;(add-hook 'fundamental-mode-hook 'visual-line-mode)

;; goto-last-change
(autoload 'goto-last-change "goto-last-change"
  "Set point to the position of the last change." t)

;; CSV mode
(setq csv-separators (quote ("," ";")))

;; Markdown mode (need markdown bin package, config not needed if installed as package)
;;(autoload 'markdown-mode "markdown-mode"
;;  "Major mode for editing Markdown files" t)
;;(add-to-list 'auto-mode-alist '("\\.\\(md\\|markdown\\)$" . markdown-mode))

;; javascript js2 mode
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; ;; force my colors on js2
;; (setq js2-use-font-lock-faces t)
;; ;; javascript js mode
;; (add-hook 'js-mode-hook
;;           (lambda () (electric-layout-mode -1)))
;; ;; Indent 2 spaces in js
;; (setq js-indent-level 2)
;; ;; Make lambda functions appear as pretty lambda symbol
;; (font-lock-add-keywords
;;  'js-mode `(("\\(function\\) *("
;;              (0 (progn (compose-region (match-beginning 1)
;;                                        (match-end 1) "\u0192")
;;                        nil)))))

;; Require Tramp at startup (use with /username@host:remote_path (for default method) or /ftp:username@host:remote_path or /ssh:...)
;;(require 'tramp)
;;(setq tramp-default-method "scp")


;; Visual autocompletion when auto-complete is installed
;; (install apt package auto-complete-el)
;; (will show minor mode AC in buffer)
;; (require 'auto-complete-config nil 'noerror)
;; (condition-case ex
;;     (ac-config-default)
;;   (error (message "auto-complete-config not found.")))

;; hippie expand is more advanced than dabbrev expand
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))


;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; ido-mode (minibuffer autocompletion)
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-enable-prefix nil
;;       ido-enable-flex-matching t

;;       ido-create-new-buffer 'always
;;       ido-use-filename-at-point 'guess
;;       ido-max-prospects 10
;;       ido-default-file-method 'selected-window)

;; flyspell-mode does spell-checking on the fly as you type
;; (setq ispell-program-name "aspell" ; use aspell instead of ispell
;;       ispell-extra-args '("--sug-mode=ultra"))
;; (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

;; Groovy/gradle mode
;; (autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
;; (add-to-list 'auto-mode-alist '("\\.\\(groovy\\|gradle\\)$" . groovy-mode))

;; display search stats in modeline
;; (require 'anzu-mode nil 'noerror)
;; (condition-case ex
;;     (global-anzu-mode +1)
;;   (error (message "anzu-mode not found.")))


;;;; USEFUL FUNCTIONS ;;;;

(defun is-os-unix()
  "Returns t if the current operating system is linux"
  (string-match "linux" system-configuration))

;; Selects light or dark background theme
;; (defun switch-light-and-dark(&optional arg)
;;   "Changes color theme to dark background theme.
;; With a prefix arg, changes to light background theme."
;;   (interactive "P")
;;   (if arg
;;       (load my/emacs-custom-light)
;;     (load my/emacs-custom-dark)))

;; (defun theme-light()
;;   "Changes color theme to light background theme."
;;   (interactive)
;;   (load my/emacs-custom-light))

;; (defun theme-dark()
;;   "Changes color theme to dark background theme."
;;   (interactive)
;;   (load my/emacs-custom-dark))


(defun eye-rest-style ()
  "Use when your eyes are tired."
  (interactive)
  (setq-default line-spacing 0.5)
  (set-frame-parameter nil 'font my/serif-font)
  (redraw-frame (selected-frame))
  (big-fringe-mode 1)
  (message "Please rest your eyes..."))

(defun eye-code-style ()
  "Use when coding."
  (interactive)
  (setq-default line-spacing nil)
  (set-frame-parameter nil 'font my/mono-font)
  (redraw-frame (selected-frame))
  (big-fringe-mode 0)
  (message "Please code hard..."))

(defun eye-style-switch ()
  "Switch between an easy to read design and a code optimized design."
  (interactive)
  (let (current-state next-state)
    (setq current-state (if (get 'eye-style-switch 'state) (get 'eye-style-switch 'state) 0))  
    (if (eq current-state 0) (eye-rest-style) (eye-code-style))
    (if (eq current-state 0) (setq next-state 1) (setq next-state 0))
    (put 'eye-style-switch 'state next-state)))

;; Inspired by Emacs, Naked
(defvar big-fringe-mode nil)
(define-minor-mode big-fringe-mode
  "Minor mode to set a big fringe (lateral padding)."
  :init-value nil
  :global t
  :variable big-fringe-mode
  :group 'editing-basics
  (if (not big-fringe-mode)
      (set-fringe-style nil)
    (set-fringe-mode
     (/ (- (frame-pixel-width)
           (* 100 (frame-char-width)))
        2))))

(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary, in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t))


;; Inspired by Emacs Rocks talk
(defun jump-to-next-file ()
  "When the current file is named <N>-*, visit the next file (named <N+1>-*)"
  (interactive)

  (defun buffer-file-dir () (file-name-directory (buffer-file-name)))
  (defun buffer-file-name-body () (file-name-nondirectory (buffer-file-name)))
  (defun incs (s &optional num) (number-to-string (+ (or num 1) (string-to-number s))))
  
  (find-file
   (car
    (file-expand-wildcards
     (concat
      (buffer-file-dir)
      (incs (car (split-string (buffer-file-name-body) "-")))
      "-*")))))


(defun recompile-all ()
  "Byte-recompile all elisp files in the emacs dir"
  (byte-recompile-directory "~/.emacs.d" 0))


(defun unicode-chars (&optional start end)
  "Display a Unicode character range."
  (interactive "nstart: \nnend: ")
  (switch-to-buffer (get-buffer-create "*UNICODE*"))
  (erase-buffer)
  (let ( (i start) )
    (while (<= i end)
      (insert (format "%s: U+%04x, %s\n" (char-to-string i) i (get-char-code-property i 'name)))
      (setq i (1+ i)) )))


(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))


(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))


(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))


(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))


(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
installed to do this. The function inserts linebreaks to separate tags that have
nothing but whitespace between them. It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
      (backward-char) (insert "\n") (setq end (1+ end)))
    (indent-region begin end))
  (message "Ah, much better!"))


(defun xpath-show ()
  "Display the hierarchy of XML elements the point is on as a XPath description."
  (interactive)
  (let ((path nil))
    (save-excursion
      (save-restriction
	(widen)
	(while (condition-case nil
		   (progn
		     (nxml-backward-up-element) ; always returns nil
		     t)       
		 (error nil))
	  (setq path (cons (xmltok-start-tag-local-name) path)))
	(message "/%s" (mapconcat 'identity path "/"))))))


(defun region-length ()
  "Compute the length of the marked region"
  (interactive)
  (message (format "%d" (- (region-end) (region-beginning)))))


;; Obsoleted by count-words in 24
;; (defun wc ()
;;   "Count the words in the current buffer, show the result in the minibuffer"
;;   (interactive)
;;   (save-excursion
;;     (save-restriction
;;       (widen)
;;       (goto-char (point-min))
;;       (let ((count 0))
;; 	(while (forward-word 1)
;; 	  (setq count(1+ count)))
;; 	(message "There are %d words in the buffer" count)))))


(defun grep-dir ()
  "grep the whole directory for something, defaults to term at cursor position"
  (interactive)
  (setq default (thing-at-point 'symbol))
  (setq needle (or (read-string (concat "grep dir for (default: " default ") ")) default))
  (setq needle (if (equal needle "") default needle))
  (grep (concat "egrep -s -i -n -r " needle " * /dev/null")))
;;(global-set-key "\C-x." 'grep-dir)


(defun annotate-text (&optional s)
  "Put fringe marker on lines containing the specified text (es. 'TODO') in the current buffer."
  (interactive "MText to annotate: ")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward s nil t)
      (let ((overlay (make-overlay (- (point) 5) (point))))
        (overlay-put overlay
                     'before-string
                     (propertize (format "A")
                                 'display '(left-fringe right-triangle)))))))


;; convert dos (^M) end of line to unix end of line. -- Obsolete: use UI controls
;;(defun dos2unix()
;;  (interactive)
;;  (goto-char(point-min))
;;  (while (search-forward "\r" nil t) (replace-match "")))
;; convert unix end of line to dos end of line
;;(defun unix2dos()
;;  (interactive)
;;  (goto-char(point-min))
;;  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;; Add special shortcut parsing to the find-file command
;; (defun my-parse-minibuffer ()
;;   "Add special shortcut parsing to the find-file command, as extension to the complete-word facility of the minibuffer"
;;   (interactive)
;;   (backward-char 4)
;;   (setq found t)
;;   (cond
;;    ;; local directories
;;    ((looking-at "..cd") (setq directory "~/"))
;;    ((looking-at ".doc") (setq directory "~/doc"))
;;    (t (setq found nil)))
;;   (cond (found (beginning-of-line)
;; 	       (kill-line)
;; 	       (insert directory))
;; 	(t     (forward-char 4)
;; 	       (minibuffer-complete))))
;; ;; Register as extension to the minibuffer complete-word function
;; (define-key minibuffer-local-completion-map " " 'myparse-minibuffer)

;; Insert date into buffer
;;(defun insert-date ()
;;"Insert date at point."
;;(interactive)
;;(insert (format-time-string "%A, %B %e, %Y %k:%M:%S %z")))



;;;; ADDITIONAL MODES CUSTOMIZATION ;;;;

;; LaTeX
;; AUCTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; use pdflatex
(setq TeX-PDF-mode t)
;; (setq TeX-view-program-selection
;;       '((output-dvi "DVI Viewer")
;;         (output-pdf "PDF Viewer")
;;         (output-html "HTML Viewer")))
;; (setq TeX-view-program-list
;;       '(("DVI Viewer" "evince %o")
;;         ("PDF Viewer" "evince %o")
;;         ("HTML Viewer" "w3m %o")))


;; (defconst my-c-style
;;   '((c-tab-always-indent . t)
;;     (c-comment-only-line-offset . 4)
;;     (c-hanging-braces-alist . ((substatement-open after)
;; 			       (brace-list-open)))
;;     (c-hanging-colons-alist . ((member-init-intro before)
;; 			       (inher-intro)
;; 			       (case-label after)
;; 			       (label after)
;; 			       (access-label after)))
;;     (c-cleanup-list . (scope-operator
;; 		       empty-defun-braces
;; 		       defun-close-semi))
;;     (c-offsets-alist . ((arglist-close . c-lineup-arglist)
;; 			(substatement-open . 0)
;; 			(case-label . 4)
;; 			(block-open . 0)
;; 			(knr-argdecl-intro . -)))
;;     (c-echo-syntactic-information-p . t)
;;     )
;;   "My C Programming Style")

;; Python (python.el)
(require 'python)
(when (featurep 'python-mode) (unload-feature 'python-mode t))
;; Indent next line when pressing return (by default bound to C-j)
(add-hook 'python-mode-hook
          #'(lambda ()
              (define-key python-mode-map "\C-m" 'newline-and-indent)))
;; autocompletion with Jedi (install package python-jedi or python3-jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; (defun my-jedi-setup ()
;;   (jedi:setup)
;;   (setq jedi:server-command
;;         (list "python3" jedi:server-script)))
;; (add-hook 'python-mode-hook 'my-jedi-setup)

;; with auto-complete
;; (defvar ac-source-python
;;   '((candidates .
;; 		(lambda ()
;; 		  (mapcar '(lambda (completion)
;; 			     (first (last (split-string completion "\\." t))))
;; 			  (python-symbol-completions (python-partial-symbol)))))))
;; (add-hook 'python-mode-hook
;; 	  (lambda() (setq ac-sources '(ac-source-python))))
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python))
;; Python (python-mode.el)
;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (when (featurep 'python) (unload-feature 'python t))
;; ;; documentation with py-help-at-point
;; (add-hook 'python-mode-hook
;;           '(lambda () (eldoc-mode 1)) t)
;; ;; with auto-complete
;; (setq py-load-pymacs-p t)

;;;; START EMACS SERVER ;;;;
; To open files with this instance: emacsclient <file>
(unless (and (fboundp 'server-running-p)
             (server-running-p))
  (server-start))
