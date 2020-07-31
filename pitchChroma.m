function pitch_chroma = pitchChroma(X,fs,blockSize)
tfInHz = 440;

%allocate memory for output, 12 rows by numBlocks columns
a = size(X);
row = a(1);
col = a(2);
pitch_chroma = zeros(12,col);
    
%filters for 12 pitch classes within range of c3-b5
pcBlock = zeros(12,1);
numBlocks = (1:col);
pcs = (1:12);
pcSum = zeros(1,3);
h = [1,2,3];

for j = numBlocks

    for i = pcs
        %plus and minus 50 cents for frequency window for each octave
        baseFreq = tfInHz * (2)^((i-22)/12);
        uFreqs = [baseFreq*(2)^(0.5/12), baseFreq*(2)^(12.5/12), baseFreq*(2)^(24.5/12)];
        lFreqs = [baseFreq*(2)^(-0.5/12), baseFreq*(2)^(11.5/12), baseFreq*(2)^(23.5/12)];
        
        uBins = cast(ceil(uFreqs.* (blockSize/fs)),'like',h);
        lBins = cast(floor(lFreqs.* (blockSize/fs)),'like',h);
        
        for z = (1:3)
            U = uBins(1,z);
            L = lBins(1,z);
            pcSum(1,z) = (1/(U - L + 1))*sum(X(L:U,j));
        end
        
        pcBlock(i,1) = sum(pcSum);
    end
    
    if all(pcBlock == 0)
        normBlock = pcBlock;
    else
        normBlock = pcBlock/sum(pcBlock);
    end
    pitch_chroma(:,j) = normBlock;

end



end 