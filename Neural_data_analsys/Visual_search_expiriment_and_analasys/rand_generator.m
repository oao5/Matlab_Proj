function [X_xyrp,O_xyrp] = rand_generator(search_type,N,target)
    switch search_type
        case feature
            breaker = true;
            while breaker 
                X_xyrp = rand(2,N-1);
                O_xyrp = rand(2,1);
                breaker = intersect(X_xyrp',O_xyrp',"rows");     
            end
    
    case conjunction 
            breaker = true;
            while breaker 
                X_xyrp = rand(2,N/2);
                O_xyrp = rand(2,((N/2)-1));
                breaker = intersect(X_xyrp',O_xyrp',"rows");     
            end
    end
end
