function [newpop,number] = mutation(pop,fit,pm,sizes,k,power,speed,duration,strength,width,depth,wmr,emr,count)

[x,y]=size(pop); % Size of the population matrix
number = ceil(rand*1);  % a random value which decides how many mutation points to use
 if rand < pm
    mpoint = randi(y-1,2,number);
%% Find out the indices and values of the top two chromosomes which have 
% highest error values so that these can be mutated
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
%% 
    newpop = pop;
     mutant1 = pop(indice(1),:);
%      indc = randi(x,1,2);
    for i=1:size(mpoint,2)
%          arb = rand;
%            if arb < 0.7
               mutant1(1,mpoint(1,i)) = abs(mutant1(1,mpoint(1,i))-1);
%            else
%                mutant1(1,mpoint(2,i)) = abs(pop(indice(1),mpoint(2,i))-1);
%            end
%         mutant2(1,mpoint(2,i)) = abs(pop(indice(2),mpoint(i))-1);
    end
    newpop(indice(1),:) = mutant1;
%     newpop(indice(2),:) = mutant2;
%     newpop(indice(1),:)= test(mutant1,sizes,k,power,speed,duration,strength,width,depth);
else
    newpop = pop;
end