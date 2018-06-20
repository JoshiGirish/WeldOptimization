function [mvl,mvm,mvh] = membership(kneelow,kneemedium,kneehigh,input)
% Low membership value
gradlow = 1/(kneemedium - kneelow);
if input <= kneelow
        mvl = 1;
    else if (input > kneelow && input <= kneemedium)
           mvl = 1 - gradlow*(input-kneelow);
        else if input > kneemedium
            mvl = 0;
            end
        end
end

% Medium membership value
gradleft = 1/(kneemedium - kneelow);
gradright = 1/(kneehigh - kneemedium);
if input <= kneelow || input >= kneehigh
    mvm = 0;
else if input > kneelow && input <= kneemedium
        mvm = 0 + gradleft*(input-kneelow);
    else if input > kneemedium && input < kneehigh
            mvm = 1 - gradright*(input-kneemedium);
        end
    end
end

% High membership value
gradhigh = 1/(kneehigh-kneemedium);
if input <= kneemedium
    mvh = 0;
else if input > kneemedium && input < kneehigh
        mvh = 0 + gradhigh*(input-kneemedium);
    else if input >= kneehigh
            mvh = 1;
        end
    end
end