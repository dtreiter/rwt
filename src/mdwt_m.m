% Mallat discrete wavelet transform
% Last edited 27.04.2013

% Usage:
% x: input signal (currently must be of length 2^N)
% h: wavelet function
% L: number of levels

%Copyright (c) 2000 RICE UNIVERSITY. All rights reserved.
%Created by Josh Chartier, Department of ECE, Rice University. 
%
%This software is distributed and licensed to you on a non-exclusive 
%basis, free-of-charge. Redistribution and use in source and binary forms, 
%with or without modification, are permitted provided that the following 
%conditions are met:
%
%1. Redistribution of source code must retain the above copyright notice, 
%   this list of conditions and the following disclaimer.
%2. Redistribution in binary form must reproduce the above copyright notice, 
%   this list of conditions and the following disclaimer in the 
%   documentation and/or other materials provided with the distribution.
%3. All advertising materials mentioning features or use of this software 
%   must display the following acknowledgment: This product includes 
%   software developed by Rice University, Houston, Texas and its contributors.
%4. Neither the name of the University nor the names of its contributors 
%   may be used to endorse or promote products derived from this software 
%   without specific prior written permission.
%
%THIS SOFTWARE IS PROVIDED BY WILLIAM MARSH RICE UNIVERSITY, HOUSTON, TEXAS, 
%AND CONTRIBUTORS AS IS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
%BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
%FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RICE UNIVERSITY 
%OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
%EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
%PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
%OR BUSINESS INTERRUPTIONS) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
%WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
%OTHERWISE), PRODUCT LIABILITY, OR OTHERWISE ARISING IN ANY WAY OUT OF THE 
%USE OF THIS SOFTWARE,  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
%For information on commercial licenses, contact Rice University's Office of 
%Technology Transfer at techtran@rice.edu or (713) 348-6173
function y = mdwt_m(x,h,L)

ns = length(x); % length of input signal
nh = length(h); % length of scaling/wavelet function
H = []; % stores all highpass components
G = []; % stores all lowpass components

maxL = floor(log2(ns)); % maximum levels that can be computed
if L > maxL % check for L
    disp('L is too big for the signal')    
end

qh = qmf(h); % quadrature mirror of filter
tempx = x;
lc = ns;

for n = 1:L
    
    tempx = [tempx tempx(1:nh)]; % extend end of input signal by the length of the filter
    tempg = conv(tempx,rot90(h,2),'valid'); % lowpass components
    temph = conv(tempx,rot90(qh,2),'valid'); % highpass components
    G = [tempg(1:2:end-1) G]; % downsample and store
    H = [temph(1:2:end-1) H];
    lc = length(tempg(1:2:end-1)); % length of current level
    tempx = tempg(1:2:end-1); 

end

y = [G(1:lc) H]; % output last lowpass component with all high pass component

end