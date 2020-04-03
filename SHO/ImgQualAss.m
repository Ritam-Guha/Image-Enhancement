% function to assess the quality of the contrast enhancement in terms of PSNR and SSIM

function[]=ImgQualAss(groundTruthPath, outputImagePath)

        groundTruth=imread(groundTruthPath);
        enhancedImage=imread(outputImagePath);
        peaksnr=psnr(groundTruth,enhancedImage);
        ssimval=ssim(groundTruth,enhancedImage);
        fprintf('psnr-%0.4f\t ssim-%0.4f\n',peaksnr,ssimval);      
        
end
