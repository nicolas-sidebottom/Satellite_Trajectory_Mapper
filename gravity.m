function [g] = gravity(z)
% GRAVITY gives a value of g as a function of altitude z.
% Call format: [g] = gravity(z)
if z >= 0 && z < 10000
    g = 9.81*(1 - (z/10000)^3);
else
    g = 0;
end
end %function gravity