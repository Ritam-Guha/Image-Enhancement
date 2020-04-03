

function[] = main(datasetName,typeImg,numAgents,numIteration,list,count)
    filePath = strcat('Data/Input Image/',datasetName,'.',typeImg);
    rgbImg = (imread(filePath));
    finalImg = rgbImg;
    
    
    I = rgb2gray(rgbImg);
    
	[iEnhanced,x]= sho1(I,numAgents,numIteration,@Ackley,list);
    rI = rgbImg(:,:,1);
    gI = rgbImg(:,:,2);
    bI = rgbImg(:,:,3);
    
	r=enhanceImage(rI,x);
    g=enhanceImage(gI,x);
    b=enhanceImage(bI,x);
	
    finalI(:,:,1) = r;
    finalI(:,:,2) = g;
    finalI(:,:,3) = b;

    saveFile = strcat('Results/Run_',int2str(count),'/Final_',regexprep(num2str(list), '  ', ','),'/enhanced_',datasetName,'.png');
    imwrite(finalI,saveFile);
end
