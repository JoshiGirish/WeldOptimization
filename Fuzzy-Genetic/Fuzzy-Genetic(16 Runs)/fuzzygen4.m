%% This program creates a fuzzy model and optimises its membership 
%  functions using genetic algorithm

close all % Closes all current open figure windows
clear all % Clears all current matlab variables and workspace
clc       % Clears the command window

filename = 'Book3.xlsx';    % Name of the excel file which contains data
sheet = 1;                  % Sheet number of the excel file
powerrange = 'B4:B19';      % Location of the Laser Beam Power Data in the sheet
speedrange = 'C4:C19';      % Location of the Torch Speed Data in the sheet
durationrange = 'D4:D19';   % Location of the Pulse Duration Data in the sheet
strengthrange = 'G4:G19';   % Location of the UTS Data in the sheet
widthrange = 'E4:E19';      % Location of the Weld Pool Width Data in the sheet
depthrange = 'F4:F19';      % Location of the Weld Pool Depth Data in the sheet


% filename = 'Book2.xlsx';    % Name of the excel file which contains data
% sheet = 1;                  % Sheet number of the excel file
% powerrange = 'B4:B12';      % Location of the Laser Beam Power Data in the sheet
% speedrange = 'C4:C12';      % Location of the Torch Speed Data in the sheet
% durationrange = 'D4:D12';   % Location of the Pulse Duration Data in the sheet
% strengthrange = 'G4:G12';   % Location of the UTS Data in the sheet
% widthrange = 'E4:E12';      % Location of the Weld Pool Width Data in the sheet
% depthrange = 'F4:F12';      % Location of the Weld Pool Depth Data in the sheet

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
for i=1:14
powerknees(i,:) = sort(min(power) + (max(power)-min(power)).*rand(1,4));              
speedknees(i,:) = sort(min(speed) + (max(speed)-min(speed)).*rand(1,4));
durationknees(i,:) = sort(min(duration) + (max(duration)-min(duration)).*rand(1,4));
strengthknees(i,:) = sort(min(strength) + (max(strength)-min(strength)).*rand(1,4));
widthknees(i,:) = sort(min(width) + (max(width)-min(width)).*rand(1,4));
depthknees(i,:) = sort(min(depth) + (max(depth)-min(depth)).*rand(1,4));
end
initial = [powerknees speedknees durationknees strengthknees widthknees depthknees];
%% Create the knee matrix
% Constants used before binary transformation
genelengths = [18 10 8 16 17 17];
% genelengths = [13 3 5 9 11 10];
a = 100;
b = 100;
c = 100;
d = 100;
e = 100;
f = 100;
k = [a b c d e f];
length = 13; % Length of the gene i.e. number of binary bits used to represent a knee point value
% Convert the decimal values to binary vectors
pkl = de2bi(round(a*powerknees(:,1)),genelengths(1)); % Power Knees Low
pkm1 = de2bi(round(a*powerknees(:,2)),genelengths(1)); % Power Knees Medium
pkm2 = de2bi(round(a*powerknees(:,3)),genelengths(1)); % Power Knees Medium
pkh = de2bi(round(a*powerknees(:,4)),genelengths(1)); % Power Knees High

sks = de2bi(round(b*speedknees(:,1)),genelengths(2));
ska1 = de2bi(round(b*speedknees(:,2)),genelengths(2));
ska2 = de2bi(round(b*speedknees(:,3)),genelengths(2));
skf = de2bi(round(b*speedknees(:,4)),genelengths(2));

dks = de2bi(round(c*durationknees(:,1)),genelengths(3)); % Duration Knees Small
dka1 = de2bi(round(c*durationknees(:,2)),genelengths(3)); % Duration Knees Average
dka2 = de2bi(round(c*durationknees(:,3)),genelengths(3));
dkb = de2bi(round(c*durationknees(:,4)),genelengths(3)); % Duration Knees Big

skl = de2bi(round(d*strengthknees(:,1)),genelengths(4));
skm1 = de2bi(round(d*strengthknees(:,2)),genelengths(4));
skm2 = de2bi(round(d*strengthknees(:,3)),genelengths(4));
skh = de2bi(round(d*strengthknees(:,4)),genelengths(4));

