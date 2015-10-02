%% iso stuff %%
SubVector = {'Sand' 'Gravel' 'Blue' 'Black'}
for i = 1:length(SubVector)
    refdir = dir(['Flagged Flounder/', SubVector{i}, '/*.Rad4U.mat']);
    directory = sprintf('%s%s', 'Flagged Flounder/', SubVector{i});
    for j = 1:length(refdir)
        [RaptorUcone(j), RaptorScone(j), RaptorMcone(j), RaptorLcone(j)] = RaptorIsoColor(directory, refdir(j).name);
        [BluefishUcone(j), BluefishScone(j), BluefishMcone(j), BluefishLcone(j)] = BluefishIsoColor(directory, refdir(j).name);
        [StriperScone(j), StriperLcone(j)] = StriperIsoColor(directory, refdir(j).name);
        [SFlounderScone(j), SFlounderLcone(j)] = SFlounderIsoColor(directory, refdir(j).name);
        [WFlounderScone(j), WFlounderLcone(j)] = WFlounderIsoColor(directory, refdir(j).name);
    end
    RaptorIsoEdge = horzcat(RaptorUcone, RaptorScone, RaptorMcone, RaptorLcone);
    BluefishIsoEdge = horzcat(BluefishUcone, BluefishScone, BluefishMcone, BluefishLcone);
    StriperIsoEdge = horzcat(StriperScone, StriperLcone);
    SFlounderIsoEdge = horzcat(SFlounderScone, SFlounderLcone);
    WFlounderIsoEdge = horzcat(WFlounderScone, WFlounderLcone);
    save([directory, '/RaptorIsoEdge.mat'], 'RaptorIsoEdge');
    save([directory, '/BluefishIsoEdge.mat'], 'BluefishIsoEdge');
    save([directory, '/StriperIsoEdge.mat'], 'StriperIsoEdge');
    save([directory, '/SFlounderIsoEdge.mat'], 'SFlounderIsoEdge');
    save([directory, 'WFlounderIsoEdge.mat'], 'WFlounderIsoEdge');
    
    summaryUcone = [mean(RaptorUcone) mean(BluefishUcone)];
    summaryScone = [mean(RaptorScone) mean(BluefishScone) mean(StriperScone) mean(SFlounderScone) mean(WFlounderScone)];
    summaryMcone = [mean(RaptorMcone) mean(BluefishMcone)];
    summaryLcone = [mean(RaptorLcone) mean(BluefishLcone) mean(StriperLcone) mean(SFlounderLcone) mean(WFlounderLcone)];
    figure; bar(summaryUcone); title(['U cone ', SubVector{i}]);
    figure; bar(summaryScone); title(['S cone ', SubVector{i}]);
    figure; bar(summaryMcone); title(['M cone ', SubVector{i}]);
    figure; bar(summaryLcone); title(['L cone ', SubVector{i}]);
    pause
    close all
end

%% 