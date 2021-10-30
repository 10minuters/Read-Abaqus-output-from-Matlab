function [D_sim,F_sim]=Read_ODB_outputs()
clear all
close all
debug = 0;
if (debug)
    debug_file = fopen('debug.dat', 'wt');
end
while exist('Dogbone.dat','file')==0
    pause(0.1)
end
file = 'Dogbone.dat';
fidd = fopen(file);
i = 0;
pause(0.5)
numSteps = 0;
j=0;
while ( ~feof(fidd) )
    
    tline = fgetl(fidd);
    
    i = i+1;
    if (regexpi(tline, 'E L E M E N T   O U T P U T')>0)  %For elements, replace 'N O D E   O U T P U T'  by 'E L E M E N T   O U T P U T'
        numSteps = numSteps + 1;
        tline = fgetl(fidd);
        i = i+1;
        
        while(isempty(str2num(tline)))
            tline = fgetl(fidd);
            i = i+1;
        end
        while(~isempty(str2num(tline)))
            j=j+1;
            data_f = sscanf(tline, '%d %e %e %e %e' , [1,4]);
%             if (debug)
%                 fprintf(debug_file, '%d\t%e\n', data_f(1), data_f(2), data_f(3));
%             end
            node_number=data_f(2);
            tline = fgetl(fidd);
            i = i+1;
            D_sim(j)=data_f(3);
            F_sim(j)=data_f(4);

        end
        if (debug)
            fprintf(debug_file, '\n');
        end
    end
end
if (debug)
    fclose(debug_file);
end
fclose(fidd);
fclose all
