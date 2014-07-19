function [responseArray,runArray,stim]=js_generateResponseArray(stim,file)

%%% creates response array 

trialNum=1;

for numRep=1:stim.numReps
    
    for iTask=1:numel(stim.tasks)
        
        for iTone=1:numel(stim.tones)
            
            for iOctave=1:stim.nOctaves
                
                for iTimbre=1:numel(stim.timbres)
                    
                    responseArray(trialNum).whichTask=stim.tasks{iTask};
                    responseArray(trialNum).whichTone=iTone;
                    responseArray(trialNum).toneName=stim.tones{iTone};
                    responseArray(trialNum).whichOctave=iOctave+3;
                    
                    if strcmp(responseArray(trialNum).toneName,'B')
                        responseArray(trialNum).whichOctave=responseArray(trialNum).whichOctave-1;
                        
                    end
                    
                    responseArray(trialNum).whichTimbre=stim.timbres{iTimbre};
                    responseArray(trialNum).freq=stim.freqMat(iTone,iOctave);
                    
                    if iTask
                        responseArray(trialNum).correctResponse=stim.validResponses{iTone};
                    end
                    
                    
                    trialNum=trialNum+1;
                    
                end
            end
        end
    end
end

totalNumTrials = trialNum - 1;

stim.randomOrderVector = randperm(totalNumTrials);


if file.run==1
    runArray=stim.randomOrderVector(1:stim.trialsPerRun);
else
    cd('data')
    load(sprintf('%s_run01_absolutePitch_IdVocalInstrumental*.mat',file.subjectID,file.timeStamp), 'stim', 'file', 'scr', 'audio', 'timing')
    runArray=randperm(stim.randomOrderVector(stim.trialsPerRun*(file.run-1)+1:stim.trialsPerRun*file.run));
end


