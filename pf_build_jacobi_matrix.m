function  J = pf_build_jacobi_matrix(N,PQNodes,PVNodes,BLNodes,S,Y,fe)
    nodeNbrOfBL = BLNodes(1,1);
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
    J = [
        H N;
        J L;
    ];


    J(nodeNbrOfBL, :) = zeros(1,2*nodeNbr);
    J(nodeNbrOfBL+nodeNbr,:) = zeros(1,2*nodeNbr);
    J(:,nodeNbrOfBL) = zeros(2*nodeNbr,1);
    J(:,nodeNbrOfBL+nodeNbr) = zeros(2*nodeNbr,1);
    J(nodeNbrOfBL,nodeNbrOfBL) = 1;
    J(nodeNbrOfBL,nodeNbrOfBL+nodeNbr) = 2;
    J(nodeNbrOfBL+nodeNbr,nodeNbrOfBL) = 3;
    J(nodeNbrOfBL+nodeNbr,nodeNbrOfBL+nodeNbr) = 4;