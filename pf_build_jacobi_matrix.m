%========================================================================================================================%
%                                              pf_build_jacobi_matrix.m                                                  %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  李倍存 创建于 2015-10-23 11:20。电邮 li.beicun@foxmail.com。                                                          %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  (C) 版权所有 2015- ，李倍存及iPso。                                                                                   %
%  对该文件所包含的代码的正确性、执行效率等任何方面不作任何保证。                                                        %
%  任何个人和组织均可不受约束地将该文件所包含的代码用于非商业用途。                                                      %
%  若需要将其用于商业软件的开发，请首先联系所有者以取得许可。                                                            %
%========================================================================================================================%
function  Jacobi = pf_build_jacobi_matrix(N,PQNodes,PVNodes,BLNodes,P,Q,Y,fe)
    %计算雅各比矩阵。
    nodeNbrOfBL = BLNodes(1,1);
    PVNbr = size(PVNodes);
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

    for i = 1:PVNbr(1)
        index = PVNodes(i);
        J(index,:) = zeros(1,nodeNbr);
        L(index,:) = zeros(1,nodeNbr); 
        J(index,index) = 2*f(index);
        L(index,index) = 2*e(index);
    end



    Jacobi = [
        H N;
        J L;
    ];


    Jacobi(nodeNbrOfBL, :) = zeros(1,2*nodeNbr);
    Jacobi(nodeNbrOfBL+nodeNbr,:) = zeros(1,2*nodeNbr);
    Jacobi(:,nodeNbrOfBL) = zeros(2*nodeNbr,1);
    Jacobi(:,nodeNbrOfBL+nodeNbr) = zeros(2*nodeNbr,1);

    Jacobi(nodeNbrOfBL,nodeNbrOfBL) = 1;
    Jacobi(nodeNbrOfBL,nodeNbrOfBL+nodeNbr) = 2;
    Jacobi(nodeNbrOfBL+nodeNbr,nodeNbrOfBL) = 3;
    Jacobi(nodeNbrOfBL+nodeNbr,nodeNbrOfBL+nodeNbr) = 4;