function [fv,knee,st,wi,de] = fitness(pop,sizes,inputs,outputs,k,count)

m = sizes(1,1); % number of rows of pop
n = size(inputs,1); % number of rows of inputs
for i=1:3
    porangelow(i) = 1+(i-1)*sizes(1,2); % Lower three range of binary vector of power
    porangehigh(i) = i*sizes(1,2); % Higher three range of binary vector of power
end
for i=1:3
    sprangelow(i) = (1+porangehigh(3)+(i-1)*sizes(2,2));
    sprangehigh(i) = porangehigh(3)+i*sizes(2,2);
end
for i=1:3
    durangelow(i) = (1+sprangehigh(3)+(i-1)*sizes(3,2));
    durangehigh(i) = sprangehigh(3)+i*sizes(3,2);
end
for i=1:3
    strangelow(i) = (1+durangehigh(3)+(i-1)*sizes(4,2));
    strangehigh(i) = durangehigh(3)+i*sizes(4,2);
end
for i=1:3
    wirangelow(i) = (1+strangehigh(3)+(i-1)*sizes(5,2));
    wirangehigh(i) = strangehigh(3)+i*sizes(5,2);
end
for i=1:3
    derangelow(i) = (1+wirangehigh(3)+(i-1)*sizes(6,2));
    derangehigh(i) = wirangehigh(3)+i*sizes(6,2);
end
    
% Sort out the knee points from the pop matrix
for i = 1:m
    pkl1(i,1) = bi2de(pop(i,porangelow(1):porangehigh(1)))/k(1);
    pkm1(i,1) = bi2de(pop(i,porangelow(2):porangehigh(2)))/k(1);
    pkh1(i,1) = bi2de(pop(i,porangelow(3):porangehigh(3)))/k(1);
    
    sks1(i,1) = bi2de(pop(i,sprangelow(1):sprangehigh(1)))/k(2);
    ska1(i,1) = bi2de(pop(i,sprangelow(2):sprangehigh(2)))/k(2);
    skf1(i,1) = bi2de(pop(i,sprangelow(3):sprangehigh(3)))/k(2);
    
    dks1(i,1) = bi2de(pop(i,durangelow(1):durangehigh(1)))/k(3);
    dka1(i,1) = bi2de(pop(i,durangelow(2):durangehigh(2)))/k(3);
    dkb1(i,1) = bi2de(pop(i,durangelow(3):durangehigh(3)))/k(3);
    
    skl1(i,1) = bi2de(pop(i,strangelow(1):strangehigh(1)))/k(4);
    skm1(i,1) = bi2de(pop(i,strangelow(2):strangehigh(2)))/k(4);
    skh1(i,1) = bi2de(pop(i,strangelow(3):strangehigh(3)))/k(4);
    
    wkl1(i,1) = bi2de(pop(i,wirangelow(1):wirangehigh(1)))/k(5);
    wkm1(i,1) = bi2de(pop(i,wirangelow(2):wirangehigh(2)))/k(5);
    wkh1(i,1) = bi2de(pop(i,wirangelow(3):wirangehigh(3)))/k(5);
    
    dkl1(i,1) = bi2de(pop(i,derangelow(1):derangehigh(1)))/k(6);
    dkm1(i,1) = bi2de(pop(i,derangelow(2):derangehigh(2)))/k(6);
    dkh1(i,1) = bi2de(pop(i,derangelow(3):derangehigh(3)))/k(6);
end
    
    knee = [pkl1 pkm1 pkh1 sks1 ska1 skf1 dks1 dka1 dkb1 skl1 skm1 skh1 wkl1 wkm1 wkh1 dkl1 dkm1 dkh1];
% Calculate membership values of all the inputs
for i=1:m
    for j=1:n
    [pomvl(i,j),pomvm(i,j),pomvh(i,j)]= membership(pkl1(i,1),pkm1(i,1),pkh1(i,1),inputs(j,1));
    [spmvl(i,j),spmvm(i,j),spmvh(i,j)]= membership(sks1(i,1),ska1(i,1),skf1(i,1),inputs(j,2));
    [dumvl(i,j),dumvm(i,j),dumvh(i,j)]= membership(dks1(i,1),dka1(i,1),dkb1(i,1),inputs(j,3));
