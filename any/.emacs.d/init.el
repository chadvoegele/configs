(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

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
)
(evil-define-key '(normal visual insert) 'global
  (kbd "C-s") (lambda () (interactive) (evil-force-normal-state) (save-buffer))
  (kbd "C-q") (lambda () (interactive) (save-buffers-kill-terminal))
)
(define-key evil-insert-state-map   (kbd "C-_") 'evil-force-normal-state)
(define-key evil-normal-state-map   (kbd "C-_") 'evil-force-normal-state)
(define-key evil-motion-state-map   (kbd "C-_") 'evil-force-normal-state)
(define-key evil-window-map         (kbd "C-_") 'evil-force-normal-state)
(define-key evil-operator-state-map (kbd "C-_") 'evil-force-normal-state)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
