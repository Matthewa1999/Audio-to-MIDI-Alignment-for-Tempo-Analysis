
% USER INPUTS 
%*************************************************

%filenames
midiFilename = 'Test.mid';
performanceFilename = 'Test.mp3';

% Display the alignment path
displayPath = true;
%Display Distance matrix
displayDmat = true;
%Display Tempo plot
displayTemp = true;

% User approximation of tempo, default is 120
tempoSet = 120;

%optional sample limit, if zero - the FULL audio is computed, 
%if sampleLimit > 0  - limit is set to that value
sampleLimit = 0;

%*************************************************


%import and treat inputs
[pWave, mWave, fs, nmat] = treatInputs(performanceFilename, midiFilename, tempoSet);

%applies sample limit
if (sampleLimit>0) && (sampleLimit~=0)
    pWave = pWave(1,(1:sampleLimit));
    mWave = mWave(1,(1:sampleLimit));
    mSamples = sampleLimit;
    nmatMask = find(nmat(:,6)>(sampleLimit/fs));
    nmat(nmatMask,:) = [];
else
    mSamples = length(mWave);
end

%chromagram of midi
durations = dur(nmat,'sec');
[shortestNote, location] = min(durations);
mWin = floor(shortestNote*fs);
mS = abs(spectrogram(mWave,mWin));
mChroma = pitchChroma(mS, fs,mWin);

%chromagram of performance
pWin = mWin;
pS = abs(spectrogram(pWave,pWin));
pChroma = pitchChroma(pS, fs,pWin);

%distance matrix using euclidean distance
dMatrix = distanceMatrix(pChroma,mChroma);

%compute cost and path matrix
[cMatrix, pMatrix] = cost_path_matrices(dMatrix);

%plot path as 1 and other entries as 0 for visual
[pltMatrix, path] = plotMatrix(pMatrix);

%extract tempo curve from alignment
perfTemp = tempoExtraction(tempoSet,path,nmat,mSamples,mWin,pWin,fs);

%plots displays corresponding to user input booleans above
displayPlots(displayPath,displayDmat,displayTemp,pltMatrix,dMatrix,perfTemp)