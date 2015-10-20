format long

[G,B,PSet,QSet,U2,nodeNbr,BL,PQ,PV,converge,MAX_ITERATION] = pf_read_data_in_ipso_format('ieee5.dat');

%设置电压初值
V = [
    1.0600+0.0000i;
    1.0000+0.0000i;
    1.0000+0.0000i;
    1.0000+0.0000i;
    1.0000+0.0000i;
];
e = real(V);
f = imag(V);
fe = [f;e;];
currentIteration = 0;
while (1)
    currentIteration = currentIteration + 1;
    if(currentIteration > MAX_ITERATION)
        fprintf('FAILED AFTER %d ITERATIONS.\n',currentIteration - 1);
        break;
    end
    f = fe(1:nodeNbr,1);
    e = fe(nodeNbr+1:nodeNbr*2);
    e_ex = [e e e e e];
    f_ex = [f f f f f];
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
    deltaP = PSet - (e.*(G*e - B*f)) - (f.*(G*f + B*e));
    deltaQ = QSet - (f.*(G*e - B*f)) + (e.*(G*f + B*e));
    deltaP(nodeNbrOfBL) = 0.0000;
    deltaQ(nodeNbrOfBL) = 0.0000;
    deltaPQ = [deltaP;deltaQ;];
    deltafe = J\deltaPQ;
    
    if(all(abs(deltafe) < converge))
        fprintf('SUCCESS AFTER %d ITERATIONS.\n',currentIteration);
        break;
    end
    
    %计算最优乘子
    mu = optimal_multiplier(fe,deltafe);
    mu
    mu = 1;
    fe = fe + mu*deltafe;
    
    fe
end




%delta = Y * V
%deltaI = V .* conj(delta)
%deltaP = PG - PD - real(deltaI)
%deltaQ = QG - QD - image(deltaI)
%hx = [
%    deltaP;
%    deltaQ;
%]%

%H = -(G*diag(e) + B*diag(f)) - diag(G*e - B*f)
%N = (B*diag(e) - G*diag(f)) - diag(G*f - B*e)
%J = (B*diag(e) - G*diag(f)) + diag(G*f + B*e)
%L = (G*diag(e) + B*diag(f)) - diag(G*e - B*f)
%dhx = [
%    H, N;
%    J, L;
%]%

%tmp1 = -diag(yp)*G - G*diag(yp) + diag(yq)*B + B* diag(yq)
%tmp2 = diag(yq)*G - G*diag(yq) + diag(yp)*B - B*diag(yp)
%d2hx = [
%    tmp1, tmp2;
%    tmp2, tmp1;
%]