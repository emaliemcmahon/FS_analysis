sids={'s001','s002','s003','s004','s005'};
for i = 1:length(sids)
sid=sids{i};
path='SI_ROI_data';

data = readmatrix([path,'/',sid,'/siLoc.csv']);
data=data(1:2,:)';
avg(i,:)=mean(data);
end

bar(avg)
xticklabels(sids)
ylabel('Average Beta')
xlabel('Subject')
legend('interact','non')