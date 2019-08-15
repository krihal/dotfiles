;; This is the .emacs file for Kristofer Hallin.
;;
;; Feel free to contact me at: kristofer.hallin@gmail.com

;; Some nice hotkeys for frequently used stuff

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(global-set-key [f1] 'goto-line)
(global-set-key [f2] 'indent-whole-buffer)
(global-set-key [f3] 'whitespace-mode)
(global-set-key (kbd "C-c C-s") 'magit-status)
(global-set-key (kbd "C-c C-c") 'magit-commit)
(global-set-key (kbd "C-c C-d") 'magit-diff-unstaged)
(global-set-key (kbd "C-c C-p") 'magit-push)
(global-set-key (kbd "C-c C-l") 'magit-pull)

;; Get rid of a lot of annoying crap
(setq column-number-mode t)
(setq inhibit-default-init t)
(setq inhibit-startup-message t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq line-number-mode t)
(setq make-backup-files nil)
(setq visible-bell t)
(setq x-stretch-cursor t)

(if (display-graphic-p)
    (progn
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode 0)))

(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)
(show-paren-mode t)
(which-function-mode 1)

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

(windmove-default-keybindings)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq-default c-basic-offset 4)
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode t)
(setq indent-tabs-mode t)
(setq tab-width 4)
(setq ispell-program-name "/usr/local/bin/ispell")

(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "#2F2F2F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Menlo"))))
 '(fringe ((t (:background "#2F2F2F" :foreground "#DCDCCC")))))

(set-face-attribute 'default nil :height 140)


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)
(setq elpy-rpc-python-command "/usr/local/bin/python3")
(elpy-enable)

(defvar myPackages
  '(better-defaults
    elpy
    flycheck ;; add the flycheck package
    material-theme))

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
