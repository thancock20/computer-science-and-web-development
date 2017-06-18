;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 16-image-larger) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image, Image -> Boolean
;; Consumes two images and produces true if the area of the first is greater than that of the second
(check-expect (image-larger? (rectangle 10 20 "solid" "red") (rectangle 10 10 "solid" "blue")) true)
(check-expect (image-larger? (rectangle 10 20 "solid" "red") (rectangle 20 10 "solid" "blue")) false)
(check-expect (image-larger? (rectangle 10 20 "solid" "red") (rectangle 20 20 "solid" "blue")) false)


;(define (image-larger? img1 img2) false)     ;stub

;(define (image-larger? img1 img2)            ;template
;  (... img1 img2))

(define (image-larger? img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))