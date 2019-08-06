function[] = main(datasetName,typeImg,numAgents,numIteration)
    filePath = strcat('Data/',datasetName,'.',typeImg);
    rgbImg = imread(filePath);
    finalImg = rgbImg;
    
    rImg = rgbImg(:,:,1);
    gImg = rgbImg(:,:,2);
    bImg = rgbImg(:,:,3);    
    
    rEnhanced = GA(rImg,numAgents,numIteration);
    gEnhanced = GA(gImg,numAgents,numIteration);
    bEnhanced = GA(bImg,numAgents,numIteration);
    
    finalImg(:,:,1) = rEnhanced;
    finalImg(:,:,2) = gEnhanced;
    finalImg(:,:,3) = bEnhanced;
    
    figure, imshow(rgbImg);
    figure, imshow(finalImg);
    
    saveFile = strcat('Results/',datasetName,'/finalImg.mat');
    save(saveFile,'finalImg');
end