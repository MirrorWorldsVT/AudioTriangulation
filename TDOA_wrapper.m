function [ output_array ] = TDOA_wrapper( input_array )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[numSamples, n] = size(input_array);

%n*(n-1)/2
timediff = zeros(n*(n-1)/2 , 1);
corr = zeros(n*(n-1)/2 , 1); 
lag = zeros(n*(n-1)/2 , 1);

for i = 1:(n-1)
    for j = (i+1):n
        audio_one = input_array(:,i);
        audio_two = input_array(:,j);
        [timediff(i+(j-1)), corr(i+(j-1)), lag(i+(j-1))] = TDOA(audio_one, audio_two, 48000);
        %replace 48k with dynamic microphone sample rate
    end
end

timediff
corr
lag

end

