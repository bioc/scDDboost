\name{scDDboost-package}
\alias{scDDboost-package}
\alias{scDDboost}
\docType{package}
\title{
\packageTitle{scDDboost}
}
\description{
\packageDescription{scDDboost}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{scDDboost}
\packageIndices{scDDboost}
Package used to score evidence of differential distribution in single-cell RNA-seq data
}
\author{
\packageAuthor{scDDboost}

Maintainer: \packageMaintainer{scDDboost}
}
\references{
https://projecteuclid.org/journals/annals-of-applied-statistics/volume-15/issue-2/A-compositional-model-to-assess-expression-changes-from-single-cell/10.1214/20-AOAS1423.short
}
\keyword{ Empirical Bayes, clustering, random weighting, local false discovery rate }
\seealso{
https://github.com/wiscstatman/scDDboost/blob/master/DESCRIPTION
}
\examples{
data(sim_dat)
dat = extractInfo(sim_dat)
data_counts = dat$count_matrix
cd = dat$condition
bp <- BiocParallel::MulticoreParam(4)
D_c = calD(data_counts,bp)
pDD = pdd(data_counts,cd,bp,D_c)
}
