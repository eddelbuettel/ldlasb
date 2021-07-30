#include <cpp11/doubles.hpp>
#include <Rcpp.h>

[[cpp11::register]] cpp11::writable::doubles other_grow_(R_xlen_t n) {
    cpp11::writable::doubles x;
    R_xlen_t i = 0;
    while (i < n) {
        x.push_back(i++);
    }
    return x;
}

[[cpp11::register]] std::vector<R_xlen_t> rcpp_grow_(R_xlen_t n) {
    std::vector<R_xlen_t> x;
    R_xlen_t i = 0;
    while (i < n) {
        x.push_back(i++);
    }
    return x;
}
