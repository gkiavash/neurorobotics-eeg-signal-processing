function [Higuchi,output_lnLk] = featuresExtraction2(segments,klin,kmax)
% Function for feature extraction
%
% INPUTS:
% segments: matrix of dimensions NxM where N is the
% number of segments and M the length of the segments.
%
% OUTPUTS:
% features vector (one feature for each segment)

if nargin<2
    kmax = 18;
    klin = 6;
end
    
    Higuchi = NaN(size(segments,1),1);
    
    for n = 1 : size(segments,1)
        [~,lnk,lnLk] = hfd(segments(n,:),kmax);
        
        % linear fit
        p = polyfit(lnk(1:klin),lnLk(1:klin),1);
        y = p(1)*lnk*p(2);
        
        % Higuchi Fractal Dimension
        Higuchi(n) = p(1);
        
        % Length
        output_lnLk(n,:) = lnLk;
    
    end
    
end

