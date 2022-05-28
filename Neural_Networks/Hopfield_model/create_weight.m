function weight_matrix = create_weight(memories)
[m ,n] = size(memories{1,1}); % use one of the memories size m - row , n - col
weight_matrix = (zeros(m*n)); %pre allocate the weight matrix
for i = 1:n*m
    for j = 1:n*m
        W_ij = 0;
        if i == j
        weight_matrix(i,j) = 0;  
        else
            for mu = 1:length(memories)
                 ksai = reshape(memories{1,mu}',[1 m*n]); %turn memories to vector
                 W_ij = W_ij + ksai(1,i)*ksai(1,j);
            end
            weight_matrix(i,j) = W_ij;
        end
     end
end

