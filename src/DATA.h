#ifndef DATA_h
#define DATA_h
#include <algorithm>
#include <iostream>
#include <vector>
#include <cmath>
#include <limits>
#include <thread>
#include <RcppEigen.h>
#include <Eigen/Dense>
#include <map>
using namespace std;
using namespace Eigen;
typedef vector<int> V;
#include "Header.h"

struct r_q{
    MatrixXd rrr;
    VectorXd qqq;
};

struct hyperparam{
    double alp;
    VectorXd bta;
};


class DATA{
public:
    
    vector<MatrixXd> r_d;
    
    vector<MatrixXd> r_r;
    
    VectorXd c_1;
    
    VectorXd r_1;
    
    size_t G;
    
    MatrixXd r;
    
    size_t K;
    
    MatrixXd data;
    
    VectorXd q;
    
    MatrixXi pat;
    
    MatrixXd d_s;
    
    MatrixXd r_s;
    
    vector<MatrixXd> reorg(MatrixXd&,  const VectorXi&);
    
    vector<MatrixXd> reorgr(const MatrixXd&, const VectorXi&);
    
    DATA(MatrixXd&, const VectorXi&, const VectorXd&, const MatrixXi&);
    
    r_q cal_r(MatrixXd&, const VectorXi&, const VectorXd&);
    
    MatrixXd cal_hp(void);
    
    void cal_sum(void);
    
    ~DATA();
};

#endif /* DATA_h */
