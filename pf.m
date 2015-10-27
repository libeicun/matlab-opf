function [errCode,iterTimes,N,U,fy,S] = pf(srcFile,  algorithmOptions, outputOptions)
% param 
%     srcFile           path of the file that contains necessary source data.
%     algorithmOptions  a list, options specified for settings of used algrothm. 
%     outputOptions     a list, options specified for settings of how the results will be export. 
% return
%     errCode           a code indicating whether the calculation works. 0 - success, 1 - not converged, else - unknown error.
%                       and N, U, fy, and S are valid only if errCode == 0.
%     iterTimes         number of iterations.
%     N                 amount of nodes.  
%     U                 a vector, the amplitude of voltages of all nodes.
%     fy                a vector, the angle of volatages of all nodes.
%     S                 a complexity vector, powers of all nodes, where every element in forms like P + Qi, where P is active power and Q is reactive power.

% Reset the error flag.
errCode = 0;

% Read the source data and build data structures needed to process.
[Y,P,QAndU2,BLVoltage,U,N,BLNodes,PQNodes,PVNodes,precision,maxIterTimes] = pf_mock_ieee1047();

% See if all properties of the source data are supported by current version.
if (~pf_validate(Y,P,QAndU2,U,N,BLNodes,PQNodes,PVNodes,precision,maxIterTimes))
    errCode = 2;return;
end

% Set the initial values of iteration variables.
fe = pf_set_init_values(N,1.0000,U,BLVoltage,PQNodes,PVNodes,BLNodes);

% Use an iteration counter.
iterTimes = 0;

while (1)
    iterTimes = iterTimes + 1;
    
    % See if the iteration counter exceeds the specified max value.
    if(iterTimes > maxIterTimes)
        errCode = 1;return;
    end
    
    % Contruct the Jacobian Matrix.
    J = pf_build_jacobi_matrix(N,PQNodes,PVNodes,BLNodes,P,QAndU2,Y,fe);
    
    % Caculate the unblance of power.
    deltaPQ = pf_calc_delta(N,PQNodes,PVNodes,BLNodes,P,QAndU2,Y,fe);
    
    % Solve the correction equations.
    deltafe = J\deltaPQ;
    
    % See if the iteration converges.
    if(common_all_near_zero(deltafe,precision))
        break;
    end
    
    % Calculate the optimal multiplier/step.
    mu = pf_optimal_multiplier(fe,deltafe);
    
    % Update the iteration variables.
    fe = fe + mu*deltafe;
end

% Calculate the node powers.
[U,fy,S,u,l] = pf_build_node_datas(fe,Y,N);

