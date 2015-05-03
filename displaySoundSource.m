function [ ] = displaySoundSource( dist, TDoA)

mic = imread('mic.jpg');
ss = imread('ss.png');

distanceArray = linspace(0, dist, 1000);
sourceArray = linspace(0, TDoA, 1000);

distanceHeight = linspace(1.5, 1.5, 1000);
sourceHeight = linspace(2, 2, 1000);

str1 = ['\bf \leftarrow TDoA = ', num2str(TDoA), ' in'];
%str2 = ['\bf \downarrow ', num2str(dist), ' in'];


subplot (1, 1, 1); 
cla
plot(distanceArray, distanceHeight, 'm', 'LineWidth', 2);
hold on;
plot(sourceArray, sourceHeight, 'g', 'LineWidth', 2);
hold on;

text(TDoA, 2, str1, 'HorizontalAlignment', 'left');
%text(dist, :, str2);

x1 = [6 1];
y1 = [1.4 1.2];
image(x1, y1, mic)
hold on;

x2 = [dist-1 dist-6];
y2 = [1.4 1.2];
image (x2, y2, mic)
hold on;

x3 = [TDoA+2.5 TDoA-2.5];
y3 = [1.85 1.6];
ss = imresize(ss, 500);
ss = imrotate(ss, -90);
image(x3, y3, ss)
hold on;

title('Biangulation Demo')
xlabel('Distance (in)')
axis([0, dist, 0.6, 2.8])