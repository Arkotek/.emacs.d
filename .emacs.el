
;;
;; Configured by Strzelewicz Alexandre
;; https://github.com/Unitech/.emacs.d
;;

(add-to-list 'custom-theme-load-path
 (expand-file-name "~/.emacs.d/themes/"))

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

;; (split-window-horizontally)
;; (save-selected-window
;;   (other-window 1)
;;   (switch-to-buffer nil))

;; Require Emacs' package functionality
(require 'package)
;; Add the Melpa repository to the list of package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; Initialise the package system.
(package-initialize)

;; (require 'graphene)


(load-library "paren")
(show-paren-mode 1)
;;
;; DISABLE BACKUP FILES
;;
(setq make-backup-files nil)
(setq backup-directory-alist `(("." . "~/.saves")))

(setq delete-auto-save-files t)
(global-font-lock-mode t)
(setq-default indicate-empty-lines t)
(transient-mark-mode t)
(column-number-mode t)
(setq standard-indent 2)
(setq-default indent-tabs-mode nil)
(global-set-key "\M- " 'hippie-expand)

;;(set-language-environment "UTF-8")


;;
;; COLORS
;;
(set-cursor-color "Red")
(set-face-background 'region "#26d840")
(set-face-background 'show-paren-match-face "Blue")
(set-face-background 'show-paren-mismatch-face "Magenta")
(set-face-foreground 'show-paren-mismatch-face "Red")


;;
;; MISC
;;
(setq inhibit-startup-message t)
(setq require-final-newline t)
(setq frame-title-format "%S: %f")
(modify-frame-parameters nil '((wait-for-wm . nil)))
(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode 1)
(setq column-number-mode t)
(setq display-time-string-forms '((format "[%s:%s]-[%s/%s/%s] " 24-hours minutes day month year)))
(setq scroll-preserve-screen-position t)
(add-hook 'save-buffer-hook 'delete-trailing-whitespace)


;;
;; Better color for mini-buffer
;;
(set-face-foreground 'minibuffer-prompt "#33FFFF")


;;
;; Nicer file
;;
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; (add-to-list 'load-path "~/.emacs.d/autopair")
;; (require 'autopair)
;; (autopair-global-mode)

;;
;; Smarter emacs
;;

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single
line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))


;;
;; SHORTCUTS
;;

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c v") 'toggle-comment-on-line)
(global-set-key (kbd "C-c C-c") 'comment-box)

(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

;;
;; Fly between window
;;
(windmove-default-keybindings 'meta)

;;
;; Default message
;;
(setq initial-scratch-message "⌬ keymetrics.io pimped emacs")

;;
;; IDO
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-mode
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido)
(ido-mode 'both) ;; for buffers and files
(setq
 ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
 ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
   "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
 ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
 ido-case-fold  t                 ; be case-insensitive
 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-directory-list 30   ; should be enough
 ido-max-work-file-list      50   ; remember many
 ido-use-filename-at-point nil    ; don't use filename at point (annoying)
 ido-use-url-at-point nil         ; don't use url at point (annoying)
 ido-enable-flex-matching nil     ; don't try to be too smart
 ido-max-prospects 8              ; don't spam my minibuffer
 ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;; increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook
          (function
           (lambda ()
             (make-local-variable 'resize-minibuffer-window-max-height)
             (setq resize-minibuffer-window-max-height 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(add-to-list 'load-path "~/.emacs.d/")
;;
;; nginxmode
;;
;;(require 'nginx-mode)

;;
;; Org mode
;;
;; (require 'org)
;; (setq org-log-done t)
;; (setq org-todo-keywords
;;       '((sequence "TODO" "INPROGRESS" "DONE")))
;; (setq org-todo-keyword-faces
;;       '(("INPROGRESS" . (:foreground "blue" :weight bold))))


;;
;; shell-toggle-cd
;;
(autoload 'shell-toggle-cd "~/.emacs.d/shell-toggle.el"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)

;;
;; Python mod
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/python-mode"))
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
                            ))
(add-hook 'html-mode-hook '(lambda ()
                             (local-set-key (kbd "RET") 'newline-and-indent)
                             ))


;;
;; Binding
;;

(add-to-list 'load-path "~/.emacs.d/js2-mode")

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.ejs$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json5$" . js2-mode))

(setq js2-strict-missing-semi-warning nil)

(add-hook 'js2-mode-hook '(lambda ()
                            (local-set-key (kbd "RET") 'newline-and-indent)
                            ))
;;
;; Autopair mode for javascript (js2-mode)
;;
;; (eval-after-load "autopair-autoloads"
;;   '(progn
;;      (require 'autopair)))
;; (eval-after-load "autopair"
;;   '(progn
;;      (autopair-global-mode 1)
;;      (setq my-autopair-off-modes '(
;;                                    ;; js2-mode
;;                                    ))
;;      (dolist (m my-autopair-off-modes)
;;        (add-hook (intern (concat (symbol-name m) "-hook"))
;;                  #'(lambda () (setq autopair-dont-activate t))))
;;      ))
;; (eval-after-load "js2-mode"
;;   '(progn
;;      (if (and (boundp 'my-autopair-off-modes)
;;               (not (memq 'js2-mode my-autopair-off-modes)))
;;          (setq js2-mirror-mode nil))
;;      ))


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
;; (add-to-list 'load-path "~/.emacs.d/rinari")
;; (require 'rinari)

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
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;
;; HAML
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/haml-mode"))
(require 'haml-mode)

;;
;; HBS
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/web-mode"))
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))


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
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;;
;; Typescript
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/typescript"))
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(setq typescript-indent-level 2)

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
;;(global-hl-line-mode)
;;(set-face-background hl-line-face "#0000ee")
;; (require 'highlight-current-line)
;; (highlight-current-line-on t)
;; To customize the background color
;;(set-face-background 'highlight-current-line-face "#010101")


;;
;; Special Speedbar
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/sr-speedbar"))
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


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;
;; Autocomplete mode
;;
;; (add-to-list 'load-path "~/.emacs.d/popup-0.5")
;; (add-to-list 'load-path "~/.emacs.d/ac")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac/ac-dict")
;; (global-auto-complete-mode t)
;; (setq ac-auto-start 2)
;; (setq ac-ignore-case nil)
;; (add-to-list 'load-path "~/.emacs.d/auto-complete-1.4")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
;; (global-auto-complete-mode t)
;;                                         ; Start auto-completion after 2 characters of a word
;; (setq ac-auto-start 2)
;;                                         ; case sensitivity is important when finding matches
;; (setq ac-ignore-case nil)


;;
;; Yasnippet
;;

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs "~/.emacs.d/yas/")
(yas-global-mode 1)

;;
;; Emacs core fix
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("5008a5c8985fda9803ff9d02bc2a56b45407ccc251ff85a817e9dfe7f345ffe5" default)))
 '(max-lisp-eval-depth 5000)
 '(max-specpdl-size 50000))

;;
;; Jade mode
;;
(add-to-list 'load-path "~/.emacs.d/jade-mode-2")
(add-to-list 'load-path "~/.emacs.d/sws-mode")
(add-to-list 'load-path "~/.emacs.d/stylus-mode")
(require 'sws-mode)
(require 'jade-mode)
(require 'stylus-mode)

(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;
;; Test function
;;
;; (defun doodlebug ()
;;  "Nonce function"
;;  (interactive)
;;  (message "Howdie-doodie fella"))
;; (global-set-key [f5] 'doodlebug)

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
;; (require 'js3-mode)
;; (custom-set-variables
;;  '(js3-auto-indent-p t)         ; it's nice for commas to right themselves.
;;  '(js3-enter-indents-newline t) ; don't need to push tab before typing
;;  '(js3-indent-on-enter-key t)
;;  '(js3-indent-dots t)
;;  )

(add-to-list 'load-path "~/.emacs.d/flymake-cursor")
(require 'flymake-cursor)

(add-to-list 'load-path "~/.emacs.d/php-mode")

(require 'php-mode)

;;
;; Alias
;;
(defalias 'pipe 'shell-command-on-region)


(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

(setq-default tab-width 2)
;;
;; Automatic indentation (tab or space) depending on user source code
;;
;; (require 'dtrt-indent)
;; (dtrt-indent-mode 1)

;;
;; Automatic byt compile
;;
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun terminal-init-screen ()
  "Terminal initialization function for screen."
   ;; Use the xterm color initialization code.
   (xterm-register-default-colors)
   (tty-set-up-initial-frame-faces))

(setq frame-background-mode 'dark)
