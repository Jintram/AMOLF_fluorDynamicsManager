
% Notes;
%
% see 
% \\storage01\data\AMOLF\users\wehrens\ZZ_EXPERIMENTAL_DATA\MICROSCOPE_EXPERIMENTS_shortcuts\CRP_plasmid_data
% also for a .docx file with a list of plasmid data.




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

[ndata, text, allXLSdata] = xlsread('\\storage01\data\AMOLF\users\wehrens\ZZ_EXPERIMENTAL_DATA\MICROSCOPE_OVERVIEW_AND_FIGURES\_projectfile_CRP.xlsx','dataset_list','B16:E200')
nrDataLines=size(allXLSdata,1);

disp('Excel file with overview of data loaded..');

%% Define which datasets should be plotted together and how

% The plasmid datasets
% { {identifier1}, {identifier2, identifier3}, .. }
% The cells within the cells allow for synonyms, e.g.
% {identifier2,identifier3} will be considered as if they were the
% same identifier.
IDENTIFIERSTOPLOT = {...
    {'WT_plasmids_pbla-CRP_pCRP-GFP_asc852'}, ...
    {'WT_plasmids_pbla-CRP_ps70-GFP_asc853'}, ...
    {'dCRP_plasmids_pbla-CRP_pCRP-GFP_asc854'}, ...
    {'dCRP_plasmids_pbla-CRP_ps70-GFP_asc855'}, ...
    {'WT_plasmids_ps70-GFP_asc841'}, ...
    {'WT_plasmids_pCRP-GFP_asc842'}, ...    
    ...{'dcAMP_plasmids-extracell800-pCRP-GFP_asc893','dcAMP-extracell800-pCRP-GFP_asc894'},...
    ...{'dcAMP_plasmids-extracell800-ps70-GFP_asc941'},...
    ...
    };
% Now also define the colors for these plots
fourcolors=linspecer(4);
morecolors=linspecer(10);
COLORSWITHIDENTIFIERS = {...
    fourcolors(1,:), ... {'WT_plasmids_pbla-CRP_pCRP-GFP_asc852'}, ...
    fourcolors(1,:), ... {'WT_plasmids_pbla-CRP_ps70-GFP_asc853'}, ...
    fourcolors(2,:), ... {'dCRP_plasmids_pbla-CRP_pCRP-GFP_asc854'}, ...
    fourcolors(2,:), ... {'dCRP_plasmids_pbla-CRP_ps70-GFP_asc855'}, ...
    fourcolors(1,:), ... {'WT_plasmids_ps70-GFP_asc841'}, ...
    fourcolors(1,:), ... {'WT_plasmids_pCRP-GFP_asc842'}, ...    
    ...fourcolors(2,:), ... {'dcAMP-extracell800-pCRP-GFP_asc893','dcAMP-extracell800-pCRP-GFP_asc894'},...
    ...fourcolors(2,:), ... {'dcAMP-extracell800-ps70-GFP_asc941'},...
    ...
};
CUSTOMLIMITSPERPARAMGROUP = {...
    [NaN NaN    0   2],...
    [0,  6e4    NaN NaN],...
    [NaN NaN    NaN NaN]...
    };
    % {[xlim(1) xlim(2) ylim(1) ylim(2)], ...}

CUSTOMLIMITSPERPARAMGROUPCCS= {...
    [-10 10    -.4 .4],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN]...
    };
%% Test dataset
fourcolors=linspecer(4);
morecolors=linspecer(10);

IDENTIFIERSTOPLOT = {...
    {'WT_plasmids_pbla-CRP_pCRP-GFP_asc852'},...
    {'WT_plasmids_pbla-CRP_ps70-GFP_asc853'}};
COLORSWITHIDENTIFIERS = {...
    fourcolors(1,:),...
    fourcolors(1,:),};

CUSTOMLIMITSPERPARAMGROUP = {...
    [NaN NaN    NaN NaN],...
    [0,  6e4    NaN NaN],...
    [NaN NaN    NaN NaN]...
    };
    % {[xlim(1) xlim(2) ylim(1) ylim(2)], ...}

CUSTOMLIMITSPERPARAMGROUPCCS= {...
    [NaN NaN    -.4 .4],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN]...
    };
    
%% Show some colors
%{
figure; hold on;
for i=1:size(somecolors,1)
    plot(i,1,'o','Color',somecolors(i,:),'MarkerSize',10,'MarkerFaceColor',somecolors(i,:))
end
%}

%% Running analyses if necessary
% TODO: maybe remove this section to a separate script file?
%
% Note: if the script crashes (e.g. a problem with setting axis limits)
% this might be due to NaN values in the data (check e.g. CorrData). This
% can be resolved by using MW_helper_schnitzcell_terror_counting to
% identify cells that have NaN values. After checking these errors are
% non-consequential for the data set (e.g. because it are the last
% schnitzes in the set that only have 1 frame and no offspring), they can
% simply be added to the "bad schnitzes" list in the excel config file of
% that data set. Open MW_GUI_schnitzcells to easily edit the config file.

