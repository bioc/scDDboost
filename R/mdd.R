#' log likelihood of aggregated multinomial counts z given aggregated proportions t
#'
#' @param z counts of each group in one condition
#' @param pp a partition
#' @param alpha parameter of double dirichlet prior
#' @return log likelihood of aggregated multinomial counts z given aggregated proportions t
#' @export

##no beta
lpzgt <- function(z,pp,alpha)
{
    # log prob
    # z a vector of counts
    # pp a partition
    # p(z|t) assuming alpha_k=1;
    tt <- tapply(z,pp,sum) ## sufficient stats over blocks
    alpha_b <- tapply(alpha,pp,sum)
    nn <- table(pp)  ## counts block sizes
    res <- sum(lgamma(tt + 1)) - sum(lgamma(z + 1)) + sum(lgamma(alpha_b)) - sum(lgamma(alpha)) + sum(lgamma(z + alpha)) - sum(lgamma(tt + alpha_b))
    res
}


#' log likelihood of z1,z2 given t1,t2
#'
#' @param z1 counts of each group in condition 1
#' @param z2 counts of each group in condition 2
#' @param pp a partition
#' @param alpha1 parameter of double dirichlet prior
#' @param alpha2 parameter of double dirichlet prior
#' @return log likelihood of z1,z2 given t1,t2
#' @export

##beta equals sum over alpha1 and alpha2
lpt1t2 <- function(z1,z2,pp,alpha1,alpha2)
{
    K <- length(z1)
    n1 <- sum(z1); n2 <- sum(z2)
    t1 <- tapply(z1,pp,sum) ## sufficient stats over blocks
    t2 <- tapply(z2,pp,sum) ## sufficient stats over blocks
    beta <- alpha1 + alpha2
    beta_b <- tapply(beta,pp,sum)
    tmp1 <- lgamma(n1+1) + lgamma(n2+1) - sum(lgamma(t1+1)) - sum(lgamma(t2+1))
    tmp2 <- lgamma(sum(beta_b)) - sum( lgamma(beta_b) )
    tmp3 <- sum(lgamma(t1+t2+beta_b))-lgamma(n1+n2+sum(beta_b))
    res <- tmp1+tmp2+tmp3
    res
}

#' posterior of proportion change given mixture double dirichlet prior
#'
#' @param z1 counts of each group in condition 1
#' @param z2 counts of each group in condition 2
#' @param pat partition patterns
#' @param alpha1 parameter of double dirichlet prior
#' @param alpha2 parameter of double dirichlet prior
#' @return posterior of proportion change
#' @export

mdd <- function(z1, z2, pat, alpha1, alpha2){

    
    lpz <- apply(pat,1,function(x) lpzgt(z1,x,alpha1) + lpzgt(z2,x,alpha2) + lpt1t2(z1,z2,x,alpha1,alpha2))
    
    post <- exp(lpz-max(lpz))
    post <- post/sum(post)
    return(post)
}





