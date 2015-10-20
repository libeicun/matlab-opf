function [e,f] = pf_dicompose_fe(nodeNbr,fe)
   
    f = fe(1:nodeNbr,1);
   
    e = fe(nodeNbr+1:nodeNbr*2);