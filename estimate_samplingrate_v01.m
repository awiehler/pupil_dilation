function [samplingrate] = estimate_samplingrate_v01(timestamps)
% function [samplingrate] = estimate_samplingrate_v01(timestamps)
%   This compute the empirical sampling rate of eytracker
%   recordings. Based on timestamps.
%
%   Input:
%   - timestamps: A vector of time stamps from an eyetribe recording (i.e.
%   eyeTrackdata.time). This should be recorded in milliseconds.
%
%   Outputs:
%   - samplingrate: An estimate of the samplingrate.
%
%   Author:   Antonius Wiehler <antonius.wiehler@gmail.com>
%   Original: 2018-02-28
%   Modified: 2018-03-22

samplingrate = 1000/nanmedian(diff(timestamps));

end  % function
