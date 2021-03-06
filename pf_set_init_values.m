%========================================================================================================================%
%                                                pf_set_init_values.m                                                    %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  李倍存 创建于 2015-10-21 21:10。电邮 li.beicun@foxmail.com。                                                          %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  (C) 版权所有 2015- ，李倍存及iPso。                                                                                   %
%  对该文件所包含的代码的正确性、执行效率等任何方面不作任何保证。                                                        %
%  任何个人和组织均可不受约束地将该文件所包含的代码用于非商业用途。                                                      %
%  若需要将其用于商业软件的开发，请首先联系所有者以取得许可。                                                            %
%========================================================================================================================%
function fe = pf_set_init_values(N,PQInit,U,BLNodeVoltage,PQNodes,PVNodes,BLNodes)

fe(1:N,:) = zeros(N,PQInit);
fe(N+1:N+N,:) = ones(N,PQInit);
fe = fe.*1.00;

blSize = size(BLNodes);

for i = 1:blSize(1)
    fe(N+BLNodes(i,1)) = BLNodeVoltage(i,1);
end

PVNbr = size(PVNodes);
for i = 1:PVNbr(1)
    index = PVNodes(i);
    fe(N+index) = U(i);
end

