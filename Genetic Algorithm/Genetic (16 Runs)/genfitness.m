function [fv,knee,st,wi,de,wmr,emr,lastsum] = genfitness(pop,sizes,inputs,outputs,k,lastsum,count)


m = size(pop,1); % number of rows of pop
n = size(inputs,1); % number of rows of inputs
for i=1:3
    porangelow(i) = 2+(i-1)*sizes(1,2); % Lower three range of binary vector of power
    posign(i) = porangelow(i) - 1;
    porangehigh(i) = i*sizes(1,2); % Higher three range of binary vector of power
end
for i=1:3
    sprangelow(i) = (2+porangehigh(3)+(i-1)*sizes(2,2));
    spsign(i) = sprangelow(i) - 1;
    sprangehigh(i) = porangehigh(3)+i*sizes(2,2);
end
for i=1:3
    durangelow(i) = (2+sprangehigh(3)+(i-1)*sizes(3,2));
    dusign(i) = durangelow(i) - 1;
    durangehigh(i) = sprangehigh(3)+i*sizes(3,2);
end
for i=1:3
    strangelow(i) = (2+durangehigh(3)+(i-1)*sizes(4,2));
    stsign(i) = strangelow(i) - 1;
    strangehigh(i) = durangehigh(3)+i*sizes(4,2);
end
for i=1:3
    wirangelow(i) = (2+strangehigh(3)+(i-1)*sizes(5,2));
    wisign(i) = wirangelow(i) - 1;
    wirangehigh(i) = strangehigh(3)+i*sizes(5,2);
end
for i=1:3
    derangelow(i) = (2+wirangehigh(3)+(i-1)*sizes(6,2));
    design(i) = derangelow(i) - 1;
    derangehigh(i) = wirangehigh(3)+i*sizes(6,2);
end
conv = [1 1 1 1 1 1];
%     k = k/1000;
% Sort out the knee points from the pop matrix
for i = 1:m
    pkl1(i,1) = bi2de(pop(i,porangelow(1):porangehigh(1)))/k(1)*conv(1);
    pkm1(i,1) = bi2de(pop(i,porangelow(2):porangehigh(2)))/k(1)*conv(2);
    pkh1(i,1) = bi2de(pop(i,porangelow(3):porangehigh(3)))/k(1)*conv(3);
    
    sks1(i,1) = bi2de(pop(i,sprangelow(1):sprangehigh(1)))/k(2)*conv(1);
    ska1(i,1) = bi2de(pop(i,sprangelow(2):sprangehigh(2)))/k(2)*conv(2);
    skf1(i,1) = bi2de(pop(i,sprangelow(3):sprangehigh(3)))/k(2)*conv(3);
    
    dks1(i,1) = bi2de(pop(i,durangelow(1):durangehigh(1)))/k(3)*conv(1);
    dka1(i,1) = bi2de(pop(i,durangelow(2):durangehigh(2)))/k(3)*conv(2);
    dkb1(i,1) = bi2de(pop(i,durangelow(3):durangehigh(3)))/k(3)*conv(3);
    
    skl1(i,1) = bi2de(pop(i,strangelow(1):strangehigh(1)))/k(4)*conv(4);
    skm1(i,1) = bi2de(pop(i,strangelow(2):strangehigh(2)))/k(4)*conv(5);
    skh1(i,1) = bi2de(pop(i,strangelow(3):strangehigh(3)))/k(4)*conv(6);
    
    wkl1(i,1) = bi2de(pop(i,wirangelow(1):wirangehigh(1)))/k(5)*conv(4);
    wkm1(i,1) = bi2de(pop(i,wirangelow(2):wirangehigh(2)))/k(5)*conv(5);
    wkh1(i,1) = bi2de(pop(i,wirangelow(3):wirangehigh(3)))/k(5)*conv(6);
    
    dkl1(i,1) = bi2de(pop(i,derangelow(1):derangehigh(1)))/k(6)*conv(4);
    dkm1(i,1) = bi2de(pop(i,derangelow(2):derangehigh(2)))/k(6)*conv(5);
    dkh1(i,1) = bi2de(pop(i,derangelow(3):derangehigh(3)))/k(6)*conv(6);
