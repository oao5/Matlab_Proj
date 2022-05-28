function present_stats()
clc;clear all ;close all;
load("VSresults.mat");
data_table = sortrows(data_table,["diffuclty level" "kinds"],"ascend");% sort the data for conviniance 
RT_classified = cell(8,8);
for i =  1:8
    switch data_table.kinds(i)
        case 'feature'
            feature_with_target_RT = zeros(1,15); %maximum correct results for each condition
            feature_no_target_RT = zeros(1,15);
            no_target_addtion =  data_table.(3){i,1}([find(data_table.(2){i,1}  == "feature no target")]);
            target_addition = data_table.(3){i,1}([find(data_table.(2){i,1}  == "feature with target")]);
            feature_no_target_RT(1:length(no_target_addtion)) = no_target_addtion;
            feature_with_target_RT(1:length(target_addition)) = target_addition;
            RT_classified{i,1} = data_table.kinds(i);
            RT_classified{i,2} = data_table.("diffuclty level")(i);
            feature_with_target_RT(feature_with_target_RT == 0) = [];
            feature_no_target_RT(feature_no_target_RT == 0)  = [];
            RT_classified{i,3} = feature_no_target_RT;
            RT_classified{i,4} = feature_with_target_RT;
            RT_classified{i,5} = mean(feature_no_target_RT);
            RT_classified{i,6} = mean(feature_with_target_RT);
            RT_classified{i,7} = std(feature_no_target_RT);
            RT_classified{i,8} = std(feature_with_target_RT);
            
        case 'conjunction'
            conj_with_target_RT = zeros(1,15);
            conj_no_target_RT = zeros(1,15) ;
            no_target_addtion =  data_table.(3){i,1}([find(data_table.(2){i,1}  == "conjunction no target")]);
            target_addition = data_table.(3){i,1}([find(data_table.(2){i,1}  == "conjunction with target")]);
            conj_no_target_RT(1:length(no_target_addtion)) = no_target_addtion;
            conj_with_target_RT(1:length(target_addition)) = target_addition;
            RT_classified{i,1} = data_table.kinds(i);
            RT_classified{i,2} = data_table.("diffuclty level")(i);
            conj_with_target_RT(conj_with_target_RT == 0) = [];
            conj_no_target_RT(conj_no_target_RT == 0)  = [];
            RT_classified{i,3} = conj_no_target_RT;
            RT_classified{i,4} = conj_with_target_RT;
            RT_classified{i,5} = mean(conj_no_target_RT);
            RT_classified{i,6} = mean(conj_with_target_RT);
            RT_classified{i,7} = std(conj_no_target_RT);
            RT_classified{i,8} = std(conj_with_target_RT);
           
    end
end

conj_mean_with = [RT_classified{[RT_classified{:,1}] == "conjunction",6}];
conj_mean_no = [RT_classified{[RT_classified{:,1}] == "conjunction",5}];
feature_mean_with = [RT_classified{[RT_classified{:,1}] == "feature",6}];
feature_mean_no = [RT_classified{[RT_classified{:,1}] == "feature",5}];

conj_std_with = [RT_classified{[RT_classified{:,1}] == "conjunction",8}];
conj_std_no = [RT_classified{[RT_classified{:,1}] == "conjunction",7}];
feature_std_with = [RT_classified{[RT_classified{:,1}] == "feature",8}];
feature_std_no = [RT_classified{[RT_classified{:,1}] == "feature",7}];

coe_feature_with = polyfit([4 6 8 12],feature_mean_with,1);
val_feature_with = polyval(coe_feature_with,[4 6 8 12]);
coe_feature_no = polyfit([4 6 8 12],feature_mean_no,1);
val_feature_no = polyval(coe_feature_no,[4 6 8 12]);

coe_conj_with = polyfit([4 6 8 12],conj_mean_with,1);
val_conj_with = polyval(coe_conj_with,[4 6 8 12]);
coe_conj_no = polyfit([4 6 8 12],conj_mean_no,1);
val_conj_no = polyval(coe_conj_no,[4 6 8 12]);

f1 = figure; %with target figure
hold on 
errorbar([4 6 8 12],feature_mean_with,feature_std_with,"o")
errorbar([4 6 8 12],conj_mean_with,conj_std_with,"o")
plot([4 6 8 12],val_conj_with)
plot([4 6 8 12],val_feature_with)
xticks([4 6 8 12])
xlim([3.8 12.8])
ylim([0 2.95])
legend(["feature","conjunction", "conjunction fit", "feature fit"])
title("Reaction times as a function of set size - with target")
hold off


f2 = figure; % no target figure
hold on 
errorbar([4 6 8 12],feature_mean_no,feature_std_no,"o")
errorbar([4 6 8 12],conj_mean_no,conj_std_no,"o")
plot([4 6 8 12],val_conj_no)
plot([4 6 8 12],val_feature_no)
xticks([4 6 8 12])
xlim([3.8 12.8])
ylim([0 2.95])
legend(["feature","conjunction" , "conjunction fit", "feature fit"])
title("Reaction times as a function of set size - no target")
hold off


%% perason corralation
[r_conj_with , p_val_conj_with] = corrcoef([4 6 8 12],conj_mean_with);
[r_conj_no , p_val_conj_no] = corrcoef([4 6 8 12],conj_mean_no);
[r_feature_with , p_val_feature_with] = corrcoef([4 6 8 12],feature_mean_with);
[r_feature_no , p_val_feature_no] = corrcoef([4 6 8 12],feature_mean_no);
R_vec = [r_feature_no(1,2) r_feature_with(1,2) r_conj_no(1,2) r_conj_with(1,2)];
p_vec = [p_val_feature_no(1,2) p_val_feature_with(1,2) p_val_conj_no(1,2) p_val_conj_with(1,2)];
pearson_corr = table(R_vec',p_vec','VariableNames',["R" , "P-value"] ,'RowNames',["feature without target" "feature with target" "conjunction without target" "conjunction with target"]);
disp(pearson_corr);

%% number of trials analyzed in each block
number_of_trials_analyzed_in_each_block = table(table2array(data_table(:,"kinds")),table2array(data_table(:,"diffuclty level")),table2array(data_table(:,"number of good results")));
number_of_trials_analyzed_in_each_block.Properties.VariableNames = {'kind', 'diffculty level' 'number of good trials'};
disp(number_of_trials_analyzed_in_each_block);