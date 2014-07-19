function js_presentRecordScreen(scr)
Screen('DrawText', scr.wPtr, sprintf('Recording '), ...
    scr.instructTextPosX, scr.instructTextPosY, scr.recCo);
Screen(scr.wPtr, 'Flip');Screen('TextSize', scr.wPtr, scr.instructText);
Screen('DrawText', scr.wPtr, sprintf('Recording '), ...
    scr.instructTextPosX, scr.instructTextPosY, scr.recCo);
Screen(scr.wPtr, 'Flip');
end
