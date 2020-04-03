function [L_idx,K_idx] = Predation(P,H,SV_p,SV_h,n)
    R=(sum(max(H)-min(H))*0.5)/n;
    L_idx=(1:size(H,1))';
    K_idx=[];
    K_count=0;
    for i = 1:size(P,1)
        Weak_idx=L_idx(SV_h(L_idx)<SV_p(i));
        if isempty(Weak_idx) ~= 1
            v_ij=H(Weak_idx,:)-repmat(P(i,:),[size(Weak_idx,1),1]);
            r_ij=sqrt(sum(v_ij.^2,2));
            Tpi_idx=find(r_ij<R);
            if isempty(Tpi_idx)~= 1
                H_pihi=(1-SV_h(Weak_idx(Tpi_idx))).*exp(-(r_ij(Tpi_idx).^2));
                target=rws(H_pihi');            
                K_count=K_count+1;
                K_idx(K_count,1)=Weak_idx(target);
                L_idx=L_idx(ismember(L_idx,K_idx(K_count,1))==0);
            end
        end
    end
end