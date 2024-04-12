function coeffcient = haar_decomposition(ppgData)
%haar小波分解的第一阶段：分解
%输入：ppg信号
%输出：近似系数与细节系数

%由于小波的二尺度性质，对ppg信号进行补零，填充到2的最小次幂刚好大于ppg信号长度
ppgData = cat(1, zeros(14767, 1), ppgData);
dec_level = 15; %现在信号的长度为2的15次方，因此最高级近似空间为V_15

%构建基于haar的多分辨率分析：
%-------------------------公式求出a15近似系数-------------------------------
m_haar = 1; %近似常量
a_15 = m_haar .* ppgData(1 : 2^15);


%-------------------------迭代求出直到0层的近似系数以及细节系数---------------
p0 = 1; p1 = 1; %haar小波的二尺度系数

%定义高通滤波器卷积序列与低通滤波器卷积序列:Mallt算法
h0 = -1/2; h1 = 1/2;
l0 = 1/2; l1 = 1/2;

%定义元胞数组存储系数向量：1位为近似系数，2位为细节系数
coeffcient{1, 1} = a_15;
count = 1;

%循环分解求得系数
for level = 15 : -1 : 1
    %定义系数矩阵
    v = zeros(2 ^ (level - 1), 1);
    w = zeros(2 ^ (level - 1), 1);

    a = coeffcient{count, 1};

    %根据第level层的近似系数求出level-1层的近似系数以及细节系数
    for k = 1 : 1 : 2 ^ (level - 1)
        v(k) = (1/2) * (a(2 * k - 1) + a(2 * k));
        w(k) = (1/2) * (a(2 * k - 1) - a(2 * k));
    end

    %将系数向量填入元胞数组
    count = count + 1;
    coeffcient{count, 1} = v;
    coeffcient{count, 2} = w;

    
end

