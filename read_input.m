function [Xo, Yo, Zo, Uo, Vo, Wo, Tstart, Tend, max_thrust] = read_input(input_filename,sat_id)
%READ_INPUT - This function reads the file containing satellite conditions
%and returns the necessary data based on the satellite ID.
%   This function takes a filename and integer as inputs, and uses reads
%   the data contained in the file out to a vector of values for each
%   satellite ID.
%   USAGE:
%
%           [Xo, Yo, Zo, Uo, Vo, Wo, Tstart, Tend, max_thrust] = read_input('satellite_data.txt', 1)
%
%           This would return a vector of values containing the data for
%           satellite 1 in the satellite.txt file.


imported = importdata(input_filename,'\t', 3);
satIDVec = imported.data(:,1);
index_num = find(satIDVec == sat_id);
if isempty(index_num)
    Xo = NaN;
    Yo = NaN;
    Zo = NaN;
    Uo = NaN;
    Vo = NaN;
    Wo = NaN;
    Tstart = NaN;
    Tend = NaN;
    max_thrust = NaN;
else
    Xo = imported.data(index_num,2);
    Yo = imported.data(index_num,3);
    Zo = imported.data(index_num,4);
    Uo = imported.data(index_num,5);
    Vo = imported.data(index_num,6);
    Wo = imported.data(index_num,7);
    Tstart = imported.data(index_num,8);
    Tend = imported.data(index_num,9);
    max_thrust = imported.data(index_num,10);
   
end

end

