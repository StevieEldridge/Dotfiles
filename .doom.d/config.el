;; place your private configuration here! remember, you do not need to run 'doom sync' after modifying this file!

;; some functionality uses this to identify you, e.g. gpg configuration, email
;; clients, file templates and snippets. it is optional.
(setq user-full-name "Steven Eldridge"
      user-mail-address "steven.eldridge@wwinc.com")

;; doom exposes five (optional) variables for controlling fonts in doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; see 'c-h v doom-font' for documentation and more examples of what they
;; accept. for example:
;;
;;(setq doom-font (font-spec :family "fira code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "fira sans" :size 13))
;;
;; if you or emacs can't find your font, use 'm-x describe-font' to look them
;; up, `m-x eval-region' to execute elisp code, and 'm-x doom/reload-font' to
;; refresh your font settings. if emacs still can't find your font, it likely
;; wasn't installed correctly. font issues are rarely doom issues!

;; there are two ways to load a theme. both assume the theme is installed and
;; available. you can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. this is the default:
(setq doom-theme 'doom-gruvbox)

;; this determines the style of line numbers in effect. if set to `nil', line
;; numbers are disabled. for relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; if you use `org' and don't want your org files in the default location below,
;; change `org-directory'. it must be set before org loads!
;;(setq org-directory "~/org/")


;; ----------------------------------------
;; Evil Mode Keybindings
;; ----------------------------------------

(define-key evil-insert-state-map "jj" 'evil-normal-state)

;; Quick page and buffer navigation
(define-key evil-normal-state-map "J" 'evil-scroll-down)
(define-key evil-normal-state-map "K" 'evil-scroll-up)
(define-key evil-normal-state-map "H" 'evil-prev-buffer)
(define-key evil-normal-state-map "L" 'evil-next-buffer)

;; Quick window navigation
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

;; Resizing Windows
(define-key evil-normal-state-map (kbd "C-<up>")    'evil-window-increase-height)
(define-key evil-normal-state-map (kbd "C-<down>")  'evil-window-decrease-height)
(define-key evil-normal-state-map (kbd "C-<right>") 'evil-window-increase-width)
(define-key evil-normal-state-map (kbd "C-<left>")  'evil-window-decrease-width)


;; ----------------------------------------
;; Org Mode
;; ----------------------------------------

(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files (directory-files-recursively "~/Documents/org/agenda/" "\\.org$"))
  (setq org-log-done 'time)
)

;; Sets up org auto tangle
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t)
)


;; ----------------------------------------
;; Other Settings From Me
;; ----------------------------------------

;; Customizes the Centaur Tabs
(setq centaur-tabs-set-close-button nil)
(setq centaur-tabs-height 32)
(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)


;; ----------------------------------------
;; Other
;; ----------------------------------------

;; whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise doom's defaults may override your settings. e.g.
;;
;;   (after! package
;;     (setq x y))
;;
;; the exceptions to this rule:
;;
;;   - setting file/directory variables (like `org-directory')
;;   - setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'c-h v variable' to look up their documentation).
;;   - setting doom variables (which start with 'doom-' or '+').
;;
;; here are some additional functions/macros that will help you configure doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; to get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'k' (non-evil users must press 'c-c c k').
;; this will open documentation for it, including demos of how they are used.
;; alternatively, use `c-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; you can also try 'gd' (or 'c-c c d') to jump to their definition and see how
;; they are implemented.

;;(defun window-half-height ()
;;     (max 1 (/ (1- (window-height (selected-window))) 2)))
;;
