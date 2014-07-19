function [mytone]=js_generateTrialTone(trial,audio,file)


    % Choose tone and fill buffer
    
    if strcmp(trial.whichTimbre,'Pure Tone')
        mytone = audio.pureToneVolume*(sin(2*pi*trial.freq*audio.setTimeIntervals));
        
        % create envelope to smooth out clicking
        mytone(1:length(audio.onset)) =  mytone(1:length(audio.onset)) .* audio.onset;
        mytone(end-length(audio.offset)+1:end) =  mytone(end-length(audio.offset)+1:end) .* audio.offset;
        
        % stereo sound - same sound in the 2 channels
        mytone = repmat(mytone, 2, 1);
        
        
    else
        
        if size(trial.toneName, 2)>1
            trial.toneName=trial.toneName(end-1:end);
        end
        
        toneFile=sprintf('%s/%s.%s%d.wav', file.tonePath, trial.whichTimbre,trial.toneName,trial.whichOctave);
        [toneData,audio.fs] = wavread(toneFile);
        mytone = toneData';
        channels = size(mytone, 1);
        
        switch trial.whichTimbre
            case {'Piano'}
            mytone=audio.pianoVolume*mytone;
            case {'Violin'}
            mytone=audio.violinVolume*mytone;
            case{'Clarinet'}
                mytone=audio.clarinetVolume*mytone;
        end
        
        
        if channels~=audio.nChannels
            mytone = repmat(mytone, 2, 1);
            
        end
        
        
        
        
    end
end

    
