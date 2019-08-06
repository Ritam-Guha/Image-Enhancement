function [population, fitness] = populationRank(population)
    numAgents = size(population,1);
    fitness = zeros(1,numAgents);
    
    for loop=1:numAgents
        fitness(1,loop) = evaluate(population(loop,:));
    end
    
    [fitness,index] = sort(fitness);
    population = population(index,:);
end