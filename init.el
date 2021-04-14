;;
;;
;; initial-package-settings
;;
;;

(eval-when-compile (require 'cl))

(require 'package) ;; You might already have this line

;;(add-to-list 'package-archives
;;    	     ("gnu" . "https://elpa.gnu.org/packages/"))
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives
;;             '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(when (< emacs-major-version 24)S
  ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(when (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
     )
(package-initialize)

;;install if not installed
(defvar my-package-list
  '(
    ;; ここに使っているパッケージを書く。
    anzu
    all-the-icons
    auto-async-byte-compile
    auto-complete
    bash-completion
    company
    counsel
    cperl-mode
    direx
    dumb-jump
    elpy
    exec-path-from-shell
    flycheck
    helm
    helm-ag
    helm-descbinds
    helm-ls-git
    ivy
    js2-mode
    magit
    material-theme
    multiple-cursors
    markdown-mode
    neotree
    recentf
    recentf-ext 
    ruby-mode
    swiper
    use-package
    yasnippet
    irony
    company-irony
    rainbow-delimiters
    google-c-style
    ))

(let ((not-installed
       (loop for package in my-package-list
             when (not (package-installed-p package))
             collect package)))
  (when not-installed
    (package-refresh-contents)
    (dolist (package not-installed)
      (package-install package))))

;;
;;
;; initial-settings
;;
;;

;; utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;;; yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; delete-backward-char
(global-set-key "\C-h" 'delete-backward-char)
;; Enable C-h on minibuffer
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; goto-line
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-xL" 'goto-line)

;; delete *scratch* message
(setq initial-scratch-message 'nil)

;; avoid "Symbolic link to SVN-controlled source file; follow link? (yes or no)"
(setq vc-follow-symlinks t)

(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)

;; メニューバーを消す
(menu-bar-mode -1)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

(defun removes-gui-elements ()
  "Remove the menu bar, tool bar and scroll bars."
  ;; removes the GUI elements
  (when (and (fboundp 'scroll-bar-mode) (not (eq scroll-bar-mode -1)))
    (scroll-bar-mode -1))
  (when (and (fboundp 'tool-bar-mode) (not (eq tool-bar-mode -1)))
    (tool-bar-mode -1))
  ;; tooltips in echo-aera
  (when (and (fboundp 'tooltip-mode) (not (eq tooltip-mode -1)))
    (tooltip-mode -1)))
(removes-gui-elements)

;; disable highlight current line
(global-hl-line-mode -1)

;; truncate lines
(setq-default truncate-lines t)

;; ロックファイル / バックアップファイルを作成しない
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)

;; 対応するカッコを強調表示
(show-paren-mode t)
(set-face-background 'show-paren-match nil)
(set-face-attribute 'show-paren-match nil
                    :inherit 'highlight)

;; 時間も表示させる。
;;(display-time)

;; 行番号を常に表示させる
(global-linum-mode)
(setq linum-format "%4d ")

;; スクロールは1行ごとに
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;; シフト＋矢印で範囲選択
(setq pc-select-selection-keys-only t)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

;; 画面の移動をalt+矢印キーで行く
(global-set-key (kbd "<M-left>")  'windmove-left)
(global-set-key (kbd "<M-down>")  'windmove-down)
(global-set-key (kbd "<M-up>")    'windmove-up)
(global-set-key (kbd "<M-right>") 'windmove-right)

;;矩形選択の先頭に文字列を挿入
(global-set-key (kbd "C-x a") 'string-rectangle)

;;
;;
;; package-settings
;;
;;
(require 'use-package)

;;
;; 自動でかかれる
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(smart-jump material-theme better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;
;; テーマとフォント設定
;;
(load-theme 'material t)
(set-face-attribute 'default (selected-frame) :height 130)


;;
;; rainbow-delimiters
;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)


;; 
;; undo-tree
;;
(require 'undo-tree)
;; undo-tree を起動時に有効にする
(global-undo-tree-mode t)
;; M-/ をredo に設定する。
(global-set-key (kbd "M-/") 'undo-tree-redo)


;;
;; minimap 
;; なんかみつからない
;;(require 'minimap)


;;
;; bash-completion
;;
(require 'bash-completion)
(bash-completion-setup)


;;
;; anzu
;;
(global-anzu-mode +1)

;; 
;; yasnippet
;; 
(require 'yasnippet)
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(setq yas-snippet-dirs
    '("~/.emacs.d/yasnippets" ;; お好みで!!
    "~/.emacs.d/mysnippets"))
(yas-global-mode 1)


;;
;; company
;;
;;(with-eval-after-load 'company)
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-<tab>") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-<tab>") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key company-active-map (kbd "C-h") nil)

;; yasnippetとの連携
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))


;;
;; ivy設定
;;
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 30) ;; minibufferのサイズを拡大！（重要）
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))


;;
;; counsel設定
;;
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file) ;; find-fileもcounsel任せ！
(setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
(global-set-key (kbd "s-f") 'counsel-rg) ;; counsel-rg


;;
;; swiper設定
;;
(global-set-key "\C-s" 'swiper)
(setq swiper-include-line-number-in-search t) ;; line-numberでも検索可能
;; ;; migemo + swiper（日本語をローマ字検索できるようになる）
;; (require 'avy-migemo)
;; (avy-migemo-mode 1)
;; (require 'avy-migemo-e.g.swiper)


;;
;; recentf
;;
;; 余分なメッセージを削除しておきましょう
(defmacro with-suppressed-message (&rest body)
  "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
  (declare (indent 0))
  (let ((message-log-max nil))
    `(with-temp-message (or (current-message) "") ,@body)))

(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 200)             ;; recentf に保存するファイルの数
(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
(setq recentf-auto-cleanup 'never)             ;; 保存する内容を整理
(run-with-idle-timer 30 t '(lambda () (with-suppressed-message (recentf-save-list))))
(require 'recentf-ext) ;; ちょっとした拡張

(define-key global-map [(super r)] 'counsel-recentf) ;; counselにおまかせ！


;;
;; dumb-jump
;;
;; (setq dumb-jump-mode t)
;; (setq dumb-jump-selector 'ivy) ;; 候補選択をivyに任せます
;; (setq dumb-jump-use-visible-window nil)
;; (define-key global-map [(super d)] 'dumb-jump-go) ;; go-to-definition!
;; (define-key global-map [(super shift d)] 'dumb-jump-back)


;;
;; smart-jump
;;
(use-package smart-jump
 :ensure t
 :config
 (smart-jump-setup-default-registers))
;; お好みでどうぞ
(define-key global-map [(super d)] 'smart-jump-go)
(define-key global-map [(super shift d)] 'dumb-jump-back)


;;
;; mode設定
;;
(add-to-list 'auto-mode-alist '("\\.urdf" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xacro" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.launch" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.*rc" . sh-mode))


;;
;; elpy
;;
(elpy-enable)
;; use flycheck
(when (require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  (add-hook 'elpy-mode-hook 'flycheck-mode))






;;
;; irony
;;
(use-package irony
  :defer t
  :commands irony-mode
  :init
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  :config
  ;; C言語用にコンパイルオプションを設定する.
  (add-hook 'c-mode-hook
            '(lambda ()
               (setq irony-additional-clang-options '("-std=c11" "-Wall" "-Wextra"))))
  ;; C++言語用にコンパイルオプションを設定する.
  (add-hook 'c++-mode-hook
            '(lambda ()
               (setq irony-additional-clang-options '("-std=c++11" "-Wall" "-Wextra"))))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  ;; Windows環境でパフォーマンスを落とす要因を回避.
  (when (boundp 'w32-pipe-read-delay)
    (setq w32-pipe-read-delay 0))
  ;; バッファサイズ設定(default:4KB -> 64KB)
  (when (boundp 'w32-pipe-buffer-size)
    (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
  )

(use-package company-irony
  :defer t
  :config
  ;; companyの補完のバックエンドにironyを使用する.
  (add-to-list 'company-backends '(company-irony-c-headers company-irony))
  )
(require 'cc-mode)
;; c-modeやc++-modeなどcc-modeベースのモード共通の設定
(add-hook
 'c-mode-common-hook
 (lambda ()
   ;; k&rスタイルをベースにする
   (c-set-style "k&r")
   ;; スペースでインデントをする
   (setq indent-tabs-mode nil)
   ;; インデント幅を2にする
   (setq c-basic-offset 2)
   ;; 自動改行（auto-new-line）と
   ;; 連続する空白の一括削除（hungry-delete）を
   ;; 有効にする
   (c-toggle-auto-hungry-state 1)
   ;; CamelCaseの語でも単語単位に分解して編集する
   ;; GtkWindow         => Gtk Window
   ;; EmacsFrameClass   => Emacs Frame Class
   ;; NSGraphicsContext => NS Graphics Context
   (subword-mode 1)
   ))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

(require 'google-c-style)
(defun cc-mode-init ()
  (google-set-c-style)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4)
  (c-set-offset 'case-label 0)
)


;;
;; 
;; ROS設定
;;
;;

;;
;; rosemacs
;;
(add-to-list 'load-path "/opt/ros/melodic/share/emacs/site-lisp")
;; or whatever your install space is + "/share/emacs/site-lisp"
(require 'rosemacs-config)

;;
;; euslime
;;
(add-to-list 'load-path "/opt/ros/melodic/share/euslime")
(require 'euslime-config)
(setq inferior-euslisp-program "roseus")
(slime-setup '(slime-fancy slime-banner slime-repl-ansi-color))

