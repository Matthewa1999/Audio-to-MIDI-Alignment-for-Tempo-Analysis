function [perfTemp] = tempoExtraction(tempoSet,path,nmat,mSamples,mWin,pWin,fs)

endTime = mSamples/fs;
beatDur = 60/tempoSet;
finalTime = endTime - mod(endTime,beatDur);
numBeats = finalTime/beatDur;

%numFours represents number of measures - 4/4 assumed
numFours = (numBeats-mod(numBeats,4))/4;

% floors the note onsets in beats, if there is a half note, it accurately
% shows the lack of onset on the second beat
flooredBeats = floor(nmat(:,1));

% Gets unique values of floored beats, so as to only consider downbeats
[uBeats,~,~] = unique(flooredBeats,'first');
uBeats = uBeats+1;

% Gets unique values of midi notematrix note onsets in beats (u1) 
% and seconds (u6) corresponding to columns 1 and 6 in nmat
[u1,~,~] = unique(nmat(:,1),'first');
u1 = u1+1;
[u6,~,~] = unique(nmat(:,6),'first');
u6 = u6+1;

% Array of measure beat alignments in 4/4
measureArr = (1:4:numBeats);

% Only selects the downbeats that are also measure downbeats.
uBeats = uBeats(ismember(uBeats,measureArr));


% Line 71 - now has been useful because now we don't 
% include measure downbeats where a note onset is not present

% if a uBeat value is not recorded specifically it can be interpreted from
% u1 and u6, the beat and time samples of note onsets and this
% supplies time values of uBeats
measureTimes = interp1(u1,u6,uBeats); 
% represents the beats per measure onsets, normally 4 but sometimes 8 or 
% more if measure(s) don't have downbeat onsets
uBDiff = diff(uBeats);
bins = floor(measureTimes*fs/mWin);

% makes it so that it begins with bin 1
if bins(1) ~= 1
    bins = bins - (bins(1) - 1);
end

% creates mask of desired midi bin locations in path array
% Path array is structured [Performance bin, midi bin]
binMask = (1:length(bins));
for w = (1:length(bins))
    new = find(path(:,2) == bins(w),1,'first');
    binMask(w) = new;
end

% extracts corresponding performance bins that align with midi measure
% bins and takes unique to avoid double mapping
perfBins = path(binMask,1);
[uperfBins,~,~] = unique(perfBins,'first');
% uses window size/fs to find corresponding time values in seconds
perfTimes = uperfBins * pWin/fs;
% calculates difference in seconds
perfDiff = diff(perfTimes);
% needs one more index for next step to match uBDiff
perfDiff = [perfDiff; perfDiff(end)];



% where there are values greater than 4 (indicating the lack of an onset
% on the downbeat of a measure, this appends new values (corresponding
% to the number of measures in a row without with a down beat) with an 
% averaged uniform time value that is the length of time divided by the 
% number of measures

notFour = find(uBDiff ~= 4);
if notFour>0 
    counterPerf = 0;
    for p = 1:length(notFour)
        newVals = (uBDiff(notFour(p)+counterPerf)/4)-1;
        origValue = perfDiff(notFour(p)+counterPerf);
        replaceValue = origValue/(newVals+1);
        perfDiff(notFour(p)) = replaceValue;
        perfShort = perfDiff(1:notFour(p)+counterPerf);
        replaces = ones(1,newVals)*replaceValue;
        perfAppend = [perfShort; replaces];
        perfBack = perfDiff(notFour(p) + counterPerf + newVals:end);
        perfDiff = [perfAppend;perfBack];
        counterPerf = counterPerf + newVals;
    end
end

% calculates tempo as if measure is a beat, then scales by 4
perfTemp = (60./perfDiff).* 4;
perfTemp(1) = [];



end