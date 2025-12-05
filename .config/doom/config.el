;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; ;; TODO: maybe turn on if doesn't work with fish???
;; ;; Non-POSIX shells (particularly Fish and Nushell) can cause
;; ;;     unpredictable issues with any Emacs utilities that spawn child
;; ;;     processes from shell commands (like diff-hl and in-Emacs
;; ;;     terminals). To get around this, configure Emacs to use a POSIX shell
;; ;;     internally, e.g.
;; (setq shell-file-name (executable-find "bash"))
;; ;; Emacs' terminal emulators can be safely configured to use your
;; ;; original $SHELL:
;; (setq-default vterm-shell "/bin/fish")
;; (setq-default explicit-shell-file-name "/bin/fish")

;; Disable confirm on exit
(setq confirm-kill-emacs nil) 

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "JetbrainsMono Nerd Font" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 13))
(setq doom-font (font-spec :family "JetbrainsMono Nerd Font" :size 21 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetbrainsMono Nerd Font" :size 24 :weight 'Regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-palenight)
;; (setq doom-theme 'doom-tokyo-night)
;; (setq doom-theme 'doom-ayu-mirage)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; To prevent Doom Emacs from automatically inserting a comment character in a new line after a commented line
(setq +evil-want-o/O-to-continue-comments nil)

;; Disable backup (~), .saves, auto-save
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)

;; ;; my_settings files
;; (add-to-list 'load-path (expand-file-name "my_settings" "~/.config/doom/"))
;; ;; (add-to-list 'load-path (expand-file-name "my_settings" user-emacs-directory))
;; (require  'my_keybindings)

;; KEYBINDINGS
;; (map! :leader
;;       :desc "Switch from insert to normal mode"
;;       "j j" #'evil-force-normal-state)
(map! (:after evil
      :i "jj" #'evil-normal-state))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
