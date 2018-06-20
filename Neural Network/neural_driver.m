clc
close all
clear all
performance = 20000;
mse = 1000;
hits = 0;
pmse = mse;
best_result = 0;
best_mse = mse;
% [performance,pmse,best_result,best_mse] = neural(pmse,best_result,best_mse);
while performance >  mse && hits < 100
    clear all
    performance = 20000;
mse = 1000;
hits = 0;
pmse = mse;
best_result = 0;
best_mse = mse;
    hits = hits + 1;
    [performance,pmse,best_result,best_mse] = neural(pmse,best_result,best_mse);
end