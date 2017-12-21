
% Notes;
%
% see 
% \\storage01\data\AMOLF\users\wehrens\ZZ_EXPERIMENTAL_DATA\MICROSCOPE_EXPERIMENTS_MORE_LINKS\CRP_plasmid_data
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



%% How to convert directory to information necessary to run cross-correlation etc script

% This will be read from master excel sheet later
% ===
% basedir
teststringp1  = 'F:\EXPERIMENTAL_DATA_2014-2015_m1\';
% config file path
teststringp2  ='2015-06-12_CRP_asc852-853_plasmids\pos1crop\configFileMadeLater_2015-06-12_pos1.xlsx'
% ID to recognize dataset
teststringp3 = 'CRP_plasmids_WT_rCRP'; 

% Now convert to usable data
% ===
fullpathstringposition  =[teststringp1 teststringp2];

%if ~(fullpathstringposition(end)=='\') 
%    fullpathstringposition(end+1)='\';
%end

% Extract information from the path, note that this relies on some
% conventions.
% ===
% Examine the full path
slashLocations = strfind(fullpathstringposition,'\');
% Get date movie + name of experiment (referred to as movieDate)
movieDate = fullpathstringposition(slashLocations(end-2)+1:slashLocations(end-1)-1)
% Get the date by itself
theMovieDateOnly   = movieDate(1:10)
% Get the position name 
movieName = fullpathstringposition(slashLocations(end-1)+1:slashLocations(end)-1)

% Get the full path to the experiment ('date dir')
dateDir = fullpathstringposition(1:slashLocations(end-1))
% Get the config file name
configfilename           = fullpathstringposition(slashLocations(end)+1:end)

analysisDataPath        = [dateDir 'fluorDynamicsManager_Data_' theMovieDateOnly '_' movieName '.mat'];

%% Set up ourSettings struct required to run analysis

% Clear ourSettings and other config variables
clear -global settings ourSettings p

% Set up minimal set of variables in ourSettings struct
ourSettings.mypathname=         dateDir;
ourSettings.myconfigfilename=   configfilename
ourSettings.configfilepath = [ourSettings.mypathname ourSettings.myconfigfilename];

% Load the configfile
runsections='reloadfile'; % 'reloadfile' is better than 'loadfile' since it doesn't ask user where file is located
Schnitzcells_masterscript

% Update some more variables
if isempty(strfind(upper(ourSettings.ASCnumber),'ASC'))
        ourSettings.ASCnumber=['asc' num2str(ourSettings.ASCnumber)];
end
ourSettings.myID = [ourSettings.myGroupID '_' ourSettings.ASCnumber];

%p.movieDate = movieDate;
%p.movieName = movieName;

%% Now run the analyis again, if necessary

if ~exist(analysisDataPath,'file')
        
    % tell master script data should be loaded from directory
    LOADDATASETATEND = 1;
    
    runsections='makeoutputfull'; 
    Schnitzcells_masterscript
    
end
    
% Now save the output from the script into a parameter 








































