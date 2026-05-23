;;; init.el --- Minimal Emacs config -*- lexical-binding: t; -*-

(setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(setq package-archives
      '(("gnu"          . "https://elpa.gnu.org/packages/")
        ("nongnu"       . "https://elpa.nongnu.org/nongnu/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")))

(setq package-pinned-packages
      '((use-package      . "gnu")
        (vertico          . "gnu")
        (orderless        . "gnu")
        (consult          . "gnu")
        (which-key        . "gnu")
        (evil             . "nongnu")
        (general          . "melpa-stable")
        (catppuccin-theme . "melpa-stable")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(setq inhibit-startup-screen t
      ring-bell-function #'ignore
      make-backup-files nil
      auto-save-default nil
      use-short-answers t)

(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)
(global-auto-revert-mode 1)

(setq recentf-max-saved-items 200)

(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(dolist (hook '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook hook (lambda () (display-line-numbers-mode 0))))

(use-package org
  :ensure nil
  :hook (org-mode . visual-line-mode)
  :config
  (setq org-directory (expand-file-name "~/org/")
        org-agenda-files (list org-directory)
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-startup-indented t
        org-hide-emphasis-markers t
        org-return-follows-link t
        org-log-done 'time)
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline (expand-file-name "inbox.org" org-directory) "Tasks")
           "* TODO %?\n  %U\n")
          ("n" "Note" entry
           (file+headline (expand-file-name "notes.org" org-directory) "Notes")
           "* %?\n  %U\n"))))

(use-package vertico
  :init
  (vertico-mode 1))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides
        '((file (styles basic partial-completion)))))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x C-r" . consult-recent-file)))

(use-package which-key
  :init
  (which-key-mode 1)
  :config
  (setq which-key-idle-delay 0.5))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-search-module 'evil-search
        evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "/") #'evil-search-forward)
  (define-key evil-normal-state-map (kbd "?") #'evil-search-backward)
  (define-key evil-normal-state-map (kbd "C-h") #'windmove-left)
  (define-key evil-normal-state-map (kbd "C-j") #'windmove-down)
  (define-key evil-normal-state-map (kbd "C-k") #'windmove-up)
  (define-key evil-normal-state-map (kbd "C-l") #'windmove-right)
  (define-key evil-normal-state-map (kbd "j") #'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") #'evil-previous-visual-line)
  (define-key evil-motion-state-map (kbd "j") #'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "k") #'evil-previous-visual-line))

(use-package general
  :after evil
  :config
  (general-define-key
   :states '(normal visual motion)
   :keymaps 'override
   :prefix "SPC"

   "f"  '(:ignore t :which-key "files")
   "ff" '(find-file :which-key "find file")
   "fr" '(consult-recent-file :which-key "recent files")
   "fb" '(consult-buffer :which-key "buffers")
   "fg" '(consult-ripgrep :which-key "grep project")
   "fh" '(describe-function :which-key "help function")

   "s"  '(:ignore t :which-key "search")
   "ss" '(consult-line :which-key "search buffer")
   "sg" '(consult-ripgrep :which-key "search project")

   "b"  '(:ignore t :which-key "buffers")
   "bb" '(consult-buffer :which-key "switch buffer")

   "w"  '(:ignore t :which-key "windows")
   "wh" '(windmove-left :which-key "move left")
   "wj" '(windmove-down :which-key "move down")
   "wk" '(windmove-up :which-key "move up")
   "wl" '(windmove-right :which-key "move right")
   "wv" '(split-window-right :which-key "split vertical")
   "ws" '(split-window-below :which-key "split horizontal")
   "wd" '(delete-window :which-key "delete window")
   "wo" '(delete-other-windows :which-key "only window")

   "o"  '(:ignore t :which-key "org")
   "oa" '(org-agenda :which-key "agenda")
   "oc" '(org-capture :which-key "capture")
   "ot" '(org-todo-list :which-key "todo list")

   "t"  '(:ignore t :which-key "toggles")
   "tt" '(load-theme :which-key "choose theme")))

(use-package catppuccin-theme
  :init
  (setq catppuccin-flavor 'mocha)
  :config
  (load-theme 'catppuccin t))

(setq consult-ripgrep-args
      "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number .")

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000))))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
