(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "gray10" :foreground "ivory"))))
 '(cursor ((t (:background "firebrick"))))
 '(custom-documentation ((t (:foreground "pink"))))
 '(custom-invalid ((t (:inherit font-lock-warning-face))))
 '(escape-glyph ((((background dark)) (:foreground "deepskyblue"))))
 '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "lightskyblue1" :weight bold))))
 '(font-lock-comment-face ((((class color) (background dark)) (:foreground "grey65"))))
 '(font-lock-constant-face ((t (:foreground "#ffae53"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :foreground "grey55"))))
 '(font-lock-function-name-face ((t (:foreground "#55acf5"))))
 '(font-lock-keyword-face ((((class color) (background dark)) (:foreground "lightskyblue2" :weight bold))))
 '(font-lock-string-face ((((class color) (background dark)) (:foreground "#ffc0cb"))))
 '(font-lock-variable-name-face ((t (:foreground "#fce94f"))))
 '(font-lock-warning-face ((((class color) (min-colors 88) (background dark)) (:background "brown4" :foreground "palevioletred1" :slant italic))))
 '(fringe ((t (:background "gray10"))))
 '(highlight ((((class color) (background dark)) (:background "darkolivegreen" :foreground "palegreen"))))
 '(hl-line ((t (:background "grey20"))))
 '(js2-error-face ((t (:inherit font-lock-warning-face))))
 '(js2-external-variable-face ((t (:foreground "palegreen"))))
 '(js2-function-param-face ((t (:foreground "palegreen"))))
 '(js2-jsdoc-html-tag-delimiter-face ((t (:foreground "lightskyblue1"))))
 '(js2-jsdoc-html-tag-name-face ((t (:foreground "lightskyblue1"))))
 '(js2-jsdoc-type-face ((t (:foreground "#55acf5"))))
 '(js2-jsdoc-value-face ((t (:foreground "palegreen"))))
 '(lazy-highlight ((((class color) (background dark)) (:background "springgreen1" :foreground "darkolivegreen"))))
 '(linum ((t (:inherit default :foreground "grey30"))))
 '(match ((((class color) (background dark)) (:background "RoyalBlue3" :foreground "lightBlue"))))
 '(minibuffer-prompt ((((background dark)) (:foreground "springgreen1"))))
 '(nxml-attribute-colon-face ((t (:inherit nxml-attribute-local-name-face))))
 '(nxml-attribute-local-name ((t (:inherit font-lock-type-face))))
 '(nxml-attribute-local-name-face ((t (:foreground "palegreen"))))
 '(nxml-attribute-prefix-face ((t (:inherit nxml-attribute-local-name-face))))
 '(nxml-attribute-value-delimiter ((t (:foreground "#e08da2"))))
 '(nxml-attribute-value-delimiter-face ((t (:foreground "pink"))))
 '(nxml-cdata-section-CDATA-face ((t (:foreground "pink"))))
 '(nxml-cdata-section-content-face ((t (:inherit nxml-cdata-section-cdata-face))))
 '(nxml-cdata-section-delimiter-face ((t (:foreground "pink" :weight bold))))
 '(nxml-char-ref-delimiter-face ((t (:inherit nxml-ref-face :weight bold))))
 '(nxml-comment-content-face ((t (:foreground "gray65" :slant italic))))
 '(nxml-comment-delimiter-face ((t (:foreground "gray40"))))
 '(nxml-delimited-data-face ((((class color) (background dark)) (:foreground "pink"))))
 '(nxml-delimiter ((t (:inherit nxml-element-prefix))) t)
 '(nxml-delimiter-face ((((class color) (background dark)) (:foreground "lightskyblue1" :weight bold))))
 '(nxml-entity-ref-delimiter-face ((t (:inherit nxml-char-ref-delimiter-face))))
 '(nxml-name-face ((((class color) (background dark)) (:foreground "lightskyblue1" :weight bold))))
 '(nxml-namespace-attribute-xmlns-face ((t (:inherit nxml-attribute-local-name-face))))
 '(nxml-ref-face ((((class color) (background dark)) (:foreground "lightgoldenrod"))))
 '(nxml-tag-slash-face ((t (:inherit nxml-tag-delimiter-face))))
 '(region ((((class color) (background dark)) (:background "blue3" :foreground "lightBlue"))))
 '(secondary-selection ((((class color) (background dark)) (:background "SkyBlue4" :foreground "lightskyblue1"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey90"))))
 '(show-paren-match ((((class color) (background dark)) (:background "steelblue3"))))
 '(tool-bar ((default (:foreground "black")) (((type x w32 ns) (class color)) (:background "grey75"))))
 '(tooltip ((((class color)) (:inherit variable-pitch :background "lightyellow" :foreground "#533803"))))
 '(trailing-whitespace ((t (:inherit font-lock-warning-face)))))
;; add jedi (and yasnippet) for python support
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode anzu rainbow-mode csv-mode systemd groovy-mode markdown-mode))))
