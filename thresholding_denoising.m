function coeffcient = thresholding_denoising(coeffcient, ppgData)
%阈值去噪，修改小波系数
%输入：原始信号的小波系数，ppg信号
%输出：阈值，去噪后信号的小波系数

%阈值：lambda
%var = 1; %我猜的
%lambda = sqrt(2 * var * log(length(ppgData)));
lambda = 0.0007;
for level = 2 : 1 : 16
    for k = 1 : 1 : 2 ^ (16 - level)
        if abs(coeffcient{level, 2}(k)) < lambda
           coeffcient{level, 2}(k) = 0;
        end
    end
end

coefficient = coeffcient;

