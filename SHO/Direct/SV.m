% function to create survival values of both preys and predators

function [SV_h, SV_p] = SV(bfit,wfit,f_h,f_p)
    SV_h=(f_h-wfit)./(bfit-wfit);%element by element division
    SV_p=(f_p-wfit)./(bfit-wfit);
    %If the SV is nan or infinity it is set to 1 or 0; 
    SV_h(isnan(SV_h))=1;%index whose value is nan is set to 1
    SV_h(isinf(SV_h))=0;
    SV_p(isnan(SV_p))=1;
    SV_p(isinf(SV_p))=0;
end
