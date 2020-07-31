function [cMatrix, pMatrix] = cost_path_matrices(dMatrix)

%initialize cost matrix
cMatrix = dMatrix;

%rewrite cost matrix with cumulative first row 
%and first column for cost
cMatrix(1,:) = cumsum(cMatrix(1,:));
cMatrix(:,1) = cumsum(cMatrix(:,1));

pMatrix = zeros(size(cMatrix));
% zero matrix so first row is already correct with 0 (left)
% denotes that first column all come from 1 (up)
pMatrix(:,1) = 1;

% [DIRECTION KEY]
% left = 0
% up = 1
% diagonal = 2

for y = (2:length(cMatrix(:,1)))
    for x = (2:length(cMatrix(1,:)))
    % current index of cMatrix
    ind = cMatrix(y,x);
    % cost value of adjacent index to the left
    left = cMatrix(y,x-1);
    %cost value of index above
    up = cMatrix(y-1,x);
    %cost value of index diagonally up and to the left
    diagonal = cMatrix(y-1,x-1);
    
    %array of all of the cost candidates
    options = [left,up,diagonal];
    
    % finds which option had the lowest cost value; gives priority to
    % diagonal
    % Sets value of path matrix to corresponding direction value
    if diagonal == min(options)
        cMatrix(y,x) = ind + diagonal;
        pMatrix(y,x) = 2;

    elseif up == min(options)
        cMatrix(y,x) = ind + up;
        pMatrix(y,x) = 1;

    else
        cMatrix(y,x) = ind + left;
        pMatrix(y,x) = 0;
    end
    
    end
    
end


end