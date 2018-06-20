%% This program creates a fuzzy model and optimises its membership 
%  functions using genetic algorithm

close all % Closes all current open figure windows
clear all % Clears all current matlab variables and workspace
clc       % Clears the command window

% filename = 'Book3.xlsx';    % Name of the excel file which contains data
% sheet = 1;                  % Sheet number of the excel file
% powerrange = 'B4:B19';      % Location of the Laser Beam Power Data in the sheet
% speedrange = 'C4:C19';      % Location of the Torch Speed Data in the sheet
% durationrange = 'D4:D19';   % Location of the Pulse Duration Data in the sheet
% strengthrange = 'G4:G19';   % Location of the UTS Data in the sheet
% widthrange = 'E4:E19';      % Location of the Weld Pool Width Data in the sheet
% depthrange = 'F4:F19';      % Location of the Weld Pool Depth Data in the sheet


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

inputs = [power speed duration];
outputs = [strength width depth];
%% Initialise initial population of knees points
% Create any three random knee points in the specified range of data and 
% sort the same in ascending order
popsize = 10;
wt = ones(popsize,9); 
ex = ones(popsize,9); 
%% Create the knee matrix
% Constants used before binary transformation
a = 100;
b = 100;
c = 100;
d = 100;
e = 100;
f = 100;
k = [a b c d e f];
length = [17 17 17 17 17 17];
% length = [18 13 10 17 18 17];

% Convert the decimal values to binary vectors
pkl = de2bi(round(a*wt(:,1)),length(1)); % Power Knees Low
pkm = de2bi(round(a*wt(:,2)),length(1)); % Power Knees Medium
pkh = de2bi(round(a*wt(:,3)),length(1)); % Power Knees High

sks = de2bi(round(b*wt(:,4)),length(2));
ska = de2bi(round(b*wt(:,5)),length(2));
skf = de2bi(round(b*wt(:,6)),length(2));

dks = de2bi(round(c*wt(:,7)),length(3)); % Duration Knees Small
dka = de2bi(round(c*wt(:,8)),length(3)); % Duration Knees Average
dkb = de2bi(round(c*wt(:,9)),length(3)); % Duration Knees Big

skl = de2bi(round(d*ex(:,1)),length(4));
skm = de2bi(round(d*ex(:,2)),length(4));
skh = de2bi(round(d*ex(:,3)),length(4));

wkl = de2bi(round(e*ex(:,4)),length(5));
wkm = de2bi(round(e*ex(:,5)),length(5));
wkh = de2bi(round(e*ex(:,6)),length(5));

dkl = de2bi(round(f*ex(:,7)),length(6));
dkm = de2bi(round(f*ex(:,8)),length(6));
dkh = de2bi(round(f*ex(:,9)),length(6));

% Create the population matrix
newpop = [pkl pkm pkh sks ska skf dks dka dkb skl skm skh wkl wkm wkh dkl dkm dkh];
sizes = [size(pkl);size(sks);size(dks);size(skl);size(wkl);size(dkl)];
lastsum = 0;
count = 0;
[fit,knee,st,wi,de,wmr,emr,lastsum] = genfitness(newpop,sizes,inputs,outputs,k,lastsum,count);

mse = 0.001;
pc = 1;
pm = 1;
trial = 0;
% Creating the figure object
xpol = [min(depth) knee(1,16) knee(1,17) knee(1,18) max(depth)];
ypol = [1 1 0 0 0];
ypom = [0 0 1 0 0];
ypoh = [0 0 0 1 1];
figure1 = figure('NumberTitle','off',...
    'Name','Fuzzy Logic',...
    'Color',[0 0 0],'Visible','off',...
    'Position',[5 384 510 305]);

% Set axes
axes1 = axes('Parent',figure1,...
    'YGrid','on',...
    'YColor',[0.9725 0.9725 0.9725],...
    'XGrid','on',...
    'XColor',[0.9725 0.9725 0.9725],...
    'Color',[0 0 0]);

hold on;

plot1 = plot(axes1,1:size(knee,2),knee(1,1:end),'Marker','.','LineWidth',5,'Color',[0 1 0],...
                            'MarkerEdgeColor','w',...
                        'MarkerFaceColor','k');
% plot2 = plot(axes1,xpol,ypom,'Marker','.','LineWidth',5,'Color',[1 0 0],...
%                             'MarkerEdgeColor','w',...
%                         'MarkerFaceColor','k');
% plot3 = plot(axes1,xpol,ypoh,'Marker','.','LineWidth',5,'Color',[0 0 1],...
%                             'MarkerEdgeColor','w',...
%                         'MarkerFaceColor','k');

% xlim(axes1,[0 4]);
xlim(axes1,[1 size(knee,2)]);

% Create xlabel
xlabel('Weights','FontWeight','bold','FontSize',14,'Color',[1 1 0]);

% Create ylabel
ylabel('Value','FontWeight','bold','FontSize',14,'Color',[1 1 0]);

