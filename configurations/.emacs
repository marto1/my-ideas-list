(setq display-time-world-list '(("America/Los_Angeles" "San Francisco")
			       ("America/New_York" "New York")
			       ("Europe/London" "London")
			       ("Asia/Tokyo" "Tokyo")
			       ("Asia/Hong_Kong" "Hong Kong")))
(setq display-time-24hr-format 1)
(setq user-mail-address "example@example.com")
(tool-bar-mode 0)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(desktop-save-mode 1)
(set-face-attribute 'vertical-border
		    nil
		    :foreground "#282a2e")
(setq x-select-enable-clipboard t)
(setq backup-directory-alist `(("." . "~/.saves")))

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
(add-to-list 'load-path "~/.emacs.d/slime")
(add-to-list 'load-path "~/.emacs.d/ezbl")



(setq c-basic-offset 4)                  ;; Default is 2
(setq c-indent-level 4)                  ;; Default is 2

(defun python-check-current ()
  (interactive)
  (python-check (concat python-check-command " " (buffer-file-name))))


(global-set-key (kbd "C-c C-e")
		'python-check-current)

;; Wrap with chars
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)

(require 'auto-complete)

(dolist (m '(c-mode c++-mode java-mode))
  (add-to-list 'ac-modes m))

(global-auto-complete-mode t)

(delete-selection-mode t)

(require 'column-marker)
(add-hook 'python-mode (lambda () (interactive) (column-marker-1 80)))


(ido-mode t)


(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;;; Shut up compile saves
(setq compilation-ask-about-save nil)
;;; Don't save *anything*
(setq compilation-save-buffers-predicate '(lambda () nil))

(require 'popup)
(require 'pos-tip)
(require 'popup-kill-ring)
(global-set-key "\M-y" 'popup-kill-ring)

(require 'iedit)

;; JSON and JavaScript mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(global-set-key "\M-W" 'yas-insert-snippet)


;; ;; hy mode - sadly didn't not work :(
;; (add-to-list 'load-path "~/.emacs.d/hy-mode")
;; (require 'hy-mode)

(display-time)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (atom-dark)))
 '(custom-safe-themes (quote ("4ba6aa8a2776688ef7fbf3eb2b5addfd86d6e8516a701e69720b705d0fbe7f08" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" default)))
 '(hy-mode-inferior-lisp-command "hy" t)
 '(package-archives (quote (("melpa" . "http://melpa.milkbox.net/packages/") ("melpa-stable" . "https://stable.melpa.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(py-pychecker-command "pychecker.sh")
 '(py-pychecker-command-args (quote ("")))
 '(python-check-command "pychecker.sh")
 '(safe-local-variable-values (quote ((test-case-name . twisted\.test\.test_tcp) (test-case-name . twisted\.test\.test_udp)))))

;; ;; ;; Real lisp mode 
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(require 'slime-autoloads)
(slime-setup)

(setq hy-mode-inferior-lisp-command "hy --spy")

(require 'ezbl)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 (defadvice python-send-region (around advice-python-send-region-goto-end)
      "Fix a little bug if the point is not at the prompt when you do
    C-c C-[rc]"
      (let ((oldpoint (with-current-buffer (process-buffer (python-proc)) (point)))
    	(oldinput
    	 (with-current-buffer (process-buffer (python-proc))
    	   (goto-char (point-max))
    	   ;; Do C-c C-u, but without modifying the kill ring:
    	   (let ((pmark (process-mark (get-buffer-process (current-buffer)))))
    	     (when (> (point) (marker-position pmark))
    	       (let ((ret (buffer-substring pmark (point))))
    		 (delete-region pmark (point))
    		 ret))))))
        ad-do-it
        (with-current-buffer (process-buffer (python-proc))
          (when oldinput (insert oldinput))
          (goto-char oldpoint))))
    (ad-enable-advice 'python-send-region 'around 'advice-python-send-region-goto-end)
    (ad-activate 'python-send-region)


(require 'sws-mode)
(require 'jade-mode)
(require 'electric-spacing)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'javascript-mode-hook 'javascript-custom-setup)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))

(require 'moz-controller)

(defconst my-lisp-dir
  (cond
   ((equal system-type 'gnu/linux) "/usr/share/emacs/site-lisp/")
   ((equal system-type 'darwin) (concat "/usr/local/Cellar/emacs/" (number-to-string emacs-major-version) "." (number-to-string emacs-minor-version) "/share/emacs/site-lisp/"))
   (t (concat "/usr/local/emacs/site-lisp/"))))

(add-to-list 'load-path (concat my-lisp-dir "w3m"))

(require 'w3m-load)
(require 'w3m) 

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq w3m-use-cookies t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)


(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'eshell-preoutput-filter-functions
           'ansi-color-filter-apply)


(require 'multi-term)
(setq multi-term-program "/bin/bash")
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))

(setq shr-external-browser "firefox")


(defun randomize-region (beg end)
  "Randomize lines in region from BEG to END."
  (interactive "*r")
  (let ((lines (split-string
		(delete-and-extract-region beg end) "\n")))
    (when (string-equal "" (car (last lines 1)))
      (setq lines (butlast lines 1)))
    (apply 'insert
	   (mapcar 'cdr
		   (sort (mapcar (lambda (x) (cons (random) (concat x "\n"))) lines)
			 (lambda (a b) (< (car a) (car b))))))))

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
		 ((not prefix) "%d.%m.%Y")
		 ((equal prefix '(4)) "%Y-%m-%d")
		 ((equal prefix '(16)) "%A, %d. %B %Y")))
	(system-time-locale "de_DE"))
    (insert (format-time-string format))))

(global-set-key (kbd "C-c d") 'insert-date)

(require 'gforth)
