function [  ] = MultiRecord( )
%totalRecording is output!


UsingTestPlatform = false; %Remember to use ASIO for non-test platform
CreateOutputFile = false;
TimeToRecord = 20;
NumberOfMicrophones = 2;
MicDist = 100;
LiveGraph = false; %false? ***********
SoundSpeed = 13397.2441; %Speed of sound in inches per second

tempDistQueue = zeros(100, 1);
i = 1;

if (CreateOutputFile)
    AFW = dsp.AudioFileWriter('MultiRecordOut.wav','FileFormat', 'WAV');
end
H = dsp.AudioRecorder;
H.QueueDuration = 2; %Store 2 seconds of audio in the queue
H.OutputNumOverrunSamples = true; %Report when audio samples are lost
H.SamplesPerFrame = 48000; %1 Frame = 1 Second of audio

if UsingTestPlatform
    disp('Using Test Platform');
    H.NumChannels = 2;
else
    H.SampleRate = 48000; %Our Audio-Technica mics record at 48000
    H.NumChannels = NumberOfMicrophones;
end

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
  %disp(time_diff*SoundSpeed) %Time difference in inches
  disp((MicDist-(time_diff*SoundSpeed))/2) %Distance from 1 microphone on a line in a 2 mic system
  
  tdoaDist = (MicDist-(time_diff*SoundSpeed))/2;
  %displaySoundSource(MicDist, tdoaDist);
  
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

j = 1;
ave = 0;
while j < i
   ave = tempDistQueue(j) + ave;
   j = j + 1;
end

average = ave/i
displaySoundSource(MicDist, average);


end