
function js_AbsolutePitch_IdVocalInstrumental
%% designate directories and run experiment

[file, stim, scr, timing, audio]=js_apParameters;
cd(file.maindir);
addpath(pwd)


%% display stuff

Screen('FillRect',scr.wPtr,scr.gray);
Screen(scr.wPtr, 'Flip');

% prepare for PsychPortAudio
InitializePsychSound(1); %1 for precise timing; 0 for not


% prepare for recording
audio.recObj=audiorecorder(audio.fs,audio.nBits,audio.nChannels);

% create stimulus array/response
[responseArray,runArray,stim]=js_generateResponseArray(stim,file);

for i = 1:numel(runArray)
    
    % get trial info
    %takes ith trial in randomized runArray
    %
    trial.currentTrial = runArray(i);
    trial.toneName=responseArray(trial.currentTrial).toneName;
    trial.whichOctave=responseArray(trial.currentTrial).whichOctave;
    trial.whichTimbre=responseArray(trial.currentTrial).whichTimbre;
    trial.freq=responseArray(trial.currentTrial).freq;
    trial.task=responseArray(trial.currentTrial).whichTask;
    
    % generate trial tone sound
    [trial.mytone]=js_generateTrialTone(trial,audio,file);
    
    %present tone sound/tone label
    
    if ~strcmp(trial.task,'Vocal') || strcmp(trial.task,'Vocal') && stim.vocalSound
        js_presentTrialTone(trial,audio,scr)
        
    elseif stim.vocalLabel
        js_presentVocalLabel(trial,scr,timing)
        
    end
    
    %% present tasks
    
    if strcmp(trial.task,'ID')
        js_presentIDtask(scr)
        [responseArray]=js_getKeypress(responseArray,stim, timing, trial, scr);
        
        
    elseif strcmp(trial.task, 'Vocal')
        js_presentVocalTask(scr)
        [responseArray]=js_getKeypress(responseArray,stim,timing, trial, scr);
        if timing.voc 
            js_presentTimerToRecord(timing, scr)
        end
    else
        js_presentInstrumentalTask(scr)
        [responseArray]=js_getKeypress(responseArray,stim,timing, trial, scr);
        if timing.instr
            js_presentTimerToRecord(timing, scr)
        end
    end
    
    
    % record audio responses
    if ~strcmp(trial.task,'ID') && ...
            ~strcmp(responseArray(trial.currentTrial).responseKey,'DNR')
        
        js_presentRecordScreen(scr)
        js_recordAudioResponse(stim,audio,timing,file,trial)
        
        
    end
        save(file.fileName, '-struct', 'file', 'subjectID', 'timeStamp', 'run')
        save(file.fileName, '-struct', 'stim', 'randomOrderVector')
        save(file.fileName ,'responseArray','runArray','scr', 'file', 'stim', 'audio', 'timing')
        
end




save(file.fileName, '-struct', 'file', 'subjectID', 'timeStamp', 'run')
save(file.fileName, '-struct', 'stim', 'randomOrderVector')
save(file.fileName ,'responseArray','runArray','scr', 'file', 'stim', 'audio', 'timing')

PsychPortAudio('Close', audio.pahandle);




end





















