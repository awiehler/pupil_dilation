function [d, blink_indx] = interpolate_blinks_nonlinear_v01(d, blink, samplingrate, blinkWindow)
% function [d, blink_indx] = interpolate_blinks_nonlinear_v01(d, blink, samplingrate, blinkWindow)
%
% Interpolate blinks in 1D pupil size measures.
%
% d: vector of pupil size measures
% blink: how is a blink defined in the data, usually 0, this is not an index vector! Typically, everything is interpolated when the signal is 0.
% samplingrate: samplingrate of the eyetracker
% blinkWindow: how many seconds should be removed before and after a blink?
% blink_indx: Where are blinks?
% The function depends on MergeBrackets.m
%
% Author: Antonius Wiehler <antonius.wiehler@gmail.com>
% Original: 2017-01-11
% Modified: 2018-09-13

% mirror signal to avoid border artefacts - if the data starts or ends with a blink, the non linear interpolation can go wild.
d      = [flipud(d); d; flipud(d)];

sampleLength   = 1 ./ samplingrate;  % how long is one sample in seconds?
blink_samples  = ceil(blinkWindow ./ sampleLength);  % how many samples do we have to remove before and after a blink?

blink_indx     = d == blink;
blink_position = [0; blink_indx; 0];  % where is the pupil diameter a blink?

blink_start    = find(diff(blink_position) == 1);  % where do the blinks start?
blink_end     = find(diff(blink_position) == -1) -1;  % where do blinks end?

blink_start    = blink_start - blink_samples;  % add window at beginning of blink
blink_end     = blink_end + blink_samples;  % add window at end of blink

% keep only legal values
blink_start(blink_start < 1) = 1;
blink_end(blink_end > length(d)) = length(d);


[blink_start, blink_end] = MergeBrackets(blink_start, blink_end);  % Merge overlapping blinks (blinks can be overlapping due to the additional window

X = (1 : length(d))'; % intext for interpolation


for i_b = 1 : length(blink_start)  % loop through blinks
    X(blink_start(i_b) : blink_end(i_b)) = nan;
end

xi = find(isnan(X));  % which samples need to be interpolated?

d(isnan(X)) = [];  % remove to be interpolated data
X(isnan(X)) = [];  % remove to be interpolated data

di = interp1(X, d, xi, 'pchip');  % interpolate

%  figure;plot(X, d, '.'); hold on; plot(xi, di, '.'); ylim([0 40]);  % plot to evaluate the interpolation


% join real and interpolated data and sort
X = [X; xi];
[X, sort_i] = sort(X);

d = [d; di];
d = d(sort_i);


% unmirror the signal again
ld         = length(d);
third      = ceil(ld ./ 3);  % for odd number of bit-stream length
d          = d(third+1 : third.*2);
blink_indx = blink_indx(third+1 : third.*2);

end
