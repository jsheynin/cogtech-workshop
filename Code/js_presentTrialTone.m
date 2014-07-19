
function js_presentTrialTone(trial,audio,scr)


PsychPortAudio('FillBuffer', audio.pahandle, trial.mytone);

Screen('TextSize', scr.wPtr, scr.instructText);
Screen('DrawText', scr.wPtr, 'Listen to the following sound:'...
    ,scr.instructTextPosX, scr.instructTextPosY, scr.instructTextCo);
Screen(scr.wPtr, 'Flip');

WaitSecs(1)
PsychPortAudio('Start', audio.pahandle, 1, 0, 1);
WaitSecs(audio.toneDur) %this is necessary!

PsychPortAudio('Stop', audio.pahandle);


end