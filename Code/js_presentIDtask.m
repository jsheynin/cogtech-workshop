function js_presentIDtask(scr)

        Screen(scr.wPtr, 'Flip');
        
        Screen('TextSize', scr.wPtr, scr.instructText);
        Screen('DrawText', scr.wPtr, '     Identify the pitch of the note using the keys listed in red'...
            ,scr.instructTextPosX, scr.instructTextPosY, scr.instructTextCo);
        Screen('DrawText', scr.wPtr, '     B       C       C#/Db      D        D#/Eb       E        F        F#/Gb       G        G#/Ab        A         A#Bb     '...
            ,scr.instructTextPosX, scr.instructTextPosY+150, scr.instructTextCo);
        Screen('DrawText', scr.wPtr, '     1       2         3        4          5         6        7          8         9          0           -          ='...
            ,scr.instructTextPosX+5, scr.instructTextPosY+250, scr.idOptionTextCo); 
        
        Screen(scr.wPtr, 'Flip');
end
