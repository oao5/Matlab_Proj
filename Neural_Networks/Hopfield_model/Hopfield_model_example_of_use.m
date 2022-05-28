% clc;close all;clear all;
%%
% % Implement 3 100 neurons memory, 
% add 10% noise to ine of the memories and see if is  convarged.
% plot shows simmilarity of the input precentage change in each update
% 
memories = random_memories(3,10,10); %random memories creation
W = create_weight(memories); %network connections matrix
noise_memo = noised(0.1,memories{1,1});
[number_of_steps,conv_vec,simmilarity_precentage] = conv_proc(noise_memo,W,memories{1,1});
f1 = figure("Units","normalized",'WindowState','maximized');
plot(1:number_of_steps,simmilarity_precentage*100)
ytickformat("percentage")
xlabel("Step number")
ylabel("Simmalrity precentage")
title("Simmalrity precntage through steps in Hopfield model")

%%
% Q2:data expirement 
% the effect of memories amount on the network
% 
noise_vec = linspace(0.1,0.5,30);
change_in_memo_num =cell(20,5);
for i = 1:20
    per_noise_suc_vec = zeros(1,length(noise_vec));
    per_noise_step_vec = zeros(1,length(noise_vec));
    for j = 1:length(noise_vec)
        avg_steps_vec = zeros(1,20);
        suc_vec = zeros(1,20);
        for k = 1:20
            [success_precentage,steps_avg] =network_success(noise_vec(j),i,10,10);
            avg_steps_vec(k) = steps_avg;
            suc_vec(k) = success_precentage;
        end
        avg_steps_vec(avg_steps_vec == 0) = [];
        per_noise_suc_vec(j) = mean(suc_vec);
        per_noise_step_vec(j) = mean(avg_steps_vec);
    end
per_noise_step_vec = per_noise_step_vec((~isnan(per_noise_step_vec)));
change_in_memo_num{i,1} = i;
change_in_memo_num{i,2} = mean(per_noise_suc_vec);
change_in_memo_num{i,3} = round(mean(per_noise_step_vec));
change_in_memo_num{i,4} = std(per_noise_step_vec);
change_in_memo_num{i,5} = std(per_noise_suc_vec);
end
% %%
% % the effect of noise level on the ntework
noise_vec = linspace(0.1,0.8,30);
change_in_noise_precent =cell(length(noise_vec),5);
for i = 1:length(noise_vec)
     per_step_suc_vec = zeros(1,20);
    per_step_step_vec = zeros(1,20);
    for j = 1:20
        avg_steps_vec = zeros(1,20);
        suc_vec = zeros(1,20);
        for k = 1:20
            [success_precentage,steps_avg] =network_success(noise_vec(j),i,10,10);
            avg_steps_vec(k) = steps_avg;
            suc_vec(k) = success_precentage;
        end
        avg_steps_vec(avg_steps_vec == 0) = [];
        per_step_suc_vec(j) = mean(suc_vec);
        per_step_step_vec(j) = mean(avg_steps_vec);
    end
per_step_step_vec = per_step_step_vec((~isnan(per_step_step_vec)));
change_in_noise_precent{i,1} = noise_vec(i);
change_in_noise_precent{i,2} = mean(per_step_suc_vec);
change_in_noise_precent{i,3} = round(mean(per_step_step_vec));
change_in_noise_precent{i,4} = std(per_step_step_vec);
change_in_noise_precent{i,5} = std(per_step_suc_vec);
end
% 
% 
% %%
% %save the data
change_in_memo = cell2table(change_in_memo_num,"VariableNames",["number of memories","avarag succeses rate","avarage steps","succeces std","avrage steps std"]);
save("change_in_memo.mat","change_in_memo");
change_in_noise = cell2table(change_in_noise_precent,"VariableNames",["Noise precentage","avarag succeses rate","avarage steps","succeces std","avrage steps std"]);
save("change_in_noise.mat","change_in_noise");
% %%
% %Plots 
load("change_in_noise.mat")
load("change_in_memo.mat")
figure
plot(change_in_noise{:,"Noise precentage"}*100,change_in_noise{:,"avarag succeses rate"}*100);
ylabel("avrage success rate");
xlabel("Noise precetage");
title("The change in success rate for different noise precetage");
ytickformat("percentage")
xtickformat("percentage")

