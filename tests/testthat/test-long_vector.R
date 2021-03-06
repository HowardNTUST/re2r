context("Long String")

test_that("long string", {
    if (Sys.getenv("RE2R_LONG_TEST") == "TRUE") {
        r = stri_c(stringi::stri_dup("x", 2 ^ 28 - 1), "y")
        expect_true(re2_detect(r, "y"))
        rm(r)

        r = stri_c(stringi::stri_dup("x", 2 ^ 31 - 3), "y")
        expect_true(re2_detect(r, "y"))
        rm(r)
    }
})

test_that("long vector", {
    if (Sys.getenv("RE2R_LONG_TEST") == "TRUE") {
        #for ( x in 1:100) { print(x);dd <<-re2_pdetect(r300, "x"); if(!all(dd)){break;} }
        r300 = replicate(2 ^ 21, "x")
        expect_true(all(re2_detect(r300, "x")))
        expect_true(all(re2_detect(r300, "x", grain_size = 1,parallel = T)))
        rm(r300)

        r4500 = c(replicate(2 ^ 31 - 2, "x"),replicate(2 ^ 4, "x"))
        expect_true(all(re2_detect(r4500, "x")))
        expect_true(all(re2_detect(r4500, "x", grain_size = 1,parallel = T)))
        rm(r4500)
    }
})
