;; This is the .emacs file for Kristofer Hallin.
;;
;; Feel free to contact me at: kristofer.hallin@gmail.com

;; Some nice hotkeys for frequently used stuff
(global-set-key [f1] 'goto-line)
(global-set-key [f2] 'indent-whole-buffer)

;; Get rid of a lot of annoying crap
(setq inhibit-default-init t)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq line-number-mode t)
(setq make-backup-files nil)
(global-font-lock-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(display-battery-mode 1)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq visible-bell t)
(scroll-bar-mode 0)

;; See some information at the bottom of the screen
(setq column-number-mode t
      line-number-mode t
      mouse-yank-at-point t
      inhibit-startup-message t
      next-line-add-newlines nil
      tab-width 3)
(delete-selection-mode t)

;; Set the color of the fringe
(custom-set-faces
 '(fringe ((t (:background "white")))))

;; C code formatting
(defun linux-c-mode ()
  "C mode"
  (setq c-default-style "cc-mode") 
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))

;; Use C mode for .c and .h files
(setq auto-mode-alist (cons '("/.*/.*\\.[ch]$" . linux-c-mode)
			    auto-mode-alist))

;; Some TCL code formatting
(defun linux-tcl-mode ()
  "TCL mode"
  (interactive)
  (tcl-mode)
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq tcl-indent-level 8))

;; Use TCL mode for .tcl files
(setq auto-mode-alist (cons '("/.*/.*\\.tcl" . linux-tcl-mode)
			    auto-mode-alist))

;; Use TCL mode for .exp files
(setq auto-mode-alist (cons '("/.*/.*\\.exp" . linux-tcl-mode)
			    auto-mode-alist))

;; Fix other peoples broken ideas of code indentation
(defun fix-broken-indentation ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\([)=]\\)[ \n\r\t]*{" nil t)
      (replace-match "\\1 {"))))

;; Whole buffer indentation
(defun indent-whole-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

;; Close all buffers
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;; Auto complete
(add-to-list 'load-path "/home/khn/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/khn/.emacs.d//ac-dict")
(ac-config-default)
