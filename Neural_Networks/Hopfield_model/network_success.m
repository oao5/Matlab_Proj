function [succeccs_precntage,step_avg] = network_success(noise_level,memories_num,m,n)
% this function gets noise level , number of memories, and the matrix
% size(number of neurons in the network) and output the succecss precentage(amount of correctly convarged memories/number of memories ) of the network 
memories = random_memories(memories_num,m,n); % create random memories
W = create_weight(memories); %create a weight matrix
each_memo_success = zeros(1,length(memories));
each_memo_number_of_steps = zeros(1,length(memories));

for i = 1:length(memories)
    noise_memo = noised(noise_level,memories{1,i}); %create a noise memorie 
    [number_of_steps,conv_vec,~] = conv_proc(noise_memo,W,memories{1,i}); 
    each_memo_success(i) = isequal(conv_vec,memories{1,i}); %check if the memory convarged
    each_memo_number_of_steps(i) = number_of_steps;
end
 succeccs_precntage = sum(each_memo_success)/length(memories);
 good_step = each_memo_number_of_steps(each_memo_success == 1);
 if isempty(good_step)
 good_step = 0;
 end 
 step_avg = mean(good_step);