%     [stmvl(i),stmvm(i),stmvh(i)]= membership(skl(i),skm(i),skh(i),inputs(i,4));
%     [wimvl(i),wimvm(i),wimvh(i)]= membership(wkl(i),wkm(i),wkh(i),inputs(i,5));
%     [demvl(i),demvm(i),demvh(i)]= membership(dkl(i),dkm(i),dkh(i),inputs(i,6));
    end
end

% %% Calculate the membership values of the outputs using the rules
% for i=1:m
%     for j=1:n
%     stmvl(i,j) = max(spmvh(i,j),max(pomvh(i,j),dumvl(i,j)));
%     wimvl(i,j) = max(pomvl(i,j),max(spmvh(i,j),dumvl(i,j)));
%     demvl(i,j) = max(pomvl(i,j),max(spmvh(i,j),dumvl(i,j)));
%     
%     stmvm(i,j) = max(min(pomvl(i,j),min(spmvl(i,j),dumvl(i,j))),max(min(pomvm(i,j),min(spmvm(i,j),dumvm(i,j))),min(pomvh(i,j),min(spmvh(i,j),dumvh(i,j)))));
%     wimvm(i,j) = max(min(pomvl(i,j),min(spmvl(i,j),dumvl(i,j))),max(min(pomvm(i,j),min(spmvm(i,j),dumvm(i,j))),min(pomvh(i,j),min(spmvh(i,j),dumvh(i,j)))));
%     demvm(i,j) = max(min(pomvl(i,j),min(spmvl(i,j),dumvl(i,j))),max(min(pomvm(i,j),min(spmvm(i,j),dumvm(i,j))),min(pomvh(i,j),min(spmvh(i,j),dumvh(i,j)))));
%     
% %     stmvm(i,j) = max(min(pomvl(i,j),spmvl(i,j)),max(min(pomvm(i,j),spmvm(i,j)),min(pomvh(i,j),spmvh(i,j))));
% %     wimvm(i,j) = max(min(pomvl(i,j),spmvl(i,j)),max(min(pomvm(i,j),spmvm(i,j)),min(pomvh(i,j),spmvh(i,j))));
% %     demvm(i,j) = max(min(pomvl(i,j),spmvl(i,j)),max(min(pomvm(i,j),spmvm(i,j)),min(pomvh(i,j),spmvh(i,j))));
%     
%     stmvh(i,j) = max(spmvl(i,j),max(pomvl(i,j),dumvh(i,j)));
%     wimvh(i,j) = max(pomvh(i,j),max(spmvl(i,j),dumvh(i,j)));
%     demvh(i,j) = max(pomvh(i,j),max(spmvl(i,j),dumvh(i,j)));
%     end
% end


%% Calculate the membership values of the outputs using the rules
for i=1:m
    for j=1:n
    stmvl(i,j) = max(min(pomvh(i,j),min(spmvh(i,j),dumvl(i,j))),max(min(pomvh(i,j),min(spmvm(i,j),dumvm(i,j))),max(min(pomvl(i,j),min(spmvm(i,j),dumvh(i,j))),min(pomvm(i,j),min(spmvh(i,j),dumvh(i,j))))));
    wimvl(i,j) = max(min(pomvm(i,j),min(spmvl(i,j),dumvm(i,j))),max(min(pomvl(i,j),min(spmvh(i,j),dumvm(i,j))),min(pomvl(i,j),min(spmvm(i,j),dumvh(i,j)))));
    demvl(i,j) = max(min(pomvl(i,j),min(spmvl(i,j),dumvl(i,j))),max(min(pomvm(i,j),min(spmvl(i,j),dumvm(i,j))),max(min(pomvh(i,j),min(spmvm(i,j),dumvm(i,j))),max(min(pomvl(i,j),min(spmvh(i,j),dumvm(i,j))),min(pomvl(i,j),min(spmvm(i,j),dumvh(i,j)))))));
    
    stmvm(i,j) = max(min(pomvl(i,j),min(spmvl(i,j),dumvl(i,j))),max(min(pomvm(i,j),min(spmvm(i,j),dumvl(i,j))),max(min(pomvl(i,j),min(spmvh(i,j),dumvm(i,j))),min(pomvh(i,j),min(spmvl(i,j),dumvh(i,j))))));
    wimvm(i,j) = max(min(pomvl(i,j),min(spmvl(i,j),dumvl(i,j))),max(min(pomvm(i,j),min(spmvm(i,j),dumvl(i,j))),max(min(pomvh(i,j),min(spmvm(i,j),dumvm(i,j))),min(pomvh(i,j),min(spmvl(i,j),dumvh(i,j))))));
    demvm(i,j) = max(min(pomvm(i,j),min(spmvm(i,j),dumvl(i,j))),max(min(pomvh(i,j),min(spmvl(i,j),dumvh(i,j))),min(pomvm(i,j),min(spmvh(i,j),dumvh(i,j)))));
    
