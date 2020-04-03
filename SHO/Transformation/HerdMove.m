
% function guiding the movement of the selfish herds

function [H] = HerdMove(H,SV_h,P,SV_p,xbest,n,xl,xu)
    scale=abs(xu-xl);
    hL_idx=find(SV_h == max(SV_h));
    if size(hL_idx,1) > 1
        hL_idx=hL_idx(randi([1,size(hL_idx,1)]));
    end
    HF_idx=find(1:size(H,1)~=hL_idx);
    SV_mean=mean(SV_h);
    SV_h_wgt=repmat(SV_h,[1,n]);
    h_M=sum(SV_h_wgt.*H)./(sum(SV_h_wgt)+.00001);%adding .00001 so that division doesnt become undefined
    SV_p_wgth=repmat(SV_p,[1,n]);
    p_M=sum(SV_p_wgth.*P)./(sum(SV_p_wgth)+.00001);
%% Herd Leader's Movement Operators
    h_L=H(hL_idx,:);
    if SV_h(hL_idx)==1
        %Seemingly Cooperative Leadership Movement
        v_bi=double(p_M-h_L);
        r_bi=sqrt(sum(v_bi.^2,2))./scale;
        W_L=exp(-r_bi^2);
        move_L=-2*W_L*(v_bi);
    else
        %Selfish movement
        v_bi=xbest-h_L;
        r_bi=sqrt(sum(v_bi.^2,2))./scale;
        W_L=exp(-r_bi^2);
        move_L=2*W_L*(v_bi);
    end
    alpha=rand(1,n);
    H(hL_idx,:)=H(hL_idx,:)+alpha.*move_L;
    
%% Herd Members Movement Operators                                                  
    for i = HF_idx
        if SV_h(i)>=rand
        % Apply Herd Following Members Movement Operators
            if SV_h(i)>SV_mean
            % Apply Nearest Neighbor Movement Rule
                HF_idx=find(SV_h(HF_idx)>SV_h(i));
                if isempty(HF_idx)
                    move_iCi=zeros(1,n);
                else
                    v_bi=H(HF_idx,:)-repmat(H(i,:),[size(HF_idx,1),1]);
                    r_bi=sqrt(sum(v_bi.^2,2))./scale;
                    Ci_idx=find(r_bi == min(r_bi));
                    if size(Ci_idx,1)>1
                        Ci_idx=Ci_idx(randi([1,size(Ci_idx,1)]));
                    end
                    h_Ci=H(HF_idx(Ci_idx),:);
                    W_iCi=SV_h(HF_idx(Ci_idx))*exp(-(r_bi(Ci_idx).^2));
                    move_iCi=W_iCi*(h_Ci-H(i,:));
                end
                r_iL=norm(h_L-H(i,:))./scale;
                W_iL=SV_h(hL_idx)*exp(-(r_iL.^2));
                move_iL=W_iL*(h_L-H(i,:));
                beta=rand(1,n);
                gamma=rand(1,n);
                H(i,:)=H(i,:)+2*(beta.*move_iL+gamma.*move_iCi);
            else
                %Apply Local Crowded Horizon Movement Rule
                delta=rand(1,n);
                move_iM=(h_M-H(i,:));
                H(i,:)=H(i,:)+2*delta.*move_iM;
            end
        else
            %Applying Herd Desertion Movement
            V=randn(1,n);
            v_i=(V./sqrt(V*V'))/scale;
            W_rand=(1-SV_h(i));
            rand_move=W_rand*v_i;
            v_bi=xbest-H(i,:);
            r_bi=sqrt(sum(v_bi.^2,2))./scale;
            W_dp=exp(-r_bi^2);
            move_bi=W_dp*(v_bi);
            beta=rand(1,n);
            gamma=rand(1,n);
            H(i,:)=H(i,:)+2*(beta.*move_bi+gamma.*rand_move);
        end
    end
    H(H<xl)=xl;
    H(H>xu)=xu;
end
