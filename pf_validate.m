%========================================================================================================================%
%                                                    pf_validate.m                                                       %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  李倍存 创建于 2015-10-24 08:14。电邮 li.beicun@foxmail.com。                                                          %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  (C) 版权所有 2015- ，李倍存及iPso。                                                                                   %
%  对该文件所包含的代码的正确性、执行效率等任何方面不作任何保证。                                                        %
%  任何个人和组织均可不受约束地将该文件所包含的代码用于非商业用途。                                                      %
%  若需要将其用于商业软件的开发，请首先联系所有者以取得许可。                                                            %
%========================================================================================================================%

function [err] = pf_validate(Y,P,Q,U2,N,BLNodes,PQNodes,PVNodes,precision,maxIterTimes)
err = [];
t = size(BLNodes);
if (t(1)~=1)
    err = common_err(1,mfilename(), 'Multi-balance-nodes is NOT supported yet: %d balance nodes found.', t(1));
    return;
end

t = size(U2);
for i = 1:t(1)
    if(U2(i)>1.5)
        err = common_err(5, mfilename(), 'A voltage value seems NOT valid: node - %d, V - %f.', i, U2(i));
        return;
    end
end

