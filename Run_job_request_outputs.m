close all
S = mfilename('fullpath');
f = filesep;
ind=strfind(S,f);
S1=S(1:ind(end)-1);
cd(S1)
%above sets the path
delete('Dogbone.odb');
delete('Dogbone.lck');


pause(2) % can this pause stop the job from getting stuck?
system('abaqus job=Dogbone cpus=3 interactive' )

pause(2)
while exist('Dogbone.lck','file')==2
    pause(0.1)
end

while exist('Dogbone.odb','file')==0
    pause(0.1)
end

[dis,force]=Read_ODB_outputs_node();
figure (1)
plot(dis,force)


