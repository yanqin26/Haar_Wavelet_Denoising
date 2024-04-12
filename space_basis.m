%创建从V15开始，一直迭代分解到V0以及W0的基矩阵，最后存为dat文件
%每一列是一个基，每降一阶基个数减少一半
clear; clc;

%level 15
Basis_V15 = zeros(2 ^ 15);
for m = 1 : 1 : 2 ^ 15
    Basis_V15(m, m) = 1;
end

clear Basis_V15;%清内存--------------------------------------------------------------

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


