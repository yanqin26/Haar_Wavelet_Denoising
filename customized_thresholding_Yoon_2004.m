function coeffcient = customized_thresholding_Yoon_2004(coeffcient, alpha)
%定制阈值去噪，修改小波系数
%输入：原始信号的小波系数，调整倾向于软阈值还是硬阈值（alpha越大越倾向于硬阈值）
%输出：去噪后信号的小波系数

%阈值：lambda
var = 0.000000007; %我猜的
lambda = sqrt(2 * var * log(18001));

%截断常参（低于该值的被置为0）
gamma = lambda / 2;

for level = 2 : 1 : 16
    for k = 1 : 1 : 2 ^ (16 - level)
        %公式中重复出现的复杂分式
        fractional = ((abs(coeffcient{level, 2}(k)) - gamma) / (lambda - gamma));

        if abs(coeffcient{level, 2}(k)) >= lambda
           coeffcient{level, 2}(k) = coeffcient{level, 2}(k) - (sign(coeffcient{level, 2}(k)) * (1 - alpha) * lambda);
        elseif abs(coeffcient{level, 2}(k)) <= gamma
            coeffcient{level, 2}(k) = 0;
        else
            coeffcient{level, 2}(k) = alpha * (fractional ^ 2) * (((alpha - 3) * fractional) + 4 - alpha);
        end
    end

end

coefficient = coeffcient;