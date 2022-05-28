function [succeccs_precntage_per_noise,step_avg_per_noise] = network_success_2(memories,noise_memo)
% this function gets noise level , memories cell array,
% and output the succecss precentage(amount of correctly convarged memories/number of memories ) of the network 
W = create_weight(memories); %create a weight matrix
succeccs_precntage_per_noise = zeros(1,length(noise_memo));
step_avg_per_noise = zeros(1,length(noise_memo));
for i = 1:length(noise_memo)
    each_memo_success = zeros(1,length(memories));
    each_memo_number_of_steps = zeros(1,length(memories));
    for j = 1:length(memories)
        [number_of_steps,conv_vec,~] = conv_proc(noise_memo{i,j},W,memories{1,j});
        each_memo_success(j) = isequal(conv_vec,memories{1,j}); %check if the memory convarged
        each_memo_number_of_steps(j) = number_of_steps;
    end
succeccs_precntage_per_noise(i) = sum(each_memo_success)/length(memories);
good_step = each_memo_number_of_steps(each_memo_success == 1);
if isempty(good_step)
    good_step = 0;
end
step_avg_per_noise(i) = mean(good_step);
end