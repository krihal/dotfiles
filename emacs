;; This is the .emacs file for Kristofer Hallin.
;; Using Linus Torvalds codingstyle.
;;
;; Feel free to contact me at: kristofer.hallin@gmail.com

;; Some nice hotkeys for frequently used stuff.
(global-set-key [f1] 'goto-line)
(global-set-key [(shift f1)] 'save-buffer)
(global-set-key [f2] 'other-window)
(global-set-key [(shift f2)] 'switch-to-buffer)
(global-set-key [(control f2)] 'switch-to-buffer)

(global-set-key [f3] 'split-window-horizontally)
(global-set-key [(shift f3)] 'split-window-vertically)
(global-set-key [f4] 'delete-window)
(global-set-key [(shift f4)] 'kill-buffer)

(global-set-key [f5] 'compile)
(global-set-key [f6] 'gdb)

;; Set font in Carbon Emacs
;;(set-frame-font "-apple-courier new-medium-r-normal--0-0-0-0-m-0-iso10646-1")

;; No annoying messages at startup, thank you very much.
(setq inhibit-default-init t)
(setq inhibit-startup-message t)

;; Highlighting is good, though...
(global-font-lock-mode t)

;; Line and column numbering on.
(setq column-number-mode t)
(setq line-number-mode t)

;; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; Stop creating annoying backups
(setq make-backup-files nil)

;; Version shit
(defun if-gnu-emacs (expr)
  (if (string-match "GNU" (emacs-version))
                (eval expr)))

;; See some information at the bottom of the screen
(setq column-number-mode t
      line-number-mode t
      display-time-24hr-format t
      mouse-yank-at-point t
      inhibit-startup-message t
      display-time-day-and-date t
      next-line-add-newlines nil
      tab-width 3)
(delete-selection-mode t)
(display-time)

;; Get rid of the fucked up menubar
(if-gnu-emacs '(menu-bar-mode 0))

;; Some c code formatting
(defun linux-c-mode ()
  "C mode"
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

;; Some c code formatting
(defun linux-tcl-mode ()
  "TCL mode"
  (interactive)
  (tcl-mode)
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq tcl-indent-level 8))

(setq auto-mode-alist (cons '("/.*/.*\\.[ch]$" . linux-c-mode)
			    auto-mode-alist))

(setq auto-mode-alist (cons '("/.*/.*\\.java" . linux-c-mode)
			    auto-mode-alist))

(setq auto-mode-alist (cons '("/.*/.*\\.tcl" . linux-tcl-mode)
			    auto-mode-alist))

(setq auto-mode-alist (cons '("/.*/.*\\.exp" . linux-tcl-mode)
			    auto-mode-alist))

;; Swedish characters.
;;(set-input-mode (car (current-input-mode))
;;		(nth 1 (current-input-mode))
;;              0)

;; Enable the mouse-wheel
(if-gnu-emacs
    '(progn
       (defun up-slightly () (interactive) (scroll-up 5))
       (defun down-slightly () (interactive) (scroll-down 5))
       (global-set-key [mouse-4] 'down-slightly)
       (global-set-key [mouse-5] 'up-slightly)))

;; Some nice colors
(set-background-color "lightyellow")
(set-foreground-color "black")
(set-cursor-color "black")
(set-border-color "lightyellow")

(set-face-background 'modeline "lightyellow")
(set-face-foreground 'modeline "black")

(custom-set-faces
 '(fringe ((t (:foreground "goldenrod1" :background "lightyellow")))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "ivory3"))))
 '(font-lock-comment-face ((((class color)) (:foreground "LightCyan4"))))
 '(font-lock-constant-face ((t (:foreground "gray60"))))
 '(font-lock-function-name-face ((((class color)) (:foreground "LightSteelBlue3"))))
 '(font-lock-keyword-face ((((class color)) (:foreground "LightSteelBlue3"))))
 '(font-lock-string-face ((((class color)) (:foreground "#7f9f7f"))))
 '(font-lock-type-face ((t (:foreground "LightSteelBlue3"))))
 '(font-lock-variable-name-face ((((class color)) (:foreground "LightSteelBlue3"))))
 '(font-lock-warning-face ((t (:foreground "red3"))))
 '(fringe ((t (:foreground "goldenrod1" :background "lightyellow"))))
 '(region ((((class color)) (:foreground "gray15" :background "gainsboro"))))
 '(show-paren-match-face ((t (:foreground "yellow"))) t)
 '(show-paren-mismatch-face ((t (:foreground "red2"))) t))

;; Get rid of a lot of shit
(show-paren-mode)
(tool-bar-mode)
(scroll-bar-mode)

;; Cycle buffers with Ctrl+N
(global-set-key "\C-n" '(lambda () (interactive)
                          (switch-to-buffer (other-buffer))))

;; Fix other peoples broken ideas of code indentation. B-]
(defun fix-broken-indentation ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\([)=]\\)[ \n\r\t]*{" nil t)
      (replace-match "\\1 {"))))

(defun indent-whole-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun rra-cvs-update ()
  "Customized cvs-update-other-window that doesn't prompt for a
    directory."
  (interactive)
  (if (string-match "XEmacs" emacs-version)
      (progn
	(if (one-window-p) (split-window-vertically))
	(other-window 1)
	(cvs-update (file-name-directory (buffer-file-name)) t))
    (cvs-update-other-window (file-name-directory (buffer-file-name)))))
(custom-set-variables

 '(column-number-mode t)
 '(display-time-mode t)
 '(show-paren-mode t)
 '(transient-mark-mode t))
