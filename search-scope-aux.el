;;; search-scope-aux.el --- auxiliary functions for `search-scope-mode' -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Pavel Sokolov
;; All rights reserved.

;; Author: Pavel Sokolov <pavel.zepp@gmail.com>
;; Maintainer: Pavel Sokolov <pavel.zepp@gmail.com>
;; Created: 2025

;; This file is NOT part of GNU Emacs.

;;;###autoload
(defun search-scope-compose-ag-args (thing scope)
  (let ((regexp (search-scope-thing-to-regexp thing t)))
    (list
     ;; do not quote thing since a literal search to be done
     (if regexp regexp (car thing))

     (alist-get 'root scope)

     :regexp (and regexp (string> regexp ""))

     :file-regex (search-scope-to-path-regexp scope))))

;;;###autoload
(defun search-scope-index-projectile-files (scope excluding-dirs &optional regexp)
  "Filters a list produced by `projectile-project-files'"

  (when regexp
    (cl-assert (memq (type-of regexp) '(cons string))))

  (when-let* ((absolute (alist-get 'absolute scope))
              (files (projectile-project-files absolute)))
    (search-scope-filter-files files regexp excluding-dirs)))

