function pf_example(srcFilePath)

[err,iterTimes,N,U,fy,S] = pf(srcFilePath,  [], @pf_notify_before_iteration, @pf_notify_after_iteration);

if (isstruct(err))
    common_err_print(err);
else
    fprintf('The process returns after %d iterations.\n', iterTimes);
    xbase = 1:1:N;
    X = transpose(xbase);
    hold on;
    ybase = ones(N,1);
    plot(X,U,'b*',X,ybase*1.1000,'r-',X,ybase*0.9000,'r-',X,ybase*0.95,'r--',X,ybase*1.05,'r--');
    title('Distribution of Node Voltages');
    xlabel('Node Index');
    ylabel('Node Voltage /pu');    
end

end


