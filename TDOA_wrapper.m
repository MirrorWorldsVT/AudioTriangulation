function [ output_array ] = TDOA_wrapper( input_array )
%TDOA_wrapper calls the TDOA function with each pair of microphones in the array.

[numSamples, n] = size(input_array);

timediff = zeros(n*(n-1)/2, 1);
corr = zeros(n*(n-1)/2 , 1);
lag = zeros(n*(n-1)/2 , 1);
count = 1;

ind = 1;

for i = 1:(n-1)
    for j = (i+1):n
        audio_one = input_array(:,i);
        audio_two = input_array(:,j);
        [timediff(count), ~, ~] = TDOA(audio_one, audio_two, 48000);
        count = count + 1;
    end
end

output_array = timediff;

end