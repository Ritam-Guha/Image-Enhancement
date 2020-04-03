function [fitness] = Ackley(agent,list)
    global grayImg;
  %  agent = sort(agent);
    newImg = enhanceImage(agent);    
    edgeImg=edge(newImg,'Canny');    
    logSumIntensity=getLogSumIntensity(newImg,edgeImg);
    edgeSum=getEdgeSum(edgeImg);
    imgEntropy=getEntropy(newImg);
    dissimilarity=getDissimilarity(grayImg,newImg);
    %contrast=getContrastValue(newImg);
    %intensityDif=getIntensityDif(newImg);
    fitness=1;
    for i=1:length(list)
        if list(i) == 1
            fitness=fitness*logSumIntensity;
            fprintf('sumInten-%f ',logSumIntensity);
        elseif list(i)==2
            fitness=fitness*edgeSum;
            fprintf('edgeSum-%f ',edgeSum);
        elseif list(i)==3
            fitness=fitness*imgEntropy;
            fprintf('imgEntropy-%f ',imgEntropy);
        else
            fitness=fitness*dissimilarity;
            fprintf('dissimilarity-%f ',dissimilarity);
        end
        fprintf('\n');
    end
    %fprintf('sumInten-%f edgeSum-%f entropy-%f dissimilarity-%f\n',logSumIntensity,edgeSum,imgEntropy,dissimilarity);
    %fitness=(logSumIntensity*edgeSum*imgEntropy*dissimilarity);
    % X intensityDif, X contrast
end

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