%     stmvm(i,j) = max(min(pomvl(i,j),spmvl(i,j)),max(min(pomvm(i,j),spmvm(i,j)),min(pomvh(i,j),spmvh(i,j))));
%     wimvm(i,j) = max(min(pomvl(i,j),spmvl(i,j)),max(min(pomvm(i,j),spmvm(i,j)),min(pomvh(i,j),spmvh(i,j))));
%     demvm(i,j) = max(min(pomvl(i,j),spmvl(i,j)),max(min(pomvm(i,j),spmvm(i,j)),min(pomvh(i,j),spmvh(i,j))));
    
    stmvh(i,j) = min(pomvm(i,j),min(spmvl(i,j),dumvm(i,j)));
    wimvh(i,j) = max(min(pomvh(i,j),min(spmvh(i,j),dumvl(i,j))),min(pomvm(i,j),min(spmvh(i,j),dumvh(i,j))));
    demvh(i,j) = min(pomvh(i,j),min(spmvh(i,j),dumvl(i,j)));
    end
end
%% Derive the crisp values of outputs using the centroid rule
for i=1:m
    for j=1:n
        st(i,j) = centroid(stmvl(i,j),stmvm(i,j),stmvh(i,j),skl1(i,1),skm1(i,1),skh1(i,1),outputs(1:n,1));
        wi(i,j) = centroid(wimvl(i,j),wimvm(i,j),wimvh(i,j),wkl1(i,1),wkm1(i,1),wkh1(i,1),outputs(1:n,2));
        de(i,j) = centroid(demvl(i,j),demvm(i,j),demvh(i,j),dkl1(i,1),dkm1(i,1),dkh1(i,1),outputs(1:n,3));
        vo(i,j) = pi*((wi(i,j)/2)^2)*de(i,j)/2; % Volume of paraboloid pi*r2*h/2
    end
end
%% Implementing the MSE 
stsum = zeros(m,1);
wisum = zeros(m,1);
desum = zeros(m,1);
fvsum = zeros(m,1);

for i=1:m
    for j=1:n
        volume(1,j) = pi*(outputs(j,2)/2)^2*outputs(j,3)/2;
        stsum(i,1)= (st(i,j)-outputs(j,1))^2+ stsum(i);
        wisum(i,1)= (wi(i,j)-outputs(j,2))^2+ wisum(i);
        desum(i,1)= (de(i,j)-outputs(j,3))^2+ desum(i);
        fvsum(i,1)= (vo(i,j)-volume(1,j))^2+ fvsum(i);
    end
%     fv(i) = sqrt(stsum(i)/(size(knee,2)*3));
        
%     fv(i) = sqrt((wisum(i)+ desum(i))/(18*3));
end
%    if count <= 1
%                fv = sqrt(stsum/n);
%    else if count > 1 && count <= 2
%                fv = sqrt(wisum/n);
%        else
%                fv = sqrt(desum/n);
%        end
%    end
fv = sqrt((wisum + desum + stsum)/(n*3));