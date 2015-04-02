function [  ] = TDOATest(  )
%TDOATEST Tests the TDOA calculations and plots the results

%Change these variables to adjust the test
timeDelay = 1; %Artificial delay between signals in seconds
%lowest is 0.00002
audioSample = 'Test.wav'; %The mono audio sample with which to test


[rawaudio, Fs] = audioread(audioSample); %Read in test audio sample
padding = zeros(round(timeDelay*Fs), 1); %Makes 1 second of padding
prepadded_audio = vertcat(padding, rawaudio); %Simulates the further microphone by adding the padding before the sound sample
postpadded_audio = vertcat(rawaudio, padding); %Simulates the closer microphone and ensures the same length as the prepadded_audio

%Calculate the time difference of arrival, the signal corellation, and the lag
[timeDiff, corr, lag] = TDOA(prepadded_audio, postpadded_audio, Fs);

%Display the expected and calculated time differential
fprintf('We expect a Time Differential of %f second(s).\n', round(timeDelay*Fs)/Fs);
fprintf('The calculated Time Differential is %f second(s).\n', timeDiff);

%Plot the post-padded audio vs. time
subplot(3,1,1)
convertSamplesToSeconds = (1:length(postpadded_audio))/Fs;
plot(convertSamplesToSeconds, postpadded_audio)
axis([0,length(postpadded_audio)/Fs,-1,1])
title('Post-padded Audio (Simulated closer mic)')
ylabel('Amplitude')

%Plot the pre-padded audio vs. time
subplot(3,1,2)
convertSamplesToSeconds = (1:length(prepadded_audio))/Fs;
plot(convertSamplesToSeconds, prepadded_audio)
axis([0,length(prepadded_audio)/Fs,-1,1])
title('Pre-padded Audio (Simulated farther mic)')
ylabel('Amplitude')

%Plot the correlation vs. time
subplot(3,1,3)
plot(lag/Fs,corr)
axis([0,length(prepadded_audio)/Fs,-200,500])
title('Correlation vs. Time Difference')
xlabel('Time in Seconds')
ylabel('Correlation')

end

