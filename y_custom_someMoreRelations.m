


%% Understanding the CRP stuff

for reporterIdx = 1:2

    switch reporterIdx
        case 1
            LETTER = 'Y';
            TITLE = 'Metabolic reporter';
        case 2
            LETTER = 'C';
            TITLE = 'Constitutive reporter';
    end
    
    h2=figure(2); clf; hold on;

    alldatap=[];alldataC=[]; alldataMu= [];
    % put printed values and single datapoints
    for groupIdx = 1:numel(applicableIndices)

        %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
            % proved not necessary

        pdata = processedOutput.(['Production_' LETTER]).allValues{groupIdx};
        Cdata = processedOutput.(['Concentration_' LETTER]).allValues{groupIdx};
        mudata = log(2)/60.*processedOutput.('Growth').allValues{groupIdx};

        % single data points
        plot(pdata./mudata,...
                Cdata,...
                'o',...
                'LineWidth',2,...
                'Color',someColors(groupIdx,:),...
                'MarkerFaceColor','none',... someColors(groupIdx,:),...
                'MarkerSize',10);

       alldatap = [alldatap pdata];
       alldataC = [alldataC Cdata];
       alldataMu = [alldataMu mudata];

    end

    allvalues = [0 alldatap./alldataMu alldataC];
    plot([min(allvalues),max(allvalues)*1.1],[min(allvalues),max(allvalues)*1.1],'k-');

    title(TITLE);
    ylabel(['Concentration [a.u./px]']);
    xlabel('Production/growth [a.u./px]');

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
    text(25,max(alldataC),['Fit: y=' sprintf('%.2f',p(2)) '' ' + ' sprintf('%.2f',p(1)) 'x']);
    text(25,max(alldataC)-25,['Or: C = p/\mu + ' sprintf('%.2f',offset) ]);

    MW_makeplotlookbetter(10,[],[6 6]/2,1)

    if exist(OUTPUTFOLDER)
        fileName = ['relationsAverages_' LETTER];
        saveas(h2,[OUTPUTFOLDER 'svg_' fileName '.svg'],'svg');
        saveas(h2,[OUTPUTFOLDER 'fig_' fileName '.fig'],'fig');
        saveas(h2,[OUTPUTFOLDER 'tif_' fileName '.tif'],'tif');
        saveas(h2,[OUTPUTFOLDER 'pdf_' fileName '.pdf'],'pdf');

        % Now some effort to create a legend
        h2ForLegend = copyfig(h2)
        lH=legend(HUMANREADABLENAMESFORGROUPS,'Location','SouthEast');    
        allText = findall(gcf,'Type','text');
        delete(allText);
        saveLegendToImage(h2ForLegend, lH, [], [OUTPUTFOLDER 'pdf_' fileName '_legend.pdf'],'pdf');
    end

end    
    
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


%% Plotting the sum of both to see total concentration remains constant

h6=figure(6); clf; 

alldatap=[]; alldataC=[]; alldataMu= [];
l=[];
alldatax=[]; alldatay=[];
% put printed values and single datapoints
for groupIdx = 1:numel(applicableIndices)

    
    %%
    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdataCRP = processedOutput.('Production_Y').allValues{groupIdx};
    CdataCRP = processedOutput.('Concentration_Y').allValues{groupIdx};
    pdatas70 = processedOutput.('Production_C').allValues{groupIdx};
    Cdatas70 = processedOutput.('Concentration_C').allValues{groupIdx};
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
    
    l(end+1)=scatter(mudata,...
            Cdatas70+CdataCRP,...
                10^2,...
                someColors(groupIdx,:),...
                'LineWidth',2);
    %set(l(end),'LineWidth',2);
    
            %,...
            %    'MarkerEdgeColor',someColors(groupIdx,:),...
            %    'MarkerFaceColor','none',... someColors(groupIdx,:),...
            %    'MarkerSize');
    hold on;

    alldatax =  [alldatax mudata];
    alldatay = [alldatay Cdatas70+CdataCRP];
    
end

minmaxX = [min(alldatax) max(alldatax)];
dminmaxX = minmaxX(2)-minmaxX(2);
myxlims = [minmaxX(1)-.1*dminmaxX minmaxX(2)+.1*dminmaxX];
totalConcentration = mean(alldatay);

plot(myxlims,[totalConcentration totalConcentration],'k--');

xlim(myxlims);
ylim([0, max(alldatay)*1.1]);

xlabel('Growth rate [/min]');
ylabel('Sum concentrations [a.u./px]');

% Save it
MW_makeplotlookbetter(10,[],[6 6]/2,1)
if exist(OUTPUTFOLDER)
    fileName = ['relationsAverages_' 'sum_YC'];
    saveas(h2,[OUTPUTFOLDER 'svg_' fileName '.svg'],'svg');
    saveas(h2,[OUTPUTFOLDER 'fig_' fileName '.fig'],'fig');
    saveas(h2,[OUTPUTFOLDER 'tif_' fileName '.tif'],'tif');
    saveas(h2,[OUTPUTFOLDER 'pdf_' fileName '.pdf'],'pdf');

    % Now some effort to create a legend
    h2ForLegend = copyfig(h2)
    lH=legend(HUMANREADABLENAMESFORGROUPS,'Location','SouthEast');    
    allText = findall(gcf,'Type','text');
    delete(allText);
    saveLegendToImage(h2ForLegend, lH, [], [OUTPUTFOLDER 'pdf_' fileName '_legend.pdf'],'pdf');
