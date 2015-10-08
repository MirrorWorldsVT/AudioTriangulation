function [corr, lag] = correlation(a,b)
%CORRELATION calculates the cross-correlation between a and b
%http://stackoverflow.com/questions/7396814/cross-correlation-in-matlab-without-using-the-inbuilt-function
%Duplicates the xcorr() function without using the MatLAB signal processing toolbox

corrLength = length(a) + length(b) - 1;
%corrLength = maxlag
corr = fftshift(ifft(fft(a, corrLength) .* conj(fft(b, corrLength))));
lag = -(length(a) - 1) : length(a) - 1;
end