function [d] = remove_outliers_mad_v01(d, cutoff, blink)
% function [d] = remove_outliers_mad_v01(d, cutoff, blink)
%
% Remove outliers in 1D pupil size measures.
%
% d: vector of pupil size measures
% cutoff: outside how many standard deviation is it an outlier?
% blink: how is a blink defined in the data? usually 0. We will replace
% outliers by this.
%
% Author: Antonius Wiehler <antonius.wiehler@gmail.com>
% Original: 2017-06-24
% Modified: 2017-10-30


blink_rows = d == blink;  % don't consider rows we marked as blinks before

cutoff_low  = nanmedian(d(~blink_rows)) - cutoff * mad(d(~blink_rows), 1);
cutoff_high = nanmedian(d(~blink_rows)) + cutoff * mad(d(~blink_rows), 1);

d(d < cutoff_low)  = blink;  % mark as blink
d(d > cutoff_high) = blink; % mark as blink

end

