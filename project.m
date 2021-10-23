clear all;
close all;
format long;
clc;

name = 'Nicolas Sidebottom';
id = 'A16166786';
hw_num = 'project';

Re = 6370000;
max_T = 0;
for i = 1:6
   maxima_ct = 0;
   Z(1) = 0;
   [Xo, Yo, Zo, Uo, Vo, Wo, Tstart, Tend, max_thrust] = read_input('satellite_data.txt', i);
   [ T, X, Y, Z, U, V, W] = satellite(Xo, Yo, Zo, Uo, Vo, Wo, Tstart, Tend, max_thrust);
   satVecs(i).sat_id = i;
   satVecs(i).T = T;
   satVecs(i).X = X.*(10^-6);
   satVecs(i).Y = Y.*(10^-6);
   satVecs(i).Z = Z.*(10^-6);
   satVecs(i).U = U;
   satVecs(i).V = V;
   satVecs(i).W = W;
   stat(i).sat_id = i;
   stat(i).end_time = T(end);
   stat(i).final_position = [X(end), Y(end), Z(end)];
   stat(i).final_velocity = [U(end), V(end), W(end)];
   stat(i).max_speed = max(sqrt((U.^2 + V.^2 + W.^2)));
   stat(i).min_speed = min(sqrt((U.^2 + V.^2 + W.^2)));
   
   for n = 1:length(T)
    H(n) = sqrt(X(n)^2 + Y(n)^2 + Z(n)^2) - Re;
   end
   for k = 2:length(T)-1
    if H(k) >= H(k+1) && H(k) >= H(k-1)
       maxima_ct = maxima_ct+1;
       max_T(maxima_ct) = T(k); 
    end
   end
   stat(i).time_lmax_altitude = max_T;
   stat(i).orbital_period_before = (max_T(2) - max_T(1));
   stat(i).orbital_period_after = (max_T(end) - max_T(end-1));
end


figure(1)
subplot(2,3,1)
plot_earth
hold on
grid on
plot3(satVecs(1).X ,satVecs(1).Y,satVecs(1).Z,'m-');
plot3(satVecs(1).X(satVecs(1).T(end)),satVecs(1).Y(satVecs(1).T(end)),satVecs(1).Z(satVecs(1).T(end)),'mo','MarkerFaceColor','m');
title('Sat. 1')

figure(1)
subplot(2,3,2)
plot_earth
hold on
grid on
plot3(satVecs(2).X ,satVecs(2).Y,satVecs(2).Z,'c-');
plot3(satVecs(2).X(satVecs(2).T(end)),satVecs(2).Y(satVecs(2).T(end)),satVecs(2).Z(satVecs(2).T(end)),'co','MarkerFaceColor','c');
title('Sat. 2')

figure(1)
subplot(2,3,3)
plot_earth
hold on
grid on
plot3(satVecs(3).X ,satVecs(3).Y,satVecs(3).Z,'r-');
plot3(satVecs(3).X(satVecs(3).T(end)),satVecs(3).Y(satVecs(3).T(end)),satVecs(3).Z(satVecs(3).T(end)),'ro','MarkerFaceColor','r');
title('Sat. 3')

figure(1)
subplot(2,3,4)
plot_earth
hold on
grid on
plot3(satVecs(4).X ,satVecs(4).Y,satVecs(4).Z,'k-');
plot3(satVecs(4).X(satVecs(4).T(end)),satVecs(4).Y(satVecs(4).T(end)),satVecs(4).Z(satVecs(4).T(end)),'ko','MarkerFaceColor','k');
title('Sat. 4')

figure(1)
subplot(2,3,5)
plot_earth
hold on
grid on
plot3(satVecs(5).X ,satVecs(5).Y,satVecs(5).Z,'g-');
plot3(satVecs(5).X(satVecs(5).T(end)),satVecs(5).Y(satVecs(5).T(end)),satVecs(5).Z(satVecs(5).T(end)),'go','MarkerFaceColor','g');
title('Sat. 5')

