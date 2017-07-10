function experimentAA2(filename, sketch)
% input
% A: n-by-d1 matrix where n >> d
% sketch: either 'gaussian' or 'srht' or 'sampling'


load(filename);
dataname = filename(1:2)
d = size(A, 2);

AA = A' * A;
maxAA = max(max(abs(AA)));
A = A / sqrt(maxAA);
AA = A' * A;


% ------------------- Parameters ------------------- %
numBoot = 20;  %%%%%%%%%%%%% can be tuned
numRepeat = 1000;  %%%%%%%%%%%%% can be tuned
tList = ceil([0.1*d : 0.1*d: 0.9*d, d: 0.5*d: 20*d]);%%%%%%%%%%%%% real data
tMax = max(tList);

% ------------------- Precompute ------------------- %
numT = length(tList);
d = size(A, 2);
outputFileName = ['result2_', dataname, '_AA_', sketch '.mat'];
resultMul = zeros(numRepeat, numT);
resultBoot = zeros(numRepeat, numT, numBoot);




for r = 1: numRepeat
    r
    ASketchMax = sketching(A, tMax, sketch);
    
    % matrix multiplication errors
    for i = 1: numT
        t = tList(i);
        AS = ASketchMax(1:t, :) * sqrt(tMax / t);
        err = max(max(abs(AS' * AS - AA)));
        resultMul(r, i) = err;
    end
    
    % bootstrap errors
    for i = 1: numT
        t = tList(i);
        AS = ASketchMax(1:t, :) * sqrt(tMax / t);
        Msketch = AS' * AS;
        for b = 1: numBoot
            randidx = randsample(t, t, true);
            Atilde = AS(randidx, :);
            Mtilde = Atilde' * Atilde;
            Residual =  Msketch - Mtilde;
            resultBoot(r, i, b) = max(max(abs(Residual)));
        end
    end
end


save(outputFileName, 'd', 'tList', 'resultMul', 'resultBoot');


end


function [Asketch] = sketching(A, s, sketch)
n = size(A, 1);

if strcmp(sketch, 'gaussian')
    S = randn(s, n);
    Asketch = S * A / sqrt(s);
elseif strcmp(sketch, 'srht')
    sgn = randi(2, [n, 1]) * 2 - 3; % one half are +1 and the rest are -1
    A = bsxfun(@times, A, sgn); % flip the signs of each row w.p. 50%
    npower = 2^(ceil(log2(n))); 
    A2 = (fwht(A, npower)) * sqrt(npower); % Hadarmard transform
    %S = randsample(npower, s);
    S = randsample(npower, s, true);
    Asketch = A2(S, :) * sqrt(npower / s);
elseif strcmp(sketch, 'sampling')
    prob = sum(A.^2, 2);
    prob = prob / sum(prob);
    S = randsample(n, s, true, prob);
    Asketch = bsxfun(@times, A(S, :), 1 ./ sqrt(prob(S, :))) / sqrt(s);
elseif strcmp(sketch, 'Uniform')
    S = randsample(n, s);
    Asketch = A(S, :) * sqrt(n / s);
end
end
