%========================================================================================================================%
%                                                pf_dicompose_ri.m                                                   %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  李倍存 创建于 2015-10-20 08:09。电邮 li.beicun@foxmail.com。                                                          %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  (C) 版权所有 2015- ，李倍存及iPso。                                                                                   %
%  对该文件所包含的代码的正确性、执行效率等任何方面不作任何保证。                                                        %
%  任何个人和组织均可不受约束地将该文件所包含的代码用于非商业用途。                                                      %
%  若需要将其用于商业软件的开发，请首先联系所有者以取得许可。                                                            %
%========================================================================================================================%
function [P,Q] = pf_dicompose_ri(S)
P = real(S);
Q = imag(S);