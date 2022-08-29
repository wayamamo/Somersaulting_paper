% Find Peaks or Valleys 2
% Find peaks or valleys from signal by a given threshold.
%
% [idx] = findpv2(X,th,mode)
%
% Inputs
% X = data as vector Fx1 (F = #frames)
% th = threshold
% mode = mode to find: 'peaks' or 'valleys'
% 
% Outputs
% Xid = Fx1 vector containing the peak (or valley) indices
%
% ..:: by Jesús E. Pérez-Ortega ::.. Oct-2011

function [Xid] = findpv2(X,th,mode)

F = numel(X);
Xid=zeros(F,1);

% Get index by mode
if strcmp(mode,'peaks')
    idx = find(X>=th);                         % index above threshold
elseif strcmp(mode,'valleys')
    idx = find(X<=th);                         % index below threshold
end

if ~numel(idx)
    disp('No data found')
    return
end

% Join peaks (or valleys)
is = find(idx~=[0; idx(1:numel(idx)-1)+1]);    % index of same peak

% Delete first if start above (or below) threshold
if min(idx)==1
    if numel(is)>1
        idx=idx(is(2):numel(idx));
        is=is(2:numel(is))-is(2)+1;
    else
        disp('No data found')
        return
    end
end

% Delete last if ends above (or below) threshold
if(max(idx)==F)
    if numel(is)>1
        idx=idx(1:max(is)-1);
        is=is(1:numel(is)-1);
    else
        disp('No data found')
        return
    end
end

% number of total peaks (or valleys)
porv = numel(is);                                       
if porv
    for j = 1:porv-1
        Xid(idx(is(j)):idx(is(j+1)-1),1)=j;    % set #peak (or #valley)
    end
    Xid(idx(is(porv)):max(idx),1)=porv;
end