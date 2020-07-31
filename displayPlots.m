function displayPlots(displayPath,displayDmat,displayTemp,pltMatrix,dMatrix,perfTemp)
% display path
if displayPath
figure()
imagesc(pltMatrix)
title('Best Past of Alignment')
xlabel('MIDI')
ylabel('Performance')
end

% display Distance Matrix
if displayDmat
figure()
imagesc(dMatrix)
title('Distance Matrix')
xlabel('MIDI')
ylabel('Performance')
colorbar
end

% display performance tempo plot
if displayTemp
figure()
plot(perfTemp)
title('Tempo Curve (Each Measure of Performance)')
xlabel('Measures')
ylabel('Tempo (bpm)')
end

end