wkl = de2bi(round(e*widthknees(:,1)),genelengths(5));
wkm1 = de2bi(round(e*widthknees(:,2)),genelengths(5));
wkm2 = de2bi(round(e*widthknees(:,3)),genelengths(5));
wkh = de2bi(round(e*widthknees(:,4)),genelengths(5));

dkl = de2bi(round(f*depthknees(:,1)),genelengths(6));
dkm1 = de2bi(round(f*depthknees(:,2)),genelengths(6));
dkm2 = de2bi(round(f*depthknees(:,3)),genelengths(6));
dkh = de2bi(round(f*depthknees(:,4)),genelengths(6));

% Create the population matrix
count = 0;
newpop = [pkl pkm1 pkm2 pkh sks ska1 ska2 skf dks dka1 dka2 dkb skl skm1 skm2 skh wkl wkm1 wkm2 wkh dkl dkm1 dkm2 dkh];
sizes = [size(pkl);size(sks);size(dks);size(skl);size(wkl);size(dkl)]; % bit lengths of each variable 
% used ahead for decoding of the chromosome string
[fit,knee,st,wi,de] = fitness4(newpop,sizes,inputs,outputs,k,count); % 
initial_fit = fit;
mse = 0.001;
pc = 1;
pm = 1;
trial = 0;
%% Creating the figure object
xpol = [min(depth) knee(1,21) knee(1,22) knee(1,23) knee(1,24) max(depth)];
ypol = [1 1 0 0 0 0];
ypom1 = [0 0 1 0 0 0];
ypom2 = [0 0 0 1 0 0];
ypoh = [0 0 0 0 1 1];
figure1 = figure('NumberTitle','off',...
    'Name','Fuzzy Logic',...
    'Color',[1 1 1],'Visible','off',...
    'Position',[5 384 510 305]);

% Set axes
axes1 = axes('Parent',figure1,...
    'YGrid','on',...
    'YColor',[0.3 0.3 0.3],...
    'XGrid','on',...
    'XColor',[0.3 0.3 0.3],...
    'Color',[1 1 1]);

hold on;

plot1 = plot(axes1,xpol,ypol,'Marker','.','LineWidth',3,'Color',[0 0 0],...
                            'MarkerEdgeColor','w',...
                        'MarkerFaceColor','k');
plot2 = plot(axes1,xpol,ypom1,'Marker','.','LineWidth',3,'Color',[0 0 0],...
                            'MarkerEdgeColor','w',...
                        'MarkerFaceColor','k');
plot3 = plot(axes1,xpol,ypoh,'Marker','.','LineWidth',3,'Color',[0 0 0],...
                            'MarkerEdgeColor','w',...
                        'MarkerFaceColor','k');
plot10 = plot(axes1,xpol,ypom2,'Marker','.','LineWidth',3,'Color',[0 0 0],...
                            'MarkerEdgeColor','w',...
                        'MarkerFaceColor','k');

% xlim(axes1,[0 4]);
xlim(axes1,[min(depth) max(depth)]);

% Create xlabel
xlabel('Depth of Penetration','FontWeight','bold','FontSize',14,'Color',[0 0 0]);

% Create ylabel
ylabel('Membership Value','FontWeight','bold','FontSize',14,'Color',[0 0 0]);

% Create title
title('DOP Membership Function','FontSize',15,'Color',[0 0 0]);
set(axes1,'FontName','Times')
hold off

%% Plot second
figure2 = figure('NumberTitle','off',...
    'Name','Fuzzy Logic',...
    'Color',[1 1 1],'Visible','off',...
    'Position',[520 384 500 305]);

% Set axes
axes2 = axes('Parent',figure2,...
    'YGrid','on',...
    'YColor',[0.3 0.3 0.3],...
    'XGrid','on',...
    'XColor',[0.3 0.3 0.3],...
    'Color',[0 0 0]);

hold on;

