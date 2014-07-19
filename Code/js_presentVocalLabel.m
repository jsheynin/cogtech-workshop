function js_presentVocalLabel(trial,scr,timing)
            Screen('TextSize', scr.wPtr, scr.instructText);
            Screen('DrawText', scr.wPtr, '   Pay attention to the following written tone:'...
                ,scr.instructTextPosX, scr.instructTextPosY, scr.instructTextCo);
            
            
            Screen('Flip', scr.wPtr )
            WaitSecs(timing.shortPause)
            
            
            Screen('TextSize', scr.wPtr, scr.toneText);
            Screen('DrawText', scr.wPtr, sprintf('%s',trial.toneName) ,scr.tonePosX, scr.tonePosY, scr.toneCo)
            Screen('Flip', scr.wPtr )
            WaitSecs(timing.shortPause)
end