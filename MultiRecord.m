AFW = dsp.AudioFileWriter('MultiRecordOut.wav','FileFormat', 'WAV');
UsingTestPlatform = true; %Remember to use ASIO for non-test platform
TimeToRecord = 5;

H = dsp.AudioRecorder;
H.QueueDuration = 2;
%H.SamplesPerFrame = 48000;
H.OutputNumOverrunSamples = true;

if UsingTestPlatform == false
    H.SampleRate = 48000; %Our Audio-Technica mics record at 48000
    H.NumChannels = 3; %Set to number of mics
else
    disp('Using Test');
end



disp('Microphones Recording...');
tic;
count = 0;
totalRecording = zeros((H.SampleRate*TimeToRecord),H.NumChannels);
while toc < TimeToRecord,
  [audioIn,nOverrun] = step(H);
  %step(AFW,audioIn);
  totalRecording(H.SampleRate*count+1:H.SampleRate*count+H.SamplesPerFrame, :) = audioIn;
  if nOverrun > 0
    fprintf('Audio recorder queue was overrun by %d samples\n'...
        ,nOverrun);
  end
  count = count + 1;
end
release(AFW);
release(H);
disp('Recording complete'); 