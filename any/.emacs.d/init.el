;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(unless (package-installed-p 'helm)
  (package-install 'helm))
(require 'helm)

(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))
(require 'flycheck)

(unless (package-installed-p 'ledger-mode)
  (package-install 'ledger-mode))
(require 'ledger-mode)

(unless (package-installed-p 'anti-zenburn-theme)
  (package-install 'anti-zenburn-theme))
(load-theme 'anti-zenburn t)

(unless (package-installed-p 'powerline)
  (package-install 'powerline))
(require 'powerline)
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
