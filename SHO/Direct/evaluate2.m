function [fitness] = evaluate(agent)
    
    global grayImg;
    agent = sort(agent);
    newImg = enhanceImage(agent);    
    edgeImg=edge(newImg,'Canny');    
    logSumIntensity=getLogSumIntensity(newImg,edgeImg);
    edgeSum=getEdgeSum(edgeImg);
    imgEntropy=getEntropy(newImg);
    dissimilarity=getDissimilarity(grayImg,newImg);        
    contrast=getContrastValue(newImg);
    intensityDif=getIntensityDif(newImg);
%     fprintf('sumInten-%f edgeSum-%f entropy-%f intensityDif-%f contrast-%f\n',logSumIntensity,edgeSum,imgEntropy,intensityDif,contrast);
    fitness=(logSumIntensity*edgeSum*imgEntropy*intensityDif);  

    
end
%added contrast (from std. deviation)
function [val]=getContrastValue(newImg)
    B=1/numel(newImg)*sum(newImg(:));
    val=sqrt(1/numel(newImg)*sum(power((newImg(:)-B),2)));
end

function [val]=getLogSumIntensity(newImg,edgeImg)
    val=sum(sum(newImg(edgeImg==1)));    
    val=log(log(val));
end

function [val]=getEdgeSum(edgeImg)
    [rows,cols]=size(edgeImg);
    numPixels=rows*cols;
    val=sum(sum(edgeImg))/numPixels;
end

function [val]=getEntropy(newImg)
    val=entropy(newImg);
end

function [val]=getDissimilarity(grayImg,newImg)
    grayImgTemp=double(reshape(grayImg,[1,size(grayImg,1)*size(grayImg,2)]));
    newImgTemp=double(reshape(newImg,[1,size(newImg,1)*size(newImg,2)]));    
    covMat=cov(grayImgTemp,newImgTemp);
    sigmaXY=covMat(1,2);
    Xmean=mean(grayImgTemp);
    Ymean=mean(newImgTemp);
    varX=covMat(1,1);
    varY=covMat(2,2);
    numerator = 4 * sigmaXY * Xmean * Ymean;
    denominator = (varX^2 + varY^2)*(Xmean^2 + Ymean^2);
    val=numerator/denominator;
end

function [val]=getIntensityDif(newImg)
    curImg=zeros(size(newImg));
    for loop1=1:size(newImg,1)
        for loop2=1:size(newImg,2)
            curImg(loop1,loop2)=newImg(loop1,loop2);
        end
    end
    val1=mean(mean(curImg));
    val2=mean(mean(curImg.*curImg));
    val=val2-(val1^2);
end



