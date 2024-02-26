% *************************************************************************
%   @file   MACD_Optimization.m
%   @brief  Calculations of MACD Algorithm in MATLAB
% 
%   @author Lead FPGA Engineer Abbas Ali (18jzele0237@uetpeshawar.edu.pk)
% ********************************************************************************/

% MACD_Calculations
clear          % clear all variables 
close all	   % close all figures 
clc			   % clear the screen 

%% Loading the Stock data 
Data = load('file.csv')*65536;  %32768, 65536

close_price = fix(Data(:,1));	% First column is close price 

length_file = length(close_price);  % find the length of close_price

N1=12; K1=2/(N1+1);   % Use for EMA12
N2=26; K2=2/(N2+1);   % Use for EMA26
N3=9; K3=2/(N3+1);	  % Use for EMA9

EMA12=[];            % Creating Array for EMA12
EMA26=[];	   		 % Creating Array for EMA26
MACD_SIGNAL=[]; 	 % Creating Array for MACD_SIGNAL
MACD=[];		  	 % Creating Array for MACD
SUM_calc=[];
SUM_calc_Msignal=[];

%% Calculating the value of EMA12
% EMA = Closing price x multiplier + EMA (previous day) x (1-multiplier)
Sum=0;
for i = 1:length_file      
    Sum=close_price(i)+Sum;
    SUM_calc(i)= Sum;
    if (i==12)
        mult1(i)= fix((Sum) * 5461);   	% EMA12 = SMA
       
        EMA12 (i) = fix(bitsra(mult1(i),16));
	elseif (i>12)
		adder_out(i) = fix(((close_price(i)*10082)+(EMA12(i-1)*(55453))));   % EMA12 10082   55453
        EMA12 (i) = fix (bitsra(adder_out(i),16));
    else
        EMA12(i)=0;  % First 12 values equal to 0
    end;
end;

%% Calculating the value of EMA26
Sum=0;
for i = 1:length_file      
    Sum=close_price(i)+Sum;
    if (i==26)
		EMA26_calc2(i)= fix(Sum)*2520;   	% EMA26 = SMA
        EMA26 (i) = fix(bitsra(EMA26_calc2(i),16));
	elseif (i>26)
		EMA26_calc(i)= fix((close_price(i)*4854)+(EMA26(i-1)*(60681)));   % EMA26
        EMA26 (i) = fix(bitsra(EMA26_calc(i),16));
    else
        EMA26(i)=0;  % First 25 values equal to 0
    end;
end;

%% Calculating MACD
for i = 26:length_file    
	MACD(i) = EMA12(i)-EMA26(i);
end;

%% Adding DC Offset to MACD
MACD = MACD+250;

%% Calculating the value of EMA9
Sum=0;
for i = 26:length_file      
    Sum=MACD(i)+Sum;
    SUM_calc_Msignal(i)= Sum;
    if (i==34)
		MACD_SIGNAL_calc(i)= fix(Sum)*7281;   	% MACD_SIGNAL = EMA9 of MACD
        MACD_SIGNAL (i) = fix(bitsra(MACD_SIGNAL_calc(i),16));
	elseif (i>34)
		MACD_SIGNAL_calc(i)= fix(((MACD(i)*13107)+(MACD_SIGNAL(i-1)*(52428))));   % MACD_SIGNAL
        MACD_SIGNAL (i) = fix(bitsra(MACD_SIGNAL_calc(i),16));
    else
        MACD_SIGNAL(i)=0;  % Previous 25 values equal to 0 from 1 to 25
    end;
end;

position_buy = 1;
position_sell = 1;
buy = [];
sell = [];

for i = 34 : length_file
   if ((MACD(i)> MACD_SIGNAL(i)) && position_buy == 1)
       buy(i)= MACD(i);
       position_sell = 1;
       position_buy = 0;
   elseif ((MACD(i)< MACD_SIGNAL(i)) && position_sell == 1)
       sell(i) = MACD(i);
       position_sell = 0;
       position_buy = 1;
   end;
end;

% Plotting the results
plot (buy,'o','DisplayName','buy', 'MarkerSize',10);
hold on;
plot (sell, '*', 'MarkerSize',10);
hold on;
plot(MACD, 'r');
hold on;
plot(MACD_SIGNAL, 'g')
hold off;
grid off;
legend('buy','sell','MACD','MACD SIGNAL');
