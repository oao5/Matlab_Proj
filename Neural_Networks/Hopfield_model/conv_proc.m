function [num_of_steps ,conv_memo, simmilarty_vec]  =  conv_proc(memo,W,right_memo) 
%Asynchronous convargance proccesses : function  gets a
% Weigth vector and a certain input matrix,and the memory we want to convarge to and output the convarge matrix , 
% number of steps and the simalirty precentage to the memory on each step
num_of_steps = 0;
no_change  = 0 ; 
[m ,n] = size(memo);
memo_vec = reshape(memo',[1 m*n])';
simmilarty_vec = [];
while  no_change < 300 && num_of_steps ~= 1000 % i chose at least a 300 that the update does not effect the memory as my treshold for the convergance and if the steps number excceed 1000
    num_of_steps = num_of_steps + 1;
    memo_vec_old = memo_vec;
    rnd_index = randperm(m*n,1);
    memo_vec(rnd_index) = sign(W(rnd_index,:)*memo_vec);
    if (memo_vec(rnd_index) == 0) %matlab sign function output 0 for input zero so its need a "fix"  to use in the modle.
        memo_vec(rnd_index) = 1;
    end
    if(memo_vec_old == memo_vec)
    no_change = no_change + 1;
    else
    no_change = 0;  
    end
    same = reshape(memo_vec',[m n])' == right_memo ;
     simmilarty_vec(num_of_steps) = (sum(same(:)))/(m*n); 
end
conv_memo =reshape(memo_vec',[m n])' ; 

end
