function [pWave, mWave, fs, nmat] = treatInputs(performanceFilename, midiFilename, tempoSet)

%input audio
[pWave,fs] = audioread(performanceFilename);
%ensures performance file is mono
[~,channels] = size(pWave);
if channels > 1
pWave = sum(pWave, 2) / size(pWave, 2);
end
% trims silence at beginning
firstReal = find(pWave~=0,1,'first');
pWave(1:(firstReal-1)) = [];
% transpose
pWave = pWave';


%creates arr of rhythmic lengths quantized to 32nd note value
beatLength = 60/tempoSet;
thirty2 = beatLength/8;
noteLengths = (1:60).*thirty2;
%read in midi
nmatOriginal = readmidi(midiFilename);
%adjusts note lengths to fit tempoSet
nmatT = settempo(nmatOriginal,tempoSet);
%trims silence
nmat = trim(nmatT);
%rounds every note duration to a multiple of 32nd note for rhythmic
%consistency
for i = 1:length(nmat(:,7))
    [~, indx] = min(abs(noteLengths - nmat(i,7)));
    nmat(i,7) = indx*thirty2;
end
% makes time onsets correspond to beat onsets
nmat(:,6) = nmat(:,1) .* beatLength;
% creates audio signal from note matrix
mWave = nmat2snd(nmat,'fm',fs);

end
