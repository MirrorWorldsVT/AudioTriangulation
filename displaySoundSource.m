function [ ] = displaySoundSource( dist, TDoA)

mic = imread('mic.jpg');
ss = imread('ss.png');

distanceArray = linspace(0, dist, 1000);
sourceArray = linspace(0, TDoA, 1000);

distanceHeight = linspace(3, 3, 1000);
sourceHeight = linspace(5, 5, 1000);

subplot (1, 1, 1); 
cla
plot(distanceArray, distanceHeight, 'm', 'LineWidth', 2);
hold on;
plot(sourceArray, sourceHeight, 'g', 'LineWidth', 2);
hold on;

%info = imfinfo('mic.png');

x1 = [.75 0.05];
y1 = [2.5 1.5];
%mic1 = mic;
%mic = imresize(mic, 500);
%mic = imcomplement(mic);
%mic(:,1,:) = 0;
%imagesc(x1, y1, mic)
image(x1, y1, mic)
hold on;

x2 = [dist-.05 dist-.75];
y2 = [2.5 1.5];
image (x2, y2, mic)
hold on;

x3 = [TDoA+.25 TDoA-.25];
y3 = [4.5 3.5];
ss = imresize(ss, 500);
ss = imrotate(ss, -90);
image(x3, y3, ss)
hold on;


axis([0, dist, 1, 7])
%x2 = [(dist-0.5) 0];
%y2 = [dist 0.5];
%image (x2, y2, mic)