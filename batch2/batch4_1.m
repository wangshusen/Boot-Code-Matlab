setup

n = 30000;
d = 1000;
[A] = GenerateData(n, d, 'NG');
save toydata/NG_n30k_d1k.mat

infile = 'NG_n30k_d1k.mat';
experimentAAtoy2(infile, 'sampling');