figure(1)
subplot(2,3,6)
plot_earth
hold on
grid on
plot3(satVecs(6).X ,satVecs(6).Y,satVecs(6).Z,'b-');
plot3(satVecs(6).X(satVecs(6).T(end)),satVecs(6).Y(satVecs(6).T(end)),satVecs(6).Z(satVecs(6).T(end)),'bo','MarkerFaceColor','b');
title('Sat. 6')

for n = 1:6
    satVecs(n).altitude = sqrt(((satVecs(n).X)).^2 + ((satVecs(n).Y)).^2 + ((satVecs(n).Z)).^2);
    satVecs(n).speed = sqrt((satVecs(n).U).^2 + (satVecs(n).V).^2 + (satVecs(n).W).^2);
    satVecs(n).accel = diff(satVecs(n).speed)./diff(satVecs(n).T);
    
end


figure(2)
subplot(3,1,1)
hold on
grid on
plot((satVecs(1).T)./3600, ((satVecs(1).altitude))-6.37, 'm-')
plot((satVecs(2).T)./3600, ((satVecs(2).altitude))-6.37, 'c-')
plot((satVecs(3).T)./3600, ((satVecs(3).altitude))-6.37, 'r-')
plot((satVecs(4).T)./3600, ((satVecs(4).altitude))-6.37, 'k-')
plot((satVecs(5).T)./3600, ((satVecs(5).altitude))-6.37, 'g-')
plot((satVecs(6).T)./3600, ((satVecs(6).altitude))-6.37, 'b-')
title('Altitude vs. Time')
xlabel('Hours')
ylabel('Altitude (10^6 m)')
axis([0 16 0.5 2])

figure(2)
subplot(3,1,2)
hold on
grid on
plot((satVecs(1).T)./3600, (satVecs(1).speed)./1000, 'm-')
plot((satVecs(2).T)./3600, (satVecs(2).speed)./1000, 'c-')
plot((satVecs(3).T)./3600, (satVecs(3).speed)./1000, 'r-')
plot((satVecs(4).T)./3600, (satVecs(4).speed)./1000, 'k-')
plot((satVecs(5).T)./3600, (satVecs(5).speed)./1000, 'g-')
plot((satVecs(6).T)./3600, (satVecs(6).speed)./1000, 'b-')
title('Speed vs. Time')
xlabel('Hours')
ylabel('Speed (Km/s)')

figure(2)
subplot(3,1,3)
hold on
grid on
plot((satVecs(1).T(1:end-1))./3600, (satVecs(1).accel), 'm-')
plot((satVecs(2).T(1:end-1))./3600, (satVecs(2).accel), 'c-')
plot((satVecs(3).T(1:end-1))./3600, (satVecs(3).accel), 'r-')
plot((satVecs(4).T(1:end-1))./3600, (satVecs(4).accel), 'k-')
plot((satVecs(5).T(1:end-1))./3600, (satVecs(5).accel), 'g-')
plot((satVecs(6).T(1:end-1))./3600, (satVecs(6).accel), 'b-')
title('Acceleration vs. Time')
xlabel('Hours')
ylabel('Acceleration (m/s^2)')
axis([0 16 -0.75 0.75])
legend('Sat. 1','Sat. 2','Sat. 3','Sat. 4','Sat. 5','Sat. 6','Location','SouthWest')

fid = fopen('report.txt','w');
fprintf(fid, '%s\n %s\n %s\n', name, id, 'sat_id, max_speed(m/s), min_speed(m/s), orbital_period_before(s), orbital_period_after(s)');
for c = 1:6
   fprintf(fid, '%i\t %15.9e\t %15.9e\t %15.9e\t %15.9e\n', c, stat(c).max_speed, stat(c).min_speed, stat(c).orbital_period_before, stat(c).orbital_period_after); 
end
fclose(fid);


p1a = evalc('help read_input');
p1b = evalc('help satellite');
p1c = 'See figure 1';
p1d = 'See figure 2';
p2a = stat(1);
p2b = stat(2);
p2c = stat(3);
p2d = stat(4);
p2e = stat(5);
p2f = stat(6);
p3 = evalc('type report.txt');
p4a = 'The Satellites move fastest when they are closest to the Earth';
p4b = 'As the Satellites move away from Earth thier velocity decreases';