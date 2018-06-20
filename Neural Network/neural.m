%% This program creates a neural network for weld parameter prediction
function [performance,pmse, best_result,best_mse] = neural(pmse,best_result,best_mse)
% close all % Closes all current open figure windows
% clear all % Clears all current matlab variables and workspace
% clc       % Clears the command window

filename = 'Book1.xlsx';    % Name of the excel file which contains data
sheet = 1;                  % Sheet number of the excel file
powerrange = 'B4:B11';      % Location of the Laser Beam Power Data in the sheet
speedrange = 'C4:C11';      % Location of the Torch Speed Data in the sheet
durationrange = 'D4:D11';   % Location of the Pulse Duration Data in the sheet
strengthrange = 'G4:G11';   % Location of the UTS Data in the sheet
widthrange = 'E4:E11';      % Location of the Weld Pool Width Data in the sheet
depthrange = 'F4:F11';      % Location of the Weld Pool Depth Data in the sheet

power = xlsread(filename,sheet,powerrange);         % Matlab Variable for storing power data
speed = xlsread(filename,sheet,speedrange);         % Matlab Variable for storing speed data
duration = xlsread(filename,sheet,durationrange);   % Matlab Variable for storing position data
strength = xlsread(filename,sheet,strengthrange);   % Matlab Variable for storing strength data
width = xlsread(filename,sheet,widthrange);         % Matlab Variable for storing width data
depth = xlsread(filename,sheet,depthrange);         % Matlab Variable for storing depth data

% Create input and output matrices
in = [power speed duration];    % Combine all the three inputs to form a single input matrix
out = [strength width depth];   % Combine all the three outputs to form a single output matrix
inputs = in';                   % Transpose of input matrix to align data in rows instead of columns
targets = out';                 % Transpose of output matrix will be used as target for training NN                 

% Create a fitting network
hiddenLayerSize = [10];            % Define the number of neurons to use in the hidden layer
brain = fitnet(hiddenLayerSize);% Create a neural network with the specified neurons and assign the name "brain"

% Set up Division of Data for Training, Validation, Testing
% brain.divideParam.trainRatio = 75/100;  % Define the ratio of samples to be used for Training the NN
% brain.divideParam.valRatio = 0/100;     % Define the ratio of samples to be used for Validation
% brain.divideParam.testRatio = 25/100;   % Define the ratio of samples to be used for Testing
brain.trainParam.goal = 0.01;
% Set some parameters
brain.divideFcn = 'divideind';
[trainInd,valInd,testInd]=divideind(8,[1 2 4 5 7 8],[],[3 6]);
% Train the Network
[brain,tr] = train(brain,inputs,targets);   % Trains the network using the inputs and target values
 
% Test the Network
hits = 0;   % Counter for counting number of training sessions required
outputs = brain(inputs);    % Calculate the outputs using the NN
performance = perform(brain,targets,outputs);   % This is the mean squared error between the targets and the calculated output values
mse = 0.01;    % Required accuracy (mean squared error)

% while performance >  mse && hits < 100 % Until required error value is reached or maximum number of trials is reached do the following
    [brain,tr] = train(brain,inputs,targets); % Train the NN again
    outputs = brain(inputs); % Simulate the outputs again
    errors = gsubtract(outputs,targets); % Simulate the errors again
    performance = perform(brain,targets,outputs); % Calculate the mean squared error(MSE) again
    hits = hits + 1; % Increament the counter every time the loop executes
    fprintf('\nOptimising Performance Value => %f <=',performance); % Print in command window the value of MSE
% end

if performance < mse % If the required MSE is achieved do the following
    fprintf('\n\nThe specified performance value of %f is reached => %f',mse,performance); % Print the specified and achieved values of MSE
    fprintf('\nThe neural network has been trained %d times\n',hits); % Display to the user the number of times the NN has been trained
else
    fprintf('\nThe neural network failed to optimise the performance'); % Display warning if the MSE is not achieved in the maximum number of trials
%     fprintf('\nNumber of training sessions exceeded maximum allowed number(%d)!!!\n',hits); 
end
result = [targets' outputs'];
old = pmse;
if performance < best_mse
    best_result = result
    best_mse = performance;
end
pmse = performance;

%% Reconstruction
% i_w = brain.IW{1}
% l_w = brain.LW{2}
% i_b = brain.b{2}
% l_b = brain.b{1}
% 
% for s=1:8 % For 8 samples repeat the following
%     i_sum = inputs(:,s)+i_b;    % Sum up the inputs and the input biases
%    for i = 1:3     % For 10 neurons
%        for j = 1:10      % For the three inputs do the following
%             int_i(i,j) = i_sum(i)*i_w(j,i);     % Calculate the multiplication of inputs and weights
%        end
%    end
%    l_sum = l_b' + sum(int_i,1);
%     for i= 1:10
%         for j = 1:3
%             int_l(i,j) = l_sum(i)*l_w(j,i);
%         end
%     end
%     o(s,:) = sum(int_l,1);
% end