function [population] = dataCreate(numAgents, numIntensities)        
    population = zeros(numAgents, numIntensities);
    for loop =1:size(numAgents,1)
        random = rand(1,255);
        [~, index] = sort(random);        
        population(loop,:) = sort(index(1,1:numIntensities));
    end    
end