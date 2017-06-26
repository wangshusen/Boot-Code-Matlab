setup

infile = './data/dna.mat';
experimentAA(infile, 'sampling');
experimentAA(infile, 'gaussian');
experimentAA(infile, 'srht');

