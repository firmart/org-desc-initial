;;; org-desc-initial.el --- Initial input for Org link description prompt -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Firmin Martin

;; Author: Firmin Martin
;; Maintainer: Firmin Martin
;; Version: 0.1
;; Keywords: convenience, notification
;; URL: https://www.github.com/firmart/notmuch-notify
;; Package-Requires: (org . "9.3") (dash . "2.0")


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
(require 'dash)

;;; Commentary:
;;

;;; Code:
(defgroup org-desc-initial nil
  "Org link description"
  :group 'org
  :package-version '(org-desc-initial . "0.1"))

(defcustom org-desc-initial-alist nil
  "An alist whose the element is of the form (link-regex . initial-input)."
  :type '(alist :key-type string :value-type string)
  :group 'org-desc-initial-alist
  :package-version '(org-desc-initial-alist . "0.1"))

(defun org-desc-initial-insert (&optional link)
  (interactive)
  (let* ((link (or link (read-string "Link: ")))
	 (desc-initial (cdr (--first (string-match (car it) link)
				     org-desc-initial-alist)))
	 (desc (read-string "Description: " desc-initial)))
    (insert (org-link-make-string link desc))))
(provide 'org-desc-initial)
;;; org-desc-initial.el ends here
