;; Highlight current line
(global-hl-line-mode 0)
(global-display-line-numbers-mode t)
(column-number-mode t)
(add-hook 'completion-list-mode-hook (lambda () (display-line-numbers-mode 0)))

;; Do not use `init.el` for `custom-*` code - use `custom-file.el` and load it
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Add melpa repo and install use-package
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package company
  :ensure t
  :bind (:map company-active-map
	      ("C-n" . company-select-next)
	      ("C-p" . company-select-previous))
  :config (setq company-idle-delay 0.1)
  :init (global-company-mode))

(use-package haskell-mode
  :ensure t
  :init (haskell-mode)
  :config
  (setq haskell-process-type 'stack-ghci))

(use-package ivy
  :ensure t
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
 	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :init (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode 1)
  :config (setq which-key-idle-delay 0.3))

; There is a bug in melpa stable version https://github.com/Yevgnen/ivy-rich/issues/88
;(use-package ivy-rich
;  :init (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer) ; Or use command counsel-switch-buffer 
	 :map minibuffer-local-map
	 ("C-x C-h" . counsel-minibuffer-history)))

; peach-melpa.org
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-hard t))

(use-package all-the-icons)

;; LSP

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (haskell-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-haskell)
