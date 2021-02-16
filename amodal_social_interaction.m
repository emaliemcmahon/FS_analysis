clear all
sids={'s002','s003','s004'};
for i = 1:length(sids)
sid=sids{i};
path='AMODAL_ROI_data';

data = readmatrix([path,'/',sid,'/siLoc.csv']);
data=data(1:2,:)';
avg(i,:)=mean(data);
end

figure;
bar(avg)
xticklabels(sids)
ylabel('Average Beta')
xlabel('Subject')
legend('interact','non')