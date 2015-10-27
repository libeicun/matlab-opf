function  Jacobi = pf_build_jacobi_matrix(N,PQNodes,PVNodes,BLNodes,P,Q,Y,fe)
    %计算雅各比矩阵。
    nodeNbrOfBL = BLNodes(1,1);
    PVNbr = size(PVNodes);
    nodeNbr = N;

    [e,f] = pf_dicompose_fe(N,fe);
    [G,B] = pf_dicompose_ri(Y);
    
    e_ex = [];
    f_ex = [];

    for i = 1:N
        e_ex(:,i) = e;
        f_ex(:,i) = f;
    end

    a = diag((G * e) - (B * f));
    b = diag((G * f) + (B * e));
    H = -B.*e_ex + G.*f_ex + b;
    N = G.*e_ex + B.*f_ex + a;
    J = -G.*e_ex - B.*f_ex + a;
    L = -B.*e_ex + G.*f_ex -b;

    for i = 1:PVNbr(1)
        index = PVNodes(i);
        J(index,:) = zeros(1,nodeNbr);
        L(index,:) = zeros(1,nodeNbr); 
        J(index,index) = 2*f(index);
        L(index,index) = 2*e(index);
    end



    Jacobi = [
        H N;
        J L;
    ];


    Jacobi(nodeNbrOfBL, :) = zeros(1,2*nodeNbr);
    Jacobi(nodeNbrOfBL+nodeNbr,:) = zeros(1,2*nodeNbr);
    Jacobi(:,nodeNbrOfBL) = zeros(2*nodeNbr,1);
    Jacobi(:,nodeNbrOfBL+nodeNbr) = zeros(2*nodeNbr,1);

    Jacobi(nodeNbrOfBL,nodeNbrOfBL) = 1;
    Jacobi(nodeNbrOfBL,nodeNbrOfBL+nodeNbr) = 2;
    Jacobi(nodeNbrOfBL+nodeNbr,nodeNbrOfBL) = 3;
    Jacobi(nodeNbrOfBL+nodeNbr,nodeNbrOfBL+nodeNbr) = 4;