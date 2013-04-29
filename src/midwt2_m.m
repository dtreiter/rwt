function x = midwt2_m(y,h,L)

[ms,ns] = size(y);

if 2^L > ns || 2^L > ms
    disp('L is too big')
end

mind = ms/2^L;
nind = ns/2^L;
qh = qmf(h);
tempy = y(1:mind,1:nind);

for n = 1:L
    ll = uconv2(tempy,h,h);
    lh = uconv2(y(1+mind:2*mind,1:nind),qh,h);
    hl = uconv2(y(1:mind,1+nind:2*nind),h,qh);
    hh = uconv2(y(1+mind:2*mind,1+nind:2*nind),qh,qh);
    
    
%     G = (upsample(tempy',2))';
%     tempg = conv2(G(:,1:end-1),h);
%     tempg = upsample(tempg,2);
%     
%     H = (upsample(tempy',2))';
%     temph = conv2(H(:,1:end-1),qh);
%     temph = upsample(temph,2);
%     
%     ll = (conv2((tempg(1:end-1,:))',h))';
%     lh = (conv2((tempg(1:end-1,:))',qh))';
%     hl = (conv2((temph(1:end-1,:))',h))';
%     hh = (conv2((temph(1:end-1,:))',qh))';
%     
    tempy = ll + lh + hl + hh;
    
    mind = 2*mind;
    nind = 2*nind;
    
end

x = tempy;

end

function y = uconv2(x,h1,h2)
lh1 = length(h1)-1;
lh2 =  length(h2)-1;

y = upsample(x,2);
y = conv2([(y(1:end,:)); (y(1:length(h1)-1,:))]',h1,'valid');
y = (upsample(y,2))';
y = conv2([y y(:,1:length(h2)-1)],h2,'valid');
tempy =[ y(end-lh1+1:end,:); y(1:end-lh1,:)];
y = [tempy(:,end-lh2+1:end) tempy(:,1:end-lh2)];

% tempx = [x(1:length(h1),:); x];
% y = upsample(tempx,2);
% y = conv2((y(1:end-1,:))',h1,'valid');
% tempy = [ y(:,1:length(h2)) y(:,1:end-2)];
% y = (upsample(tempy(:,1:end),2))';
% y = conv2(y(:,1:end-1),h2,'valid');
% y = y(:,1:end-2);
%tempx = [x(length(h1):-1:1,:); x; x(1:length(h1),:)];
%x = [tempx(:,length(h2):-1:1) tempx tempx(:,1:length(h2))];

% tempx = [x; x(1:length(h1),:)];
% x = [tempx tempx(:,1:length(h2))];
% y = upsample(x,2);
% y = (upsample(y',2))';
% y = y(1:end-1,1:end-1);
% y = conv2(h1,h2,y);
% y = y(1:end,1:end);

end
