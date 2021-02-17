;;; org-desc-initial.el --- Initial input for Org link description prompt -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Firmin Martin

;; Author: Firmin Martin
;; Maintainer: Firmin Martin
;; Version: 0.1
;; Keywords: convenience, notification
;; URL: https://www.github.com/firmart/notmuch-notify
;; Package-Requires: (org . "9.3") cl-lib


;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(require 'org)
(require 'cl-lib)

;;; Commentary:
;;

;;; Code:
(defgroup org-desc-initial nil
  "Org link description"
  :group 'org
  :package-version '(org-desc-initial . "0.1"))

(defcustom org-desc-initial-alist nil
  "An alist whose the element is of the form (link-regex . initial-input)."
  :type '(alist :key-type string :value-type (choice string function))
  :group 'org-desc-initial
  :package-version '(org-desc-initial . "0.1"))

(defun org-desc-initial--first-match (link)
  (cl-loop for a in org-desc-initial-alist
	   for r = (car a)
	   when (string-match r link)
	   return a))

(defun org-desc-initial-insert (&optional link)
  "Insert an Org link at point with description initial input."
  (interactive)
  (let* ((link (or link (read-string "Link: ")))
	 (region (when (region-active-p)
		   (buffer-substring-no-properties (region-beginning) (region-end))))
	 (remove (and region (list (region-beginning) (region-end))))
	 (match (org-desc-initial--first-match link))
	 (regex (car match))
	 (match-value (cdr match))
	 (desc-initial (cond
			((stringp match-value) (concat match-value region))
			((functionp match-value) (funcall match-value link regex region))))
	 (desc (read-string "Description: " desc-initial)))
    (when remove (apply #'delete-region remove))
    (insert (org-link-make-string link desc))))

(provide 'org-desc-initial)
;;; org-desc-initial.el ends here
