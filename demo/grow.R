library(ggplot2)
library(ldlasb)

benchmarkGrow <- function(verbose=FALSE) {
    grid <- expand.grid(len = 10^(0:7), Package = c("other", "Rcpp"), stringsAsFactors = FALSE)
    b_grow <- bench::press(.grid = grid, {
                         fun <- match.fun(if (Package == "Rcpp") "rcpp_grow_" else "other_grow_")
                         bench::mark(fun(len))
                     })# [c("len", "pkg", "min", "mem_alloc", "n_itr", "n_gc")]
    if (verbose) print(b_grow)
    b_grow
}

plotGrow <- function(b_grow) {
    ggplot(b_grow[c("len", "Package", "median")],
           aes(x = len, y = median, color = Package)) +
        geom_point() + geom_line() + bench::scale_y_bench_time() +
        scale_x_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
                      labels = scales::trans_format("log10", scales::math_format(10^.x))) +
        theme(panel.grid.minor = element_blank()) +
        labs(title = "Growing vectors: Persistent Performance Gap",
             subtitle = "Median time from up to 100 replications per sizeCh",
             x = "Vector size (log scale)", y = "Creation time (log scale)")
}

plotGrow(benchmarkGrow(FALSE))
