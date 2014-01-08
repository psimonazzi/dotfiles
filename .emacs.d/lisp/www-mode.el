;;;###autoload
(define-minor-mode www-mode
  "Helpers for writing HTML documents."
  :lighter " www"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-c i") 'www/insert-image)
            (define-key map (kbd "C-c C-c b") 'www/insert-blockquote)
            (define-key map (kbd "C-c C-c c") 'www/insert-code)
            (define-key map (kbd "C-c C-c r") 'www/insert-code-region)
            (define-key map (kbd "C-c C-c n") 'www/insert-footnotes)
            (define-key map (kbd "C-c C-c m") 'www/insert-meta)
            (define-key map (kbd "C-c C-c q") 'www/insert-cite)
            (define-key map (kbd "C-c C-c u") 'www/insert-static-url)
            (define-key map (kbd "C-c C-c e") 'www/html-escape-region)
            map))

;;;###autoload
(add-hook 'nxml-mode-hook 'www-mode)
(add-hook 'html-mode-hook 'www-mode)
(add-hook 'markdown-mode-hook 'www-mode)


(defun www/html-escape-region (start end)
  "Escape special HTML chars in the current region."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (replace-string "&" "&amp;")
      (goto-char (point-min))
      (replace-string "<" "&lt;")
      (goto-char (point-min))
      (replace-string ">" "&gt;")
      (goto-char (point-min))
      (replace-string "\"" "&quot;")
      (goto-char (point-min))
      (replace-string "'" "&#39;")
      )))

(defun www/escape-url (start end)
  "Escape the current region as URL hex format."
  (interactive "r")
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (url-hexify-string text))
      )))

(defun www/unescape-url (start end)
  "Unescape the current region as URL hex format."
  (interactive "r")
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (url-unhex-string text))
      )))

(defun www/insert-image ()
  "Insert a figure element with img and figcaption. Put cursor in img src."
  (interactive)
  (insert "
<figure>
  <img src=\"\" alt=\"\" />
  <figcaption></figcaption>
</figure>
")
  (backward-char 50))

(defun www/insert-blockquote ()
  "Insert a figure element with blockquote and figcaption (for quote source)."
  (interactive)
  (insert "
<figure class=\"nostretch\">
  <blockquote><p>“”</p></blockquote>
  <figcaption><cite><a title=\"\" href=\"\"></a></cite></figcaption>
</figure>
")
  (backward-char 94))

(defun www/insert-code ()
  "Insert a figure element with pre & code, and a figcaption."
  (interactive)
  (insert "
<figure>
  <pre><code data-language=\"\" class=\"maxheight\">

  </code></pre>
</figure>
")
  (backward-char 27))

(defun www/insert-code-region (start end)
  "Insert a figure element with pre & code around the region, and a figcaption."
  (interactive "r")
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert "
<figure>
  <pre><code data-language=\"\" class=\"maxheight\">
")
      (insert text)
      (insert "
  </code></pre>
</figure>
"))))

(defun www/insert-cite ()
  "Insert a quote source with url."
  (interactive)
  (insert "“” · Z.com")
  (backward-char 9))

(defun www/insert-static-url ()
  "Insert a base url for cloud hosted resources. Read from env variable WWW_STATIC_URL."
  (interactive)
  (insert (getenv "WWW_STATIC_URL")))

(defun www/insert-footnotes ()
  "Insert a list of footnotes."
  (interactive)
  (insert "
<ol class=\"footnotes\">
  <li id=\"fn-1\">. <a title=\"ritorna\" href=\"#fn-ref-1\">↩</a></li>
</ol>
")
    (backward-char 55))

(defun www/insert-meta ()
  "Insert the HTML5 doctype and some metadata."
  (interactive)
  (insert "<!DOCTYPE html>
<meta charset=\"utf-8\"/>
<title></title>
<script>
{
\"tag\": [ \"\" ],
\"timestamp\": \"2013/07/01 10:10\"
}
</script>

"))


;; (make-variable-buffer-local
;;  (defvar foo-count 0
;;    "Number of foos inserted into the current buffer."))

;; (defun insert-foo ()
;;   (interactive)
;;   (setq foo-count (1+ foo-count))
;;   (insert "foo"))


(provide 'www-mode)
