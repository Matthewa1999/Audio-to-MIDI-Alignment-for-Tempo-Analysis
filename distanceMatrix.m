function dMatrix = distanceMatrix(input_rows,input_cols)

dMatrix = zeros(length(input_rows(1,:)),length(input_cols(1,:)));
for i = 1:length(input_rows(1,:))
    for j = 1:length(input_cols(1,:))
        % each chroma bin of performance
        p = input_rows(:,i);
        % each chroma bin of midi
        m = input_cols(:,j);
        % calculates euclidean distance between them
        dMatrix(i,j) = eDistance(p,m);
    end
end

end