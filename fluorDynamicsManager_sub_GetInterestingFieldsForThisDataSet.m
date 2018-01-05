%% Make a list of the parameters we've got data for
%
% Output:
% parameterOfInterestList

parameterOfInterestList = {};

% 
parameterOfInterestList{end+1} = ourSettings.muFieldName

% Put fluor values in cell
fluorValues = {ourSettings.fluor1, ourSettings.fluor2, ourSettings.fluor3};
% nr fluor colors is # of fluor values that do not match 'none'
nrFluorColors = sum(cellfun(@(c) ~strcmp(lower(c),'none'), fluorValues));

for fluorIdx = 1:nrFluorColors
    
    currentFluor=fluorValues{fluorIdx};       
    
    parameterOfInterestList{end+1} = strrep(ourSettings.fluorFieldName,'X',upper(currentFluor));
    parameterOfInterestList{end+1} = strrep(ourSettings.fluorDerivativeFieldName,'X',upper(currentFluor));
    
end    
   
