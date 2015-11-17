function [err] = common_err(code, src, msg, varargin)
    err.code = code;
    err.msg = msg;
    err.source = src;

    temp = 3;%固定参数个数
    err.context = cell(1,nargin-temp);

    if nargin > temp
        for i = temp+1:nargin
            err.context{i-temp} = varargin{i-temp};
        end        
    end
end