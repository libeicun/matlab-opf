function common_err_print(err)
    fprintf(2,'+  Error occured!\n');
    context = cell2mat(err.context);
    s = sprintf(err.msg, context);
    fprintf(2,'  -   message: %s\n',s);
    fprintf(2,'  -   source : %s\n',err.source);
    fprintf(2,'  -   code   : %d\n',err.code);
end