function [ d ] = bandpass_filter_v02( d, fs, fcutlow, fcuthigh )
%function [ d ] = bandpass_filter_v02( d, fs, fcutlow, fcuthigh )
% this is a low pass filter for temporal data, e.g. pupil diameter.
%
% d: time series.
% fs: sampling rate in Hz.
% fcutlow: Filter lower than this.
% fcuthigh: Filter higher than this.
%
% Author: Antonius Wiehler <antonius.wiehler@gmail.com>
% Original: 2017-06-30
% Modified: 2018-09-13

% mirror signal to avoid border artefacts
d      = [flipud(d); d; flipud(d)];

order  = 1;
[b, a] = butter(order, [fcutlow, fcuthigh] / (fs / 2), 'bandpass');  % create filter
d      = filter(b, a, d);  % filtered signal

% unmirror the signal again
ld         = length(d);
third      = ceil(ld ./ 3);  % for odd number of bit-stream length
d          = d(third+1 : third.*2);

end
