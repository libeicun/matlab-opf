function pf_notify_after_iteration(iterTime, J, deltafe, deltaPQ)
    fprintf('done.\n');

    global g_unbalance
    global g_unbalanceIndex
    g_unbalance(g_unbalanceIndex) = max(deltaPQ);
    g_unbalanceIndex = g_unbalanceIndex + 1;

end