end

%% The growth rate appears to follow a linear relationship with production CRP

% This relationship appears to be linear, but that doesn't work to fit
% things later. Also polynomial fitting is not optimal. However, we can
% also derive a prediction by Benjamin about the shape:
growthMuFn = @(params,p) params(1)*(p.^2-2.*p+1) ./ (params(2)*p -1)

h7=figure(7); clf; 

alldatap=[]; alldataC=[]; alldataMu= [];
l=[];
alldatax=[]; alldatay=[];
% put printed values and single datapoints
for groupIdx = 1:numel(applicableIndices)

    
    %%
    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdataCRP = processedOutput.('Production_Y').allValues{groupIdx};
    CdataCRP = processedOutput.('Concentration_Y').allValues{groupIdx};
    pdatas70 = processedOutput.('Production_C').allValues{groupIdx};
    Cdatas70 = processedOutput.('Concentration_C').allValues{groupIdx};
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
    
    l(end+1)=scatter(pdataCRP,...
            mudata,...
            10^2,...
                someColors(groupIdx,:),...
                'LineWidth',2);
             %'MarkerEdgeColor',someColors(groupIdx,:),...
             %'MarkerFaceColor',someColors(groupIdx,:));
    hold on;

    if groupIdx ~= 1
        alldatax =  [alldatax pdataCRP];
        alldatay = [alldatay mudata];
    end
    
end

%allvalues = [alldatax alldatay];
%plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)],'k-');

% fit 1
p=polyfit(alldatax,alldatay,1);
xToFit = linspace(min(alldatax),max(alldatax),3);
plot(xToFit,xToFit*p(1)+p(2),'k:')

alhphaPcMu = p(1);
betaPcMu = p(2);

% fit 2
p=polyfit(alldatax,alldatay,2);
xToFit = linspace(min(alldatax),max(alldatax),100);
plot(xToFit,xToFit.^2*p(1)+xToFit*p(2)+p(3),'k--')

alhpha3PcMu = p(1);
beta3PcMu = p(2);
gamma3PcMu = p(3);

% fit 3
params=lsqcurvefit(growthMuFn, [1,1], alldatax,alldatay)
plot(xToFit,growthMuFn(params,xToFit),'k-');

%{
minmaxX = [min(alldatax) max(alldatax)];
dminmaxX = minmaxX(2)-minmaxX(2);
myxlims = [minmaxX(1)-.1*dminmaxX minmaxX(2)+.1*dminmaxX];
totalConcentration = mean(alldatay);

plot(myxlims,[totalConcentration totalConcentration],'k--');

xlim(myxlims);
ylim([0, max(alldatay)*1.1]);
%}

xlabel('CRP production [a.u/(min px)]');
ylabel('Growth rate [/min]');

% Save it
MW_makeplotlookbetter(10,[],[6 6]/2,1)
if exist(OUTPUTFOLDER)
    fileName = ['relationsAverages_' 'prod_mu'];
    saveas(h7,[OUTPUTFOLDER 'svg_' fileName '.svg'],'svg');
    saveas(h7,[OUTPUTFOLDER 'fig_' fileName '.fig'],'fig');
    saveas(h7,[OUTPUTFOLDER 'tif_' fileName '.tif'],'tif');
    saveas(h7,[OUTPUTFOLDER 'pdf_' fileName '.pdf'],'pdf');

    % Now some effort to create a legend
    h2ForLegend = copyfig(h7)
    lH=legend(HUMANREADABLENAMESFORGROUPS,'Location','SouthEast');    
    allText = findall(gcf,'Type','text');
    delete(allText);
    saveLegendToImage(h2ForLegend, lH, [], [OUTPUTFOLDER 'pdf_' fileName '_legend.pdf'],'pdf');
end

%% Testing more complicated relationship between two production rates
% This needs the fitting parameter "totalConcentration" and "params".

h8=figure(8); clf; 

