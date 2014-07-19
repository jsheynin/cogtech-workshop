
% Absolute Pitch Perception
% Define Parameters && Run Experiment Script
% Jacob Sheynin, June 2014
function [file, stim, scr, timing, audio]=js_apParameters

% define parameters
% file.maindir='/Users/Jacob/Documents/Work and Research/Berkeley Silver Lab/Absolute Pitch/Completed CODE 6 30';
file.maindir='/Users/Jacob/Dropbox/Research - Absolute Pitch Performance/Code';
file.subjectID=input('Enter the Subject ID: ', 's');
file.run=input('Enter the run number: ');
file.tonePath=[file.maindir '/stimuli'];
file.timeStamp = datestr(now, 'ddmmmyyyy');
file.dataPath = [file.maindir '/data'];
file.recordPath=sprintf('%s/recordings/%s',file.dataPath, file.subjectID);

file.runStr=[file.subjectID,'_', sprintf('run0%d', file.run)];
file.fileName = [file.dataPath,'/' file.runStr, '_AbsolutePitch_IdVocalInstrumental_',file.timeStamp ];






stim.vocalLabel=0;% 1 or 0% vocal task (2) label (written tone) or sound option, defaults to
stim.vocalSound=1;% 1 or 0% vocalSound
stim.whiteNoiseOn=1;
stim.tasks={'ID', 'Vocal', 'Instrumental'}; 
stim.timbres={'Pure Tone', 'Piano', 'Violin', 'Clarinet'}; %'Bb Clarinet 'Voice' 
stim.tones={'B'  'C',  'C#/Db', 'D',  'D#/Eb',  'E', 'F',  'F#/Gb','G',  'G#/Ab','A','A#/Bb'};
stim.nTones=12;  % tones in octave
stim.nOctaves=2;    % 1:2 (2 octave range B3-Bb5) starting at Octave(1) is the third octave (i.e. B3) on a keyboard
stim.numReps=1;
stim.numRuns=2; % will make sure there is an equal num trials/run
stim.trialsPerRun=stim.nTones*stim.nOctaves*numel(stim.timbres)*...
    numel(stim.tasks)*stim.numReps/stim.numRuns;
stim.tasks={'ID', 'Vocal', 'Instrumental'};  % should align with nTasks, < than 3 will only count first 2
stim.validResponses={ '1'  '2'   '3'    '4'     '5'      '6'      '7'      '8'     '9'     '0'     '-'   '='};
stim.freqs=[...
    246.94
    261.63
    277.18
    293.66
    311.13
    329.63
    349.23
    369.99
    392.00
    415.30
    440.00
    466.16
    493.88
    523.25
    554.37
    587.33
    622.25
    659.25
    698.46
    739.99
    783.99
    830.61
    880.00
    932.33];
stim.freqMat=zeros(12, stim.nOctaves);
stim.freqMat(:,1)=stim.freqs(1:12);
stim.freqMat(:,2)=stim.freqs(13:end);

scr.screenNum = 0;
Screen('Preference', 'VisualDebugLevel', 3); %replaces startup screen
[scr.wPtr]=Screen('OpenWindow', scr.screenNum);
scr.black=BlackIndex(scr.wPtr);
scr.white=WhiteIndex(scr.wPtr);
scr.gray=GrayIndex(scr.wPtr);
scr.instructText=30;
scr.subInstructText=20;
scr.instructTextCo=[ 0 0 0];
scr.instructTextPosX=50;
scr.instructTextPosY=200;
scr.idOptionTextCo=[128 0 0];
scr.TimerTextSize=75;
scr.timePosX=100;
scr.timePosY=200;
scr.timeCo=[128 0 0];
scr.recCo=[128 0 0];
scr.toneText=80;
scr.toneCo=[0 0 0];
scr.tonePosX=100;
scr.tonePosY=300;

timing.dur=2;   % length of timer(in seconds)
timing.instr=1; % on or off timer instrument recording
timing.voc=1; % on or off timer vocal instrument recording
timing.shortPause=.1;
timing.recordTime=1; % (s) for recording
timing.timeAllowed = 10; %time (S) allowed to make a keypress for ID task and to record% on or off timing vocal recording

% audio parameters
audio.toneDur=.8;
audio.nChannels = 2;     % play stereo
audio.fs = 44100; % sampling rate
audio.nBits=16;
audio.pahandle = PsychPortAudio('Open', [], [], 0, audio.fs, audio.nChannels);

%sound volume
audio.pureToneVolume = .5;
audio.whiteNoiseVolume=.5; 
audio.pianoVolume=12;
audio.violinVolume=10;
audio.clarinetVolume=1.5;

audio.setTimeIntervals = 0:(1/audio.fs):audio.toneDur;
audio.setTimeIntervals = audio.setTimeIntervals(1:end-1);
audio.rampDur_ms = 10; % ramp duration (beginning and end) cosinus: 5 ms
audio.rampDur_samples = round(audio.fs*(audio.rampDur_ms/1000)); % duration  of  ramps in samples
audio.Freq_ramp = 1/(2*(audio.rampDur_ms/1000)); % frequence of the cosine gate
audio.temps = 1:audio.rampDur_samples; % generate ramp vector
audio.onset  = (1 + sin(2*pi*audio.Freq_ramp*audio.temps./audio.fs + (-pi/2)))/2;
audio.offset = (1 + sin(2*pi*audio.Freq_ramp*audio.temps./audio.fs + (pi/2)))/2;

audio.timeIntervalWN = 0:(1/audio.fs):timing.recordTime+10;
audio.timeIntervalWN = audio.timeIntervalWN(1:end-1);
audio.whiteNoise = Shuffle(audio.whiteNoiseVolume*(sin(2*pi*stim.freqs(1)*audio.timeIntervalWN)));
audio.whiteNoise = repmat(audio.whiteNoise, 2, 1);






%% refine parameters to match options

if exist([file.fileName '.mat'], 'file')  && ~strcmp(file.subjectID, 'test')
    error('A file with this name already exists! Subject ID "test" will not give this error.')
end


if ~exist([file.dataPath], 'file')
    mkdir(file.dataPath)
end


if ~exist([file.recordPath], 'file')
    mkdir(file.recordPath)
end


if rem(stim.trialsPerRun,1)~=0
    error('Uneven trials per run. Check numRuns')
end


if stim.vocalLabel && stim.vocalSound
    error('vocal task cannot be both label and sound. choose one.')
end



end









