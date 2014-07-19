
function js_recordAudioResponse(stim,audio,timing,file,trial)
% option to turn on white noise during recording
if stim.whiteNoiseOn
    
    PsychPortAudio('FillBuffer', audio.pahandle, audio.whiteNoise);
    PsychPortAudio('Start', audio.pahandle, 1, 0, 1);
end

tNoise = GetSecs;
WaitSecs(.01)

FlushEvents %removes keypress events
stop = tNoise + timing.recordTime+.01;

while GetSecs<stop
    recordblocking(audio.recObj, timing.recordTime);
    audioresponse=getaudiodata(audio.recObj,'int16');
    
end

if stim.whiteNoiseOn
    PsychPortAudio('Stop', audio.pahandle);
    
end

wavwrite(audioresponse, audio.fs, sprintf('%s/%s_trial_%d.wav',...
    [file.recordPath], file.runStr, trial.currentTrial))
