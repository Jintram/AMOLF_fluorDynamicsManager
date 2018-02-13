
%% Understanding the general relationships

h2=figure(2); clf; hold on;

alldatap=[];alldataC=[]; alldataMu= [];
% put printed values and single datapoints
for groupIdx = 1:numel(applicableIndices)

    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdata = processedOutput.('Production_Y').allValues{groupIdx};
    Cdata = processedOutput.('Concentration_Y').allValues{groupIdx};
    mudata = log(2)/60.*processedOutput.('Growth').allValues{groupIdx};

    % single data points
    plot(Cdata.*mudata,...
            pdata,...
            'o',...
            'LineWidth',myLineWidth,...
            'Color',someColors(groupIdx,:),...
            'MarkerFaceColor',someColors(groupIdx,:));

   alldatap = [alldatap pdata];
   alldataC = [alldataC Cdata];
   alldataMu = [alldataMu mudata];

end
    %{
    allvalues = [alldatax alldatay];
    plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)],'k-');
    
    % fit 1
    p=polyfit(alldatax,alldatay,1);
    xToFit = linspace(min(allvalues),max(allvalues),3);
    plot(xToFit,xToFit*p(1)+p(2),'k--')
    
    % fit 2
    offset = mean(alldatay-alldatax);
    plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)]+offset,'k:');
    %}
    
    %alpha=1.5; beta=.5;
    %plot(alldatap,alpha*alldatap./alldataMu + alldatap*beta,'o');
    
    yDataToFit = alldatap;
    xDataToFit = alldataC.*alldataMu;
    p=polyfit(xDataToFit,yDataToFit,1);
    xToShow = linspace(min(xDataToFit),max(xDataToFit),3);
    plot(xToShow,xToShow*p(1)+p(2),'k-')
    
%end

ylabel(['Concentration * growth' 10 '[a.u./(area*min]']);
xlabel('Production [a.u./(area*min)]');

text(min(xDataToFit),max(yDataToFit),['Fit: y=' sprintf('%.2f',p(2)) ' + ' sprintf('%.2f',p(1)) 'x']);

%% Understanding the CRP stuff

h2=figure(2); clf; hold on;

alldatap=[];alldataC=[]; alldataMu= [];
% put printed values and single datapoints
for groupIdx = 1:numel(applicableIndices)

    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdata = processedOutput.('Production_C').allValues{groupIdx};
    Cdata = processedOutput.('Concentration_C').allValues{groupIdx};
    mudata = log(2)/60.*processedOutput.('Growth').allValues{groupIdx};

    % single data points
    plot(pdata./mudata,...
            Cdata,...
            'o',...
            'LineWidth',myLineWidth,...
            'Color',someColors(groupIdx,:),...
            'MarkerFaceColor',someColors(groupIdx,:));

   alldatap = [alldatap pdata];
   alldataC = [alldataC Cdata];
   alldataMu = [alldataMu mudata];

end

legend(HUMANREADABLENAMESFORGROUPS,'Location','SouthEast');
    
allvalues = [0 alldatap./alldataMu alldataC];
plot([min(allvalues),max(allvalues)*1.1],[min(allvalues),max(allvalues)*1.1],'k-');
    
ylabel(['Concentration [a.u./area]']);
xlabel('Production/growth rate [a.u./area]');

xlim([0,max(allvalues)*1.1]);
ylim([0,max(allvalues)*1.1]);

% fit 1
p=polyfit(alldatap./alldataMu,alldataC,1);
xToFit = linspace(min(allvalues),max(allvalues),3);
plot(xToFit,xToFit*p(1)+p(2),'k--')
    
% fit 2
offset = mean(alldataC-alldatap./alldataMu);
plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)]+offset,'k:');

