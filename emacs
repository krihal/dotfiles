;; This is the .emacs file for Kristofer Hallin.
;; Using Linus Torvalds codingstyle.
;;
;; Feel free to contact me at: kristofer.hallin@gmail.com

;; Some nice hotkeys for frequently used stuff
(global-set-key [f1] 'goto-line)
(global-set-key [(shift f1)] 'save-buffer)
(global-set-key [f2] 'cscope-find-this-symbol)
(global-set-key [(shift f2)] 'switch-to-buffer)
(global-set-key [(control f2)] 'switch-to-buffer)

(global-set-key [f3] 'split-window-horizontally)
(global-set-key [(shift f3)] 'split-window-vertically)
(global-set-key [f4] 'delete-window)
(global-set-key [(shift f4)] 'kill-buffer)

(global-set-key [f5] 'cvs-examine)
(global-set-key [f6] 'cvs-update)
(global-set-key [f7] 'indent-whole-buffer)

(global-set-key [f11] 'gdb)
(global-set-key [f12] 'compile)
(global-set-key [(shift f12)] 'compile-goto-error)

;; No annoying messages at startup, thank you very much
(setq inhibit-default-init t)
(setq inhibit-startup-message t)

;; Code highlighting
(global-font-lock-mode t)

;; Line and column numbering on
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

;; Some C code formatting
(defun linux-c-mode ()
  "C mode"
  (setq c-default-style "cc-mode") 
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

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

;; Use TCP mode for .exp files
(setq auto-mode-alist (cons '("/.*/.*\\.exp" . linux-tcl-mode)
			    auto-mode-alist))

;; Swedish characters.
(set-input-mode (car (current-input-mode))
		(nth 1 (current-input-mode))
              0)

;; Enable the mouse-wheel
(if-gnu-emacs
    '(progn
       (defun up-slightly () (interactive) (scroll-up 5))
       (defun down-slightly () (interactive) (scroll-down 5))
       (global-set-key [mouse-4] 'down-slightly)
       (global-set-key [mouse-5] 'up-slightly)))

;; Cycle buffers with Ctrl+N
(global-set-key "\C-n" '(lambda () (interactive)
                          (switch-to-buffer (other-buffer))))

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

(put 'downcase-region 'disabled nil)

;; Get rid of a lot of annoying crap
(show-paren-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(display-battery-mode 1)

;; Hilight the current line
(require 'highlight-current-line)
(highlight-current-line-on t)
(set-face-background 'highlight-current-line-face "light yellow")

;; Execute Python scripts in a better way
(defun python-send-file ()
  (interactive)
  (save-buffer)
  (python-send-string (concat "execfile('" (buffer-file-name) "')")))

(eval-after-load "python" 
  (define-key python-mode-map "\C-c\C-c" 'python-send-file))