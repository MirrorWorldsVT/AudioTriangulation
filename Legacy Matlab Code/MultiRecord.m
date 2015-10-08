function [  ] = MultiRecord( )

%--- Settings ---
CreateOutputFile = false; %Whether to save the recording to a WAV file
TimeToRecord = 20; %Time in seconds to record
NumberOfMicrophones = 2;
MicDist = 12; %The distance between the microphones in inches
LiveGraph = false; %Show the sound clips while recording
SoundSpeed = 13397.2441; %Speed of sound in inches per second

tempDistQueue = zeros(100, 1);
i = 1;

if (CreateOutputFile)
    AFW = dsp.AudioFileWriter('MultiRecordOut.wav','FileFormat', 'WAV');
end

H = dsp.AudioRecorder;
H.QueueDuration = 2; %Store 2 seconds of audio in the queue
H.OutputNumOverrunSamples = true; %Report when audio samples are lost
H.SamplesPerFrame = 48000; %This many frames = 1 Second of audio
H.SampleRate = 48000; %Our Audio-Technica mics record at 48000
H.NumChannels = NumberOfMicrophones;

disp('Microphones Recording...');
count = 0;
totalRecording = zeros((H.SampleRate*TimeToRecord),H.NumChannels);
tic;
while toc < TimeToRecord
  [audioIn,nOverrun] = step(H);
  if (CreateOutputFile)
    step(AFW,audioIn);
  end
  time_diff = TDOA_wrapper(audioIn);
  %disp(time_diff*SoundSpeed) %Time difference in sound inches
  
  tdoaDist = (MicDist-(time_diff*SoundSpeed))/2;
  
  disp(tdoaDist) %Distance from 1 microphone on a line in a 2 mic system
  
  displaySoundSource(MicDist, tdoaDist);
  drawnow
  
  if tdoaDist <= MicDist && tdoaDist >= 0
     tempDistQueue(i) = tdoaDist;
     i = i + 1;
  end
  
  if LiveGraph
    plot(audioIn)
    drawnow
  end
  
  totalRecording(H.SamplesPerFrame*count+1:H.SamplesPerFrame*count+H.SamplesPerFrame, :) = audioIn;
  if nOverrun > 0
    fprintf('Audio recorder queue was overrun by %d samples\n', nOverrun);
  end
  count = count + 1;
end

if (CreateOutputFile)
    release(AFW);
end
release(H);
disp('Recording complete');

end