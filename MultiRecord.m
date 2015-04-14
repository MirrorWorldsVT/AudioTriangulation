UsingTestPlatform = false; %Remember to use ASIO for non-test platform
CreateOutputFile = false;
TimeToRecord = 30;

if (CreateOutputFile)
    AFW = dsp.AudioFileWriter('MultiRecordOut.wav','FileFormat', 'WAV');
end
H = dsp.AudioRecorder;
H.QueueDuration = 2;
H.OutputNumOverrunSamples = true;
H.SamplesPerFrame = 48000;

if UsingTestPlatform == false
    H.SampleRate = 48000; %Our Audio-Technica mics record at 48000
    H.NumChannels = 2; %Set to number of mics
else
    disp('Using Test');
end


disp('Microphones Recording...');
tic;
count = 0;
totalRecording = zeros((H.SampleRate*TimeToRecord),H.NumChannels);
while toc < TimeToRecord
  [audioIn,nOverrun] = step(H);
  if (CreateOutputFile)
    step(AFW,audioIn);
  end
  
  time_diff = TDOA_wrapper(audioIn);
  %disp(time_diff*340*39.3701) %Time difference in inches
  disp((221-(time_diff*340.29*39.3701))/2) %Distance from 1 microphone on a line in a 2 mic system
  %plot(audioIn)
  %drawnow
  
  totalRecording(H.SamplesPerFrame*count+1:H.SamplesPerFrame*count+H.SamplesPerFrame, :) = audioIn;
  if nOverrun > 0
    fprintf('Audio recorder queue was overrun by %d samples\n'...
        ,nOverrun);
  end
  count = count + 1;
end
if (CreateOutputFile)
    release(AFW);
end
release(H);
disp('Recording complete'); 