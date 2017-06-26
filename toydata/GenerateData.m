function [X] = GenerateData(n, d, type)

covMatrix = GenerateCovMatrix(d);

if strcmp(type, 'UG') || strcmp(type, 'UB')
    U = orth(mvnrnd(ones(n, d), covMatrix));
elseif strcmp(type, 'NG') || strcmp(type, 'NB')
    v = 2; % degree of freedom
    U = orth(mvtrnd(covMatrix, v, n));
end

if strcmp(type, 'UG') || strcmp(type, 'NG')
    singularvalues = linspace (1 , 1e-1, d);
elseif strcmp(type, 'UB') || strcmp(type, 'NB')
    singularvalues = logspace(0, -6, d);
end

X = U * diag(singularvalues) * orth(randn(d));

end


function [covMatrix] = GenerateCovMatrix(p)
covMatrix = zeros(p);
for i = 1: p
    for j = 1: p
        covMatrix(i, j) = 2 * 0.5^(abs(i-j));
    end
end
end