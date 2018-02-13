
% Execute e.g. first:
% z_plotssets_chromoCRPs70_prime

THEFOLDERTOFINDTHEM ='U:\THESIS\Thesis\ChapterX_CRP\Figures\matlabExport\';
OUTPUTFOLDER='U:\THESIS\Thesis\ChapterX_CRP\Figures\matlabExport\';

if ~exist('CLOSEFIGS','var')
    CLOSEFIGS=0;
end

if ~exist('FIGUREVISIBLEOFFON','var')
    FIGUREVISIBLEOFFON='on'; % choose off or on
end



%% Now for a custom figure of the concentrations of CRP vs. mu

fluorValues = {'C','Y'};

SETSwhichsubplottoputthem={};
SETSwhichfigurestottake={};
SETsaveIdentifiers={};
SETxAxesLabels={}; SETyAxesLabels={};
SETtheXlims={};SETtheYlims={};
SETaxisScales={};

% define multiple sets of data

% s70 concentration
SETxAxesLabels{end+1} = 'Concentration constitutive reporter (a.u.)';
SETyAxesLabels{end+1} = 'Growth rate (dbl/hr)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithConcentration' 'C' '_concentration' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithConcentration' 'C' '_concentration' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithConcentration' 'C' '_concentration' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithConcentration' 'C' '_concentration' 'C' '.fig']};
SETsaveIdentifiers{end+1} = ['muVsConcentration' 'C'];
SETtheXlims{end+1}=[50 1e3];
SETtheYlims{end+1}=[0 1.5];
SETaxisScales{end+1}={'log','linear'};

% s70 rate
SETxAxesLabels{end+1} = 'Production constitutive reporter (a.u.)';
SETyAxesLabels{end+1} = 'Growth rate (dbl/hr)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithRate' 'C' '_rate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithRate' 'C' '_rate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithRate' 'C' '_rate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithRate' 'C' '_rate' 'C' '.fig']};                      
SETsaveIdentifiers{end+1} = ['muVsRate' 'C'];
SETtheXlims{end+1}=[.01 5];
SETtheYlims{end+1}=[0 1.5];
SETaxisScales{end+1}={'log','linear'};

% CRP concentration
SETxAxesLabels{end+1} = 'Concentration CRP reporter (a.u.)';
SETyAxesLabels{end+1} = 'Growth rate (dbl/hr)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithConcentration' 'Y' '_concentration' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithConcentration' 'Y' '_concentration' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithConcentration' 'Y' '_concentration' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithConcentration' 'Y' '_concentration' 'Y' '.fig']};
SETsaveIdentifiers{end+1} = ['muVsConcentration' 'Y'];
SETtheXlims{end+1}=[100 1e3];
SETtheYlims{end+1}=[0 1.5];
SETaxisScales{end+1}={'log','linear'};

% CRP rate
SETxAxesLabels{end+1} = 'Production CRP reporter (a.u.)';
SETyAxesLabels{end+1} = 'Growth rate (dbl/hr)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithRate' 'Y' '_rate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithRate' 'Y' '_rate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithRate' 'Y' '_rate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithRate' 'Y' '_rate' 'Y' '.fig']};                      
SETsaveIdentifiers{end+1} = ['muVsRate' 'Y'];
SETtheXlims{end+1}=[.01 5];
SETtheYlims{end+1}=[0 1.5];
SETaxisScales{end+1}={'log','linear'};

% CRP concentration (y-axis) vs. s70 concentration (x-axis)
SETxAxesLabels{end+1} = 'Concentration CRP reporter (a.u.)';
SETyAxesLabels{end+1} = 'Concentration s70 reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_concentration' 'C' '_concentration' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_concentration' 'C' '_concentration' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_concentration' 'C' '_concentration' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_concentration' 'C' '_concentration' 'Y' '.fig']};                      
SETsaveIdentifiers{end+1} = ['concentrationVsConcentration' 'YC'];
SETtheXlims{end+1}=[10 1e3];
SETtheYlims{end+1}=[10 1e3];
SETaxisScales{end+1}={'log','log'};

