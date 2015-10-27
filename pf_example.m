


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


