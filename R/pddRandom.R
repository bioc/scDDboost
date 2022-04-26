
#' calculate PDD when add random noise in distance matrix
#'
#' @param data normalized preprocessed transcripts
#' @param cd condition label
#' @param K number of subgroups
#' @param D distance matrix of cells
#' @param a shape param for weights
#' @param sz size factors 
#' @param hp hyper parameters for EBSeq
#' @param Posp parition patterns
#' @param iter max number of iterations for EM in EBSeq
#' @param REF refinement relation matrix
#' @param stp1 step size of hyperparameter alpha (shared by all units) in one step EM
#' @param stp2 step size of hyperparameter beta (unit specific) in one step EM
#' @return posterior probabilities under random distance matrix
#' @keywords internal
#' @export

pddRandom <- function(data, cd, K, D, a, sz, hp, Posp, iter, REF, stp1, stp2){
    
    
    cstar <- genRClus(D,a,K)
    
    
    gcl <- seq_len(nrow(data))
    n1 <- table(cd)[1]
    sequence <- seq_len(K)
    z1<-sequence
    z2<-sequence
    for(i in sequence){
        ##current index
        cur<-which(cstar==i)
        z1[i]<-length(which(cur<=n1))
        z2[i]<-length(which(cur>n1))
    }
    alpha1 <- rep(1,K)
    alpha2 <- rep(1,K)
    post <- mdd(z1, z2, Posp, alpha1, alpha2)
    np <- nrow(Posp)
    modified_p <- t(REF) %*% post
    
    if(K >= 2){
        res <- EBS(data,cstar,gcl,sz,iter,hp,Posp,stp1,stp2)
        DE <- res$DEpattern
    }
    PED <- DE%*%modified_p
    
    
    PDD <- 1 - PED
    return(PDD)
}