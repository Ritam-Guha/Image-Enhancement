function [population] = dataCreate(numAgents, numIntensities)        
    rng('shuffle');
    population = zeros(numAgents, numIntensities);
    for loop =1:numAgents
        random = rand(1,256);
        [~, index] = sort(random);        
        population(loop,:) = sort(index(1,1:numIntensities));
    end        
end