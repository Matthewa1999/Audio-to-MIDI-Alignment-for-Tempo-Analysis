**audioScoreAlignment**

This script functions as the main body, with calls to all other functions. The user does not need to edit
or access any of the other functions.

There is a User Input section at the top of audioScoreAlignment where you may input the following:
	
midiFilename: 
this should be the string of the midi file that is already in the file path
ex. 'Test.mid'
	
performanceFilename:  
this should be the string of the performance wav/mp3 file that is already in the file path
ex. 'Test.mp3'
	
displayPath: 
boolean to display the alignment path plot 
(true/false)
	
displayDmat: 
boolean to display the distance matrix heat map 
(true/false)

displayTemp: 
boolean to display the tempo curve of the performance 
(true/false)

tempoSet: 
numeric user approximation of performance tempo bpm, default is 120

sampleLimit: 
numeric sample limit for computational purposes, if the value is 0, the FULL audio is computed.

The ext code is necessary for the script to run, so it must be added to the path.

**testing**

There is one test set (1 midi file and 1 mp3 file, titled the same as the examples above), and the file strings are already input into the script midiFilename and performanceFilename. The performance mp3 is very large, so the sampleLimit of
2000000 (2 million) has been set. However, if different test files are used that have fewer than 2000000 samples, the code will error.

(Test run takes an average of 18-20 seconds on the machines we have used.)

After adding the ext folder to path, the script will be able to run.

The test piece is Joseph Haydn - Symphony No. 88 in G-Major.