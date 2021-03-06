% The following is defined here:
% GROUPNAME
% IDENTIFIERSTOPLOT
% COLORSWITHIDENTIFIERS
% CUSTOMLIMITSPERPARAMGROUP
% CUSTOMLIMITSPERPARAMGROUPCCS

GROUPNAME='chromo1';

% The plasmid datasets
% { {identifier1}, {identifier2, identifier3}, .. }
% The cells within the cells allow for synonyms, e.g.
% {identifier2,identifier3} will be considered as if they were the
% same identifier.
IDENTIFIERSTOPLOT = {...    
    {'CRP_s70_chromosomal_asc990','CRP_s70_chromosomal_asc990_prime'}, ...    
    {'CRP_s70_chromosomal_cAMPLOW80_asc1004','CRP_s70_chromosomal_cAMPLOW80_asc1004_prime'},...
    {'CRP_s70_chromosomal_cAMP800_asc1004','CRP_s70_chromosomal_cAMP800_asc1004_prime'}, ...    
    {'CRP_s70_chromosomal_cAMPHIGH5000_asc1004','CRP_s70_chromosomal_cAMPHIGH5000_asc1004_prime'},...
    ...
    };

HUMANREADABLENAMESFORGROUPS = ...
    {...
    'WT, CRP',...
    'No FB, low',...    
    'No FB, med',...
    'No FB, high',...
    };

% Now also define the colors for these plots
fourcolors=linspecer(4);
morecolors=linspecer(10);
COLORSWITHIDENTIFIERS = {...
    fourcolors(1,:), ... {'WT_plasmids_ps70-GFP_asc841'}, ...
    fourcolors(2,:), ... {'WT_plasmids_pCRP-GFP_asc842'}, ...    
    fourcolors(2,:), ... {'dcAMP-extracell800-pCRP-GFP_asc893','dcAMP-extracell800-pCRP-GFP_asc894'},...
    fourcolors(2,:), ... {'dcAMP-extracell800-ps70-GFP_asc941'},...
    ...
};

%{
CUSTOMLIMITSPERPARAMGROUP = {...
    [NaN NaN    NaN NaN],... 0   2],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN]...
    };
    % {[xlim(1) xlim(2) ylim(1) ylim(2)], ...}
%}

%{
CUSTOMLIMITSPERPARAMGROUPCCS= {...
    [NaN NaN    -.4 .4],... [-10 10    -.4 .4],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN],...
    [NaN NaN    NaN NaN]...
    };
%}