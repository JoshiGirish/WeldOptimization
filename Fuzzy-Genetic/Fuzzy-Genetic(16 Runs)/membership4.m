function [mvl,mvm1,mvm2,mvh] = membership4(kneelow,kneemedium1,kneemedium2,kneehigh,input)
% Low membership value
gradlow = 1/(kneemedium1 - kneelow);
if input <= kneelow
        mvl = 1;
    else if (input > kneelow && input <= kneemedium1)
           mvl = 1 - gradlow*(input-kneelow);
        else if input > kneemedium1
            mvl = 0;
            end
        end
end

% Medium membership value
gradleft1 = 1/(kneemedium1 - kneelow);
gradright1 = 1/(kneemedium2 - kneemedium1);
if input <= kneelow || input >= kneemedium2
    mvm1 = 0;
else if input > kneelow && input <= kneemedium1
        mvm1 = 0 + gradleft1*(input-kneelow);
    else if input > kneemedium1 && input < kneemedium2
            mvm1 = 1 - gradright1*(input-kneemedium1);
        end
    end
end

% Medium membership value
gradleft2 = 1/(kneemedium2 - kneemedium1);
gradright2 = 1/(kneehigh - kneemedium2);
if input <= kneemedium1 || input >= kneehigh
    mvm2 = 0;
else if input > kneemedium1 && input <= kneemedium2
        mvm2 = 0 + gradleft2*(input-kneemedium1);
    else if input > kneemedium2 && input < kneehigh
            mvm2 = 1 - gradright2*(input-kneemedium2);
        end
    end
end

% High membership value
gradhigh = 1/(kneehigh-kneemedium2);
if input <= kneemedium2
    mvh = 0;
else if input > kneemedium2 && input < kneehigh
        mvh = 0 + gradhigh*(input-kneemedium2);
    else if input >= kneehigh
            mvh = 1;
        end
    end
end