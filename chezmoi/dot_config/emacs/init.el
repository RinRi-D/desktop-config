;;; init.el --- Minimal Emacs config: Evil + Org -*- lexical-binding: t -*-

;;; Bootstrap straight.el (package manager, no need for package.el)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; use-package (bundled with Emacs 29+, also available via straight)
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; ─── Sane defaults ───────────────────────────────────────────────────────────
(setq inhibit-startup-message t
      ring-bell-function 'ignore
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      native-comp-async-report-warnings-errors 'silent)

(setq-default indent-tabs-mode nil
              tab-width 4)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

;; Keep custom settings out of this file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; ─── Evil (vim keybindings) ───────────────────────────────────────────────────
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil   ; let evil-collection handle mode bindings
        evil-want-C-u-scroll t
        evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; ─── General.el – Space leader keybindings ───────────────────────────────────
(use-package general
  :config
  (general-evil-setup)

  (general-create-definer leader-def
    :states '(normal visual motion emacs)
    :keymaps 'override
    :prefix "SPC")

  ;; Files
  (leader-def
    "f"  '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fr" '(recentf-open-files :which-key "recent files")
    "fs" '(save-buffer :which-key "save file"))

  ;; Buffers
  (leader-def
    "b"  '(:ignore t :which-key "buffers")
    "bb" '(switch-to-buffer :which-key "switch buffer")
    "bd" '(kill-current-buffer :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next buffer")
    "bp" '(previous-buffer :which-key "prev buffer"))

  ;; Org
  (leader-def
    "o"  '(:ignore t :which-key "org")
    "oa" '(org-agenda :which-key "agenda")
    "oc" '(org-capture :which-key "capture")
    "ol" '(org-store-link :which-key "store link"))

  ;; Help
  (leader-def
    "h"  '(:ignore t :which-key "help")
    "hk" '(describe-key :which-key "describe key")
    "hf" '(describe-function :which-key "describe function")
    "hv" '(describe-variable :which-key "describe variable"))

  ;; Quit
  (leader-def
    "q"  '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-emacs :which-key "quit emacs")))

;; ─── Which-key – show available keybindings ──────────────────────────────────
(use-package which-key
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.4))

;; ─── Recent files ─────────────────────────────────────────────────────────────
(recentf-mode 1)
(setq recentf-max-saved-items 50)

;; ─── Org mode ─────────────────────────────────────────────────────────────────
(use-package org
  :straight nil  ; use built-in org
  :hook (org-mode . visual-line-mode)
  :config
  (setq org-directory "~/org"
        org-default-notes-file (expand-file-name "inbox.org" org-directory)
        org-agenda-files (list org-directory)
        org-log-done 'time
        org-hide-leading-stars t
        org-startup-indented t
        org-startup-folded 'content
        org-ellipsis " ▾"
        org-return-follows-link t)

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Task" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n  %U\n")
          ("n" "Note" entry (file+headline org-default-notes-file "Notes")
           "* %?\n  %U\n"))))

;; Better org bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; ─── Vertico – minimal completion UI ─────────────────────────────────────────
(use-package vertico
  :config
  (vertico-mode 1))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)))

;;; init.el ends here
