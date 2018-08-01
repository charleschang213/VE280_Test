clear;clc;
status = {'regular','silver','gold','platinum'};
for k=0:100
    fd = fopen(['test',num2str(k),'/test2.in'],"w");
    time = randi([10 40]);
    rand_number = randi([0,10],1,time+1);
    count = sum(rand_number);
    fprintf(fd,'%d\n',count);
    flag = 0;
    for i = 0:time
        for j = 1:rand_number(i+1)
            flag = flag+1;
            fprintf(fd,'%d ',i);
            fprintf(fd,'customer%d ',flag);
            fprintf(fd,status{randi([1 4])});
            fprintf(fd,' %d\n',randi([1 10]));
        end
    end
    fclose(fd);
end
