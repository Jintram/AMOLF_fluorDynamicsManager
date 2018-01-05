%% Make a list of the parameters we've got data for
%
% Output:
% parameterOfInterestList

parameterOfInterestList = {};

% 
muFieldName = ourSettings.muFieldName;
parameterOfInterestList{end+1} = muFieldName;

% Put fluor values in cell
fluorValues = {ourSettings.fluor1, ourSettings.fluor2, ourSettings.fluor3};
% nr fluor colors is # of fluor values that do not match 'none'
nrFluorColors = sum(cellfun(@(c) ~strcmp(lower(c),'none'), fluorValues));

parameterOfInterestDoubleCombinatorialList={};
for fluorIdx = 1:nrFluorColors
    
    currentFluor=fluorValues{fluorIdx};
    
    currentFluorFieldName = strrep(ourSettings.fluorFieldName,'X',upper(currentFluor));
    currentRateFieldName  = strrep(ourSettings.fluorDerivativeFieldName,'X',upper(currentFluor));
    
    % Now create the entrances for parameters that relate to fluor
    % measurements   
    parameterOfInterestList{end+1} = currentFluorFieldName;
    parameterOfInterestList{end+1} = currentRateFieldName;
    
    % ==============
    % Also create a 2nd list of combinations of the params (for cross-correlations)
    % This needs to repeat the procedure followed in the schnitzcells
    % masterscript. 
    
    % R(concentration, growth)
    parameterOfInterestDoubleCombinatorialList{end+1} = ...        
        [currentFluorFieldName '_' muFieldName];
    
    % R(rate, growth)
    parameterOfInterestDoubleCombinatorialList{end+1} = ...
        [currentRateFieldName '_' muFieldName];
    
    % R(Y, Y), i.e. autocorrelation functions, order: mu, C, p.
    parameterOfInterestDoubleCombinatorialList{end+1} = ...
        [muFieldName '_' muFieldName];
    parameterOfInterestDoubleCombinatorialList{end+1} = ...
        [currentFluorFieldName '_' currentFluorFieldName];
    parameterOfInterestDoubleCombinatorialList{end+1} = ...
        [currentRateFieldName '_' currentRateFieldName];
    
    % R(prod, E)
    parameterOfInterestDoubleCombinatorialList{end+1} = ...   
        [currentRateFieldName '_' currentFluorFieldName];
    
    % Fluors against each other
    for fluorIdx2 = (fluorIdx+1):nrFluorColors
        
        % Fetch 2nd fluor
        currentFluor2=fluorValues{fluorIdx2};
        currentFluorFieldName2 = strrep(ourSettings.fluorFieldName,'X',upper(currentFluor2));
        currentRateFieldName2  = strrep(ourSettings.fluorDerivativeFieldName,'X',upper(currentFluor2));
            
        % R(C_i,C_j)
        parameterOfInterestDoubleCombinatorialList{end+1} = ...
            [currentFluorFieldName '_' currentFluorFieldName2];
        
        % R(p_i,p_j)
        parameterOfInterestDoubleCombinatorialList{end+1} = ...
            [currentRateFieldName '_' currentRateFieldName2];
    end
    % ==============
    
end    
   

for fluorIdx = 1:nrFluorColors
    
    

end
    %{
parameterOfInterestDoubleCombinatorialList={};
for ii = 1:numel(parameterOfInterestList)
    for jj = (ii)+1:numel(parameterOfInterestList)
        
        parameterOfInterestDoubleCombinatorialList{end+1} = ...
            
        
    end
end
%}