figure
plot(change_in_memo{:,"number of memories"},change_in_memo{:,"avarag succeses rate"}*100);
ylabel("avrage success rate");
xlabel("number of memories");
title("The change in success rate for different number of memories");
ytickformat("percentage")

figure
plot(change_in_noise{:,"Noise precentage"}*100,change_in_noise{:,"avarage steps"});
ylabel("avrage steps rate");
xlabel("Noise precetage");
title("The change in avarage steps for different noise precnetage");
xtickformat("percentage")

figure
plot(change_in_memo{:,"number of memories"},change_in_memo{:,"avarage steps"});
ylabel("avrage steps rate");
xlabel("number of memories");
title("The change in avrage steps for different number of memories");

%%
% Q3
%create 5 random memories
memories_Q3 = random_memories(5,10,10);
W_rnd_memo = create_weight(memories_Q3);
not_det_noise = 0.1:0.01:0.5;
Noise_not_det = cell(length(not_det_noise),length(memories_Q3));
for  k = 1:length(memories_Q3)
    for i = 1:length(not_det_noise)
      Noise_not_det{i,k} = noised(not_det_noise(i),memories_Q3{1,k});
    end
end





%determenistic noise
Line_width = linspace(0.5,3,length(not_det_noise)); % different lined widths
Noise_det = cell(length(Line_width),length(memories_Q3));% creating arrays

for k = 1:length(memories_Q3)
    for i = 1:length(Line_width)
        Row_ind = ceil((size(memories_Q3{1,k},1)/2)-(Line_width(i)/2)+1:(size(memories_Q3{1,k},1)/2)+(Line_width(i)/2)); %finding row indexes
        Col_ind = ceil((size(memories_Q3{1,k},2)/2)-(Line_width(i)/2)+1:(size(memories_Q3{1,k},2)/2)+(Line_width(i)/2));% finding col indexes

        temp  = memories_Q3{1,k};
        temp(Row_ind,:) = temp(Row_ind,:)*(-1); %changing row
        temp(:,Col_ind) = temp(:,Col_ind)*(-1); %changing col
        % notice junction of row and col returned to original state
        temp(Row_ind,Col_ind) = temp(Row_ind,Col_ind)*(-1); % changing only junction
        Noise_det{i,k} = temp;
    end

end
step_no = zeros(1,length(Noise_det));
step_det = zeros(1,length(Noise_det));
suc_no = zeros(1,length(Noise_det));
suc_det = zeros(1,length(Noise_det));
for i = 1:100
[not_det_suc,not_det_step] = network_success_2(memories_Q3,Noise_not_det);
[det_suc,det_step] = network_success_2(memories_Q3,Noise_det);
step_no = step_no + not_det_step;
step_det = step_det + det_step;
suc_no = suc_no + not_det_suc;
suc_det = suc_det + det_suc;

end

step_no = step_no/i;
step_det = step_det/i;
suc_no = suc_no/i;
suc_det = suc_det/i;



figure 
hold on
plot(Line_width*20,suc_det*100)
plot(not_det_noise*100,suc_no*100)
hold off
xlabel("noise precentage")
ylabel("success rate")
legend("determent noise","randomize noise")
ytickformat("percentage")
xtickformat("percentage")
title("Determent Vs random noise effect on success rate")
figure 
hold on
plot(Line_width*20,det_step)
plot(not_det_noise*100,not_det_step)
xtickformat("percentage")
xlabel("Noise precentage")
ylabel("average number of steps")
title("Determent Vs random noise effect on avrage steps number")
legend("determent noise","randomize noise")
hold off
