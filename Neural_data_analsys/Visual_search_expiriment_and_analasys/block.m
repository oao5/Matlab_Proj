function  [good_res,filterd_types,time_filtered]  = block(search_kind,N,f,run_mode,trials_num)
    hit = zeros(1,trials_num);
    time_vec = zeros(1,trials_num);
    switch run_mode
    case 1
        switch search_kind
            case 'conjunction'
                con = ["conjunction no target"  "conjunction with target"];
                types = repelem(con,trials_num/2);
                types = types(randperm(length(types))); 
                key_vec = dry_run_key(types);
                for i = 1:trials_num
                    fig_maker(types(i),N);
                    rnd_run_time = dry_run_time(search_kind,N);
                    tic
                    pause(rnd_run_time);key = key_vec(i);
                    time_vec(i) = toc;
                    if (types(i) == "conjunction with target")
                        hit(i) = strcmpi('a',key);
                    else
                        hit(i) = strcmpi('l',key);
        
                    end
                end
            case 'feature'
                con = ["feature no target"  "feature with target"];
                types = repelem(con,trials_num/2);
                types = types(randperm(length(types)));
                key_vec = dry_run_key(types);
                for i = 1:trials_num
                    fig_maker(types(i),N);
                    rnd_run_time =dry_run_time(search_kind,N);
                    tic
                    pause(rnd_run_time);key = key_vec(i);
                    time_vec(i) = toc;
                    if (types(i) == "feature with target")
                        hit(i) = strcmpi('a',key);
                    else
                        hit(i) = strcmpi('l',key);
                    end
                end
        end
        
        case 0       
          switch search_kind
            case 'conjunction'
                con = ["conjunction no target"  "conjunction with target"];
                types = repelem(con,trials_num/2);
                types = types(randperm(length(types))); 
                for i = 1:trials_num
                    fig_maker(types(i),N);
                    tic
                    pause;key = get(f,'CurrentCharacter');
                    time_vec(i) = toc;
                    if (types(i) == "conjunction with target")
                        hit(i) = strcmpi('a',key);
                    else
                        hit(i) = strcmpi('l',key);
                    end
                end
        
            case 'feature'
                con = ["feature no target"  "feature with target"];
                types = repelem(con,trials_num/2);
                types = types(randperm(length(types)));
                for i = 1:trials_num
                    fig_maker(types(i),N);
                    tic
                    pause;key = get(f,'CurrentCharacter');
                    time_vec(i) = toc;
                    if (types(i) == "feature with target")
                        hit(i) = strcmpi('a',key);
                    else
                        hit(i) = strcmpi('l',key);
                    end
                end
         end    
    end
    
    filterd_types = types;
    filterd_types(hit == 0 | time_vec >= 3) = []; %  condition indicator for with/no target for  good results
    time_filtered = time_vec;
    time_filtered(hit == 0 | time_filtered >= 3)= []; % reaction times of good results
    good_res = length(time_filtered);
