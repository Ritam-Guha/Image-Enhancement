function [finalImg] = GA(inputImg,numAgents,numIteration)    
    
    global baseAgent grayImg
    
    grayImg = inputImg;    
    baseAgent=unique(grayImg)';         
    numIntensities = size(baseAgent,2);
    population = dataCreate(numAgents,numIntensities);
    fitness = zeros(1,numAgents);
    probC = 0.5;
    probM = 0.5;
    
    for loop =1:numIteration        
        [population,fitness] = populationRank(population);
        [population] = crossoverMutation(population,fitness,probC,probM);        
    end
    [population,fitness] = populationRank(population);
    finalImg = enhanceImage(population(1,:));    
end

