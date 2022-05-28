function noised_memo = noised(noise_precentage , memo)
[m , n] = size(memo);
memo_vec = reshape(memo',[1 m*n]); 
noise_num = ceil(length(memo_vec)*noise_precentage);
indexes_noised = randperm(m*n,noise_num);
for i = 1 : length(indexes_noised)
    if(memo_vec(i)  == 1)
        memo_vec(i) = -1;
    else
        memo_vec(i) = 1;
    end
noised_memo = reshape(memo_vec,[m n])' ; 
end
end

