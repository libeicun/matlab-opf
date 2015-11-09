%========================================================================================================================%
%                                                     pf_example.m                                                       %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  李倍存 创建于 2015-10-25 14:57。电邮 li.beicun@foxmail.com。                                                          %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  (C) 版权所有 2015- ，李倍存及iPso。                                                                                   %
%  对该文件所包含的代码的正确性、执行效率等任何方面不作任何保证。                                                        %
%  任何个人和组织均可不受约束地将该文件所包含的代码用于非商业用途。                                                      %
%  若需要将其用于商业软件的开发，请首先联系所有者以取得许可。                                                            %
%========================================================================================================================%



[errCode,iterTimes,N,U,fy,S] = pf('',  [], []);

if (errCode == 0)
    fprintf('The process returns after %d iterations.\n', iterTimes);
    xbase = 1:1:N;
    X = transpose(xbase);
    hold on;
    ybase = ones(N,1);
    plot(X,U,'b*',X,ybase*1.1000,'r-',X,ybase*0.9000,'r-',X,ybase*0.95,'r--',X,ybase*1.05,'r--');
    title('Distribution of Node Voltages');
    xlabel('Node Index');
    ylabel('Node Voltage /pu');
elseif (errCode == 1)
    fprintf('It DOES NOT converges after %d iterations.\n', iterTimes);
else
    fprintf('Unexpected error occurs.\n');
end