% Create title
title('Weight Curve','FontSize',15,'Color',[1 1 0]);

hold off

%% Plot second
figure2 = figure('NumberTitle','off',...
    'Name','Fuzzy Logic',...
    'Color',[0 0 0],'Visible','off',...
    'Position',[520 384 500 305]);
    %     'Position',[4 384 1020 305]);

% Set axes
axes2 = axes('Parent',figure2,...
    'YGrid','on',...
    'YColor',[0.9725 0.9725 0.9725],...
    'XGrid','on',...
    'XColor',[0.9725 0.9725 0.9725],...
    'Color',[0 0 0]);

hold on;

plot4 = plot(axes2,1:size(inputs,1),width,'Marker','.','LineWidth',3,'Color','r',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5,'LineStyle','--');
plot5 = plot(axes2,1:size(inputs,1),min(width)*ones(size(inputs,1),1),'Marker','.','LineWidth',5,'Color','y',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5);
plot6 = plot(axes2,1:size(inputs,1),depth,'Marker','.','LineWidth',3,'Color','g',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5,'LineStyle','--');
plot7 = plot(axes2,1:size(inputs,1),min(depth)*ones(size(inputs,1),1),'Marker','.','LineWidth',5,'Color','y',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5);
plot8 = plot(axes2,1:size(inputs,1),strength,'Marker','.','LineWidth',5,'Color','b',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5,'LineStyle','--');
plot9 = plot(axes2,1:size(inputs,1),min(strength)*ones(size(inputs,1),1),'Marker','.','LineWidth',5,'Color','y',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5);

xlim(axes2,[1 size(inputs,1)]);

% Create xlabel
xlabel('Data','FontWeight','bold','FontSize',14,'Color',[1 1 0]);

% Create ylabel
ylabel('Value','FontWeight','bold','FontSize',14,'Color',[1 1 0]);

% Create title
title('Actual Vs Target','FontSize',15,'Color',[1 1 0]);
average = (sum(width))/(size(inputs,1));
reg = 0;
counter = 0;
last_fit=min(fit);
tic
 while min(fit) > mse && trial < 20000
     newpop = crossover(newpop,fit,pc,sizes,k,power,speed,duration,strength,width,depth);
     count = floor(trial/2000);
     [newpop,mpoint] = mutate(newpop,fit,pm,sizes,k,power,speed,duration,strength,width,depth,wmr,emr,count);
     [fit,knee,st,wi,de,wmr,emr,lastsum] = genfitness(newpop,sizes,inputs,outputs,k,lastsum,count);
     trial = trial + 1;
     if reg == 50
         reg = 0;
         counter = counter + 1;
         errors(counter) = min(fit);
     else
         reg = reg + 1;
     end
     
     time = toc;
     per_error = min(fit(1))/average*100;
     [fitval ind]=min(fit);
     mv = knee(ind,:);
     fprintf('\n Time = %f  Iteration = %d  RMS Error = %f  Error Percentage = %f   pc = %d   pm = %d  mpoint = %d  ' ,time,trial,min(fit),per_error,pc,pm,mpoint);
     
     out1 = st(ind,:)';
     out2 = wi(ind,:)';
     out3 = de(ind,:)';
     if min(fit) < last_fit
%      xpol = [floor(knee(ind,16)) knee(ind,16) knee(ind,17) knee(ind,18) ceil(knee(ind,18))];
%      xlim(axes1,[floor(knee(ind,16)) ceil(knee(ind,18))]);
     set(plot1,'YData',mv,'XData',1:size(mv,2));
%      set(plot2,'YData',ypom,'XData',xpol);
%      set(plot3,'YData',ypoh,'XData',xpol);
     set(figure1,'Visible','on');
     set(plot8,'YData',strength,'XData',1:size(inputs,1));
     set(plot9,'YData',out1,'XData',1:size(inputs,1));
     set(plot4,'YData',width,'XData',1:size(inputs,1));
     set(plot5,'YData',out2,'XData',1:size(inputs,1));
     set(plot6,'YData',depth,'XData',1:size(inputs,1));
     set(plot7,'YData',out3,'XData',1:size(inputs,1));
     set(figure2,'Visible','on');
     drawnow;
     last_fit = min(fit);
     else
     end
%      fprintf('The number the trial exceeded maximum allowed trials !!!');
 end
 w1 = mv(7)-mv(10);
 w2 = mv(8)-mv(11);
 w3 = mv(9)-mv(12);
 w4 = mv(1)-mv(4);
 w5 = mv(2)-mv(5);
 w6 = mv(3)-mv(6);
 c = mv(13)-mv(14)+mv(15)-mv(16)+mv(17)-mv(18);
 answer = [w1 w2 w3 w4 w5 w6 c]
 prediction = w1*power(1)^2+w2*speed(1)^2+w3*duration(1)^2+w4*power(1)+w5*speed(1)+w6*duration(1)+c
  result = [strength out1 width out2 depth out3];
 