% Print fit
%text((max(xDataToFit)-min(xDataToFit))/5+min(xDataToFit),min(yDataToFit),['Fit: y=' sprintf('%.4f',p(3)) ' + ' sprintf('%.4f',p(2)) 'x' ' + ' sprintf('%.4f',p(1)) 'x^2']);
text(25,max(alldataC),['Fit: y=' sprintf('%.2f',p(2)) 'x' ' + ' sprintf('%.2f',p(1)) 'x^2']);
text(25,max(alldataC)-25,['Or: C = p/\mu + ' sprintf('%.2f',offset) ]);

    %{

    %}
    
    %alpha=1.5; beta=.5;
    %plot(alldatap,alpha*alldatap./alldataMu + alldatap*beta,'o');
    
    %{
    yDataToFit = alldatap;
    xDataToFit = alldataC;
    p=polyfit(xDataToFit,yDataToFit,2);
    xToShow = linspace(min(xDataToFit),max(xDataToFit),100);
    plot(xToShow,xToShow.^2*p(1)+xToShow*p(2)+p(3),'k-')
    %}
    
%end




%% Misc other plot..

h2=figure(2); clf; hold on;

alldatap=[];alldataC=[]; alldataMu= [];
l=[];
% put printed values and single datapoints
for groupIdx = 1:numel(applicableIndices)

    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdata = processedOutput.('Production_Y').allValues{groupIdx};
    Cdata = processedOutput.('Concentration_Y').allValues{groupIdx};
    mudata = log(2)/60.*processedOutput.('Growth').allValues{groupIdx};

    % single data points
    l(end+1)=plot(Cdata,...
            mudata,...
            'o',...
            'LineWidth',myLineWidth,...
            'Color',someColors(groupIdx,:),...
            'MarkerFaceColor',someColors(groupIdx,:));

   alldatap = [alldatap pdata];
   alldataC = [alldataC Cdata];
   alldataMu = [alldataMu mudata];

end

    %{
    allvalues = [alldatax alldatay];
    plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)],'k-');
    
    % fit 1
    p=polyfit(alldatax,alldatay,1);
    xToFit = linspace(min(allvalues),max(allvalues),3);
    plot(xToFit,xToFit*p(1)+p(2),'k--')
    
    % fit 2
    offset = mean(alldatay-alldatax);
    plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)]+offset,'k:');
    %}
    
    %alpha=1.5; beta=.5;
    %plot(alldatap,alpha*alldatap./alldataMu + alldatap*beta,'o');
    
    %{
    yDataToFit = alldatap;
    xDataToFit = alldataC;
    p=polyfit(xDataToFit,yDataToFit,2);
    xToShow = linspace(min(xDataToFit),max(xDataToFit),100);
    plot(xToShow,xToShow.^2*p(1)+xToShow*p(2)+p(3),'k-')
    %}
    
%end

xlabel(['Concentration ' 10 '[a.u./(area]']);
ylabel('Growth raet [1/min]');

% text((max(xDataToFit)-min(xDataToFit))/5+min(xDataToFit),min(yDataToFit),['Fit: y=' sprintf('%.4f',p(3)) ' + ' sprintf('%.4f',p(2)) 'x' ' + ' sprintf('%.4f',p(1)) 'x^2']);

%% Relating Y and C to each other

h2=figure(2); clf; 

alldatap=[]; alldataC=[]; alldataMu= [];
l=[];
% put printed values and single datapoints
for groupIdx = 1:numel(applicableIndices)

    
    %%
    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdataCRP = processedOutput.('Production_Y').allValues{groupIdx};
    CdataCRP = processedOutput.('Concentration_Y').allValues{groupIdx};
    pdatas70 = processedOutput.('Production_C').allValues{groupIdx};
    Cdatas70 = processedOutput.('Concentration_Y').allValues{groupIdx};
    mudata = log(2)/60.*processedOutput.('Growth').allValues{groupIdx};

    % single data points
    %{
    plot(pdataCRP,...
            pdatas70,...
            'o',...
            'LineWidth',myLineWidth,...
            'Color',someColors(groupIdx,:),...
            'MarkerFaceColor',someColors(groupIdx,:));
    %}
    
    l(end+1)=scatter3(pdataCRP./mudata,...
             pdatas70./mudata,...
             Cdatas70,...
             'MarkerEdgeColor',someColors(groupIdx,:),...
             'MarkerFaceColor',someColors(groupIdx,:));
    hold on;
        
   alldatap = [alldatap pdata];
   alldataC = [alldataC Cdata];
   alldataMu = [alldataMu mudata];

end

xlabel(['Production CRP / growth rate']);
ylabel(['Production s70 / growth rate']);
zlabel('Concentration ');

legend(HUMANREADABLENAMESFORGROUPS);
