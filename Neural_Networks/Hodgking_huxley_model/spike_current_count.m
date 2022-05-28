function result = spike_current_count(Vt,TH)
SaTH = Vt>TH; %marks all instances above the threshold
SaTHdiff = diff(SaTH); % all "passes" through threshold
L2H = find(SaTHdiff >0); % all "passes" above treshold
result = length(L2H);
end