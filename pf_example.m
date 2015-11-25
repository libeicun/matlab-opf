function pf_example(srcFilePath)

[err,iterTimes,N,U,fy,S] = pf(srcFilePath,  [], @pf_notify_before_initialize, @pf_notify_before_iterations, @pf_notify_before_iteration, @pf_notify_after_iteration, @pf_notify_when_finished);

if (isstruct(err))
    common_err_print(err);
else
    xbase = 1:1:N;
    X = transpose(xbase);
    ybase = ones(N,1);
    figure;
    plot(X,U,'b*',X,ybase*1.1000,'r-',X,ybase*0.9000,'r-',X,ybase*0.95,'r--',X,ybase*1.05,'r--');
    title('Distribution of Node Voltages');
    xlabel('Node Index');
    ylabel('Node Voltage /pu');    
end

end


