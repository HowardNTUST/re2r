## This file is part of the 're2r' package for R.
## Copyright (C) 2016, Qin Wenfeng
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are met:
##
## 1. Redistributions of source code must retain the above copyright notice,
## this list of conditions and the following disclaimer.
##
## 2. Redistributions in binary form must reproduce the above copyright notice,
## this list of conditions and the following disclaimer in the documentation
## and/or other materials provided with the distribution.
##
## 3. Neither the name of the copyright holder nor the names of its
## contributors may be used to endorse or promote products derived from
## this software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
## BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
## FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
## HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
## PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
## OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
## WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
## OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
## EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#' Keep strings matching a pattern.
#'
#' This is a convenient wrapper around \code{x[re2_detect(x, pattern)]}. Vectorised over strings and patterns.
#'
#' @inheritParams re2_detect
#' @param omit_na omit na result
#' @return A character vector.
#' @export
#' @examples
#' fruit <- c("apple", "banana", "pear", "pinapple")
#' re2_subset(fruit, "a")
#' re2_subset(fruit, "^a")
#' re2_subset(fruit, "a$")
#' re2_subset(fruit, "b")
#' re2_subset(fruit, "[aeiou]")
#'
#' re2_subset(c("a", NA, "b"), ".")
re2_subset <-
    function(string,
             pattern,
             anchor = 0,
             omit_na = TRUE,
             parallel = FALSE,
             grain_size = 100000,
             ...) {
        if (is.character(pattern) || mode(pattern) == "logical") {
            pattern = re2(pattern, ...)
        }
        cpp_subset(stri_enc_toutf8(string), pattern , anchor, parallel, grain_size, omit_na)
    }
