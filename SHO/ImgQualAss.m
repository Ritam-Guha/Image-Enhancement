%%%% Colour image (RGB) quality assesment (S.K.Bera)
function[]=ImgQualAss(datasetName)


%         list={[1],[2],[3],[4],[1,2],[1,3],[1,4],[2,4],[3,4],[1,2,3],[1,2,4],[1,3,4],[2,3,4],[1,2,3,4]};
        list={[1,3]};
        avgPSNR(1,size(list,2))=0;
        avgSSIM(1,size(list,2))=0;
        bestList=[];
        bestOutcome=0;
        bestIndex=0;
        for i=1:size(list,2)
            curList=list{1,i};
            for loop=1:24
                if(loop<10)
                    curData=strcat(datasetName,'0',int2str(loop));

                else
                    curData=strcat(datasetName,int2str(loop));
                end
                inputImg=imread(strcat('Data/Ground Truth/',curData,'.png'));
                outputImg=imread(strcat('Results/Run_6/Final_',regexprep(num2str(curList), '  ', ','),'/enhanced_',curData,'.png'));
                peaksnr=psnr(inputImg,outputImg);
                ssimval=ssim(inputImg,outputImg);
                fprintf('%0.4f\t',peaksnr);
                fprintf('& %0.4f\n',ssimval);
                %snrVal=snr(double(outputImg),double(inputImg));
                avgPSNR(1,i)=avgPSNR(1,i)+peaksnr;
                avgSSIM(1,i)=avgSSIM(1,i)+ssimval;

                % visual information fidelity (VIF) of images
                %vif=vifvec(rgb2gray(inputImg),rgb2gray(outputImg));
                %fprintf('The VIF value is %0.4f.\n',vif);
            end
            avgPSNR(1,i)=avgPSNR(1,i)/24;
            avgSSIM(1,i)=avgSSIM(1,i)/24;
            fprintf('Average is -%0.4f \t',avgPSNR(1,i));
            fprintf('& %0.4f\n',avgSSIM(1,i));
            curOutcome=avgPSNR(1,i)+avgSSIM(1,i);
            if(curOutcome>bestOutcome)
                bestOutcome=curOutcome;
                bestList=curList;
                bestIndex=i;
            end
        end
        
        fprintf('best list-');
        disp(bestList);
        fprintf('avgPSNR-%f\n avgSSIM-%f\n',avgPSNR(1,bestIndex),avgSSIM(1,bestIndex));
        
  


    
    
    
%     avgPSNR=0;
%     avgSSIM=0;
%     curData='lena';
%     inputImg=imread(strcat('Data/',curData,'.png'));
%     outputImg=imread(strcat('Results/Without contrast/','enhanced_',curData,'.png'));
%     peaksnr=psnr(inputImg,outputImg);
%     ssimval=ssim(inputImg,outputImg);       
%     snrVal=snr(double(outputImg),double(inputImg));
%     
%     avgPSNR=avgPSNR+peaksnr;
%     avgSSIM=avgSSIM+ssimval;
%     fprintf('For lena:\navgPSNR-%0.4f\n',avgPSNR);
%     fprintf('avgSSIM-%0.4f\n',avgSSIM);
% Fidelity Criterion (IFC)
end
