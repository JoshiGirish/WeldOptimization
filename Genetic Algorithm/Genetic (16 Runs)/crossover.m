function newpop = crossover(pop,fit,pc,sizes,k,power,speed,duration,strength,width,depth)
[x,y]=size(pop); % Find the size of the population matrix
 if (rand < pc) % generate a random number and proceed only if it is less than the crossover probability
    mini = max(fit)*ones(2,1); % initial two element array for finding the two minimum error chromosomes
    index = ones(2,1); % initial two element array to store the indices of the the two minimum error chromosomes
    maxc =zeros(2,1); % initial two element array for finding the two max error chromosomes
    indc = ones(2,1); % initial two element array to store the indices of the two max error chromosomes
    for i=1:x % loop through each row/chromosome
        if fit(i) <= mini(1) % if the error of the current chromo is less than the first element
            mini(2) = mini(1); % assign the value of first element to the second
            index(2) = index(1); % assign the index of the first index element to the second
            mini(1) = fit(i); % assign the error value of current chromo to the first element
            index(1) = i; % assign the index of the current chromo to the first index element
        else if fit(i) < mini(2)
                mini(2) = fit(i);
                index(2) = i;
            end
        end
    end
%      for i=1:x
%         if fit(i) >= maxc(1)
%             maxc(2) = maxc(1);
%             indc(2) = indc(1);
%             maxc(1) = fit(i);
%             indc(1) = i;
%         else if fit(i) > maxc(2)
%                 maxc(2) = fit(i);
%                 indc(2) = i;
%             end
%         end
%      end
 indc = randi(x,1,2)';
      cpoint=ceil(randi(y-1,1,1));
        newpop = pop;
         newpop(indc(1),:) =[pop(index(1),1:cpoint) pop(index(2),cpoint+1:end)];
         newpop(indc(2),:) =[pop(index(2),1:cpoint) pop(index(1),cpoint+1:end)];

%         child1 =[pop(index(1),1:cpoint) pop(index(2),cpoint+1:end)];
%         child2 =[pop(index(2),1:cpoint) pop(index(1),cpoint+1:end)];
%         indc = randi(x,1,2)';
%         if indc(1)==index(1) || indc(2)==index(2) || indc(1)==index(2) || indc(2)==index(1) 
%             indc = randi(x,1,2);
%         else
%         newpop(indc(1),:) = test(child1,sizes,k,power,speed,duration,strength,width,depth);
%         newpop(indc(2),:) = test(child2,sizes,k,power,speed,duration,strength,width,depth);
%         end

    else
    newpop = pop;
end