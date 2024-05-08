;; This is the .emacs file for Kristofer Hallin.
;;
;; Feel free to contact me at: kristofer.hallin@gmail.com
;;

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-to-list 'package-archives
			 '("melpa" . "http://melpa.org/packages/"))

(setq exec-path (append '("/opt/homebrew/bin/"
						  )
						exec-path))
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-w") 'whitespace-cleanup)
(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "M-a") 'mark-whole-buffer)

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
(setq electric-pair-preserve-balance nil)
(setq load-prefer-newer t)

(set-face-attribute 'default nil :height 140)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
;;(electric-pair-mode)
(set-language-environment "UTF-8")

(load-theme 'wombat)
(load "~/.emacs.d/freeradius-mode.el")
(load "~/.emacs.d/framemove.el")
(load "~/.emacs.d/yang-mode.el")

(set-face-attribute 'fringe nil :background nil)
(set-face-attribute 'default nil :height 140)

;;(add-hook 'elpy-mode-hook 'py-autopep8-mode)
(add-hook 'before-save-hook 'py-isort-before-save)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'before-save-hook 'blacken-buffer)
(add-hook 'completion-at-point-functions 'go-complete-at-point)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-to-list 'auto-mode-alist '("\\.pp\\'" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.yml.erb\\'" . yaml-mode))
(add-to-list 'load-path "~/.emacs.d/copilot.el")

(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

(require 'magit)
(require 'py-isort)
(require 'py-autopep8)
(require 'freeradius-mode)
(require 'framemove)
(require 'use-package)
(require 'copilot)
(require 'blacken)

(add-hook 'prog-mode-hook 'copilot-mode)
(define-key copilot-completion-map (kbd "S-<return>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-next-completion)

(framemove-default-keybindings)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" "f681100b27d783fefc3b62f44f84eb7fa0ce73ec183ebea5903df506eb314077" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" "30b14930bec4ada72f48417158155bc38dd35451e0f75b900febd355cda75c3e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "fb83a50c80de36f23aea5919e50e1bccd565ca5bb646af95729dc8c5f926cbf3" "e3a1b1fb50e3908e80514de38acbac74be2eb2777fc896e44b54ce44308e5330" "b6269b0356ed8d9ed55b0dcea10b4e13227b89fd2af4452eee19ac88297b0f99" "b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "e6f3a4a582ffb5de0471c9b640a5f0212ccf258a987ba421ae2659f1eaa39b09" "c2aeb1bd4aa80f1e4f95746bda040aafb78b1808de07d340007ba898efa484f5" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" default))
 '(electric-pair-mode t)
 '(package-selected-packages
   '(blacken dap-mode which-key puppet-mode yang-mode eglot company-irony irony use-package python-black tramp-auto-auth auto-package-update go-expr-completion go-complete go-autocomplete go-mode rust-mode clues-theme dracula-theme spacemacs-theme monokai-pro-theme solarized-theme dockerfile-mode company-c-headers w32-browser yaml-mode exec-path-from-shell flycheck py-isort py-autopep8 magit)))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
		 (python-mode . lsp)
		 ;; if you want which-key integration
		 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
	:config
	(which-key-mode))
