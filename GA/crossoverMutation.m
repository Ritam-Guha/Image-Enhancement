function [population] = crossoverMutation(population,fitness,probC,probM)    
    
    [rows,cols] = size(population);
    if cols==1
        return;
    end
    
    rankcs = zeros(1,rows);
    for loop1=1:(rows/2)        
        for loop2 = 1:rows
            rankcs(1,loop2)=1./(fitness(1,loop2)+1);
        end
        
        for loop2= 2:rows
            rankcs(1,loop2)=fitness(1,loop2)+rankcs(1,loop2-1);
        end
        maxcs=rankcs(1,rows);
        for loop2= 1:rows
            rankcs(1,loop2)=rankcs(1,loop2)/maxcs;
        end
        
        firstParentIndex=find(rankcs>rand(1),1,'first');
        secondParentIndex=find(rankcs>rand(1),1,'first');

        newPopulation = zeros(2,cols);        
        newPopulation(1,:) = population(firstParentIndex,:);
        newPopulation(2,:) = population(secondParentIndex,:);       
        
        for loop2 = 1:cols
            if(probC>rand)
                temp = newPopulation(1,loop2);
                newPopulation(1,loop2) = newPopulation(2,loop2);
                newPopulation(2,loop2) = temp;
            end
        end        
        
        for loop2 = 1:cols
            if(probM>rand)
                if (loop2==1)
                    newPopulation(1,loop2) =min(floor(rand*newPopulation(1,loop2+1)),255);
                elseif (loop2==cols)
                    newPopulation(1,loop2)=min(floor(rand*(255-newPopulation(1,loop2-1))+newPopulation(1,loop2-1)),255);
                else
                    newPopulation(1,loop2) = min(floor(rand*(newPopulation(1,loop2+1)-newPopulation(1,loop2-1)) + newPopulation(1,loop2-1)),255);
                end
                newPopulation(1,loop2) = min(floor(newPopulation(1,loop2) + (2*rand -1) * 10),255); % allow for peturbation
            end            
        end

        [newPopulation, newFitness] = populationRank(newPopulation);
        index1 = 0;
        index2 = 0;
        
        for loop2=1:rows
            if(newFitness(1,1)>fitness(1,loop2))
                index1 = loop2;
                break;
            end
        end
        
        for loop2 = index1+1:rows
            if(newFitness(1,1)>fitness(1,loop2))
                index2 = loop2;
                break;
            end
        end
        
        if index1~=0
            population(index1,:) = newPopulation(1,:);            
        end
        if index2~=0
            population(index2,:) = newPopulation(2,:);                    
        end
        
        
    end
end