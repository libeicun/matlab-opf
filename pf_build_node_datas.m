function [U,fy,S,UExceedUprNodes,UExceedLwrNodes] = pf_build_node_datas(fe,Y,N)
e = fe(N+1:N+N,1);
f = fe(1:N,1);

U1 = e+f*i;
U = abs(U1);
fy = angle(U1);
G = real(Y);
B = imag(Y);

tmp1 = G*e-B*f;
tmp2 = G*f+B*e;

P = diag(e)*tmp1 + diag(f)*tmp2;
Q = diag(f)*tmp1 - diag(e)*tmp2;

S = P + Q*i;

UExceedUprNodes = zeros(N,1);
UExceedLwrNodes = zeros(N,1);

for j = 1:N
    if (U(j)>1.1)
        UExceedUprNodes(j) = 1;
    elseif (U(j)<0.9)
        UExceedLwrNodes(j) = 1;
    end
end