% function to form the new enhanced image based on the optimized intenstiy values

function [newImg] = enhanceImage(finalAgent)
    
    global grayImg baseAgent
    finalAgent = sort(finalAgent);    
    [rows,cols]=size(grayImg);
    newImg = grayImg;
    for row =1:rows
        for col=1:cols
            index = find(baseAgent==grayImg(row,col),1);    
            newImg(row,col) = finalAgent(1,index);            
        end
    end
    
end