plot4 = plot(axes2,1:size(inputs,1),width,'Marker','.','LineWidth',3,'Color','r',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5,'LineStyle','--');
plot5 = plot(axes2,1:size(inputs,1),min(width)*ones(size(inputs,1),1),'Marker','.','LineWidth',5,'Color','r',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5);
plot6 = plot(axes2,1:size(inputs,1),depth,'Marker','.','LineWidth',3,'Color','g',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5,'LineStyle','--');
plot7 = plot(axes2,1:size(inputs,1),min(depth)*ones(size(inputs,1),1),'Marker','.','LineWidth',5,'Color','g',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5);
plot8 = plot(axes2,1:size(inputs,1),strength,'Marker','.','LineWidth',5,'Color','b',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5,'LineStyle','--');
plot9 = plot(axes2,1:size(inputs,1),min(strength)*ones(size(inputs,1),1),'Marker','.','LineWidth',5,'Color','b',...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor','k','MarkerSize',5);

xlim(axes2,[1 size(inputs,1)]);

% Create xlabel
xlabel('Data','FontWeight','bold','FontSize',14,'Color',[0 0 0]);

% Create ylabel
ylabel('Value','FontWeight','bold','FontSize',14,'Color',[0 0 0]);

% Create title
title('Actual Vs Target','FontSize',15,'Color',[0 0 0]);
% average = (sum(depth))/size(inputs,1);
average = (sum(width)+sum(depth)+sum(strength))/(size(inputs,1));
reg = 0;
counter = 0;
change_count = 0;
last_fit = min(fit);
tic % start the timer
while min(fit) > mse && trial < 10000 % until mse is met of number of trials exceed the specified number do the following
     newpop = crossover4(newpop,fit,pc,sizes,k,power,speed,duration,strength,width,depth); % crossover operation
     count = floor(trial/1000); % temp. variable counting thousand trials
     
     [newpop,mpoint] = mutation(newpop,fit,pm,sizes,k,power,speed,duration,strength,width,depth); % mutation operation
     [fit,knee,st,wi,de] = fitness4(newpop,sizes,inputs,outputs,k,count); % function to find out if the mse is reached
     trial = trial + 1; % increament the value of trial
      if reg == 50
         reg = 0;
         counter = counter + 1;
         errors(counter) = min(fit);
     else
         reg = reg + 1;
     end
     time = toc; % record the time in a variable
     per_error = min(fit)/average*100; % percentage error
     fprintf('\n Time = %f  Iteration = %d  RMS Error = %f  Error Percentage = %f   pc = %d   pm = %d  mpoint = %d',time,trial,min(fit),per_error,pc,pm,mpoint);
     [fitval ind]=min(fit); % get the min error value and index of the chromosome that results in min error
     mv = knee(ind,:); 
     out1 = st(ind,:)';
     out2 = wi(ind,:)';
     out3 = de(ind,:)';
     %% Setting the plot data
     
     if min(fit) < last_fit % Update the plot if new minimum fit found
         change_count = change_count + 1;
         evolved_knee(change_count,:) = mv;
         evolved_fit(change_count) = fitval;
     xpol = [floor(knee(ind,21)) knee(ind,21) knee(ind,22) knee(ind,23) knee(ind,24) ceil(knee(ind,24))];
     xlim(axes1,[floor(knee(ind,21)) ceil(knee(ind,24))]);
     set(plot1,'YData',ypol,'XData',xpol);
     set(plot2,'YData',ypom1,'XData',xpol);
     set(plot3,'YData',ypoh,'XData',xpol);
     set(plot10,'YData',ypom2,'XData',xpol);
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
     
%      switch trial
%          case 999
%             final(1,:) = out1;
%             kneepoints(1,:) = knee(ind,:);
%          case 1999
%              final(2,:) = out2;
%              kneepoints(2,:) = knee(ind,:);
%          case 2999
%              final(3,:) = out3;
%              kneepoints(3,:) = knee(ind,:);
%         otherwise
%      end
         
%      fprintf('The number the trial exceeded maximum allowed trials !!!');
 end
%  result = [strength final(1,:)' width final(2,:)' depth final(3,:)'];
result = [strength out1 width out2 depth out3];