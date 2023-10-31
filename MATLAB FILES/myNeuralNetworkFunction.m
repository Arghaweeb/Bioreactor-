function [y1] = myNeuralNetworkFunction(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = Qx3 matrix, input #1
% and returns:
%   y = Qx1 matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [100;1;10];
x1_step1.gain = [0.025;1;0.04];
x1_step1.ymin = -1;

% Layer 1
b1 = [-2.7311192319997110722;-2.3399635430012177828;-2.1957797279338526764;1.1880629765162460387;0.41315852459699609067;-1.7045059418952865915;0.7593937581106336987;0.40419589171599457078;0.91720801938381768537;-1.6988821253811523526;2.356119703945117827;2.3968032004124601997;3.3054136126562192466;-3.3451568350072320435;3.0854701944263700497];
IW1_1 = [4.3143575120443822257 1.0989308229594501043 1.1479157249182228018;2.0323176102638398355 2.0282208563521382239 1.2751551760430319682;0.83532090556993221497 -0.5402091740270044129 2.4961665432492896599;0.24103633109910990728 3.2432208025986755118 1.5316782911240656162;-2.3074287192037665761 -0.17013600053106400778 -1.4223295163003815134;1.0247376120563869151 0.5017037724223041284 -1.9693812031505519844;-2.1480674168070779118 2.0772981567888999521 -2.5710145039113743159;-1.1535502888850321934 -1.5000667483521545886 2.2048200844779199947;0.12962067318910458491 -1.6663977824568139141 -2.8505479353384388652;-2.2210678851657661426 -1.9686154442622534333 -2.4565176077482644423;2.4777434283257040448 0.38643922122398066676 -1.1581269699195924083;1.9200421766382411715 2.2520639607190977571 -1.6502192343125015039;1.7222185295006458006 2.739678926233256373 0.80288312093352443011;-2.1544306011641674026 -2.5452381042257830046 -0.8024280973304463993;1.352589178007078452 -0.43476726925980840877 3.662446093608306974];

% Layer 2
b2 = -0.38141683321076919055;
LW2_1 = [0.19657844722500583678 -0.21140936281757333193 -0.19706139188331539547 -0.088632961447453015302 -0.66620170539664658182 0.0055971927454759873299 0.010832853077166994943 0.08567161986143286001 -0.15088389133886268012 -0.12381113031117807477 0.4473905904617495044 -0.28037142204036902271 -0.31453346985444929906 -0.66279041522501436212 0.027862089701150144494];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.02255299954894;
y1_step1.xoffset = 5.9;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,1); % samples

% Input 1
x1 = x1';
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
y1 = y1';
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end