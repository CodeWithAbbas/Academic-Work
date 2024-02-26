% *************************************************************************
%   @file     RSI_MATLAB.m
%   @brief    Calculations of RSI Algorithm in MATLAB
%
%   @author   Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
% ********************************************************************************/
% Clearing workspace, closing figures, and clearing command window
clear all
close all
clc

% Loading the Data
Data = load ('file.csv');
length_file = length(Data); % Length of File

% Arrays for gain, loss, and difference variables
difference = [];
gain = [];
loss = [];
Average_gain = [];
Ave_gain = [];
Ave_loss = [];
gain_adder = [];
loss_adder = [];
Average_loss = [];
sum_gain = 0;
sum_loss = 0;
RS = [];
RSI = [];

% Loop to calculate gain and loss
for i = 2:length_file
    difference(i-1) = Data(i) - Data(i-1);
    if difference(i-1) > 0
        gain(i-1) = difference(i-1);
        loss(i-1) = 0;
    elseif difference(i-1) < 0
        gain(i-1) = 0;
        loss(i-1) = abs(difference(i-1));
    else
        gain(i-1) = 0;
        loss(i-1) = 0;
    end
end

% Loop to calculate sum of gain and loss
for i = 1:length_file-1
    sum_gain = sum_gain + gain(i);
    gain_adder(i) = sum_gain;
    sum_loss = sum_loss + loss(i);
    loss_adder(i) = sum_loss;
    if (i == 14)
        Av_gain(i) = sum_gain;
        Av_loss(i) = sum_loss;
        RS(i) = Av_gain(i) / Av_loss(i);
        RSI(i) = 100 - (100 / (1 + RS(i)));
        Average_gain(i) = Av_gain(i) * 14;
        Average_loss(i) = Av_loss(i) * 14;
    elseif (i > 14)
        Average_gain(i) = (((Average_gain(i-1)) * 13) + gain(i)) / 14;
        Average_loss(i) = ((Average_loss(i-1) * 13) + loss(i)) / 14;
        RS(i) = Average_gain(i) / Average_loss(i);
        RSI(i) = 100 - (100 / (1 + RS(i)));
    end
end

% Arrays for buy and sell signals
buy = [];
sell = [];

% Loop to identify buy and sell signals
for i = 16:length_file-1
    if (RSI(i-1) >= 30 && RSI(i) < 30)
        buy(i) = RSI(i);
    elseif ((RSI(i-1) <= 70 && RSI(i) > 70))
        sell(i) = RSI(i);
    end
end

% Plotting RSI with buy and sell signals
plot(RSI, 'r')
hold on;
plot(buy, 'o');
hold on;
plot(sell, '*');
hold on;
