function js_presentVocalTask(scr)
Screen('TextSize', scr.wPtr, scr.instructText);

Screen('DrawText', scr.wPtr, '   Now reproduce the note with your voice:'...
    ,scr.instructTextPosX, scr.instructTextPosY, scr.instructTextCo);
Screen('TextSize', scr.wPtr, scr.subInstructText);
Screen('DrawText', scr.wPtr, '   (Press any key to begin countdown for recording.)',...
    scr.instructTextPosX, scr.instructTextPosY+120, scr.instructTextCo);
Screen(scr.wPtr, 'Flip')
end