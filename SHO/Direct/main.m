 % datasetName: Name of the input image
 % typeImg: Extension of the image(.png/.jpg/.jpeg)
 % numAgents: population size
 % numIteration: num of generations
 % list: list of image parameters to be used for fitness function (log sum intensity-1, edge count-2, image entropy-3, dissimilarity-4)
 % count: count of the current run
    
function[] = main(datasetName,typeImg,numAgents,numIteration,list,count)    
    
    filePath = strcat('Data/Input Image/',datasetName,'.',typeImg);
    rgbImg = (imread(filePath));
    finalImg = rgbImg;
    
    rImg = rgbImg(:,:,1);
    gImg = rgbImg(:,:,2);
    bImg = rgbImg(:,:,3);
    
    rEnhanced = sho1(rImg,numAgents,numIteration,@Ackley,list);
    gEnhanced = sho1(gImg,numAgents,numIteration,@Ackley,list);
    bEnhanced = sho1(bImg,numAgents,numIteration,@Ackley,list);
    
    finalImg(:,:,1) = rEnhanced;
    finalImg(:,:,2) = gEnhanced;
    finalImg(:,:,3) = bEnhanced;
    
    figure, imshow(rgbImg);
    figure, imshow(finalImg);
    
    saveFile = strcat('Results/Run_',int2str(count),'/Final_',regexprep(num2str(list), '  ', ','),'/enhanced_',datasetName,'.png');
    imwrite(finalImg,saveFile);
end
