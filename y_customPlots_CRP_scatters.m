
THEFOLDERTOFINDTHEM ='U:\THESIS\Thesis\ChapterX_CRP\Figures\matlabExport\';
OUTPUTFOLDER='U:\THESIS\Thesis\ChapterX_CRP\Figures\matlabExport\';

%% Now for a custom figure of the concentrations of CRP vs. mu

fluorValues = {'C','Y'};

SETSwhichsubplottoputthem={};
SETSwhichfigurestottake={};
SETsaveIdentifiers={};
SETxAxesLabels={};
SETtheXlims={};SETtheYlims={};

% define multiple sets of data

% s70 concentration
SETxAxesLabels{end+1} = 'Concentration constitutive reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithConcentration_concentration_' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithConcentration_concentration_' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithConcentration_concentration_' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithConcentration_concentration_' 'C' '.fig']};
SETsaveIdentifiers{end+1} = ['muVsConcentration' 'C'];
SETtheXlims{end+1}=[50 1e3];
SETtheYlims{end+1}=[0 1.5];

% s70 rate
SETxAxesLabels{end+1} = 'Production constitutive reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithRate_rate_' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithRate_rate_' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithRate_rate_' 'C' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithRate_rate_' 'C' '.fig']};                      
SETsaveIdentifiers{end+1} = ['muVsRate' 'C'];
SETtheXlims{end+1}=[10 1e4];
SETtheYlims{end+1}=[0 1.5];

% CRP concentration
SETxAxesLabels{end+1} = 'Concentration CRP reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithConcentration_concentration_' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithConcentration_concentration_' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithConcentration_concentration_' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithConcentration_concentration_' 'Y' '.fig']};
SETsaveIdentifiers{end+1} = ['muVsConcentration' 'Y'];
SETtheXlims{end+1}=[100 1e3];
SETtheYlims{end+1}=[0 1.5];

% CRP rate
SETxAxesLabels{end+1} = 'Production CRP reporter (a.u.)';
SETSwhichsubplottoputthem{end+1} = [1,2,2,2];
SETSwhichfigurestottake{end+1}= {['fig_chromo1prime_scatters_WT_CRP_muWithRate_rate_' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_low_muWithRate_rate_' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_med_muWithRate_rate_' 'Y' '.fig'],...
                      ['fig_chromo1prime_scatters_No_FB_high_muWithRate_rate_' 'Y' '.fig']};                      
SETsaveIdentifiers{end+1} = ['muVsRate' 'Y'];
SETtheXlims{end+1}=[10 1e4];
SETtheYlims{end+1}=[0 1.5];


%%

for setIdx = 1:numel(SETSwhichsubplottoputthem)
    
    whichsubplottoputthem = SETSwhichsubplottoputthem{setIdx};
    whichfigurestottake   = SETSwhichfigurestottake{setIdx};          
    
    saveIdentifier = SETsaveIdentifiers{setIdx};
    xAxesLabel = SETxAxesLabels{setIdx};
    
    theXlim=SETtheXlims{setIdx};
    theYlim=SETtheYlims{setIdx};
    
    %% Do it
    h1=figure; clf; hold on;
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
        s1=subtightplot(1,2,currentPanelNr,[0.12,0.12],[0.2 0.05],[0.1 0.1]); hold on;
        copyobj(fig1,s1);

    end     

    %% cosmetics
    for currentPanelNr = 1:2
        %ax=subplot(1,2,currentPanelNr);     
        s1=subtightplot(1,2,currentPanelNr,[0.12,0.12],[0.2 0.05],[0.1 0.1]); hold on;

        lineHandles= findall(s1,'type','Line');
        contourHandles= findall(s1,'type','Contour');

        uistack(lineHandles,'top');        
        uistack(contourHandles,'top');  

        set(gca,'xscale','log');
        
        if ~any(isnan(theXlim))
            xlim(theXlim);
        end
        if ~any(isnan(theYlim))
            ylim(theYlim);
        end

        MW_makeplotlookbetter(10,[],[12.8, 19.2/3]/2,1);
    end

    subtitle_mw('',xAxesLabel,'Growth rate (dbl/hr)',0.05,0.12);

    fileName = [GROUPNAME '_overview_custom_scatter_' saveIdentifier];

    saveas(h1,[OUTPUTFOLDER 'tif_' fileName '.tif']);
    saveas(h1,[OUTPUTFOLDER 'fig_' fileName '.fig']);
    saveas(h1,[OUTPUTFOLDER 'svg_' fileName '.svg']);
    
end

