function [ timeDiff, corr, lag ] = TDOA( audio_one, audio_two, Fs )
%TDOA calculates the time difference of arrival between two audio sources

%maxlag = floor((210/13397.2441)*Fs);
[corr, lag] = correlation(audio_one, audio_two); %Find the correlation of the audio input
[~, index] = max(corr); %Get the index with the maximum correlation
%When self-correlating to find echos, find the min(corr) because the audio
%should be its opposite (after reflecting off of a wall)

lagDiff = lag(index); %Find the sample associated with the maximum correlation
timeDiff = lagDiff/Fs; %Find the time difference in seconds

end