% Run over datafiles to run analysis if this is necessary
for dataIdx= 1:nrDataLines
    
    %% skip if empty    
    if isempty(allXLSdata{dataIdx,1}) | isnan(allXLSdata{dataIdx,1})
        continue
    end
    
    %% Load configuration file and pre-process dataset info
    fluorDynamicsManager_sub_PreprocessDatasetInfo        
        % some parameters that are determined are:
        % ourSettings, dateDir, theMovieDateOnly, movieName, dataFileName,
        % identifierInXLS
    
    %% Now the idea is to check for the existence of already analyzed data    
    
    % Now determine if we want to re-run the analysis
    % (I.e. if we want to go over all, or if dataset is mentioned in any of 
    % the to-plot identifiers.)
    if exist('NOSELECTIONLOOKATALLANALYSES','var') | any(cellfun(@(x) strcmp(identifierInXLS,x), {IDENTIFIERSTOPLOT{:}}))
    
        % And run the analysis if there is not already data
        if exist(dataFileName,'file') & ~exist('RERUNANALYSIS','var')

            disp(['Dataset [' theMovieDateOnly ', ' movieName '] was already analyzed before; I did not repeat analysis.']);

        else

            %% Otherwise run the analysis
            disp(['Dataset [' theMovieDateOnly ', ' movieName '] was not analyzed before (or user defined re-run); running analysis now.']);

            disp('Taking 5 seconds pause before starting..');
            pause(5);

            % ===
            % overwrite the PLOTSCATTER setting
            ourSettings.PLOTSCATTER = 0;
            % Don't show figures
            FIGUREVISIBLE='off';      
            % Re-evaluate the bad schnitzes (in case the Excel file was
            % updated)
            ourSettings.alreadyRemovedInMatFile = 0;
            % tell master script schnitzcells data should be loaded from directory
            LOADDATASETATEND = 1;
            % Note:
            % also ourSettings.fitTimeCrosscorr is an important paramter
            % that decides which part of the branchData is taken.

            % run the masterscript analysis part
            runsections='makeoutputfull'; 
            Schnitzcells_masterscript

            % A number of (invisible) figures will have been
            % generated, so close all figures here to avoid accumulation..
            close all;
            
            % The masterscript will save the data
            disp('Analysis done and saved.');
        end
       
    end
        
end
disp('Section done, all datasets were inspected to see if analyis was necessary..');

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
paramIdx = 1;

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
dualOrSinglePlot = 'SingleParameter';

%% The same can be done for cross-correlations
%figurePaths = struct;
paramIdx = 1;

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
        
        % Get the path                
        figFilename = ['FIG_crosscorrs_' parameterOfInterestDoubleCombinatorialList{paramIdx} '_small.fig'];
        completeFigurePath = [theDirectoryWithThePlots figFilename];
               
        % Organize this into the figure list
        figurePaths.CCs{paramIdx}{groupIdx}{plotIdx}=completeFigurePath;
        
    end
end

dualOrSinglePlot = 'CC';
%% Then place the figures neatly tiled into a figure
paramIdx=1;
plotType = 'CCs'; % CCs branches PDF CVovertime
dualOrSinglePlot = 'CC'; % CC or SingleParameter

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
        
        % Turn of axes ticks if desired
        %set(gca,'YTickLabel',[]); %set(gca,'XTickLabel',[]); 
        
        % give a title if it is the first of a group
        if plotIdx==1
            t=title(groupLabels(groupIdx));
            set(t, 'horizontalAlignment', 'left');
            set(t, 'units', 'normalized');
            t1 = get(t, 'position');
            set(t, 'position', [0 t1(2) t1(3)]);
        end
        
        % Set limits to axes if desired        
        if strcmp(dualOrSinglePlot,'SingleParameter')
            if exist('CUSTOMLIMITSPERPARAMGROUP','var')
                if ~any(isnan(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(1:2)))
                    xlim(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(1:2));
                end
                if ~any(isnan(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(3:4)))
                    ylim(CUSTOMLIMITSPERPARAMGROUP{paramIdx}(3:4));
                end
            end
        elseif strcmp(dualOrSinglePlot,'CC')
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
    if strcmp(dualOrSinglePlot,'SingleParameter')
        disp([groupLabels(idIdx) ': ' IDENTIFIERSTOPLOT{idIdx}{:} ', ' parameterOfInterestList{paramIdx}]); 
    elseif strcmp(dualOrSinglePlot,'CC')
        disp([groupLabels(idIdx) ': ' IDENTIFIERSTOPLOT{idIdx}{:} ', ' parameterOfInterestDoubleCombinatorialList{paramIdx}]); 
    end
end
disp('===');

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








































