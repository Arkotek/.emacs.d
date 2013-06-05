
;;
;; Configured by Strzelewicz Alexandre 
;; https://github.com/Alexandre-Strzelewicz/.emacs.d
;;



;; ;; Require Emacs' package functionality
;; (require 'package)
;; ;; Add the Melpa repository to the list of package sources
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; ;; Initialise the package system.
;; (package-initialize)
;; (require 'graphene)


(load-library "paren")
(show-paren-mode 1)
;;
;; DISABLE BACKUP FILES
;;
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(global-font-lock-mode t)
(setq-default indicate-empty-lines t)
(transient-mark-mode t)
(column-number-mode t)
(setq standard-indent 2)
(setq-default indent-tabs-mode nil)
(global-set-key "\M- " 'hippie-expand)

;;
;; COLORS
;;
(set-cursor-color "Red")
(set-face-background 'region "Red")
(set-face-background 'show-paren-match-face "Blue")
(set-face-background 'show-paren-mismatch-face "Magenta")
(set-face-foreground 'show-paren-mismatch-face "Red")
(set-face-foreground 'highlight "yellow")
;;
;; MISC
;;
(setq inhibit-startup-message t)
(setq frame-title-format "%S: %f")
(modify-frame-parameters nil '((wait-for-wm . nil)))
(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode 1)
(setq column-number-mode t)
(setq display-time-string-forms '((format "[%s:%s]-[%s/%s/%s] " 24-hours minutes day month year)))
(setq scroll-preserve-screen-position t)
(add-hook 'save-buffer-hook 'delete-trailing-whitespace)

;; 
;; SHORTCUTS
;;
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c v") 'uncomment-region)
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

;;
;; Fly between window
;;
(windmove-default-keybindings 'meta)

;;
;; Default message
;;
(setq initial-scratch-message "Unitech.io customized emacs.")

;;
;; IDO
;;
(setq ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-everywhere t)
(ido-mode 1)

(add-to-list 'load-path "~/.emacs.d/")

;;
;; shell-toggle-cd
;;
(autoload 'shell-toggle-cd "~/.emacs.d/shell-toggle.el"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)

;;
;; Python mod
;;
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
    (setq interpreter-mode-alist (cons '("python" . python-mode)
                                       interpreter-mode-alist))
    (autoload 'python-mode "python-mode" "Python editing mode." )

;;
;; AUTO tab
;;
(add-hook 'css-mode-hook '(lambda ()
			    (local-set-key (kbd "RET") 'newline-and-indent)
			    (rainbow-mode t)
			    ))
(add-hook 'html-mode-hook '(lambda ()
			     (local-set-key (kbd "RET") 'newline-and-indent)
			     ))


;;
;; JS2MOD
;;

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook '(lambda ()
			    (local-set-key (kbd "RET") 'newline-and-indent)
			    (rainbow-mode t)
			    ))

(eval-after-load "js2-mode"
  '(progn
     (setq js2-missing-semi-one-line-override t)
     (setq-default js2-basic-offset 2)
     ;; add from jslint global variable declarations to js2-mode globals list
     ;; modified from one in http://www.emacswiki.org/emacs/Js2Mode
     (defun my-add-jslint-declarations ()
       (when (> (buffer-size) 0)
         (let ((btext (replace-regexp-in-string
                       (rx ":" (* " ") "true") " "
                       (replace-regexp-in-string
                        (rx (+ (char "\n\t\r "))) " "
                        ;; only scans first 1000 characters
                        (save-restriction (widen) (buffer-substring-no-properties (point-min) (min (1+ 1000) (point-max)))) t t))))
           (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                 (split-string
                  (if (string-match (rx "/*" (* " ") "global" (* " ") (group (*? nonl)) (* " ") "*/") btext)
                      (match-string-no-properties 1 btext) "")
                  (rx (* " ") "," (* " ")) t))
           )))
     (add-hook 'js2-post-parse-callbacks 'my-add-jslint-declarations)))


(setq js2-use-font-lock-faces t)



;;
;; Rinari
;;
(add-to-list 'load-path "~/.emacs.d/rinari")
(require 'rinari)

;;
;; ERB & co
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rhtml-minor-mode"))
(require 'rhtml-mode)

;;
;; YAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/yaml-mode"))
(require 'yaml-mode)

;;
;; HAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/haml-mode"))
(require 'haml-mode)

;;
;; SASS
;;
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

;;
;; MARKDOWN
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/markdown-mode"))
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;;
;; Coffeescript
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/coffee-mode"))
(require 'coffee-mode)

;;
;; Resize window
;;
(global-set-key (kbd "<f5>") 'shrink-window-horizontally)
(global-set-key (kbd "<f6>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f7>") 'shrink-window)
(global-set-key (kbd "<f8>") 'enlarge-window)

;;
;; Remove menu bar
;;
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;
;; Highlight the current line
;;
(require 'highlight-current-line)
(highlight-current-line-on t)
;; To customize the background color
(set-face-background 'highlight-current-line-face "#010101")


;;
;; Special Speedbar
;;
(require 'sr-speedbar)

(setq speedbar-hide-button-brackets-flag t
      speedbar-show-unknown-files t
      speedbar-smart-directory-expand-flag t
      speedbar-use-images nil
      speedbar-indentation-width 2
      speedbar-update-flag t
      sr-speedbar-width 35
      sr-speedbar-width-x 35
      sr-speedbar-auto-refresh nil
      sr-speedbar-skip-other-window-p t
      sr-speedbar-right-side nil)

(global-set-key (kbd "C-c p") 'sr-speedbar-toggle)


;; Always use the last selected window for loading files from speedbar.
(defvar last-selected-window (selected-window))
(defadvice select-window (after remember-selected-window activate)
  "Remember the last selected window."
  (unless (eq (selected-window) sr-speedbar-window)
    (setq last-selected-window (selected-window))))

(defun sr-speedbar-before-visiting-file-hook ()
  "Function that hooks `speedbar-before-visiting-file-hook'."
  (select-window last-selected-window))

(defun sr-speedbar-before-visiting-tag-hook ()
  "Function that hooks `speedbar-before-visiting-tag-hook'."
  (select-window last-selected-window))

(defun sr-speedbar-visiting-file-hook ()
  "Function that hooks `speedbar-visiting-file-hook'."
  (select-window last-selected-window))

(defun sr-speedbar-visiting-tag-hook ()
  "Function that hooks `speedbar-visiting-tag-hook'."
  (select-window last-selected-window))


;;
;; Smart paste (auto indent paste)
;;
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     js2-mode css-mode
						     html-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))





;; (add-to-list 'load-path "~/.emacs.d/popup-0.5")
;; (add-to-list 'load-path "~/.emacs.d/ac")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac/ac-dict")
;; (global-auto-complete-mode t)
;; (setq ac-auto-start 2)
;; (setq ac-ignore-case nil)

;;
;; Autocomplete mode
;; ;;
;; (add-to-list 'load-path "~/.emacs.d/auto-complete-1.4")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

;; (setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
;; (global-auto-complete-mode t)
;; ; Start auto-completion after 2 characters of a word
;; (setq ac-auto-start 2)
;; ; case sensitivity is important when finding matches
;; (setq ac-ignore-case nil)

;;
;; Yasnippet
;;
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)

;;
;; Emacs core fix
;;
(custom-set-variables
 '(max-lisp-eval-depth 5000)
 '(max-specpdl-size 50000))

;;
;; Jade mode
;;
(add-to-list 'load-path "~/.emacs.d/jade-mode")
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;
;; Test function
;;
(defun doodlebug ()
 "Nonce function"
 (interactive)
 (message "Howdie-doodie fella"))
(global-set-key [f5] 'doodlebug)

;;
;; Align C-c a
;;
(defun my-align-single-equals ()
  "Align on a single equals sign (with a space either side)."
  (interactive)
  (align-regexp
   (region-beginning) (region-end)
   "\\(\\s-*\\) = " 1 0 nil))

(global-set-key (kbd "C-c a") 'my-align-single-equals)




















;;(require 'nodejs-repl)

;; (add-to-list 'load-path "~/.emacs.d/lintnode")
;; (require 'flymake-jslint)
;; ;; Make sure we can find the lintnode executable
;; (setq lintnode-location "~/.emacs.d/lintnode")
;; ;; JSLint can be... opinionated
;; (setq lintnode-jslint-excludes (list 'nomen 'undef 'plusplus 'onevar 'white))
;; ;; Start the server when we first open a js file and start checking
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (lintnode-hook)))


;;
;; el-get
;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;;
;; js-commint
;;

(require 'js-comint) 
(setq inferior-js-program-command "node") ;; not "node-repl"
;; Use your favorited js mode here:
(add-hook 'js2-mode-hook '(lambda () 
                            (local-set-key "\C-x\C-e" 
                                           'js-send-last-sexp)
                            (local-set-key "\C-\M-x" 
                                           'js-send-last-sexp-and-go)
                            (local-set-key "\C-cb" 
                                           'js-send-buffer)
                            (local-set-key "\C-c\C-b" 
                                           'js-send-buffer-and-go)
                            (local-set-key "\C-cl" 
                                'js-load-file-and-go)
                            ))

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output)))))

(setenv "NODE_NO_READLINE" "1")

;;
;; Agressive JS3 Mode
;;
(require 'js3-mode)
(custom-set-variables
 '(js3-auto-indent-p t)         ; it's nice for commas to right themselves.
 '(js3-enter-indents-newline t) ; don't need to push tab before typing
 '(js3-indent-on-enter-key t)
 '(js3-indent-dots t)
)
 
(require 'flymake-cursor)

