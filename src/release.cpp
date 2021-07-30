#include <vector>
#include <cpp11/sexp.hpp>
#include <Rcpp.h>

[[cpp11::register]] void other_release_(int n) {
    std::vector<cpp11::sexp> x;
    int count = 0;
    while (count < n) {
        x.push_back(Rf_ScalarInteger(count));
        ++count;
    }
    count = 0;
    while (count < n) {
        x.pop_back();
        ++count;
    }
}

// [ [ Rcpp::export ] ]
[[cpp11::register]] void rcpp_release_(int n) {
    std::vector<SEXP> x;
    int count = 0;
    while (count < n) {
        x.push_back(Rcpp::Rcpp_PreciousPreserve(Rf_ScalarInteger(count)));
        ++count;
    }
    count = 0;
    while (count < n) {
        Rcpp::Rcpp_PreciousRelease(x.back());
        x.pop_back();
        ++count;
    }
}
