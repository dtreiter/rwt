function y = mdwt2_m(x,h,L)

[ms,ns] = size(x); % size of image
nh = length(h); % length of wavelet function

qh = qmf(h); % quadrature mirror of filter
tempx = x; 
tempy = zeros(ms,ns);

for n = 1:L
    
    tempx = [tempx tempx(:,1:nh)]; % % extend columns of signal by the length of the filter
    tempg = conv2(tempx,rot90(h,2),'valid'); % lowpass components column-wise
    temph = conv2(tempx,rot90(qh,2),'valid'); % highpass components column-wise
    G = [tempg; tempg(1:nh,:)]; % extend by rows
    H = [temph; temph(1:nh,:)];
    G = G(:,1:2:end-1); % downsample 
    H = H(:,1:2:end-1);
    ll = (conv2(G',rot90(h,2),'valid'))'; % convolve by rows
    ll = ll(1:2:end-1,:);
    lh = (conv2(G',rot90(qh,2),'valid'))';
    lh = lh(1:2:end-1,:);
    hl = (conv2(H',rot90(h,2),'valid'))';
    hl = hl(1:2:end-1,:);
    hh = (conv2(H',rot90(qh,2),'valid'))';
    hh = hh(1:2:end-1,:);
    
    tempy(1:ms/2,1:ns/2) = ll; % upper left of level
    tempy(1+ ms/2:ms,1:ns/2) = lh; % lower left of level
    tempy(1:ms/2,1+ns/2:ns) = hl; % upper right of level
    tempy(1+ms/2:ms,1+ns/2:ns) = hh; % lower right of level
    
    tempx = ll; % new level
    [ms,ns] = size(tempx); % size of new level
end

y = tempy;