% CRP rate (y-axis) vs. s70 rate (x-axis)
SETxAxesLabels{end+1} = 'Production CRP reporter (a.u.)';
SETyAxesLabels{end+1} = 'Production s70 reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_rate' 'C' '_rate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_rate' 'C' '_rate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_rate' 'C' '_rate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_rate' 'C' '_rate' 'Y' '.fig']};                      
SETsaveIdentifiers{end+1} = ['rateVsRate' 'YC'];
SETtheXlims{end+1}=[.01 5];
SETtheYlims{end+1}=[.01 5];
SETaxisScales{end+1}={'log','log'};

% -------------------------------------------------------------------------

% CRP concentration (y-axis) vs. s70 rate (x-axis)
SETxAxesLabels{end+1} = 'Concentration CRP reporter (a.u.)';
SETyAxesLabels{end+1} = 'Production s70 reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_rate' 'C' '_concentrationWithRate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_rate' 'C' '_concentrationWithRate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_rate' 'C' '_concentrationWithRate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_rate' 'C' '_concentrationWithRate' 'Y' '.fig']};                      
SETsaveIdentifiers{end+1} = ['concVsRate' 'CY'];
SETtheXlims{end+1}=[10 5000];
SETtheYlims{end+1}=[.01 5];
SETaxisScales{end+1}={'log','log'};

% CRP concentration (y-axis) vs. CRP rate (x-axis)
SETxAxesLabels{end+1} = 'Concentration CRP reporter (a.u.)';
SETyAxesLabels{end+1} = 'Production CRP reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_rate' 'Y' '_concentrationWithRate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_rate' 'Y' '_concentrationWithRate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_rate' 'Y' '_concentrationWithRate' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_rate' 'Y' '_concentrationWithRate' 'Y' '.fig']};                      
SETsaveIdentifiers{end+1} = ['concVsRate' 'YY'];
SETtheXlims{end+1}=[10 5000];
SETtheYlims{end+1}=[.01 5];
SETaxisScales{end+1}={'log','log'};

% s70 concentration (y-axis) vs. s70 rate (x-axis)
SETxAxesLabels{end+1} = 'Concentration s70 reporter (a.u.)';
SETyAxesLabels{end+1} = 'Production s70 reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_rate' 'C' '_concentrationWithRate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_rate' 'C' '_concentrationWithRate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_rate' 'C' '_concentrationWithRate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_rate' 'C' '_concentrationWithRate' 'C' '.fig']};                      
SETsaveIdentifiers{end+1} = ['concVsRate' 'CC'];
SETtheXlims{end+1}=[10 5000];
SETtheYlims{end+1}=[.01 5];
SETaxisScales{end+1}={'log','log'};

% s70 concentration (y-axis) vs. CRP rate (x-axis)
SETxAxesLabels{end+1} = 'Concentration s70 reporter (a.u.)';
SETyAxesLabels{end+1} = 'Production CRP reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_rate' 'Y' '_concentrationWithRate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_rate' 'Y' '_concentrationWithRate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_rate' 'Y' '_concentrationWithRate' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_rate' 'Y' '_concentrationWithRate' 'C' '.fig']};                      
SETsaveIdentifiers{end+1} = ['concVsRate' 'YC'];
SETtheXlims{end+1}=[10 5000];
SETtheYlims{end+1}=[.01 5];
SETaxisScales{end+1}={'log','log'};
%%

