function [ totalRecording ] = MultiRecord( )

UsingTestPlatform = false; %Remember to use ASIO for non-test platform
CreateOutputFile = false;
TimeToRecord = 60;
NumberOfMicrophones = 2;
MicDist = 109;
LiveGraph = false;
SoundSpeed = 13397.2441; %Speed of sound in inches per second

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