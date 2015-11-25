%========================================================================================================================%
%                                                 pf_calc_delta.m                                                        %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  æŽå?å­?åˆ›å»ºä�?2015-10-21 10:12ã€�?ç”µé�??li.beicun@foxmail.comã�?                                                         %
%________________________________________________________________________________________________________________________%
%                                                                                                                        %
%  (C) ç‰ˆæƒæ�??œ�?2015- ï¼ŒæŽå€å­˜åŠiPsoã�?                                                                                  %
%  å¯¹è¯¥æ–�?ä»¶æ�?Œ…å«çš�?ä»£ç çš„æ­£ç¡®�?ã€æ�?§è¡Œæ•ˆçŽ�?ç­‰ä»»ä½�?æ–¹é¢ä¸ä½œä»»ä½�?ä¿è¯ã�?                                                       %
%  ä»»ä½•ä¸ªäººå�?Œç»„ç»�?å‡å¯ä¸å�?çº¦æŸåœ°å°†è¯¥æ�?‡ä»¶æ�??Œ…å«çš�?ä»£ç ç”¨äºŽéžå�?†ä¸šç�?¨é€�?ã?                                                      %
%  è‹¥éœ€è¦å°†å�?¶ç”¨äºŽå�?†ä¸šè½¯ä»¶çš�?å¼?‘ï¼Œè¯·é¦�?å…ˆè�?ç³»æ�?œ‰è€…ä»¥å�?å¾—è®¸å¯ã€?                                                           %
%========================================================================================================================%
function [delta, Jacobi] = pf_calc_delta(N,PQNodes,PVNodes,BLNodes,P,QAndU2,Y,fe)
    
    [e,f]   = pf_dicompose_fe(N,fe);
    [G,B]   = pf_dicompose_ri(Y);

    PQAndU2 = sparse([P; QAndU2]);
    fe      = sparse([f; e]);
    diagE   = sparse(diag(e));
    diagF   = sparse(diag(f));
    mAboutEf = sparse([diagE, diagF; diagF, -diagE;]);
    mAboutGB = sparse([-B, G; G, B]);
    mAboutGeBf = sparse(diag(G*e - B*f));
    mAboutBeGf = sparse(diag(B*e + G*f));
    mAboutGBef = sparse(mAboutEf * mAboutGB);

    delta = sparse([P; QAndU2] - mAboutGBef*fe) ;

    NOfBL = BLNodes(1,1);

    delta(NOfBL) = 0.0000;
    delta(N + NOfBL) = 0.0000;

    PVNbr = size(PVNodes);
    for i = 1:PVNbr(1)
        index = PVNodes(i);
        delta(N + index) = QAndU2(index) - (e(index)*e(index)+f(index)*f(index));
    end


    Jacobi = (mAboutGBef + [mAboutBeGf, mAboutGeBf; mAboutGeBf, -mAboutBeGf]);

    for i = 1:PVNbr(1)
        index                       = PVNodes(i);
        Jacobi(N + index,:)         = zeros(1,2*N);
        Jacobi(N + index, index)    = 2*f(index);
        Jacobi(N + index, N + index)= 2*e(index);
    end


    Jacobi(NOfBL, :)        = zeros(1,2*N);
    Jacobi(NOfBL+N,:)       = zeros(1,2*N);
    Jacobi(:,NOfBL)         = zeros(2*N,1);
    Jacobi(:,NOfBL+N)       = zeros(2*N,1);

    Jacobi(NOfBL,NOfBL)     = 1;
    Jacobi(NOfBL,NOfBL+N)   = 2;
    Jacobi(NOfBL+N,NOfBL)   = 3;
    Jacobi(NOfBL+N,NOfBL+N) = 4;

    Jacobi = sparse(Jacobi);

    