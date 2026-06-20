clear; close all; clc;

% 3次元曲面データ作成
N = 30;
r = 8;
xstep = 2*pi/N;
ystep = 2*pi/N;

x = -r:xstep:r;
y = -r:ystep:r;
[x, y] = meshgrid(x, y);

d = sqrt(x.^2 + y.^2);
z = sin(d)./d;

% 中心点を補正
z(d == 0) = 1;

% 表示設定
fig = figure(1);
colormap copper;

elevation = 30;      % 形状が見やすい仰角
az_step = 2;         % 滑らかな回転表示
az_list = 0:az_step:360;

% 動画作成
video = VideoWriter('rotation.mp4', 'MPEG-4');
video.FrameRate = 30;
open(video);

for azimuth = az_list

    % 曲面表示
    surf(x, y, z);

    % 凹凸が見やすくなるように設定
    shading interp;
    lighting phong;
    lightangle(45, 45);

    % 表示範囲を固定
    xlim([-r r]);
    ylim([-r r]);
    zlim([-0.5 1]);

    xlabel('x');
    ylabel('y');
    zlabel('z');

    % 水平方向に回転
    view(azimuth, elevation);
    title(['azimuth = ', num2str(azimuth), ' deg']);

    % フレーム保存
    frame = getframe(fig);
    writeVideo(video, frame);
end

close(video);