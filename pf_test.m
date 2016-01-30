fprintf(2,'*****************System of 14 nodes calculation: expecting no errors*************************************\n')
fprintf(2,'pf_example IEEE14.dat\n');
pf_example('IEEE14.dat');
fprintf('\n\n\n\n');


fprintf(2,'*****************System of 300 nodes calculation: expecting no errors*************************************\n')
fprintf(2,'pf_example IEEE300.dat\n');
pf_example('IEEE300.dat');
fprintf('\n\n\n\n');


fprintf(2,'******************System of 1047 nodes calculation: expecting no errors***********************************\n')
fprintf(2,'pf_example IEEE1047.dat\n');
pf_example('IEEE1047.dat');
fprintf('\n\n\n\n');



fprintf(2,'******************System of 5 nodes calculation: expecting error - file not found*************************\n')
fprintf(2,'pf_example IEEE5-NOT-FOUND.dat\n');
pf_example('IEEE5-NOT-FOUND.dat');
fprintf('\n\n\n\n');


fprintf(2,'******************System of 5 nodes calculation: expecting error - multi-balance-nodes is not supported***\n')
fprintf(2,'pf_example IEEE5-3B.dat\n');
pf_example('IEEE5-3B.dat');
fprintf('\n\n\n\n');


fprintf(2,'******************System of 5 nodes calculation: expecting error - invalid data found*********************\n')
fprintf(2,'pf_example IEEE5-IV.dat\n');
pf_example('IEEE5-IV.dat');
fprintf('\n\n\n\n');


fprintf(2,'******************System of 5 nodes calculation: expecting error - does not converge**********************\n')
fprintf(2,'pf_example IEEE5-NC.dat\n');
pf_example('IEEE5-NC.dat');
fprintf('\n\n\n\n');
