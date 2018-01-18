
% Notes;
%
% see 
% \\storage01\data\AMOLF\users\wehrens\ZZ_EXPERIMENTAL_DATA\MICROSCOPE_EXPERIMENTS_shortcuts\CRP_plasmid_data
% also for a .docx file with a list of plasmid data.

OUTPUTFOLDER = 'U:\THESIS\Thesis\ChapterX_CRP\Figures\matlabExport\';

%% A flashy new script to handle all my data

% Documentation
% 
% DATA STORAGE ===
% The general idea is that there is an excel sheet that contains the names
% of the folders that hold the data.
% 
% Note sure necessary ---> 
% There will also be a column with identifiers, that describe 
% similar experiments such that data can be 
% grouped later.
% <-----
% 
% DATA&ANALYSIS STORAGE POLICY ===
% Generally, analyzed data will be stored in .mat files (or otherwise), 
% preferably in the directory with the data.
% Overview plots will be stored in an output directory.
% DATA STRUCTURE
% ===
% Experimental datasets are stored in folders that are labeled with the
% date the experiment has taken place, plus an additional description
% string (the "date" folder.
% Each experiment has different subfolders, where positions that were
% observed under the microscope are stored. Each analysis is performed on
% these "sub"experiments. Each of these sub experiments also has its own
% Excel configuration file, which allow Matlab to process the data. These
% configuration files are stored in the experimental date folder.
% The experimental folders are organized in "base" directories, that are
% organized per year.
%
% ANALYSIS === 
% Optimally, the script, when ran, would loop over all datasets and check
% whether analyses were already performed beforehand. Per dataset, if this
% is not the case, the analysis would be run again.
% This could be implemented by saving the analysis result per dataset to
% the folder itself (with a name specific to this script) and later
% checking whether that file already exists.
%
% 

%% Load Excel file to get information on directories

[ndata, theTextData, allXLSdata] = xlsread('\\storage01\data\AMOLF\users\wehrens\ZZ_EXPERIMENTAL_DATA\MICROSCOPE_OVERVIEW_AND_FIGURES\_projectfile_CRP.xlsx','dataset_list','B16:E200')
nrDataLines=size(allXLSdata,1);

disp('Excel file with overview of data loaded..');

%% Define which datasets should be plotted together and how
% Sets of data that you want to plot are defined by a few key parameters, 

%% 
z_plotssets_plasmids1

%% 
z_plotssets_plasmids2

%%

%{
z_plotssets_testplots
%}

    
%% Show some colors
%{
figure; hold on;
for i=1:size(somecolors,1)
    plot(i,1,'o','Color',somecolors(i,:),'MarkerSize',10,'MarkerFaceColor',somecolors(i,:))
end
%}

%% Running analyses if necessary

fluorDynamicsManager_sub_runAnalyses

%% Create grouped plots

% First find out which lines of the xls file match the groups of plots that we want
applicableIndices = {};
% Go over the different plot groups
for plotGroupIdx = 1:numel(IDENTIFIERSTOPLOT)
    % Now find all lines in the xls file of which the identifier match any
    % of the IDENTIFIERSTOPLOT{plotGroupIdx}
    applicableIndices{plotGroupIdx} = ...
    find(...
        cellfun(@(currentIdentifierXls) any( ...
            cellfun(@(currentIdentifierToPlot) strcmp(currentIdentifierToPlot,currentIdentifierXls), IDENTIFIERSTOPLOT{plotGroupIdx})...
            ),  {allXLSdata{:,4}})...
    );
end

%% Now go and fetch all the corresponding filepaths, first for single params
figurePaths = struct;

for groupIdx = 1:numel(applicableIndices)
    for plotIdx = 1:numel(applicableIndices{groupIdx}) 
        
       
        %% 
        
        % Set appropriate index
        dataIdx =  applicableIndices{groupIdx}(plotIdx);
        
        % Load configuration file and pre-process dataset info
        fluorDynamicsManager_sub_PreprocessDatasetInfo
        
        % determine which fields are of interest
        fluorDynamicsManager_sub_GetInterestingFieldsForThisDataSet
            % i.e. get parameterOfInterestList
        
        for paramIdx = 1:numel(parameterOfInterestList)
            % Get the path to the PDF and put into figure list
            figFilename = ['FIG_PDF_' parameterOfInterestList{paramIdx} '_small.fig'];
            completeFigurePath = [theDirectoryWithThePlots figFilename];
            figurePaths.PDF{paramIdx}{groupIdx}{plotIdx}=completeFigurePath;
            % Get the path to the branches plot
            figFilename = ['FIG_branches_' parameterOfInterestList{paramIdx} '_small.fig'];
            completeFigurePath = [theDirectoryWithThePlots figFilename];
            figurePaths.branches{paramIdx}{groupIdx}{plotIdx}=completeFigurePath;
            % Get the path to the CV over time plot
            figFilename = ['FIG_CVovertime_' parameterOfInterestList{paramIdx} '_small.fig'];
            completeFigurePath = [theDirectoryWithThePlots figFilename];
            figurePaths.CV{paramIdx}{groupIdx}{plotIdx}=completeFigurePath;    
        end
        
        
    end
end

disp('==');
allParamString=cell2mat(arrayfun(@(x) [10 '- ' parameterOfInterestList{x}],1:numel(parameterOfInterestList),'UniformOutput',0));
disp(['Parameters that have been defined in last run: ' allParamString]);

allDualParamString=cell2mat(arrayfun(@(x) [10 '- ' parameterOfInterestDoubleCombinatorialList{x}],1:numel(parameterOfInterestDoubleCombinatorialList),'UniformOutput',0));
disp(['Parameters pairs that have been defined in last run: ' allDualParamString]);
disp('==');

%% The same can be done for cross-correlations
%figurePaths = struct;

for groupIdx = 1:numel(applicableIndices)
    for plotIdx = 1:numel(applicableIndices{groupIdx}) 
        
       
        %% 
        
        % Set appropriate index
        dataIdx =  applicableIndices{groupIdx}(plotIdx);
        
        % Load configuration file and pre-process dataset info
        fluorDynamicsManager_sub_PreprocessDatasetInfo
        
        % determine which fields are of interest
        fluorDynamicsManager_sub_GetInterestingFieldsForThisDataSet
            % i.e. get parameterOfInterestList, parameterOfInterestDoubleCombinatorialList
        
        for paramIdx = 1:numel(parameterOfInterestDoubleCombinatorialList)
            
            %%
            
            % Get the path                
            figFilename = ['FIG_crosscorrs_' parameterOfInterestDoubleCombinatorialList{paramIdx} '_small.fig'];
            completeFigurePath = [theDirectoryWithThePlots figFilename];

            % Organize this into the figure list
            figurePaths.CCs{paramIdx}{groupIdx}{plotIdx}=completeFigurePath;
        
        end
        
    end
end

%% Then place the figures neatly tiled into a figure

SINGLEORDUALNAMES = {'single','CC'};
SINGLEPLOTTYPES   = {'branches' 'PDF' 'CVovertime'};

% dual or single, i.e. single parameter, or comparison of two parameters
% like for CC
for singleOrDualPlot = 1:2  

    if singleOrDualPlot==1
        paramIndices = 1:numel(parameterOfInterestList);        
    elseif singleOrDualPlot==2
        paramIndices = 1:numel(parameterOfInterestDoubleCombinatorialList);                
    else, error('Not recognized');
    end
    
    for paramIdx=paramIndices    

        if singleOrDualPlot == 1
            plotType = SINGLEPLOTTYPES{paramIdx};
        elseif singleOrDualPlot == 2
            plotType = 'CCs'; % CCs branches PDF CVovertime
        end
        
        %% Now create for each parameter (or combination of parameters) an overview plot        

        % Determine the size of our subplot figure first
        nrPanels      = cellfun(@(x) numel(x), applicableIndices);
        totalNrPanels = sum(nrPanels);
        xNrPanels = min(ceil(sqrt(totalNrPanels)), max(nrPanels));
        yNrPanels = sum(ceil(nrPanels./xNrPanels));

        % Determine (y) size of figure
        theHeight = min(yNrPanels*4.8, 19.2);

        % Make figure
        if exist('h1','var'), if ishandle(h1), close(h1), end, end % close if handle already existed
        h1=figure(); clf; hold on; % make new
        MW_makeplotlookbetter(8,[],[12.8 theHeight]./2,1); 

        % Necessary later
        groupLabels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        %
        panelLine=0;
        panelNr=0;
        for groupIdx = 1:numel(applicableIndices)
            panelLine=panelLine+1;
            panelColumn=0;
            for plotIdx = 1:numel(applicableIndices{groupIdx}) 

                %%

                % Determine which panel to use
                panelColumn=panelColumn+1;
                if panelColumn>xNrPanels
                    panelColumn=0; panelLine=panelLine+1;
                end
                panelNr=(panelLine-1)*xNrPanels+panelColumn

                % Get the path for the current figure
                currentFigure = figurePaths.(plotType){paramIdx}{groupIdx}{plotIdx};

                % Load and get handle for current figure
                hCurrentFig = openfig(currentFigure);
                set(0,'CurrentFigure',hCurrentFig);
                set(hCurrentFig,'Visible','off');
                ax1 = gca;
                fig1 = get(ax1,'children');

                % Switch to figure with multiple panels
                set(0,'CurrentFigure',h1);
                s1=subplot(yNrPanels,xNrPanels,panelNr);        
                copyobj(fig1,s1);

                % XLim and YLim are not copied, so copy manually
                xlim(ax1.XLim);
                ylim(ax1.YLim);

                % Turn of axes ticks if desired
                %set(gca,'YTickLabel',[]); %set(gca,'XTickLabel',[]); 

                % give a title if it is the first of a group
                if plotIdx==1
                    t=title(groupLabels(groupIdx));
                    set(t, 'horizontalAlignment', 'left');
                    set(t, 'units', 'normalized');
                    t1 = get(t, 'position');
                    %set(t, 'position', [0 t1(2) t1(3)]);
                    set(t, 'position', [0-.1*xNrPanels t1(2) t1(3)]); % This was a bit trial and error
                end

                % Set limits to axes if desired        
                if singleOrDualPlot == 1
                    if exist('CUSTOMLIMITSPERPARAMGROUP','var')
                        if ~any(isnan(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(1:2)))
                            xlim(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(1:2));
                        end
                        if ~any(isnan(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(3:4)))
                            ylim(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(3:4));
                        end
                    end
                elseif singleOrDualPlot == 2
                    if exist('CUSTOMLIMITSPERPARAMGROUPCCS','var')            
                    if ~any(isnan(CUSTOMLIMITSPERPARAMGROUPCCS{paramIdx}(1:2)))
                        xlim(CUSTOMLIMITSPERPARAMGROUPCCS{paramIdx}(1:2));
                    end
                    if ~any(isnan(CUSTOMLIMITSPERPARAMGROUPCCS{paramIdx}(3:4)))
                        ylim(CUSTOMLIMITSPERPARAMGROUPCCS{paramIdx}(3:4));
                    end
                    end
                end

            end

        end

        figure(h1);

        % Also give overview of the different conditions:
        disp(['===' 10 'FIGURE LEGEND']);
        for idIdx = 1:size(IDENTIFIERSTOPLOT,2)
            if singleOrDualPlot == 1
                disp([groupLabels(idIdx) ': ' IDENTIFIERSTOPLOT{idIdx}{:} ', ' parameterOfInterestList{paramIdx}]); 
            elseif singleOrDualPlot == 2
                disp([groupLabels(idIdx) ': ' IDENTIFIERSTOPLOT{idIdx}{:} ', ' parameterOfInterestDoubleCombinatorialList{paramIdx}]); 
            end
        end
        disp('===');

        %% Now save the plot
        
        if singleOrDualPlot == 1
            plotName = parameterOfInterestList{paramIdx};
        elseif singleOrDualPlot == 2
            plotName = parameterOfInterestDoubleCombinatorialList{paramIdx};
        end
        
        fileName = [GROUPNAME '_' plotType '_' ]
        
        saveas
        
    end
        
end

%% Now to compare some things that are only stored in the output parameters

PARAMETERNAMESTOCOLLECT = {'growthMean','CV'};

for groupIdx = 1:numel(applicableIndices)
    for plotIdx = 1:numel(applicableIndices{groupIdx}) 


        %% 

        clear output

        % Set appropriate index
        dataIdx =  applicableIndices{groupIdx}(plotIdx);

        % Load configuration file and pre-process dataset info
        fluorDynamicsManager_sub_PreprocessDatasetInfo
            % also determines dataFileName

        load(dataFileName,'output');

        for paramIdx = 1:numel(PARAMETERNAMESTOCOLLECT)

            currentParameterNameToCollect=PARAMETERNAMESTOCOLLECT{paramIdx};

            collectedOutput.(currentParameterNameToCollect){groupIdx}{plotIdx} = ...
                output.(currentParameterNameToCollect);
        end

    end
end
    


%% A simple direct plot for values

currentParameterNameToCollect='growthMean';
plotType = 'mu'; % mu, CV; This will be used later for labeling of plot

labelLocations = []; technicalReplicateNrs = [];
allMeans = []; allSEMs = [];
for groupIdx = 1:numel(applicableIndices)

    % Get values
    allCurrentValues = [collectedOutput.(currentParameterNameToCollect){groupIdx}{:}];
    
    % Mean, SEM, etc
    currentMean = mean(allCurrentValues);
    currentSEM = std(allCurrentValues)/sqrt(numel(allCurrentValues));
    currentTechnicalReplicateNr = numel(allCurrentValues);
    
    % Remove SEMs based on 1 replicate
    if currentTechnicalReplicateNr==1
        currentSEM=NaN;
    end
        
    labelLocations(end+1) = groupIdx;
    technicalReplicateNrs(end+1) = currentTechnicalReplicateNr;
    allMeans(end+1)= currentMean;
    allSEMs(end+1) = currentSEM;
end

myYlim=[0 max(allMeans)*1.1];

% print values on top
for groupIdx = 1:numel(applicableIndices)
    myValueString=sprintf('%0.2f',allMeans(groupIdx));
    text(groupIdx, myYlim(2),myValueString,'HorizontalAlignment','center');
end

labelNames = arrayfun(@(x) IDENTIFIERSTOPLOT{x}{:}, 1:numel(IDENTIFIERSTOPLOT),'UniformOutput', 0);

set(gca,'XTick',labelLocations,'XTickLabel',labelNames,'TickLabelInterpreter','None');
xtickangle(90);

ylabel('Growth rate [dbl/hr]');
MW_makeplotlookbetter(10);


%% Do the same as above for the slightly more complicated CV

searchTermForWhatToPlot = 'mu'; % e.g.: mu, dG, G5

% Find the field name based on simple search term
theFieldNames = fieldnames(collectedOutput.CV{1}{1});
theFieldIdx   = find(arrayfun(@(x) any(strfind(theFieldNames{x},searchTermForWhatToPlot)), 1:numel(theFieldNames)));
whatToPlotName = theFieldNames{theFieldIdx};

labelLocations=[];
technicalReplicateNrs = [];
allMeans = []; allSEMs = [];
for groupIdx = 1:numel(applicableIndices)

    % Get values
    allCurrentValues = arrayfun(@(x) collectedOutput.CV{groupIdx}{x}.(whatToPlotName).meanCoefficientOfVariationLast10, 1:numel(collectedOutput.CV{groupIdx}) );
        % note that CV is determined in a complicated way
    
    % Mean, SEM, etc
    currentMean = mean(allCurrentValues);
    currentSEM = std(allCurrentValues)/sqrt(numel(allCurrentValues));
    currentTechnicalReplicateNr = numel(allCurrentValues);
    
    % Remove SEMs based on 1 replicate
    if currentTechnicalReplicateNr==1
        currentSEM=NaN;
    end
    
    % Store for later plotting
    labelLocations(end+1) = groupIdx;
    technicalReplicateNrs(end+1) = currentTechnicalReplicateNr;
    allMeans(end+1)= currentMean;
    allSEMs(end+1) = currentSEM;
end

plotType = 'CV'; % mu, CV

%% General way of plotting data per group..
% TODO: maybe make a function out of this?

%plotType = 'CV'; % mu, CV

h1=figure; clf; hold on;
bar(1:numel(applicableIndices), allMeans,'FaceColor',[.7 .7 .7]);
errorbar(1:numel(applicableIndices), allMeans, allSEMs,'k','LineStyle','none','LineWidth',2);

myYlim=[0 max(allMeans+allSEMs)*1.1];

% print values on top
for groupIdx = 1:numel(applicableIndices)
    myValueString=sprintf('%0.2f',allMeans(groupIdx));
    text(groupIdx, myYlim(2),myValueString,'HorizontalAlignment','center');
end

% xtick labels
labelNames = arrayfun(@(x) IDENTIFIERSTOPLOT{x}{:}, 1:numel(IDENTIFIERSTOPLOT),'UniformOutput', 0);
set(gca,'XTick',labelLocations,'XTickLabel',labelNames,'TickLabelInterpreter','None');
xtickangle(90);

MW_makeplotlookbetter(10);

if strcmp(plotType,'mu')
    ylabel('Growth rate [dbl/hr]');
elseif strcmp(plotType,'CV')
    ylabel('CV');
else
    ylabel('[unkown parameter]');
end


%plotting CV
%output.CV.(theFieldNames).meanCoefficientOfVariationLast10

%% Plot CV lines separately but color for group

searchTermForWhatToPlot = 'mu'; % e.g.: mu, dG, G5

% Find the field name based on simple search term
theFieldNames = fieldnames(collectedOutput.CV{1}{1});
theFieldIdx   = find(arrayfun(@(x) any(strfind(theFieldNames{x},searchTermForWhatToPlot)), 1:numel(theFieldNames)));
whatToPlotName = theFieldNames{theFieldIdx};

% Now plot
h1=figure; clf; hold on;

% cosmetics
someColors = linspecer(numel(applicableIndices));

labelLocations = []; technicalReplicateNrs = [];
allMeans = []; allSEMs = [];
myLegendLines = []; myAxes = [];
allWeighedAverages={};
for groupIdx = 1:numel(applicableIndices)

    allWeighedAverages{groupIdx}=[];
    for lineIdx=1:numel(collectedOutput.CV{groupIdx})
    
        % Get values
        currentValuesToPlot = ...
            collectedOutput.CV{groupIdx}{lineIdx}.(whatToPlotName).coefficientOfVariationOverTime;
        currentTimePoints = ...
            collectedOutput.CV{groupIdx}{lineIdx}.(whatToPlotName).time;
        
            
        ax=subplot(numel(applicableIndices),1,groupIdx); hold on;
        l=plot(currentTimePoints,currentValuesToPlot,'Color',someColors(groupIdx,:),'LineWidth',2);
        
        % additionally, we could calculate a weighed average..
        currentNumberOfValues = ...
            collectedOutput.CV{groupIdx}{lineIdx}.(whatToPlotName).numberOfValues;
        currentWeighedAverage = sum(currentValuesToPlot.*currentNumberOfValues)/sum(currentNumberOfValues);
        
        allWeighedAverages{groupIdx}(end+1) = currentWeighedAverage;
    end
    
    myLegendLines(end+1) = l;
    myAxes(end+1)=ax;       
    
end

ylabel('CV');
xlabel('Time (hrs)');

%% Now create legend from this figure

labelNames = arrayfun(@(x) IDENTIFIERSTOPLOT{x}{:}, 1:numel(IDENTIFIERSTOPLOT),'UniformOutput', 0);
legendHandle=legend(myLegendLines,labelNames,'Interpreter','None','Location','NorthOutside');

saveLegendToImage(h1, legendHandle, myAxes);


%{
% Create separate legend plot
hLegend=figure(); clf; hold on;
myLegendLinesPrime=[];
for groupIdx = 1:numel(applicableIndices)
    lprime=plot([groupIdx,groupIdx],[1,2],'Color',someColors(groupIdx,:),'LineWidth',2);
    myLegendLinesPrime(end+1)=lprime;    
end
labelNames = arrayfun(@(x) IDENTIFIERSTOPLOT{x}{:}, 1:numel(IDENTIFIERSTOPLOT),'UniformOutput', 0);
legendHandle=legend(myLegendLinesPrime,labelNames,'Interpreter','None','Location','NorthOutside');

set(myLegendLinesPrime, 'visible', 'off');
set(gca, 'visible', 'off');

%hLegend=figure();
%copyobj(legendHandle,hLegend);
%}

%% Now plot weighed averages

someColors = linspecer(numel(applicableIndices));

h1=figure; clf; hold on;
for groupIdx = 1:numel(applicableIndices)
    
    bar(groupIdx,mean(allWeighedAveragesCV{groupIdx}),'FaceColor',[.7 .7 .7],'EdgeColor','none');
    
    plot(ones(1,numel(allWeighedAverages{groupIdx})).*groupIdx,...
            allWeighedAverages{groupIdx},'o',...
            'LineWidth',2,...
            'Color',someColors(groupIdx,:));            
end

labelNames = arrayfun(@(x) IDENTIFIERSTOPLOT{x}{:}, 1:numel(IDENTIFIERSTOPLOT),'UniformOutput', 0);
set(gca,'XTick',1:numel(applicableIndices),'XTickLabel',labelNames,'TickLabelInterpreter','None');
xtickangle(90);

ylabel('CV');

%% Plot CV against growth rate

h1=figure; clf; hold on;
for groupIdx = 1:numel(applicableIndices)
    
    plot([collectedOutput.(currentParameterNameToCollect){groupIdx}{:}],...        
         allWeighedAverages{groupIdx},...
            'o',...
            'LineWidth',2,...
            'Color',someColors(groupIdx,:)); 
         
end

xlabel('Growth rate [dbl/hr]');
ylabel('CV');

%% 

%{
for i= 1:numel(identifiers)
disp(identifiers{i});
end
%}

%%


%% ...

for i=1:10
    i=i+1
end








































