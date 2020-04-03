function [newImg] = enhanceImage(grayImg,finalAgent)    
  %  finalAgent = sort(finalAgent);    
    [rows,cols]=size(grayImg);
    newImg = grayImg;
    fprintf('values are = (%f,%f)\n',finalAgent(1),finalAgent(2));
    for row =1:rows
        for col=1:cols
            newImg(row,col)= floor(betainc(double(grayImg(row,col))/255,finalAgent(1),finalAgent(2))*255);    
        end
    end
    
end