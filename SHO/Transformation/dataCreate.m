% function to create random initial population

function [population] = dataCreate(numAgents, numIntensities)        
    rng('shuffle');
    alpha_l=0.01;
    alpha_u=10;
    beta_l=0.01;
    beta_u=10;
    population = zeros(numAgents, numIntensities);
    for loop =1:numAgents
        alpha = alpha_l+rand*(alpha_u-alpha_l);
        beta = beta_l+rand*(beta_u-beta_l);        
        population(loop,1) = alpha;
        population(loop,2) = beta;
    end        
end
