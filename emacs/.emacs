;;------------------------------------------------------------------------------
;; Emacs Configuration File
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;; Package Management
;;------------------------------------------------------------------------------

(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;;------------------------------------------------------------------------------
;; UI Settings
;;------------------------------------------------------------------------------

;; Strip menu, toolbar & scroll-bar
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 1)

;; Disable startup splash screen and scratch message
(setq inhibit-startup-screen t)


;; Line & column numbers
(line-number-mode 1)
(column-number-mode t)

;; No flashing, no beeping
(setq ring-bell-function 'ignore)

;; Cursor settings
(blink-cursor-mode 0)

;; Set default font size
(set-face-attribute 'default nil :height 180)

;; Set initial frame size (columns x rows)
(setq initial-frame-alist
      '((width . 85)
        (height . 50)))


;;------------------------------------------------------------------------------
;; Editing Behavior
;;------------------------------------------------------------------------------

;; Enable narrowing
(put 'narrow-to-region 'disabled nil)

;; Change yes/no prompts to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Insert newline above cursor
(defun insert-newline-above ()
  "Insert a newline above the line of the cursor."
  (interactive)
  (move-beginning-of-line 1)
  (newline)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key (kbd "C-o") 'insert-newline-above)


;;------------------------------------------------------------------------------
;; Window Management
;;------------------------------------------------------------------------------

(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)


;;------------------------------------------------------------------------------
;; Zoom / Font Scaling
;;------------------------------------------------------------------------------

(global-set-key (kbd "M-+")            'text-scale-increase)
(global-set-key (kbd "M--")            'text-scale-decrease)
(global-set-key (kbd "<M-wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "<M-wheel-up>")   'text-scale-increase)


;;------------------------------------------------------------------------------
;; Apple Keyboard / Clipboard
;;------------------------------------------------------------------------------

(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

(global-set-key (kbd "M-c")      'kill-ring-save)     ;; ⌘-c = Copy
(global-set-key (kbd "M-v")      'yank)               ;; ⌘-v = Past
(global-set-key (kbd "M-a")      'mark-whole-buffer)  ;; ⌘-a = Select al
(global-set-key (kbd "M-z")      'undo)               ;; ⌘-z = Und
(global-set-key (kbd "<escape>") 'keyboard-quit)      ;; Make ESC act like C-g


;;------------------------------------------------------------------------------
;; Multiple cursors with VSCode-style keybindings
;;------------------------------------------------------------------------------

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-d" .     mc/mark-next-word-like-this) ;; Ctrl+D: add next occurrence
   ("C-S-d" .   mc/mark-previous-like-this)  ;; Ctrl+Shift-D add prev occurance
   ("C-S-l" .   mc/mark-all-like-this)       ;; Ctrl+Shift+L mark all occurrences
   ("C-c m e" . mc/edit-lines))              ;; edit lines in region
  :config
  ;; Add cursors above/below like VSCode with Cmd+Up/Cmd+Down
  (global-set-key (kbd "s-<up>")   'mc/mark-previous-line)
  (global-set-key (kbd "s-<down>") 'mc/mark-next-line)
  (setq mc/list-file "~/.emacs.d/.mc-lists.el"))


;;------------------------------------------------------------------------------
;; Theme & Appearance
;;------------------------------------------------------------------------------

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'gruber-paper t)

;; Store custom-set variables in a separate file
(setq custom-file "~/.emacs.d/custom/custom.el")
(load custom-file)


;;------------------------------------------------------------------------------
;; Packages
;;------------------------------------------------------------------------------

;; Move text
(use-package move-text
  :bind
  (("C-S-<up>"   . move-text-up)
   ("C-S-<down>" . move-text-down)))


;; Mode Line: Minions
(use-package minions
  :ensure t
  :custom
  (mode-line-modes-delimiters nil)
  (minions-mode-line-lighter " …")
  :config
  (minions-mode +1)
  (force-mode-line-update t))


;; Moody Mode Line
(use-package moody
  :ensure t
  :config
  (setq-default mode-line-format
                '(""
                  mode-line-front-space
                  mode-line-client
                  mode-line-frame-identification
                  mode-line-buffer-identification
                  " "
                  mode-line-position
                  (vc-mode vc-mode)
                  (multiple-cursors-mode mc/mode-line)
                  mode-line-modes
                  mode-line-end-spaces))
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))


;; Helm
(use-package helm
  :ensure t
  :init (helm-mode 1)
  :config
  (setq helm-split-window-in-side-p t)
  :bind (("C-x b"   . helm-buffers-list)
         ("M-y"     . helm-show-kill-ring)
         ("C-x C-f" . helm-find-files))
  :bind (:map helm-map ("<tab>" . helm-execute-persistent-action)))


;; Expand Region
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))


;;------------------------------------------------------------------------------
;; Eshell
;;------------------------------------------------------------------------------

;; Prompt
(setq eshell-prompt-function
      (lambda () (concat (eshell/pwd) "\n$ ")))

(setq eshell-prompt-regexp (concat "^" (regexp-quote "$")))

;; Clear eshell
(require 'eshell)
(defun eshell/clearit (&optional scrollback)
 "Clear eshell"
 (let ((inhibit-read-only t))
   (erase-buffer)))


;; -----------------------------------------------------------------------------
;; C Programming
;; -----------------------------------------------------------------------------

;; Importing simpc-mode
(add-to-list 'load-path "~/.emacs.d/simple-c-mode/")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))


;; -----------------------------------------------------------------------------
;; Faces
;; -----------------------------------------------------------------------------

;; Use list-faces-display to list all horrible colors


;; Eshell
(custom-set-faces
 ;; Eshell prompt
 '(eshell-prompt      ((t (:foreground "#3a3a3a" :weight bold))))
 '(eshell-prompt-exec ((t (:foreground "#997000" :weight bold))))
 
 ;; Files and directories
 '(eshell-ls-directory  ((t (:foreground "#3a3a3a" :weight bold))))
 '(eshell-ls-executable ((t (:foreground "#708238" :weight bold))))
 '(eshell-ls-symlink    ((t (:foreground "#708238"))))
 '(eshell-ls-archive    ((t (:foreground "#997000"))))
 '(eshell-ls-backup     ((t (:foreground "#b0a090"))))
 '(eshell-ls-clutter    ((t (:foreground "#a09080"))))
 '(eshell-ls-missing    ((t (:foreground "#c73c3f"))))
 '(eshell-ls-special    ((t (:foreground "#708238"))))
 '(eshell-ls-readonly   ((t (:foreground "#3a3a3a" :weight bold))))
 '(eshell-ls-unreadable ((t (:foreground "#c73c3f"))))

 ;; ANSI-style colors
 '(term-color-black   ((t (:foreground "#3a3a3a" :background "#fbf8f1"))))
 '(term-color-red     ((t (:foreground "#c73c3f"))))
 '(term-color-green   ((t (:foreground "#708238"))))
 '(term-color-yellow  ((t (:foreground "#997000"))))
 '(term-color-blue    ((t (:foreground "#6b8e23"))))
 '(term-color-magenta ((t (:foreground "#8a7cae"))))
 '(term-color-cyan    ((t (:foreground "#7c9b9b"))))
 '(term-color-white   ((t (:foreground "#3a3a3a"))))
)


;; Dired
(custom-set-faces
 '(dired-regular    ((t (:foreground "#3a3a3a" :background nil))))
 '(dired-directory  ((t (:foreground "#3a3a3a" :background nil :weight bold))))
 '(dired-executable ((t (:foreground "#3a3a3a" :background nil))))
 '(dired-symlink    ((t (:foreground "#3a3a3a" :background nil))))
 '(dired-ignored    ((t (:foreground "#3a3a3a" :background nil))))
 '(dired-mark       ((t (:foreground "#3a3a3a" :background "#e4ddc8" :weight bold))))
 '(dired-marked     ((t (:foreground "#3a3a3a" :background "#e4ddc8" :weight bold))))
 '(dired-header     ((t (:foreground "#3a3a3a" :background "#f7f4ec" :weight bold))))
 '(dired-warning    ((t (:foreground "#3a3a3a" :background nil :weight normal))))
 '(dired-ignored    ((t (:foreground "#3a3a3a" :background nil :weight normal))))
 '(dired-warning    ((t (:foreground "#3a3a3a" :background nil :weight normal))))
 '(dired-flagged    ((t (:foreground "#3a3a3a" :background nil :weight normal))))

 )


;; Helm
(custom-set-faces
 '(helm-ff-file            ((t (:foreground "#3a3a3a" :background nil))))
 '(helm-ff-file-extension  ((t (:foreground "#3a3a3a" :background nil))))
 '(helm-ff-directory       ((t (:foreground "#3a3a3a" :background nil :weight bold))))
 '(helm-ff-executable      ((t (:foreground "#3a3a3a" :background nil))))
 '(helm-ff-symlink         ((t (:foreground "#3a3a3a" :background nil))))
 '(helm-ff-invalid-symlink ((t (:foreground "#3a3a3a" :background "#f4ede0"))))
 '(helm-selection          ((t (:background "#e4ddc8" :foreground nil))))
 '(helm-selection-line     ((t (:background "#e4ddc8" ))))
 '(helm-match              ((t (:foreground "#5f78a8" :weight bold))))
 '(helm-moccur-match       ((t (:foreground "#5f78a8" :weight bold))))
 '(helm-visible-mark       ((t (:foreground "#3a3a3a" :background "#e4ddc8" :weight bold))))
 '(helm-source-header      ((t (:foreground "#3a3a3a" :background "#f7f4ec" :weight bold))))
 '(helm-header             ((t (:foreground "#3a3a3a" :background "#f7f4ec"))))
 '(helm-separator          ((t (:foreground "#3a3a3a" :background nil))))
 '(helm-candidate-number   ((t (:foreground "#3a3a3a" :background "#efeada" :weight bold))))
 )


