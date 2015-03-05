function [ timeDiff, corr, lag ] = livestream_TDOA(  )
%function to find time difference of arrival using two live audio streams
%   

%Visualization of audio spectrum frame by frame
%Create system objects and initialize them
Microphone = dsp.AudioRecorder;
%Speaker = dsp.AudioPlayer;
SpecAnalyzer = dsp.SpectrumAnalyzer;

%process frame-by-frame in a loop
%will need two loops for two different microphones
tic;
sec = 10;
Fs = Microphone.SampleRate;
totalRecording = zeros((Fs*sec),2);
while (toc < sec)
    audio = step(Microphone);
            step(SpecAnalyzer, audio);
            %step(Speaker, audio);
    totalRecording = vertcat(totalRecording, audio);
end

%convertSamplesToSeconds = (1:length(audio))/Fs;
plot(1:length(totalRecording(1:end,1)), totalRecording(1:end,1))
axis([0,length(totalRecording)/Fs,-1,1])
title('Post-padded Audio (Simulated closer mic)')
ylabel('Amplitude')


%copied from TDOA.m
%[corr, lag] = correlation(audio_one, audio_two); %Find the correlation of the audio input
%[~, index] = max(corr); %Get the index with the maximum correlation
%When self-correlating to find echos, find the min(corr) because the audio
%should be its opposite (after reflecting off of a wall)

%lagDiff = lag(index); %Find the sample associated with the maximum correlation
%timeDiff = lagDiff/Fs; %Find the time difference in seconds

end

