function delta = pf_calc_delta(N,PQNodes,PVNodes,BLNodes,P,QAndU2,Y,fe)
    
    [e,f] = pf_dicompose_fe(N,fe);

    nodeNbrOfBL = BLNodes(1,1);
    [G,B] = pf_dicompose_ri(Y);

    deltaP = P - (e.*(G*e - B*f)) - (f.*(G*f + B*e));
    deltaQ = QAndU2 - (f.*(G*e - B*f)) + (e.*(G*f + B*e));


    deltaP(nodeNbrOfBL) = 0.0000;
    deltaQ(nodeNbrOfBL) = 0.0000;

    PVNbr = size(PVNodes);
    for i = 1:PVNbr(1)
        index = PVNodes(i);
        deltaQ(index) = QAndU2(index) - (e(index)*e(index)+f(index)*f(index));
    end


    delta = [deltaP;deltaQ;];