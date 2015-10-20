function fe = pf_set_init_values(N,PQInit,BLNodeVoltage,PQNodes,PVNodes,BLNodes)

fe(1:N,:) = zeros(N,1);
fe(N+1:N+N,:) = ones(N,1);
fe = fe.*1.00;

fe(N+BLNodes(1,1)) = BLNodeVoltage;

