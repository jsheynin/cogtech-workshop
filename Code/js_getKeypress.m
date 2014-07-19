    %%  Get Kbresponse.
    function[responseArray]=js_getKeypress(responseArray,stim, timing, trial, scr)
    % keypress info
    tStim = GetSecs;
    WaitSecs(.01)
    
    FlushEvents %removes keypress events
    stop = tStim + timing.timeAllowed;
    
    while GetSecs < stop
        [keyIsDown, secs, keyCode] = KbCheck;
        if keyIsDown
            break
            
        else
            keyCode = 60000; 
           
        end
    end
    
    RT = secs - tStim;
    responseArray(trial.currentTrial).RT = RT;
    responseKey = KbName(keyCode);
    responseKey=responseKey(1);
     
    
    
    
    if ismember(responseKey, stim.validResponses)
        responseArray(trial.currentTrial).responseKey = responseKey;
    
    elseif strcmp(trial.task, 'ID')
        responseArray(trial.currentTrial).responseKey = responseKey;
        Screen('TextSize', scr.wPtr, scr.instructText);
        Screen('DrawText', scr.wPtr, 'WARNING: Please use the appropriate keys to identify the tone', ...
            scr.instructTextPosX, scr.instructTextPosY, scr.idOptionTextCo);
        Screen(scr.wPtr, 'Flip');
        WaitSecs(timing.shortPause);
        
    end
    
        if keyCode == 60000
        responseArray(trial.currentTrial).responseKey='DNR';
        end
        
        
        
        
    end