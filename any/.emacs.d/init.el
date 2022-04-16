(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil)
(use-package helm)
(use-package flycheck)
(use-package ledger-mode)
(use-package anti-zenburn-theme)
(use-package powerline)

(load-theme 'anti-zenburn t)

(evil-mode 1)
(powerline-center-evil-theme)

(evil-define-key '(normal visual) 'global
  "H" "hhhhh"
  "J" "jjjjj"
  "K" "kkkkk"
  "L" "lllll"
  )
(evil-define-key '(normal) 'global
  (kbd "C-p") 'helm-find-files
  (kbd "C-j") 'helm-mini
  "U" (kbd "C-r")
)
(evil-define-key '(normal visual insert) 'global
  (kbd "C-s") (lambda () (interactive) (evil-force-normal-state) (save-buffer))
  (kbd "C-q") (lambda () (interactive) (save-buffers-kill-terminal))
)
(define-key evil-insert-state-map   (kbd "C-_") 'evil-normal-state)
(define-key evil-normal-state-map   (kbd "C-_") 'evil-normal-state)
(define-key evil-motion-state-map   (kbd "C-_") 'evil-normal-state)
(define-key evil-window-map         (kbd "C-_") 'evil-normal-state)
(define-key evil-operator-state-map (kbd "C-_") 'evil-normal-state)

(setq evil-want-fine-undo t)
(evil-set-undo-system 'undo-redo)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq create-lockfiles nil)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq vc-follow-symlinks t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
