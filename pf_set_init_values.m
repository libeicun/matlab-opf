function fe = pf_set_init_values(N,PQInit,U,BLNodeVoltage,PQNodes,PVNodes,BLNodes)

fe(1:N,:) = zeros(N,PQInit);
fe(N+1:N+N,:) = ones(N,PQInit);
fe = fe.*1.00;

fe(N+BLNodes(1,1)) = BLNodeVoltage;
PVNbr = size(PVNodes);
for i = 1:PVNbr(1)
    index = PVNodes(i);
    fe(N+index) = U(i);
end