%     pkl1(i,1) = ((-1)^pop(i,posign(1)))*bi2de(pop(i,porangelow(1):porangehigh(1)))/k(1);
%     pkm1(i,1) = ((-1)^pop(i,posign(2)))*bi2de(pop(i,porangelow(2):porangehigh(2)))/k(2);
%     pkh1(i,1) = ((-1)^pop(i,posign(3)))*bi2de(pop(i,porangelow(3):porangehigh(3)))/k(3);
%     
%     sks1(i,1) = ((-1)^pop(i,spsign(1)))*bi2de(pop(i,sprangelow(1):sprangehigh(1)))/k(1);
%     ska1(i,1) = ((-1)^pop(i,spsign(2)))*bi2de(pop(i,sprangelow(2):sprangehigh(2)))/k(2);
%     skf1(i,1) = ((-1)^pop(i,spsign(3)))*bi2de(pop(i,sprangelow(3):sprangehigh(3)))/k(3);
%     
%     dks1(i,1) = ((-1)^pop(i,dusign(1)))*bi2de(pop(i,durangelow(1):durangehigh(1)))/k(1);
%     dka1(i,1) = ((-1)^pop(i,dusign(2)))*bi2de(pop(i,durangelow(2):durangehigh(2)))/k(2);
%     dkb1(i,1) = ((-1)^pop(i,dusign(3)))*bi2de(pop(i,durangelow(3):durangehigh(3)))/k(3);
%     
%     skl1(i,1) = ((-1)^pop(i,stsign(1)))*bi2de(pop(i,strangelow(1):strangehigh(1)))/k(4);
%     skm1(i,1) = ((-1)^pop(i,stsign(2)))*bi2de(pop(i,strangelow(2):strangehigh(2)))/k(5);
%     skh1(i,1) = ((-1)^pop(i,posign(3)))*bi2de(pop(i,strangelow(3):strangehigh(3)))/k(6);
%     
%     wkl1(i,1) = ((-1)^pop(i,wisign(1)))*bi2de(pop(i,wirangelow(1):wirangehigh(1)))/k(4);
%     wkm1(i,1) = ((-1)^pop(i,wisign(2)))*bi2de(pop(i,wirangelow(2):wirangehigh(2)))/k(5);
%     wkh1(i,1) = ((-1)^pop(i,wisign(3)))*bi2de(pop(i,wirangelow(3):wirangehigh(3)))/k(6);
%     
%     dkl1(i,1) = ((-1)^pop(i,design(1)))*bi2de(pop(i,derangelow(1):derangehigh(1)))/k(4);
%     dkm1(i,1) = ((-1)^pop(i,design(2)))*bi2de(pop(i,derangelow(2):derangehigh(2)))/k(5);
%     dkh1(i,1) = ((-1)^pop(i,design(3)))*bi2de(pop(i,derangelow(3):derangehigh(3)))/k(6);
end
    
    knee = [pkl1 pkm1 pkh1 sks1 ska1 skf1 dks1 dka1 dkb1 skl1 skm1 skh1 wkl1 wkm1 wkh1 dkl1 dkm1 dkh1];
    l = size(knee,2);
    %% Implementing the MSE 
stsum = zeros(m,1);
wisum = zeros(m,1);
desum = zeros(m,1);
fvsum = zeros(m,1);

        for i=1:m
            for j=1:n
                st(i,j) = rmse(pkl1(i,:),pkm1(i,:),pkh1(i,:),skl1(i,:),skm1(i,:),skh1(i,:),...
                    sks1(i,:),ska1(i,:),skf1(i,:),wkl1(i,:),wkm1(i,:),wkh1(i,:),dks1(i,:),dka1(i,:),...
                    dkb1(i,:),dkl1(i,:),dkm1(i,:),dkh1(i,:),inputs(j,1:end));
                stsum(i,1)= (st(i,j)-outputs(j,1)')^2+ stsum(i,1);
%                     vo(i,j) = pi*((wi(i,j)/2)^2)*de(i,j)/2; % Volume of paraboloid pi*r2*h/2
            end
        end
         for i=1:m
            for j=1:n
                wi(i,j) = rmse(pkl1(i,:),pkm1(i,:),pkh1(i,:),skl1(i,:),skm1(i,:),skh1(i,:),...
                    sks1(i,:),ska1(i,:),skf1(i,:),wkl1(i,:),wkm1(i,:),wkh1(i,:),dks1(i,:),dka1(i,:),...
                    dkb1(i,:),dkl1(i,:),dkm1(i,:),dkh1(i,:),inputs(j,1:end));
                wisum(i,1)= (wi(i,j)-outputs(j,2)')^2+ wisum(i,1);
            end
        end
         for i=1:m
            for j=1:n
                de(i,j) = rmse(pkl1(i,:),pkm1(i,:),pkh1(i,:),skl1(i,:),skm1(i,:),skh1(i,:),...
                    sks1(i,:),ska1(i,:),skf1(i,:),wkl1(i,:),wkm1(i,:),wkh1(i,:),dks1(i,:),dka1(i,:),...
                    dkb1(i,:),dkl1(i,:),dkm1(i,:),dkh1(i,:),inputs(j,1:end));
                desum(i,1)= (de(i,j)-outputs(j,3)')^2+ desum(i,1);
            end
        end



% for i=1:m
%     for j=1:n
%         volume(1,j) = pi*(outputs(j,2)/2)^2*outputs(j,3)/2;
%         
%         
%         
%         fvsum(i,1)= (vo(i,j)-volume(1,j))^2+ fvsum(i,1);
%     end
%     fv(i) = sqrt(stsum(i)/(size(knee,2)*3));
       switch count
           case 0
               fv = sqrt(wisum/n);
           case 1
               fv = sqrt(wisum/n);
           case 2
               fv = sqrt(wisum/n);
           otherwise
               fv = sqrt(wisum/n);
       end
%     fv(i) = sqrt((wisum(i)+ desum(i))/(18*3));
% end
% fv = [wisum desum];
% count = 0;
% fv = sqrt((stsum + wisum + desum)/(n*3));
    wmr = [posign' spsign' dusign' stsign' wisign' design'] ; % Weight mutation range
    emr = [porangehigh' sprangehigh' durangehigh' strangehigh' wirangehigh' derangehigh'] ;
%    lastsum = min(fv);