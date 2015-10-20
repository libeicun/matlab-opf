
function isValid = pf_validate(Y,S,U2,N,BLNodes,PQNodes,PVNodes,precision,maxIterTimes)
isValid = 1;
if (size(BLNodes)~=[1,1])
    isValid = 0;
end
if(size(PVNodes)~=[0,0])
    isValid = 0;
end
