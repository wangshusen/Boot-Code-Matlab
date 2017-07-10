setup

n = 30000;
d = 1000;
[A] = GenerateData(n, d, 'NB');
save toydata/NB_n30k_d1k.mat

infile = 'NB_n30k_d1k.mat';
experimentAAtoy2(infile, 'sampling');


