function normalized = NormalizePopulation1(InputArray)
%UNTITLED10 Summary of this function goes here
%normalize a gene between [0,1]
normalized1=(InputArray-mean(InputArray))/std(InputArray);
normalized=normalized1/4+0.5;
end

