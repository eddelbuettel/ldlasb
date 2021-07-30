library(ggplot2)
library(ldlasb)

benchmarkRelease <- function(verbose=FALSE) {
    grid <- expand.grid(len = c(10^(2:5), 2.5e5, 5e5),
                        Package = c("other", "Rcpp"),
                        stringsAsFactors = FALSE)
    b_release <- bench::press(.grid = grid, {
                            fun <- match.fun(if (Package == "Rcpp") "rcpp_release_" else "other_release_")
                            bench::mark(fun(len), iterations = 100)
                        })
    if (verbose) print(b_release)
    b_release
}

plotRelease <- function(b_release) {
    ggplot(b_release[c("len", "Package", "median")], aes(x = len, y = median / len, color = Package)) +
        geom_point() + geom_line() + bench::scale_y_bench_time(base = NULL) +
        scale_x_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
                      labels = scales::trans_format("log10", scales::math_format(10^.x))) +
        labs(title = "Protecting and releasing objects is constant time",
             subtitle = "Median time per object, up to 100 replications per size",
             x = "Number of protected objects",
             y = "Average median time to release protection on one object")
}

plotRelease(benchmarkRelease(FALSE))
