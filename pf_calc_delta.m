function delta = pf_calc_delta(N,PQNodes,PVNodes,BLNodes,S,Y,fe)
    [e,f] = pf_dicompose_fe(N,fe);
    [PSet,QSet] = pf_dicompose_ri(S);
    nodeNbrOfBL = BLNodes(1,1);
    [G,B] = pf_dicompose_ri(Y);
    deltaP = PSet - (e.*(G*e - B*f)) - (f.*(G*f + B*e));
    deltaQ = QSet - (f.*(G*e - B*f)) + (e.*(G*f + B*e));

    deltaP(nodeNbrOfBL) = 0.0000;
    deltaQ(nodeNbrOfBL) = 0.0000;

    delta = [deltaP;deltaQ;];