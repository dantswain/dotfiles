;;; init.el -- my emacs config
;;; Commentary:
;;; FlyCheck bitches if this is not here.

;;; Code:

;; cask/pallet for package management
(require 'cask
      (if (eq system-type 'darwin)
       "/usr/local/share/emacs/site-lisp/cask/cask.el"
       "~/.cask/cask.el"))
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; where I keep my packages
(add-to-list 'load-path "~/.emacs.d/packages/")

;; set the default font face to Monaco 11pt, which is what
;;  pretty much everything else on my Mac uses
(if (display-graphic-p)
    (set-face-attribute 'default nil :font "Monaco-11"))

;; disable the menu bar (in terminal mode)
(menu-bar-mode -1)

;; enable use of emacsclient
(load "server")
(unless (server-running-p) (server-start))

;; Use the ir-black theme for Emacs24
;;   https://github.com/jmdeldin/ir-black-theme.el
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'ir-black t)
;; the 't' keeps emacs from continually asking
;; permission to load the theme
;;(load-theme 'solarized-light t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(customize-set-variable 'frame-background-mode 'dark)
(load-theme 'solarized t)

;; don't launch the startup screen
(setq inhibit-startup-buffer-menu t)
(setq inhibit-startup-screen t)

;; never use tabs
(setq-default indent-tabs-mode nil)

;; indent on enter
(define-key global-map (kbd "RET") 'newline-and-indent)

;; yell at me if i go past 80 columns
(require 'column-enforce-mode)
(global-column-enforce-mode t)

;; automatic paren/bracket closure
(electric-pair-mode)

;; markdown mode
;;   http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ruby mode
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; groovy mode for Jenkinsfile
(add-to-list 'auto-mode-alist
             '("\\Jenkinsfile\\'" . groovy-mode))

;; octave mode
;; (overrides ObjC mode for .m files)
(autoload 'octave-mode "octave-mode" "Major mode for editing Octave/Matlab files" t)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; git-gutter
;;   https://github.com/syohex/emacs-git-gutter
(require 'git-gutter)
(global-git-gutter-mode t)

;; package setup
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("elpa" . "http://tromey.com/elpa/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; xclip
(require 'xclip)
(xclip-mode)

;; ESS (R)
(require 'ess-site)

;; don't indent c++ namespaces
;; http://stackoverflow.com/questions/13825188/suppress-c-namespace-indentation-in-emacs
(defconst my-cc-style
    '("stroustrup"
          (c-offsets-alist . ((innamespace . [0])))))

(c-add-style "my-cc-mode" my-cc-style)
(setq c-default-style "my-cc-mode" c-basic-offset 4)

;; c++ stuff (THANKS JR)
(add-hook 'c++-mode-hook
          '(lambda ()
             (setq c-set-style "my-cc-mode" c-basic-offset 4)))

(add-hook
 'c++-mode-hook
 '(lambda()
    ;; We could place some regexes into `c-mode-common-hook', but note that their evaluation order
    ;; matters.
    (font-lock-add-keywords
     nil '(;; complete some fundamental keywords
           ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
           ;; namespace names and tags - these are rendered as constants by cc-mode
           ("\\<\\(\\w+::\\)" . font-lock-function-name-face)
           ;;  new C++11 keywords
           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
           ("\\<\\(char16_t\\|char32_t\\)\\>" . font-lock-keyword-face)
           ;; PREPROCESSOR_CONSTANT, PREPROCESSORCONSTANT
           ("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
           ("\\<[A-Z]\\{3,\\}\\>"  . font-lock-constant-face)
           ;; hexadecimal numbers
           ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
           ;; integer/float/scientific numbers
           ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
           ;; c++11 string literals
           ;;       L"wide string"
           ;;       L"wide string with UNICODE codepoint: \u2018"
           ;;       u8"UTF-8 string", u"UTF-16 string", U"UTF-32 string"
           ("\\<\\([LuU8]+\\)\".*?\"" 1 font-lock-keyword-face)
           ;;       R"(user-defined literal)"
           ;;       R"( a "quot'd" string )"
           ;;       R"delimiter(The String Data" )delimiter"
           ;;       R"delimiter((a-z))delimiter" is equivalent to "(a-z)"
           ("\\(\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\)" 1 font-lock-keyword-face t) ; start delimiter
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\(.*?\\))[^\\s-\\\\()]\\{0,16\\}\"" 1 font-lock-string-face t)  ; actual string
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(.*?\\()[^\\s-\\\\()]\\{0,16\\}\"\\)" 1 font-lock-keyword-face t) ; end delimiter

           ;; user-defined types (rather project-specific)
           ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(type\\|ptr\\)\\>" . font-lock-type-face)
           ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
           ))
    ) t)

;; evil
(require 'evil)
(evil-mode 1)

;; textmate mode
(require 'textmate)
(textmate-mode 1)

;; erlang indentation
(require 'erlang)
(setq erlang-indent-level 2)
(add-hook 'erlang-mode-hook 'rainbow-delimiters-mode)

;; yas
(require 'yasnippet)

;; elixir
(require 'elixir-mode)
(add-hook 'elixir-mode-hook 'yas-minor-mode)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'erlang-mode)
(auto-complete-mode)

;; javascript indentation
(setq js-indent-level 2)

;; scroll one line at a time (less "jumpy" than defaults)
;;     http://www.emacswiki.org/emacs/SmoothScrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; cmake mode
(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/cmake-20110824/") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; shut up, magit
(setq magit-last-seen-setup-instructions "1.4.0")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(flycheck-indication-mode (quote left-fringe))
 '(magit-diff-options nil)
 '(package-selected-packages
   (quote
    (yasnippet yaml-mode xclip web-mode thrift textmate solarized-theme scala-mode sass-mode rvm rubocop rainbow-delimiters protobuf-mode projectile php-mode pallet markdown-mode magit linum-relative ir-black-theme highlight-indentation highlight-chars haskell-mode handlebars-mode groovy-mode git-gutter flycheck flx-ido evil ess erlang elixir-mix dockerfile-mode column-enforce-mode color-theme cmake-mode clojure-mode auto-complete alchemist ag)))
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (flycheck-erlang-executable . "erlc -Ilib"))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :foreground "magenta"))))
 '(font-lock-comment-face ((t (:foreground "magenta")))))

;; projectile
(projectile-global-mode)

;; enable flyckeck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; key bindings for magit
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g p") 'magit-push)

;; increment number at cursor
;;   http://www.emacswiki.org/emacs/IncrementNumber
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(global-set-key (kbd "C-c +") 'my-increment-number-decimal)

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

(provide 'init)
;;; init.el ends here

