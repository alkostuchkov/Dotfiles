;;; package --- KEYBINDINGS ---
;;; Commentary:

;; ;; ##### Moving ######
;; ;; Up
;; ;; (global-unset-key (kbd "M-i"))
;; ;; (global-set-key (kbd "M-i") 'previous-line)

;; ;; Down
;; ;; (global-unset-key (kbd "M-k"))
;; ;; (global-set-key (kbd "M-k") 'next-line)

;; ;; Left
;; ;; (global-unset-key (kbd "M-j"))
;; ;; (global-set-key (kbd "M-j") 'backward-char)

;; ;; Right
;; ;; (global-unset-key (kbd "M-l"))
;; ;; (global-set-key (kbd "M-l") 'forward-char)

;; ;; Page Up
;; ;; (global-unset-key (kbd "M-I"))
;; ;; (global-set-key (kbd "M-I") 'scroll-down-command)

;; ;; Page Down
;; ;; (global-unset-key (kbd "M-K"))
;; ;; (global-set-key (kbd "M-K") 'scroll-up-command)

;; ;; Beginning of buffer
;; ;; (global-unset-key (kbd "M-J"))
;; ;; (global-set-key (kbd "M-J") 'beginning-of-buffer)

;; ;; End of buffer
;; ;; (global-unset-key (kbd "M-L"))
;; ;; (global-set-key (kbd "M-L") 'end-of-buffer)

;; ;; Forward word
;; ;; (global-unset-key (kbd "M-o"))
;; ;; (global-set-key (kbd "M-o") 'forward-word)

;; ;; Backward word
;; ;; (global-unset-key (kbd "M-u"))
;; ;; (global-set-key (kbd "M-u") 'backward-word)

;; ;; Beginning of line
;; ;; (global-unset-key (kbd "M-F"))
;; ;; (global-set-key (kbd "M-F") 'move-beginning-of-line)

;; ;; End of line
;; ;; (global-unset-key (kbd "M-f"))
;; ;; (global-set-key (kbd "M-f") 'move-end-of-line)

;; ;; ##### Edit #####
;; ;; Delete
;; ;; (global-unset-key (kbd "M-d"))
;; ;; (global-set-key (kbd "M-d") 'delete-forward-char)

;; ;; Delete the word from the right
;; ;; (global-unset-key (kbd "M-D"))
;; ;; (global-set-key (kbd "M-D") 'kill-word)

;; ;; Backspace
;; ;; (global-unset-key (kbd "M-h"))
;; ;; (global-set-key (kbd "M-h") 'delete-backward-char)

;; ;; Delete the word from the left
;; ;; (global-unset-key (kbd "M-H"))
;; ;; (global-set-key (kbd "M-H") 'backward-kill-word)

;; ;; Kill whole line
;; ;; (global-unset-key (kbd "M-g"))
;; ;; (global-set-key (kbd "M-g") 'kill-whole-line)
;; ;; Mark whole buffer
;; ;; (global-unset-key (kbd "M-a"))
;; ;; (global-set-key (kbd "M-a") 'mark-whole-buffer)

;; ;; Enter
;; ;; (global-unset-key (kbd "M-m"))
;; ;; (global-set-key (kbd "M-m") 'reindent-then-newline-and-indent)

;; ;; #### Copy line #### beginning
;; ;; Copy the string if it's not marked
;; (defadvice kill-ring-save (before slick-copy activate compile)
;;   "When called interactively with no active region, copy a single
;; line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (message "Copied line")
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; ;; Cut the string if it's not marked
;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single
;;   line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; (defun my:copy-line ()
;;   "Copy line."
;;   (interactive)
;;   (save-excursion
;;   (beginning-of-line)
;;   (set-mark (point))
;;   (end-of-line)
;;   (kill-ring-save (region-beginning) (region-end))
;;   (newline)
;;   (yank)))
;; (global-unset-key (kbd "M-C"))
;; (global-set-key (kbd "M-C") 'my:copy-line)
;; ;; #### Copy line #### end

;; ;; ;; Copy
;; ;; (global-unset-key (kbd "M-c"))
;; ;; (global-set-key (kbd "M-c") 'kill-ring-save)

;; ;; ;; Cut
;; ;; (global-unset-key (kbd "M-x"))
;; ;; (global-set-key (kbd "M-x") 'kill-region)

;; ;; ;; Paste
;; ;; (global-unset-key (kbd "M-v"))
;; ;; (global-set-key (kbd "M-v") 'yank)

;; ;; ;; +##### Yank(paste) Pop (from Tutorial) #####+
;; ;; (global-unset-key (kbd "M-y"))
;; ;; (global-set-key (kbd "M-y") 'yank-pop)

;; ;; ;; Undo
;; ;; (global-unset-key (kbd "M-z"))
;; ;; (global-set-key (kbd "M-z") 'undo)

;; ;; ;; ##### File managment #####
;; ;; ;; Save file
;; ;; (global-unset-key (kbd "M-s"))
;; ;; (global-set-key (kbd "M-s") 'save-buffer)

;; ;; ;; Save file as
;; ;; (global-unset-key (kbd "M-S"))
;; ;; (global-set-key (kbd "M-S") 'ido-write-file)

;; ;; ;; Open file
;; ;; (global-unset-key (kbd "C-o"))
;; ;; (global-set-key (kbd "C-o") 'find-file)

;; ;; ;; ##### Commads #####
;; ;; ;; Run extended command
;; ;; (global-unset-key (kbd "<f5>"))
;; ;; (global-set-key (kbd "<f5>") 'execute-extended-command)

;; ;; #### Macroses #### beginning
;; ;; Start record macro
;; (global-unset-key (kbd "<f3>"))
;; (global-set-key (kbd "<f3>") 'kmacro-start-macro)

;; ;; Stop and Call macro
;; (global-unset-key (kbd "<f4>"))
;; (global-set-key (kbd "<f4>") 'kmacro-end-or-call-macro)
;; ;; #### Macroses #### end

;; ;; ############## BUFFERS & WINDOWS  ############################
;; ;; Buffers show
;; (global-unset-key (kbd "C-x C-b"))
;; (global-set-key (kbd "C-x C-b") 'electric-buffer-list)

;; (global-unset-key (kbd "<f2>"))
;; (global-set-key (kbd "<f2>") 'bs-show)

;; ;; ##### Moving between opened windows (tabs) #####
;; ;; Next buffer
;; (global-unset-key (kbd "M-q"))
;; (global-set-key (kbd "M-q") 'other-window)

;; ;; ace-window
;; (global-set-key [remap other-window] 'ace-window)

;; ;; Windmove up (Select the window above the current one.)
;; (global-unset-key (kbd "C-M-i"))
;; (global-set-key (kbd "C-M-i") 'windmove-up)
;; (define-key emacs-lisp-mode-map (kbd "C-M-i") 'windmove-up)

;; ;; Windmove down (Select the window below the current one.)
;; (global-unset-key (kbd "C-M-k"))
;; (global-set-key (kbd "C-M-k") 'windmove-down)

;; ;; Windmove left (Select the window to the left of the current one.)
;; (global-unset-key (kbd "C-M-j"))
;; (global-set-key (kbd "C-M-j") 'windmove-left)

;; ;; Windmove right (Select the window to the  of the current one.)
;; (global-unset-key (kbd "C-M-l"))
;; (global-set-key (kbd "C-M-l") 'windmove-right)

;; ;; ##### RESIZE WINDOWS #####
;; (defun my:enlarge-vert ()
;;   (interactive)
;;   (enlarge-window 2))

;; (defun my:shrink-vert ()
;;   (interactive)
;;   (enlarge-window -2))

;; (defun my:enlarge-horz ()
;;   (interactive)
;;   (enlarge-window-horizontally 2))

;; (defun my:shrink-horz ()
;;   (interactive)
;;   (enlarge-window-horizontally -2))

;; (global-unset-key (kbd "C-0"))
;; (global-set-key (kbd "C-0") 'my:shrink-vert)
;; (global-unset-key (kbd "C-9"))
;; (global-set-key (kbd "C-9") 'my:enlarge-vert)
;; (global-unset-key (kbd "C-("))
;; (global-set-key (kbd "C-(") 'my:shrink-horz)
;; (global-unset-key (kbd "C-)"))
;; (global-set-key (kbd "C-)") 'my:enlarge-horz)

;; ;; Goto line number (jump to ...)
;; (global-set-key (kbd "C-c j") 'goto-line)

;; ;; ################## My Functions ####################
;; ;; #### insert line below or above (from elpy.el) #### beginning
;; (defun my:open-and-indent-line-below ()
;;   "Open a line below the current one, move there, and indent."
;;   (interactive)
;;   (move-end-of-line 1)
;;   (newline-and-indent))
;; (global-unset-key (kbd "<S-return>"))
;; (global-set-key (kbd "<S-return>") 'my:open-and-indent-line-below)

;; (defun my:open-and-indent-line-above ()
;;   "Open a line above the current one, move there, and indent."
;;   (interactive)
;;   (move-beginning-of-line 1)
;;   (save-excursion
;;     (insert "\n"))
;;   (indent-according-to-mode))
;; (global-unset-key (kbd "<M-C-return>"))
;; (global-set-key (kbd "<M-C-return>") 'my:open-and-indent-line-above)

;; ;; (defun my:insert-line-above ()
;; ;;   "Insert line above the current one."
;; ;;   (interactive)
;; ;;   (beginning-of-line)
;; ;;   (newline)
;; ;;   (forward-line -1))					;(previous-line)
;; ;; ;; (global-unset-key (kbd "M-N"))
;; ;; ;; (global-set-key (kbd "M-N") 'my:insert-line-above)

;; ;; (defun my:insert-line-below ()
;; ;;   "Insert line below the current one."
;; ;;   (interactive)
;; ;;     (end-of-line)
;; ;;     (newline))
;; ;; ;; (global-unset-key (kbd "M-n"))
;; ;; ;; (global-set-key (kbd "M-n") 'my:insert-line-below)

;; ;; #### insert line below or above (from elpy.el) #### end

;; ;; #### moving line or region up or down (from elpy.el) #### beginning
;; (defun my:move-line-or-region-down (&optional beg end)
;;   "Move the current line or active region down."
;;   (interactive
;;    (if (use-region-p)
;;        (list (region-beginning) (region-end))
;;      (list nil nil)))
;;   (if beg
;;       (my:move-region-vertically beg end 1)
;;     (my:move-line-vertically 1)))
;; (global-unset-key (kbd "M-S-<down>"))
;; (global-set-key [M-S-down] 'my:move-line-or-region-down)

;; (defun my:move-line-or-region-up (&optional beg end)
;;   "Move the current line or active region down."
;;   (interactive
;;    (if (use-region-p)
;;        (list (region-beginning) (region-end))
;;      (list nil nil)))
;;   (if beg
;;       (my:move-region-vertically beg end -1)
;;     (my:move-line-vertically -1)))
;; (global-unset-key (kbd "M-S-<up>"))
;; (global-set-key [M-S-up] 'my:move-line-or-region-up)

;; (defun my:move-line-vertically (dir)
;;   (let* ((beg (point-at-bol))
;;          (end (point-at-bol 2))
;;          (col (current-column))
;;          (region (delete-and-extract-region beg end)))
;;     (forward-line dir)
;;     (save-excursion
;;       (insert region))
;;     (goto-char (+ (point) col))))

;; (defun my:move-region-vertically (beg end dir)
;;   (let* ((point-before-mark (< (point) (mark)))
;;          (beg (save-excursion
;;                 (goto-char beg)
;;                 (point-at-bol)))
;;          (end (save-excursion
;;                 (goto-char end)
;;                 (if (bolp)
;;                     (point)
;;                   (point-at-bol 2))))
;;          (region (delete-and-extract-region beg end)))
;;     (goto-char beg)
;;     (forward-line dir)
;;     (save-excursion
;;       (insert region))
;;     (if point-before-mark
;;         (set-mark (+ (point)
;;                      (length region)))
;;       (set-mark (point))
;;       (goto-char (+ (point)
;;                     (length region))))
;;     (setq deactivate-mark nil)))
;; ;; #### moving line or region up or down (from elpy.el) #### end

;; ;; (defun my:move-line-down ()
;; ;;   "Move the current line down."
;; ;;   (interactive)
;; ;;   (forward-line 1)			;(next-line)
;; ;;   (transpose-lines 1)
;; ;;   (forward-line -1)) 			;(previous-line)
;; ;; (global-unset-key (kbd "M-S-<down>"))
;; ;; (global-set-key [M-S-down] 'my:move-line-down)

;; ;; (defun my:move-line-up ()
;; ;;   "Move the current line up."
;; ;;   (interactive)
;; ;;   (transpose-lines 1)
;; ;;   (forward-line -2))			;(previous-line)
;; ;; (global-unset-key (kbd "M-S-<up>"))
;; ;; (global-set-key (kbd "M-S-<up>") 'my:move-line-up)
;; ;; ;; #### moving line up or down (my) ####

;; ;; #### shift line or region (from python.el and elpy.el)#### beginning
;; (defun my:indent-shift-right (&optional count)
;;   "Shift current line by COUNT columns to the right.

;; COUNT defaults to 1(one).
;; If region is active, normalize the region and shift."
;;   (interactive)
;;   (if (use-region-p)
;;       (progn
;;         (my:normalize-region)
;;         (my:one-indent-shift-right (region-beginning) (region-end) current-prefix-arg))
;;     (my:one-indent-shift-right (line-beginning-position) (line-end-position) current-prefix-arg)))
;; (global-unset-key (kbd "M-S-<right>"))
;; (global-set-key (kbd "M-S-<right>") 'my:indent-shift-right)

;; (defun my:indent-shift-left (&optional count)
;;   "Shift current line by COUNT columns to the left.

;; COUNT defaults to 1(one).
;; If region is active, normalize the region and shift."
;;   (interactive)
;;   (if (use-region-p)
;;       (progn
;;         (my:normalize-region)
;;         (my:one-indent-shift-left (region-beginning) (region-end) current-prefix-arg))
;;     (my:one-indent-shift-left (line-beginning-position) (line-end-position) current-prefix-arg)))
;; (global-unset-key (kbd "M-S-<left>"))
;; (global-set-key (kbd "M-S-<left>") 'my:indent-shift-left)

;; (defun my:normalize-region ()
;;   "If the first or last line are not fully selected, select them completely."
;;   (let ((beg (region-beginning))
;;         (end (region-end)))
;;     (goto-char beg)
;;     (beginning-of-line)
;;     (push-mark (point) nil t)
;;     (goto-char end)
;;     (when (not (= (point) (line-beginning-position)))
;;       (end-of-line))))

;; (defun my:one-indent-shift-right (start end &optional count)
;;   "Shift lines contained in region START END by COUNT columns to the right.
;; COUNT defaults to 1(one).  If region isn't
;; active, the current line is shifted.  The shifted region includes
;; the lines in which START and END lie."
;;   (interactive
;;    (if mark-active
;;        (list (region-beginning) (region-end) current-prefix-arg)
;;      (list (line-beginning-position) (line-end-position) current-prefix-arg)))
;;   (let ((deactivate-mark nil))
;;     (setq count (if count (prefix-numeric-value count) 1))
;;     (indent-rigidly start end count)))

;; (defun my:one-indent-shift-left (start end &optional count)
;;   "Shift lines contained in region START END by COUNT columns to the left.
;; COUNT defaults to 1(one).  If region isn't
;; active, the current line is shifted.  The shifted region includes
;; the lines in which START and END lie.  An error is signaled if
;; any lines in the region are indented less than COUNT columns."
;;   (interactive
;;    (if mark-active
;;        (list (region-beginning) (region-end) current-prefix-arg)
;;      (list (line-beginning-position) (line-end-position) current-prefix-arg)))
;;   (if count
;;       (setq count (prefix-numeric-value count))
;;     (setq count 1))
;;   (when (> count 0)
;;     (let ((deactivate-mark nil))
;;       (save-excursion
;;         (goto-char start)
;;         (while (< (point) end)
;;           (if (and (< (current-indentation) count)
;;                    (not (looking-at "[ \t]*$")))
;;               (user-error "Can't shift all lines enough"))
;;           (forward-line))
;;         (indent-rigidly start end (- count))))))
;; ;; #### shift line or region (from python.el and elpy.el)#### end

;; ;; #### my:copy word #### beginning
;; (defun my:get-point (symbol &optional arg)
;;   "Get the point"
;;   (funcall symbol arg)
;;   (point))

;; (defun my:copy-thing (begin-of-thing end-of-thing &optional arg)
;;   "Copy thing between beg & end into kill ring"
;;   (save-excursion
;;     (let ((beg (my:get-point begin-of-thing 1))
;;           (end (my:get-point end-of-thing arg)))
;;       (copy-region-as-kill beg end))))

;; (defun my:copy-word (&optional arg)
;;   "Copy words at point into kill-ring"
;;   (interactive "P")
;;   (my:copy-thing 'backward-word 'forward-word arg)
;;   (message "The word has been copied."))

;; (global-unset-key (kbd "C-c w"))
;; (global-set-key (kbd "C-c w") 'my:copy-word)
;; ;; ##### my:copy-word ####### end

;; ;; ############ UP/downcase word ############
;; (global-set-key (kbd "C-c l") 'downcase-word)
;; (global-set-key (kbd "C-c u") 'upcase-word)

;; ;; ################ Change coding for current buffer ################## beginning
;; (setq my-working-codings ["utf-8" "windows-1251" "cp866"]) ; "koi8-r"])
;; (setq my-current-coding-index -1)
;; (defun my:change-coding-for-current-buffer ()
;;   "Change coding for current buffer."
;;   (interactive)
;;   (let (my-current-eol
;;         my-next-coding-index
;;         my-new-coding-system
;;         my-new-coding)
;;     (setq my-current-eol
;;           (coding-system-eol-type buffer-file-coding-system))
;;     (setq my-next-coding-index (1+ my-current-coding-index))
;;     (if (equal my-next-coding-index (length my-working-codings))
;;         (setq my-next-coding-index 0))
;;     (setq my-new-coding-system
;;           (elt my-working-codings my-next-coding-index))
;;     (cond ((equal my-current-eol 0)
;;            (setq my-new-coding (concat my-new-coding-system "-unix")))
;;           ((equal my-current-eol 1)
;;            (setq my-new-coding (concat my-new-coding-system "-dos")))
;;           ((equal my-current-eol 2)
;;            (setq my-new-coding (concat my-new-coding-system "-mac"))))
;;     (setq coding-system-for-read (read my-new-coding))
;;     (revert-buffer t t)
;;     (setq my-current-coding-index my-next-coding-index)
;;     (message "Set coding %s." my-new-coding)
;;     )
;;   )
;; (global-set-key [f8] 'my:change-coding-for-current-buffer)
;; ;; ################ Change coding for current buffer ################## end

;; ;; #### toggle auto-complete-mode #### beginning
;; (defun my:toggle-auto-complete-mode ()
;;   "Toggle auto-complete-mode. It's bound to <f9>."
;;   (interactive)
;;   (if (equal auto-complete-mode t)
;;       (progn
;; 	(setq auto-complete-mode nil)
;; 	(message "auto-complete-mode is disabled"))
;;     (progn
;;       (setq auto-complete-mode t)
;;       (message "auto-complete-mode is enabled"))))
;; (global-unset-key (kbd "<f9>"))
;; (global-set-key (kbd "<f9>") 'my:toggle-auto-complete-mode)
;; ;; #### toggle auto-complete-mode #### beginning

;; ;; Sr speedbar
;; (global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

;; (global-unset-key (kbd "C-j"))
;; (global-set-key (kbd "C-j") 'reindent-then-newline-and-indent)

;; KEYBINDINGS
;; (map! :leader
;;       :desc "Switch from insert to normal mode"
;;       "j j" #'evil-force-normal-state)
;;; Code:
(map! :after evil
      :i "jj" #'evil-normal-state)

(provide 'my-keybindings)
;;; my-keybindings.el ends here
