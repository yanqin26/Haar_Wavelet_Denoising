function coeffcient = soft_thresholding_Donoho_1994(coeffcient, ppgData)
%软阈值去噪，修改小波系数
%输入：原始信号的小波系数，ppg信号
%输出：去噪后信号的小波系数

%阈值：lambda
var = 0.000000007; %我猜的
lambda = sqrt(2 * var * log(18001));

for level = 2 : 1 : 16
    for k = 1 : 1 : 2 ^ (16 - level)
        if coeffcient{level, 2}(k) >= lambda
           coeffcient{level, 2}(k) = coeffcient{level, 2}(k) - lambda;
        elseif coeffcient{level, 2}(k) <= -lambda
            coeffcient{level, 2}(k) = coeffcient{level, 2}(k) + lambda;
        else
            coeffcient{level, 2}(k) = 0;
        end
    end
end

coefficient = coeffcient;