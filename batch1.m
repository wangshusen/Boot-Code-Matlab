setup

infile = './data/connect.mat';
experimentAA(infile, 'sampling');
experimentAA(infile, 'gaussian');
experimentAA(infile, 'srht');


infile = './data/dna.mat';
experimentAA(infile, 'sampling');
experimentAA(infile, 'gaussian');
experimentAA(infile, 'srht');



infile = './data/mushrooms.mat';
experimentAA(infile, 'sampling');
experimentAA(infile, 'gaussian');
experimentAA(infile, 'srht');



infile = './data/protein.mat';
experimentAA(infile, 'sampling');
experimentAA(infile, 'gaussian');
experimentAA(infile, 'srht');



infile = './data/mnist.mat';
experimentAA(infile, 'sampling');
experimentAA(infile, 'gaussian');
experimentAA(infile, 'srht');



