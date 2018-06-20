function [newpop,number] = mutate(pop,fit,pm,sizes,k,power,speed,duration,strength,width,depth,wmr,emr,count)

[x,y]=size(pop);
number = ceil(rand*3);
 if rand < pm
       mpoint = round(randi(y-1,2,number));
%     switch count 
%         case 0
%             range1 = wmr(1,1):emr(3,1);
%             range2 = wmr(1,4):emr(3,4);
%         case 1
%             range1 = wmr(1,2):emr(3,2);
%             range2 = wmr(1,5):emr(3,5);
%         otherwise
%             range1 = wmr(1,3):emr(3,3);
%             range2 = wmr(1,6):emr(3,6);
%     end
% 
range1 = wmr(1,1):emr(3,4);
range2 = wmr(1,5):emr(3,6);
limit = 1;
for j = 1:limit
    mpoint(1,j) = round(min(range1) + (max(range1)-min(range1))*rand(1,1));
    mpoint(2,j) = round(min(range2) + (max(range2)-min(range2))*rand(1,1));
end
    maxi = zeros(2,1);
    indice = zeros(2,1);
    for i=1:x
        if fit(i) >= maxi(1)
            maxi(2) = maxi(1);
            indice(2) = indice(1);
            maxi(1) = fit(i);
            indice(1) = i;
        else if fit(i) > maxi(2)
                maxi(2) = fit(i);
                indice(2) = i;
            end
        end
    end
    newpop = pop;
    for i=1:size(mpoint,2)
        mutant1 = pop(indice(1),:);
%         mutant2 = pop(indice(2),:);
           arb = rand;
           if arb < 0.7
               mutant1(1,mpoint(1,i)) = abs(pop(indice(1),mpoint(1,i))-1);
           else
               mutant1(1,mpoint(2,i)) = abs(pop(indice(1),mpoint(2,i))-1);
           end
%         mutant2(1,mpoint(2,i)) = abs(pop(indice(2),mpoint(i))-1);
    end
    newpop(indice(1),:) = mutant1;
%     newpop(indice(2),:) = mutant2;
%     newpop(indice(1),:)= test(mutant1,sizes,k,power,speed,duration,strength,width,depth);
else
    newpop = pop;
end