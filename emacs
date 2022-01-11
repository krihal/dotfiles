
;; This is the .emacs file for Kristofer Hallin.
;;
;; Feel free to contact me at: kristofer.hallin@gmail.com
;;

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(global-set-key [f1] 'goto-line)
(global-set-key [f2] 'indent-whole-buffer)
(global-set-key [f3] 'whitespace-mode)
(global-set-key (kbd "C-c C-s") 'magit-status)
(global-set-key (kbd "C-c C-c") 'magit-commit)
(global-set-key (kbd "C-c C-d") 'magit-diff-unstaged)
(global-set-key (kbd "C-c C-p") 'magit-push)
(global-set-key (kbd "C-c C-l") 'magit-pull)

(windmove-default-keybindings 'meta)

(setq column-number-mode t)
(setq inhibit-default-init t)
(setq inhibit-startup-message t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq line-number-mode t)
(setq make-backup-files nil)
(setq visible-bell t)
(setq x-stretch-cursor t)
(setq tramp-default-method "ssh")
(setq default-directory "/Users/khn/")
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq-default c-basic-offset 4)
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode t)
(setq indent-tabs-mode t)
(setq tab-width 4)
(setq ispell-program-name "/usr/local/bin/ispell")
(setq elpy-rpc-python-command "/usr/bin/python3")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode 0)
(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)
(show-paren-mode t)
(which-function-mode 1)
(windmove-default-keybindings)
(elpy-enable)
(custom-set-faces)

(load-theme 'wombat)
(load "~/.emacs.d/freeradius-mode.el")

(set-face-attribute 'fringe nil :background nil)
(set-face-attribute 'default nil :height 140)

(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'before-save-hook 'py-isort-before-save)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(require 'magit)
(require 'py-isort)
(require 'py-autopep8)
(require 'freeradius-mode)

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

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(el-get 'sync)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(custom-set-variables
 '(package-selected-packages
   '(ace-window exec-path-from-shell flycheck py-isort py-autopep8 magit elpy)))
