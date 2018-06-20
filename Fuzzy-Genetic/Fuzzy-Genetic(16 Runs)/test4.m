function mix = test4(child,sizes,k,power,speed,duration,strength,width,depth)
m = sizes(1,1); % number of rows of pop
% n = size(inputs,1); % number of rows of inputs
for i=1:4
    porangelow(i) = 1+(i-1)*sizes(1,2); % Lower three range of binary vector of power
    porangehigh(i) = i*sizes(1,2); % Higher three range of binary vector of power
end
for i=1:4
    sprangelow(i) = (1+porangehigh(4)+(i-1)*sizes(2,2));
    sprangehigh(i) = porangehigh(4)+i*sizes(2,2);
end
for i=1:4
    durangelow(i) = (1+sprangehigh(4)+(i-1)*sizes(3,2));
    durangehigh(i) = sprangehigh(4)+i*sizes(3,2);
end
for i=1:4
    strangelow(i) = (1+durangehigh(4)+(i-1)*sizes(4,2));
    strangehigh(i) = durangehigh(4)+i*sizes(4,2);
end
for i=1:4
    wirangelow(i) = (1+strangehigh(4)+(i-1)*sizes(5,2));
    wirangehigh(i) = strangehigh(4)+i*sizes(5,2);
end
for i=1:4
    derangelow(i) = (1+wirangehigh(4)+(i-1)*sizes(6,2));
    derangehigh(i) = wirangehigh(4)+i*sizes(6,2);
end
    
% Sort out the knee points from the pop matrix

    pl1 = bi2de(child(1,porangelow(1):porangehigh(1)))/k(1);
    pm1 = bi2de(child(1,porangelow(2):porangehigh(2)))/k(1);
    pm2 = bi2de(child(1,porangelow(3):porangehigh(3)))/k(1);
    ph1 = bi2de(child(1,porangelow(4):porangehigh(4)))/k(1);
    
    ss1 = bi2de(child(1,sprangelow(1):sprangehigh(1)))/k(2);
    sa1 = bi2de(child(1,sprangelow(2):sprangehigh(2)))/k(2);
    sa2 = bi2de(child(1,sprangelow(3):sprangehigh(3)))/k(2);
    sf1 = bi2de(child(1,sprangelow(4):sprangehigh(4)))/k(2);
    
    ds1 = bi2de(child(1,durangelow(1):durangehigh(1)))/k(3);
    da1 = bi2de(child(1,durangelow(2):durangehigh(2)))/k(3);
    da2 = bi2de(child(1,durangelow(3):durangehigh(3)))/k(3);
    db1 = bi2de(child(1,durangelow(4):durangehigh(4)))/k(3);
    
    sl1 = bi2de(child(1,strangelow(1):strangehigh(1)))/k(4);
    sm1 = bi2de(child(1,strangelow(2):strangehigh(2)))/k(4);
    sm2 = bi2de(child(1,strangelow(3):strangehigh(3)))/k(4);
    sh1 = bi2de(child(1,strangelow(4):strangehigh(4)))/k(4);
    
    wl1 = bi2de(child(1,wirangelow(1):wirangehigh(1)))/k(5);
    wm1 = bi2de(child(1,wirangelow(2):wirangehigh(2)))/k(5);
    wm2 = bi2de(child(1,wirangelow(3):wirangehigh(3)))/k(5);
    wh1 = bi2de(child(1,wirangelow(4):wirangehigh(4)))/k(5);
    
    dl1 = bi2de(child(1,derangelow(1):derangehigh(1)))/k(6);
    dm1 = bi2de(child(1,derangelow(2):derangehigh(2)))/k(6);
    dm2 = bi2de(child(1,derangelow(3):derangehigh(3)))/k(6);
    dh1 = bi2de(child(1,derangelow(4):derangehigh(4)))/k(6);


% Check if low knee is smaller than medium knee and medium knee is lower
% than high knee
pow = sort([pl1 pm1 pm2 ph1]);
spe = sort([ss1 sa1 sa2 sf1]);
dur = sort([ds1 da1 da2 db1]);
str = sort([sl1 sm1 sm2 sh1]);
wid = sort([wl1 wm1 wm2 wh1]);
dep = sort([dl1 dm1 dm2 dh1]);
% Convert anything "above max" to "max" and "below min" to "min"
% for i=1:3
%     if pow(i) > max(power)
%         pow(i) = max(power);
%     else if pow(i) < min(power)
%             pow(i) = min(power);
%         end
%     end
%     if spe(i) > max(speed)
%         spe(i) = max(speed);
%     else if spe(i) < min(speed)
%             spe(i) = min(speed);
%         end
%     end
%     if dur(i) > max(duration)
%         dur(i) = max(duration);
%     else if dur(i) < min(duration)
%             dur(i) = min(duration);
%         end
%     end
%     if str(i) > max(strength)
%         str(i) = max(strength);
%     else if str(i) < min(strength)
%             str(i) = min(strength);
%          end
%     end
%     if wid(i) > max(width)
%         wid(i) = max(width);
%     else if wid(i) < min(width)
%             wid(i) = min(width);
%         end
%     end
%     if dep(i) > max(depth)
%         dep(i) = max(depth);
%     else if dep(i) < min(depth)
%             dep(i) = min(depth);
%         end
%     end
% end
p = sizes(1,2);
q = sizes(2,2);
r = sizes(3,2);
s = sizes(4,2);
t = sizes(5,2);
u = sizes(6,2);
mix = [de2bi(ceil(pow(1)*k(1)),p) de2bi(round(pow(2)*k(1)),p) de2bi(floor(pow(3)*k(1)),p) de2bi(floor(pow(4)*k(1)),p) de2bi(ceil(spe(1)*k(2)),q) de2bi(round(spe(2)*k(2)),q) de2bi(floor(spe(3)*k(2)),q) de2bi(floor(spe(4)*k(2)),q) de2bi(ceil(dur(1)*k(3)),r) ...
    de2bi(round(dur(2)*k(3)),r) de2bi(floor(dur(3)*k(3)),r) de2bi(floor(dur(4)*k(3)),r) de2bi(ceil(str(1)*k(4)),s) de2bi(round(str(2)*k(4)),s) de2bi(floor(str(3)*k(4)),s) de2bi(floor(str(4)*k(4)),s) de2bi(ceil(wid(1)*k(5)),t) de2bi(round(wid(2)*k(5)),t) ...
    de2bi(floor(wid(3)*k(5)),t) de2bi(floor(wid(4)*k(5)),t) de2bi(ceil(dep(1)*k(6)),u) de2bi(round(dep(2)*k(6)),u) de2bi(floor(dep(3)*k(6)),u) de2bi(floor(dep(4)*k(6)),u)];


