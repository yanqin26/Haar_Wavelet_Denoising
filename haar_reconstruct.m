function new_coeffcient = haar_reconstruct(coeffcient)
%haar小波逆变换
%输入：小波系数
%输出：重构后的每一层小波系数

%新元胞数组，用于存储迭代新系数
new_coeffcient{16, 1} = coeffcient{16, 1}; %0层近似系数，v0

for level = 1 : 1 : 15
    
    a = zeros(2 ^ level, 1); %每次循环计算得出的上一层近似系数

    %循环得出上一层的近似系数
    for k = 1 : 1 : (2 ^ (level - 1))
    %k为当前层（低一阶层的小波系数下标），两两一组一加一减
    a(2 * k - 1) = new_coeffcient{17 - level, 1}(k) + coeffcient{17 - level, 2}(k);
    a(2 * k) = new_coeffcient{17 - level, 1}(k) - coeffcient{17 - level, 2}(k);
    end

    new_coeffcient{16 - level, 1} = a;

end
