clear;close all; clc;
trials_num = 30; % must be even integer
run_mode = 1; % 0 - wet run-subject reaction , 1 - dry run - a randomized automatic reaction 
kinds = ["conjunction","feature" ];
kinds = repelem(kinds,4); % create 4 pairs of kinds
N  = [4,6,8,12,4,6,8,12]; % create leveles that match the kinds (1 level for each kind)
shuffle = randperm(8); %create a random order for to apply for both vectors
N = N(shuffle);
kinds = kinds(shuffle);
data(1:8,1:5) = {0}; %data allocation
Visual_Search_Experiment= figure('WindowState','fullscreen','Units','normalized','Position',[0 0 1 1]); %set figure properties
set(Visual_Search_Experiment,'MenuBar','none','toolbar','none','color','white')
axis off % remove axes
        text(0.3,0.5,"Starting the trial, if target is presented press A if not press L ","FontSize",14);
        pause(2) %show how to continue after 2 sec to make suere the subject read the instructions
        text(0.3,0.4,"Press the spacebar to continue","FontSize",14);
        axis off
        pause; key = get(Visual_Search_Experiment,'CurrentCharacter');  %get the key pressed and pause
        while strcmpi(' ',key) == 0 %  pause untill the subject press on space bar
            pause; key = get(Visual_Search_Experiment,'CurrentCharacter');
        end
        for i  = 1:8
            [good_res,filterd_types,time_filtered]=block(kinds(i),N(i),Visual_Search_Experiment,run_mode,trials_num);
            data(i,:) = {good_res,filterd_types,time_filtered,kinds(i),N(i)};%save data in cell array
            clf()
            axis off
            text(0.2,0.5, "you finished " +i+ " out of the 8 blocks Press spacebar to continue",'fontsize',14);
            pause; key = get(Visual_Search_Experiment,'CurrentCharacter');
            while strcmpi(' ',key) == 0
                pause; key = get(Visual_Search_Experiment,'CurrentCharacter');
            end
        end

        for i = 1:8
            clf();
            if(cell2mat(data(i,1)) < 20)
                text(0.2,0.5,"Redoing trials Press spacebar to continue",'FontSize',14);
                axis off
                pause; key = get(Visual_Search_Experiment,'CurrentCharacter');
                while strcmpi(' ',key) == 0
                    pause; key = get(Visual_Search_Experiment,'CurrentCharacter');
                end
                [good_res,filterd_types,time_filtered] = block(data{i,4},data{i,5},Visual_Search_Experiment,run_mode,trials_num);
                if(good_res>cell2mat(data(i,1)))
                    data(i,1:3) = {good_res,filterd_types,time_filtered};
                end
            end
        end
 

%convert cell array to table
data_table = cell2table(data,"VariableNames",["number of good results","types of good results","times of good results","kinds","diffuclty level"]);
save("VSresults.mat","data_table");
present_stats(); %present stats funcgion