function ksai = random_memories(number_of_memo,m,n) 
%function gets the number of wanted memories and the the size of each memorie and return a wanted number
% of different random memories in cell array.
ksai = repelem({zeros(m,n)},number_of_memo);
new_memo = randi([0,1],m,n);
new_memo(new_memo == 0) = -1;
ksai{1,1} = new_memo;
for i = 2:number_of_memo 
    new_memo = randi([0,1],m,n);
    new_memo(new_memo == 0) = -1;
    while new_memo == ksai{1,i-1}
        new_memo = randi([0,1],m,n);
        new_memo(new_memo == 0) = -1;
    end
    ksai{1,i} = new_memo;
end



