function [U,S] = pf(srcFile,  algorithmOptions, outputOptions)

%读取源数据并构造特定数据结构。
[Y,S,U2,N,BLNodes,PQNodes,PVNodes,precision,maxIterTimes] = pf_read_data_in_ipso_format(srcFile);
%确认当前程序支持源数据的所有特性。
isValid = pf_validate(Y,S,U2,N,BLNodes,PQNodes,PVNodes,precision,maxIterTimes);
if (isValid == 0)
    fprintf('The input datas are invalid, please check them and try again.');return;
end
%设置迭代变量的初始值。
fe = pf_set_init_values(N,1.05,1.06,PQNodes,PVNodes,BLNodes);
%使用迭代计数器。
currentIteration = 0;
while (1)
    currentIteration = currentIteration + 1;
    %迭代次数判断。
    if(currentIteration > maxIterTimes)
        fprintf('Exit after %d iterations WITHOUT converge.\n',currentIteration - 1);break;
    end
    %构造雅各比矩阵。
    J = pf_build_jacobi_matrix(N,PQNodes,PVNodes,BLNodes,S,Y,fe);
    %计算不平衡量。
    deltaPQ = pf_calc_delta(N,PQNodes,PVNodes,BLNodes,S,Y,fe);
    %解修正方程式，得迭代增量。
    deltafe = J\deltaPQ;
    %收敛判断。
    if(pf_near_zero(deltafe,precision))
        fprintf('Converge after %d iterations.\n',currentIteration);break;
    end
    %计算最优乘子。
    mu = pf_optimal_multiplier(fe,deltafe);
    %更新迭代变量。
    fe = fe + mu*deltafe;
end
U = fe(1:N,1) + i*fe(N+1:N+N,1);
S = [];
