%此文件作为主运行文件，调用函数，脚本，并得到降噪处理后的数据文件
%版本: 1.0 测试用，0次迭代
%作者: 陈羿乔，2024年4月11日 - 

clc; clear; close all;
format compact; %命令行显示不换行

%-----------------------------常量设置与文件导入-----------------------------

%读取PPG文件
ppgData = csvread("ppg_sample.csv");

%常量
FS = 4000; %采样频率，4000Hz
TS = 1 / 4000; %采样周期，0.25ms




%---------------------------------小波分解----------------------------------
coeffcient = haar_decomposition(ppgData);

%做出V14与W14的图
%level 14
Basis_V14 = zeros(2 ^ 15, 2 ^ 14);
Basis_W14 = zeros(2 ^ 15, 2 ^ 14);

%逐列循环
%每列的首个不为0值的下标
first_index = 1;
for m = 1 : 1 : 2 ^ 14   
    Basis_V14(first_index + m - 1: (first_index + 2 ^ 1) - 1 + (m - 1), m) = 1;
    first_index = first_index + 1;
end

%每列的首个不为0值的下标
first_index = 1;
for m = 1 : 1 : 2 ^ 14   
    Basis_W14(first_index + m - 1: (first_index + 2 ^ 1) - 1 + (m - 1), m) = [1, -1];
    first_index = first_index + 1;
end

%作图
x = [1 : 2^15];

figure(1);%V15
y15 = cat(1, zeros(14767, 1), ppgData);
plot(x, y15);
title("V15");

figure(2);%V14
y14 = Basis_V14 * coeffcient{2, 1};
plot(x, y14);
title("V14");

figure(3);%W14
w14 = Basis_W14 * coeffcient{2, 2};
plot(x, w14);
title("W14")


%------------------------------------阈值去噪-------------------------------
coeffcient = thresholding_denoising(coeffcient, ppgData);




%-------------------------------------小波重组------------------------------
new_coeffcient = haar_reconstruct(coeffcient);
a_15 = new_coeffcient{1, 1};

Basis_V15 = zeros(2 ^ 15);
for m = 1 : 1 : 2 ^ 15
    Basis_V15(m, m) = 1;
end

figure(4);%V15
V15 = Basis_V15 * a_15;
plot(x, y15, "b");

grid on;
hold on;

plot(x, V15, "r");

hold off;
legend("RowPPG", "FilteredPPG")












