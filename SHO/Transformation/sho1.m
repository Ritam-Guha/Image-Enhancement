function [finalImg,xbest] = sho1(inputImg,N,iter,f,list) % n-no of population,iter-no of iterations, f-fitness function
    close all
    
    global grayImg
    numAgents=N; %population size
    grayImg = inputImg;
    xl=0;
    xu=10;

    A = dataCreate(numAgents,2);
    %A = A-1;
        
    %n=numIntensities;%number of dimension or features
    n=2;
    %A=randi([1,256],N,n);% initiallizing the total population with random values between the lower and upper bound
    rate=0.7+(0.2)*rand;         
    N_h=round(N*rate);                                                
    N_p=N-N_h;
    
    H=A(1:N_h,:);  %herd members                                                   
    f_h=zeros(N_h,1);                                                 
    for ind=1:N_h                                                    
        f_h(ind)=f(H(ind,:),list);                                         
    end 
    
    P=A(N_h+1:N,:);    %predators                                               
    f_p=zeros(N_p,1);                                                 
    for ind=1:N_p                                                     
        f_p(ind)=f(P(ind,:),list);                                             
    end                                                                 
    %setting global variables
    fit=[f_h;f_p];    %stores fitness values of all poplation                                                
    [~,b_idx]=max(fit);     %gives index with minimum fitness                                              
    xbest=A(b_idx,:);   %best individual                                                  
    bfit=fit(b_idx);   %best fitness value                              
    [~,w_idx]=min(fit);                                               
    wfit=fit(w_idx);    %worst fitness value
    
    [SV_h, SV_p]=SV(bfit, wfit, f_h, f_p);      % Calculating SV for herd and predator    
 
    for it=1:iter   
        H= HerdMove(H,SV_h,P,SV_p,xbest,n,xl,xu);  
        P=PredMove(P,H,SV_h,n,xl,xu);
        
        %%  Updating survival values of herd and predator
        for i=1:N_h                                                                 
            f_h(i)=f(H(i,:),list);                                                           
        end                                                                         
        for i=1:N_p                                                                 
            f_p(i)=f(P(i,:),list);                                                       
        end
        [SV_h, SV_p]=SV(bfit,wfit,f_h,f_p);
        %%
        [L_idx, K_idx]=Predation(P,H,SV_p,SV_h,n);
        
        %% Herd Restoration
        if any(K_idx)                                                               
            [H,f_h]=Restoration(H,f_h,SV_h,L_idx,K_idx,n,f,list);     % Replace killed prey with a new one
            [SV_h,SV_p]=SV(bfit,wfit,f_h,f_p);    % Updating survival values due to the chnage of her members
        end
        
        %% updating global variables
        A=[H; P];                                                                 
        fit=[f_h; f_p];                                                           
        [~,b_idx]=max(fit);                                                       
        gbest_th=A(b_idx,:);                                                        
        bfit_th=fit(b_idx);                                                               
        if bfit_th>=bfit                                                            
            bfit=bfit_th;                                                               
            xbest=gbest_th;                                                             
        end                                                                         
        [~,w_idx]=min(fit);                                                       
        wfit_th=fit(w_idx);                                                         
        if wfit_th <= wfit                                                            
            wfit=wfit_th;                                                               
        end
        fprintf('fitness-%f\n',bfit_th); 
    end
    %err=(bfit);%error w.r.t to zero (actual minima)
    finalImg = enhanceImage(xbest);
end
% Sho ends