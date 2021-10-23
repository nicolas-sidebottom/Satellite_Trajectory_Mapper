function [Th] = thrust(t)
% THRUST gives the upward thrust of the rocket as a function of time.
% Call format: [Th] = thrust(t)
if t >= 0 && t < 2
    Th = 670;  
elseif t < 4
    Th = 1360; 
else
    Th = 0;
end
end %function thrust