for setIdx = 1:numel(SETSwhichsubplottoputthem)
    
    %%
    
    whichsubplottoputthem = SETSwhichsubplottoputthem{setIdx};
    whichfigurestottake   = SETSwhichfigurestottake{setIdx};          
    
    saveIdentifier = SETsaveIdentifiers{setIdx};
    xAxesLabel = SETxAxesLabels{setIdx};
    yAxesLabel = SETyAxesLabels{setIdx};
    
    theXlim=SETtheXlims{setIdx};
    theYlim=SETtheYlims{setIdx};
    
    currentScale=SETaxisScales{setIdx};
    
    %% Do it
    h1=figure('Visible',FIGUREVISIBLEOFFON); clf; hold on;
    MW_makeplotlookbetter(10,[],[12.8, 19.2/3]/2,1);
    %ax=subtightplot(1,2,2,[0.5,0.12],[0.10 0.05],[0.1 0.1]); hold on;

    %%
    for takeIdx = 1:numel(whichfigurestottake)
        currentFigure = [THEFOLDERTOFINDTHEM whichfigurestottake{takeIdx}];
        currentPanelNr = whichsubplottoputthem(takeIdx);

        hCurrentFig = openfig(currentFigure);
        set(0,'CurrentFigure',hCurrentFig);
        set(hCurrentFig,'Visible','off');
        ax1 = gca;
        fig1 = get(ax1,'children');

        set(0,'CurrentFigure',h1);
        %s1=subplot(1,2,currentPanelNr);        
        %s1=subtightplot(1,2,currentPanelNr,[0.12,0.12],[0.2 0.05],[0.1 0.1]); hold on;
        s1=subtightplot(1,2,currentPanelNr,[0.12,0.12],[0.2 0.05],[0.12 0.06]); hold on;
        copyobj(fig1,s1);

    end     

    %% cosmetics
    for currentPanelNr = 1:2
        %ax=subplot(1,2,currentPanelNr);     
        s1=subtightplot(1,2,currentPanelNr,[0.12,0.12],[0.2 0.05],[0.12 0.06]); hold on;
            % Note: numbers need to be the same as above otherwise plots
            % will clear...?

        lineHandles= findall(s1,'type','Line');
        contourHandles= findall(s1,'type','Contour');

        uistack(lineHandles,'top');        
        uistack(contourHandles,'top');  

        set(gca,'xscale',currentScale{1});
        set(gca,'yscale',currentScale{2});
        % set(gca,'xscale','log');        
        
        % 
        %xtickformat('%0.2f')
        %ytickformat('%0.2f')
        
        if ~any(isnan(theXlim))
            xlim(theXlim);
        end
        if ~any(isnan(theYlim))
            ylim(theYlim);
        end

        MW_makeplotlookbetter(10,[],[12.8, 19.2/3]/2,1);
    end

    subtitle_mw('',xAxesLabel,yAxesLabel,0.05,0.12);

    fileName = [GROUPNAME '_overview_custom_scatter_' saveIdentifier];

    saveas(h1,[OUTPUTFOLDER 'tif_' fileName '.tif']);
    saveas(h1,[OUTPUTFOLDER 'fig_' fileName '.fig']);
    saveas(h1,[OUTPUTFOLDER 'svg_' fileName '.svg']);
    saveas(h1,[OUTPUTFOLDER 'pdf_' fileName '.pdf']);
    
    if CLOSEFIGS
        close(h1);
    end
    
end

%% Legend

% recreate colors 
distinguishableColors = linspecer(numel(SETSwhichsubplottoputthem{1})); 

% Plot and make legend
hLegendFig=figure; clf; hold on;
hLegendLines=[];
for idx = 1:numel(SETSwhichsubplottoputthem{1})
    hLegendLines(end+1)=plot(1,idx,'o','Color',distinguishableColors(idx,:),'MarkerFaceColor',distinguishableColors(idx,:));
end

hLegend = legend(hLegendLines, HUMANREADABLENAMESFORGROUPS)

% and save to separate image
fileName = [GROUPNAME '_overview_custom_scatter_legend'];
saveLegendToImage(hLegendFig,hLegend,[]);%,[OUTPUTFOLDER 'tif_' fileName])
saveas(hLegendFig,[OUTPUTFOLDER 'tif_' fileName '.tif']);
saveas(hLegendFig,[OUTPUTFOLDER 'fig_' fileName '.fig']);
saveas(hLegendFig,[OUTPUTFOLDER 'svg_' fileName '.svg']);
saveas(hLegendFig,[OUTPUTFOLDER 'pdf_' fileName '.pdf']);

