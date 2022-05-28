function time = dry_run_time(kind,set_size)
time  = 0;
%function return random run time from normal distrubution with diffrent
%means. for conjunction we set growing mean and variance according to
%diffrent kinds of set sizes and in feature we use a steady distrubution
switch kind 
    case "conjunction"
    if set_size  == 4
        time = abs(random("Normal",0.5,0.2)); 
    end
     if set_size  == 6
       time = abs(random("Normal",0.63,0.22));
    end
     if set_size  == 8
        time = abs(random("Normal",0.73,0.25));
    end
     if set_size  == 12
        time = abs(random("Normal",0.85,0.27));
    end

    case "feature"
    time = abs(random("Normal",0.55,0.23));
end
end

  