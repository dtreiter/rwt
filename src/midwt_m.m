% Mallat inverse discrete wavelet transform
% Created by Josh Chartier
% Last edited 27.04.2013

% Usage:
% y: wavelet coefficients
% h: reconstruction wavelet function
% L: number of levels

function x = midwt_m(y,h,L)

ns = length(y); % length of coefficients
nh = length(h); 
if 2^L > ns
    disp('L is too big')
end

ind = ns/2^L; % index for level
qh = qmf(h); % quadrature mirror of filter
tempy = y(1:ind); % lowpass coefficients

for n = 1:L
        
    G = upsample(tempy,2); % insert zeros in between lowpass coefficients       
    tempg = conv(G(1:end-1),h); % convolve with recontruction filter 
    
    H = upsample(y(ind+1:2*ind),2); % insert zeros in between lowpass coefficients
    temph = conv(H(1:end-1),qh); % convolve with recontruction filter 
    
    tempy = tempg(1:end-nh+2) + temph(1:end-nh+2); % add lowpass and highpass reconstructions
    ind = 2*ind; % next level
    
end
    
x = tempy;