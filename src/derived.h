//
//  derived.hpp
//  test for map<matrixXd>
//
//  Created by MaXiuyu on 6/9/17.
//  Copyright © 2017 MaXiuyu. All rights reserved.
//

#ifndef derived_h
#define derived_h

#include <stdio.h>
#include "DATA.h"
#include <boost/math/special_functions/digamma.hpp>

class DC:public DATA{
    
public:
    int gc;
    V gclus;
    MatrixXd gm;
    size_t PT;
    VectorXd p;
    std::unordered_map<size_t, Eigen::MatrixXd> converters;

    
public:
    
    DC(MatrixXd&, VectorXi&, VectorXd&, vector<int>&, MatrixXi&);
    
    //prior predictive function(PPF) on one group of subtypes
    VectorXd cb( double alpha,  VectorXd& beta, const MatrixXd& rs, const MatrixXd& cs);
        
    //derivative w.r.t. alpha and beta of PPF
    MatrixXd drv( double alpha,  VectorXd& beta, const MatrixXd& rs, const MatrixXd& cs);
    
    //derivate w.r.t. alpha and beta of log likelihood 
    void go_drv(const MatrixXd& A, const MatrixXd& B, double& alpha, VectorXd& beta,double stepsize1, double stepsize2);
    
    vector<MatrixXd> cal_gm(double alpha, VectorXd& beta);
    
    MatrixXd cal_delta(MatrixXd&);
    
    ~DC();
};






#endif /* derived_h */
