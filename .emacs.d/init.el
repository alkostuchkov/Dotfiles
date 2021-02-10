(setq default-frame-alist '((width . 90) (height . 28) (top . 40) (left . 170)))
;; start package.el with emacs
(require 'package)
;; add MELPA to repository list
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; initialize package.el
(package-initialize)

;; start auto-complete with emacs
(require 'auto-complete)
;; (use-package auto-complete
;;   :ensure t)

;; do defualt config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
;; (use-package auto-complete-config
;;   :init
;;   (ac-config-default))

(require 'kivy-mode)
(add-to-list 'auto-mode-alist '("\\.kv$" . kivy-mode))
;;
;; This mode does not enable electric-indent by default. To get this
;; behavior, either enable electric-indent-mode globally or enable it only
;; for kivy buffers using `kivy-mode-hook':
(add-hook 'kivy-mode-hook
		  '(lambda ()
			 (electric-indent-local-mode t)))


;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
;; (use-package yasnippet
;;   :ensure t
;;   :init
;;   (yas-global-mode 1))

;; ace-window
(require 'ace-window)
;; (use-package ace-window
;;   :ensure t)

;; no backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files

;; built-in
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
;; (use-package ido
;;   :ensure t
;;   :init
;;   (ido-mode t)
;;   (setq ido-enable-flex-matching t))

;; built-in (also show scratch in buffers)
(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))
;; (use-package bs
;;   :ensure t
;;   :init
;;   (setq bs-configurations
;; 	'(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last))))

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;; (set-language-environment 'Cyrillic-KOI8)
;; (set-terminal-coding-system 'koi8-r)
;; (set-keyboard-coding-system 'koi8-r)
;; (setq default-buffer-file-coding-system 'koi8-r)
;; (prefer-coding-system 'koi8-r)
;; (define-coding-system-alias 'koi8-u 'koi8-r)
;; (put-charset-property 'cyrillic-iso8859-5 'preferred-coding-system 'koi8-r)
;; ;(codepage-setup 1251)
;; (define-coding-system-alias 'windows-1251 'cp1251)
;; (set-input-mode nil nil 'We-will-use-eighth-bit-of-input-byte)
;; (setq-default coding-system-for-read 'koi8-r)
;; (set-selection-coding-system 'koi8-r)

;; carrying over strings like in Unix
(setq default-buffer-file-coding-system 'utf-8-unix)

;; set a default font
;; my favourite fonts
;; InconsolataCyr : Terminus (TTF) : Anonymous Pro : PT Mono : Fira Code : Monaco
;; (when (member "Fira Code" (font-family-list))
;;   (set-face-attribute 'default nil :font "Fira Code-14"))
(when (member "Monaco" (font-family-list))
  (set-face-attribute 'default nil :font "Monaco-14"))

;; my favourite themes
(require 'color-theme)
(color-theme-initialize)
;;;(color-theme-robin-hood)
;; (use-package color-theme
;;   :ensure t
;;   :init
;;   (color-theme-initialize)
;;   (color-theme-robin-hood))
;(color-theme-select) M-x color-theme-select

;(load-theme 'monokai t)
;(load-theme 'wombat)
;(load-theme 'tsdh-dark)
;(load-theme 'manoj-dark)
;(load-theme 'tango-dark)
;(load-theme 'misterioso)

;; (use-package darcula-theme
;;   :ensure t
;;   :config)
(require 'darcula-theme)
(setq color-theme 'darcula-theme)

(add-to-list 'default-frame-alist '(cursor-color . "#ffa500"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-window-display-mode t)
 '(auto-save-default t)
 '(blink-cursor-mode t)
 '(case-fold-search nil)
 '(cursor-type (quote bar))
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(linum-format (quote dynamic))
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
	(("melpa" . "http://melpa.milkbox.net/packages/")
	 ("gnu" . "http://elpa.gnu.org/packages/")
	 ("elpy" . "http://jorgenschaefer.github.io/packages/"))))
 '(package-selected-packages
   (quote
	(yasnippet sr-speedbar solarized-theme monokai-theme iedit color-theme auto-complete-c-headers)))
 '(scroll-bar-mode (quote left))
 '(scroll-step 1)
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(truncate-lines nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "red" :height 3.0 :family "Monaco"))))
 '(cursor ((t (:background "white smoke" :foreground "#042028")))))

;; my_settings files
(add-to-list 'load-path (expand-file-name "my_settings" user-emacs-directory))
(require 'my_keybindings)
;; (require 'my_hooks_asm)
;; (require 'my_hooks_cpp)
(require 'my_hooks_python)
(require 'unicad)
;; (use-package my_keybindings)
;; (use-package my_hooks)
;; (use-package unicad)		       ;auto detect codepage for files

(require 'key-chord)
(key-chord-mode 1)
;;
;; and some chords, for example
;;
;;      (key-chord-define-global "hj"     'undo)
(key-chord-define-global ";;"     "\C-e;\n")


;; (provide 'init)
;; ;;; init.el ends here