alldatap=[]; alldataC=[]; alldataMu= [];
l=[];
% put printed values and single datapoints
alldatamu=[]; alldatax=[]; alldatay=[];
xmeansofset=[];ymeansofset=[];zmeansofset=[];
for groupIdx = 1:numel(applicableIndices)

    
    %%
    %thedts = myTimeBetweenShots(applicableIndices{groupIdx});
        % proved not necessary

    pdataCRP = processedOutput.('Production_Y').allValues{groupIdx};
    CdataCRP = processedOutput.('Concentration_Y').allValues{groupIdx};
    pdatas70 = processedOutput.('Production_C').allValues{groupIdx};
    Cdatas70 = processedOutput.('Concentration_C').allValues{groupIdx};
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
    
    l(end+1)=scatter(pdataCRP,...
                pdatas70,...
                10^2,...
                someColors(groupIdx,:),...
                'LineWidth',2);
             %'MarkerEdgeColor',someColors(groupIdx,:),...
             %'MarkerFaceColor',someColors(groupIdx,:));
    hold on;

    alldatax =  [alldatax pdataCRP];
    alldatay = [alldatay pdatas70];
    alldatamu = [alldatamu ];
    
    %{
    xmeansofset(end+1) = mean(pdataCRP);
    ymeansofset(end+1) = mean(pdatas70);
    zmeansofset(end+1) = mean(mudata);
    
    % Plot expectation for group
    plot(mean(pdataCRP),totalConcentration.*mean(mudata) - mean(pdataCRP),'sk','MarkerSize',15,'LineWidth',2,'Color',someColors(groupIdx,:));
    %}
    
end

minmaxX = [min(alldatax) max(alldatax)];
dminmaxX = minmaxX(2)-minmaxX(2);
myxlims = [minmaxX(1)-.1*dminmaxX minmaxX(2)+.1*dminmaxX];

% Now also plot the hypothetical relationship
tofitPc = linspace(myxlims(1),myxlims(2),100);
fittedPs70 = totalConcentration.*(xToFit*alhphaPcMu+betaPcMu) - tofitPc;
plot(tofitPc,fittedPs70,'k:')

% Now also plot the hypothetical relationship
tofitPc = linspace(myxlims(1),myxlims(2),100);
fittedPs70 = totalConcentration.*(tofitPc.^2*p(1)+tofitPc*p(2)+p(3)) - tofitPc;
plot(tofitPc,fittedPs70,'k--')

% Now plot Benjamin's hypothetical relationship
tofitPc = linspace(myxlims(1),myxlims(2),1000);
fittedPs70 = totalConcentration.*(growthMuFn(params,tofitPc)) - tofitPc;
plot(tofitPc,fittedPs70,'k-')

xlabel(['Production CRP [a.u./(min px)]']);
ylabel(['Prodcution s70 [a.u./(min px)]']);

%legend(l,HUMANREADABLENAMESFORGROUPS,'Location', 'NorthWest');

%{
set(gca,'xscale','log')
set(gca,'yscale','log')
xlim([1e-2 1e1])
ylim([1e-2 1e1])
%}


% Save it
MW_makeplotlookbetter(10,[],[6 6]/2,1)
if exist(OUTPUTFOLDER)
    fileName = ['relationsAverages_' 'prodC_prodY'];
    saveas(h8,[OUTPUTFOLDER 'svg_' fileName '.svg'],'svg');
    saveas(h8,[OUTPUTFOLDER 'fig_' fileName '.fig'],'fig');
    saveas(h8,[OUTPUTFOLDER 'tif_' fileName '.tif'],'tif');
    saveas(h8,[OUTPUTFOLDER 'pdf_' fileName '.pdf'],'pdf');

    % Now some effort to create a legend
    h2ForLegend = copyfig(h8)
    lH=legend(HUMANREADABLENAMESFORGROUPS,'Location','SouthEast');    
    allText = findall(gcf,'Type','text');
    delete(allText);
    saveLegendToImage(h2ForLegend, lH, [], [OUTPUTFOLDER 'pdf_' fileName '_legend.pdf'],'pdf');
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additional plots :
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

xlabel(['Concentration ' 10 '[a.u./px]']);
ylabel('Growth rate [1/min]');

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

%% Testing whether p = C for the consitutive reporter

h4=figure(4); clf; 

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
    Cdatas70 = processedOutput.('Concentration_C').allValues{groupIdx};
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
    
    l(end+1)=scatter(pdatas70,...
             Cdatas70.*mudata,...
             'MarkerEdgeColor',someColors(groupIdx,:),...
             'MarkerFaceColor',someColors(groupIdx,:));
    hold on;

    alldatax =  [alldatax pdatas70];
    alldatay = [alldatay [Cdatas70.*mudata]];
    
end

allvalues = [alldatax alldatay];
plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)],'k-');

% fit 1
p=polyfit(alldatax,alldatay,1);
xToFit = linspace(min(alldatax),max(alldatax),2);
plot(xToFit,xToFit*p(1)+p(2),'k--')

% fit 2
offset = mean(alldatay-alldatax);
plot([min(allvalues),max(allvalues)],[min(allvalues),max(allvalues)]+offset,'k:');

%alpha=1.5; beta=.5;
%plot(alldatap,alpha*alldatap./alldataMu + alldatap*beta,'o');

%{
yDataToFit = alldatap;
xDataToFit = alldataC;
p=polyfit(xDataToFit,yDataToFit,2);
xToShow = linspace(min(xDataToFit),max(xDataToFit),100);
plot(xToShow,xToShow.^2*p(1)+xToShow*p(2)+p(3),'k-')
%}

xlabel(['Production s70']);
ylabel(['Concentration s70 times growth rate']);

legend(HUMANREADABLENAMESFORGROUPS);


%% Understanding the general relationships
%{

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
%}
