(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package all-the-icons)

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "MS notepad: the ultimate editor")
  (setq dashboard-startup-banner "~/.config/emacs/logo.png")
  (setq dashboard-center-content t) ;; Center
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (registers . 3)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
			      (bookmarks . "book"))))

;; Load in emacsclient
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))
(use-package evil-tutor)

(use-package projectile
  :config
  (projectile-global-mode 1))

(use-package doom-modeline)
(doom-modeline-mode 1)

(use-package general
  :config
  (general-evil-setup t))

(use-package doom-themes)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)

(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))







(use-package haskell-mode)
(use-package lua-mode)
(use-package markdown-mode)

(delete-selection-mode t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;; zoom in/out like we do everywhere else.
  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
  (global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
  (global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

  (nvmap :keymaps 'override :prefix "SPC"
	 "SPC"   '(counsel-M-x :which-key "M-x")
	 "c c"   '(compile :which-key "Compile")
	 "c C"   '(recompile :which-key "Recompile")
	 "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
	 "t t"   '(toggle-truncate-lines :which-key "Toggle truncate lines"))
  (nvmap :keymaps 'override :prefix "SPC"
	 "m *"   '(org-ctrl-c-star :which-key "Org-ctrl-c-star")
	 "m +"   '(org-ctrl-c-minus :which-key "Org-ctrl-c-minus")
	 "m ."   '(counsel-org-goto :which-key "Counsel org goto")
	 "m e"   '(org-export-dispatch :which-key "Org export dispatch")
	 "m f"   '(org-footnote-new :which-key "Org footnote new")
	 "m h"   '(org-toggle-heading :which-key "Org toggle heading")
	 "m i"   '(org-toggle-item :which-key "Org toggle item")
	 "m n"   '(org-store-link :which-key "Org store link")
	 "m o"   '(org-set-property :which-key "Org set property")
	 "m t"   '(org-todo :which-key "Org todo")
	 "m x"   '(org-toggle-checkbox :which-key "Org toggle checkbox")
	 "m B"   '(org-babel-tangle :which-key "Org babel tangle")
	 "m I"   '(org-toggle-inline-images :which-key "Org toggle inline imager")
	 "m T"   '(org-todo-list :which-key "Org todo list")
	 "o a"   '(org-agenda :which-key "Org agenda")
	 )
  (set-face-attribute 'default nil
    :font "Inconsolata"
    :height 110
    :weight 'medium)
  (set-face-attribute 'variable-pitch nil
    :font "Iosevka"
    :height 120
    :weight 'medium)
  (set-face-attribute 'fixed-pitch nil
    :font "Inconsolata"
    :height 110
    :weight 'medium)
  ;; Makes commented text and keywords italics.
  ;; This is working in emacsclient but not emacs.
  ;; Your font must have an italic face available.
  (set-face-attribute 'font-lock-comment-face nil
    :slant 'italic)
  (set-face-attribute 'font-lock-keyword-face nil
    :slant 'italic)

  ;; Uncomment the following line if line spacing needs adjusting.
  (setq-default line-spacing 0.12)

  ;; Needed if using emacsclient. Otherwise, your fonts will be smaller than expected.
  (add-to-list 'default-frame-alist '(font . "Inconsolata-17"))
  ;; changes certain keywords to symbols, such as lamda!
  (setq global-prettify-symbols-mode t)
  (nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
	 "."     '(find-file :which-key "Find file")
	 "f f"   '(find-file :which-key "Find file")
	 "f r"   '(counsel-recentf :which-key "Recent files")
	 "f s"   '(save-buffer :which-key "Save file")
	 "f u"   '(sudo-edit-find-file :which-key "Sudo find file")
	 "f y"   '(dt/show-and-copy-buffer-path :which-key "Yank file path")
	 "f C"   '(copy-file :which-key "Copy file")
	 "f D"   '(delete-file :which-key "Delete file")
	 "f R"   '(rename-file :which-key "Rename file")
	 "f S"   '(write-file :which-key "Save file as...")
	 "f U"   '(sudo-edit :which-key "Sudo edit file"))
  (global-set-key (kbd "C-c") 'keyboard-quit)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "C-c") 'evil-normal-state)
