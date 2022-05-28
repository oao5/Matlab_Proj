function key = dry_run_key(types)
    key = repelem("null",length(types));
    for i = 1:length(types)
        switch types(i) 
            case "conjunction no target" 
            key(i) = "l";
            case  "feature no target"
            key(i) = "l";
            case "conjunction with target" 
            key(i) = "a";
            case  "feature with target"
            key(i) = "a";        
        end
    end
wrong_rate = abs(random("Normal",0.2,0.1));%sample from normal distrubution with mean of 0.2 and variance of 0.1 for  wrong answers rate 
wrong_indexes = randperm(length(key),round(length(key)*wrong_rate));
for i  = wrong_indexes
if key(i) == 'l'
    key(i) = 'a';
else
    key(i)= 'l';
end
end