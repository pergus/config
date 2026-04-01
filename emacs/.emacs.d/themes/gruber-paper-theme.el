;;; gruber-paper-theme.el --- Gruber Paper light theme for Emacs 24+

;; Author: You + Gruber lineage
;; Version: 1.0
;; Package-Requires: ((emacs "24"))
;; URL: https://example.invalid/gruber-paper-theme

;;; Commentary:
;;
;; A light, paper / ebook inspired variant of Gruber.
;; Warm parchment background, dark ink foreground,
;; muted accents, readable mode-line and line highlighting.

;;; Code:

(deftheme gruber-paper
  "Gruber Paper — a warm light theme inspired by Gruber Darker.")

(let (
      ;; Base foreground / background
      (fg        "#3a3a3a")   ;; ink
      (fg-strong "#2e2e2e")
      (fg-soft   "#6f6a5a")

      (bg        "#fbf8f1")   ;; parchment
      (bg-1      "#f7f4ec")
      (bg+1      "#efeada")
      (bg+2      "#e4ddc8")
      (bg+3      "#d8d0b8")
      (bg+4      "#cfc6ad")

      ;; Accents (muted)
      (red       "#c94a4a")
      (red-soft  "#a63a3a")
      (green     "#5f8f3a")
      (yellow    "#997000")
      (brown     "#8b6b3f")
      (blue      "#5f78a8")
      (blue-soft "#8fa1c4")
      (purple    "#7a6fa6")
      (gray      "#9a927a")
      )

  (custom-theme-set-variables
   'gruber-paper
   '(frame-background-mode 'light))

  (custom-theme-set-faces
   'gruber-paper

   ;; Default
   `(default		((t (:foreground ,fg :background ,bg))))
   `(cursor		((t (:background ,brown))))
   `(fringe		((t (:background ,bg :foreground ,bg+3))))
   `(vertical-border	((t (:foreground ,bg+3))))

   ;; Region / selection
   `(region			((t (:background ,bg+2))))
   `(secondary-selection	((t (:background ,bg+3))))

   ;; Current line
   `(highlight				((t (:background ,bg+1))))
   `(highlight-current-line-face	((t (:background ,bg+1))))

   ;; Minibuffer
   `(minibuffer-prompt ((t (:foreground ,fg :weight bold))))

   ;; Links
   `(link		((t (:foreground ,blue :underline t))))
   `(link-visited	((t (:foreground ,purple :underline t))))

   ;; Line numbers
   `(line-number		((t (:foreground ,gray :background ,bg))))
   `(line-number-current-line	((t (:foreground ,fg-strong :background ,bg :weight bold))))

   ;; Mode line
   `(mode-line
     ((t (:background ,bg+2
           :foreground ,fg-strong
           :box (:line-width -1 :color ,bg+4)))))
   `(mode-line-buffer-id
     ((t (:foreground ,fg-strong :weight bold))))
   `(mode-line-inactive
     ((t (:background ,bg-1
           :foreground ,gray
           :box (:line-width -1 :color ,bg+3)))))

   ;; Font lock
   `(font-lock-builtin-face		((t (:foreground ,yellow))))
   `(font-lock-comment-face		((t (:foreground ,fg-soft :slant italic))))
   `(font-lock-comment-delimiter-face	((t (:foreground ,fg-soft))))
   `(font-lock-constant-face		((t (:foreground ,fg))))
   `(font-lock-doc-face			((t (:foreground ,fg :weight bold))))
   `(font-lock-function-name-face	((t (:foreground ,fg))))
   `(font-lock-keyword-face		((t (:foreground ,yellow :weight bold))))
   `(font-lock-string-face		((t (:foreground ,fg-soft :wight bold))))
   `(font-lock-type-face		((t (:foreground ,fg))))
   `(font-lock-variable-name-face	((t (:foreground ,fg))))
   `(font-lock-warning-face		((t (:foreground ,red :weight bold))))

   ;; Search
   `(isearch		((t (:foreground ,fg-strong :background ,bg+3))))
   `(isearch-fail	((t (:foreground ,bg :background ,red))))
   `(lazy-highlight	((t (:background ,bg+2))))

   ;; Whitespace
   `(trailing-whitespace	((t (:background ,red))))
   `(whitespace-space		((t (:foreground ,bg+3))))
   `(whitespace-tab		((t (:foreground ,bg+3))))

   ;; Org mode
   `(org-level-1	((t (:foreground ,fg :weight bold))))
   `(org-level-2	((t (:foreground ,fg))))
   `(org-level-3	((t (:foreground ,fg))))
   `(org-level-4	((t (:foreground ,fg))))
   `(org-todo		((t (:foreground ,red-soft :weight bold))))
   `(org-done		((t (:foreground ,green :weight bold))))
   `(org-block		((t (:background ,bg-1))))
   `(org-code		((t (:foreground ,brown))))
   `(org-verbatim	((t (:foreground ,brown))))

   ;; Show-paren
   `(show-paren-match		((t (:background ,bg+3 :weight bold))))
   `(show-paren-mismatch	((t (:background ,red :foreground ,bg))))

   ;; Tooltip
   `(tooltip	((t (:background ,bg+2 :foreground ,fg))))

   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'gruber-paper)

;;; gruber-paper-theme.el ends here

