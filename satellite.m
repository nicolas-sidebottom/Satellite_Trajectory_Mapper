function [Tt, Xt, Yt, Zt, Ut, Vt, Wt] = satellite(Xo, Yo, Zo, Uo, Vo, Wo, Tstart, Tend, max_thrust)
%SATELLITE This finction takes a row vector of length 9 as an input, and
%uses those values as the initial conditions for calculating the position
%and velocity vectors of a satellite in orbit via the Euler-Cromer method.

%   This input vector is in the form of (Xo, Yo, Zo, Uo, Vo, Wo, Tstart,
%   Tend, max_thrust), and takes (in order from left to right) the initial 
%   X, Y, and Z positions, the initial velocity in the X, Y, and Z dircections,
%   the start time of the rocket engine burning, the end time of the rocket
%   burning, and the maximum thrust provided by the rocket. On output, the
%   function returns an array [T, X, Y, Z, U, V, W] that contains the
%   trajectories and velocity vectorsof the satellite's orbit from its initial position until
%   it reaches a total travel distance of 420000000 meters 
%
%   USAGE:
%
%   [ T, X, Y, Z, U, V, W] = satellite(0, -5949594.5, -3435000, 7615.60659, 0, 0, 20500, 24100, 350);

n = 1;
Ut(n) = Uo;
Vt(n) = Vo;
Wt(n) = Wo;
Tt(n) = 0;
Xt(n) = Xo;
Yt(n) = Yo;
Zt(n) = Zo;
arcFin = 420000000;
distance = 0;

dt = 1;

while distance < arcFin     
    [thx, thy, thz] = engine(Tstart, Tend, max_thrust, Tt(n), Ut(n), Vt(n), Wt(n));
    Ut(n+1) = Ut(n) + ((thx/1500)-((6.67408*10^-11)*(5.97*10^24))*(Xt(n)/(((Xt(n)^2)+(Yt(n)^2)+(Zt(n)^2))^(3/2))))*dt;
    Vt(n+1) = Vt(n) + ((thy/1500)-((6.67408*10^-11)*(5.97*10^24))*(Yt(n)/(((Xt(n)^2)+(Yt(n)^2)+(Zt(n)^2))^(3/2))))*dt;
    Wt(n+1) = Wt(n) + ((thz/1500)-((6.67408*10^-11)*(5.97*10^24))*(Zt(n)/(((Xt(n)^2)+(Yt(n)^2)+(Zt(n)^2))^(3/2))))*dt;
    Xt(n+1) = Xt(n) + Ut(n+1)*dt;
    Yt(n+1) = Yt(n) + Vt(n+1)*dt;
    Zt(n+1) = Zt(n) + Wt(n+1)*dt;
    Tt(n+1) = Tt(n) + dt;
    distance = distance + sqrt((Xt(n+1)-Xt(n))^2 + (Yt(n+1)-Yt(n))^2 + (Zt(n+1)-Zt(n))^2);
    n = n+1;
end 


end


