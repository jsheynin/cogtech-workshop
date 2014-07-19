function js_presentTimerToRecord(timing, scr)

base=0;

while(base-1<timing.dur)
    time=timing.dur-base;
    Screen('TextSize', scr.wPtr, scr.TimerTextSize);
    Screen('DrawText', scr.wPtr, sprintf('%d',time), ...
        scr.timePosX, scr.timePosY, scr.timeCo);
    
    pause(1)
    base=base+1;
    Screen(scr.wPtr, 'Flip');
end
end

