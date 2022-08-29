

%get number of contraction 
% this uses code of peak detection function that Jesus has written 06/24/21
% get number from analysis after using python code
% Parameters for smoothing and threshold can be played with.
% This uses peak detection function written previously by Jesus
% Make a datasheet named body that has a body length calculated with python

body_s = smooth(body,50);
body_diff = diff(body_s);
body_diff_s = smooth(body_diff,50);
th = -0.4;                            %this is the threshold that can be changed

contraction_id = findpv2(body_diff_s,th,'valleys');

n_contractions = max(contraction_id);

for i=1:n_contractions
    id = find(contraction_id==i);
    [~,contraction_time(i)] = min(body_diff_s(id));
    contraction_time(i) = id(contraction_time(i));
    contraction_speed(i) = body_diff_s(contraction_time(i));
end

figure(1);clf
subplot(4,1,1)
plot(body)
subplot(4,1,2)
plot(body_s)
subplot(4,1,3)
plot(body_diff)
subplot(4,1,4)
plot(body_diff_s); hold on
plot([0 length(body)],[th th],'--r')
plot(contraction_time,contraction_speed,'or')
 

