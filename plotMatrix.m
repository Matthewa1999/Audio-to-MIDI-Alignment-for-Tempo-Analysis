function [pltMatrix, path] = plotMatrix(pMatrix)
% Path is [Performance, Midi]
c = length(pMatrix(1,:));
r = length(pMatrix(:,1));
path = [r,c];

%begins at end of matrix, r is maximum and c is maximum
while r > 1 || c > 1
    %determines what direction that index came from, changes c and/or r to
    %go to that index next, and saves that index in path array
    if pMatrix(r,c) == 0 %left
        c = c-1;
        path = [path;[r,c]];
    elseif pMatrix(r,c) == 1 %up
        r = r-1;
        path = [path;[r,c]];
    else %diagonal
        c = c-1;
        r = r-1;
        path = [path;[r,c]];
    end
end

%distance plot model
pltMatrix = zeros(size(pMatrix));

% assigns a 1 for each index referenced by the path array
for i = 1:length(path)
    a = path(i,1);
    b = path(i,2);
    pltMatrix(a,b) = 1;
end


end