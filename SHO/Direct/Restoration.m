% function to restore killed preys according to the flow of SHO

function [H, f_h] = Restoration(H,f_h,SV_h,L_idx,K_idx,n,f,list)
    alive_H=H(L_idx,:);
    alive_SVh=SV_h(L_idx); 
    for i=1:size(K_idx,1)
        for gen=1:n
            pose_i=rws(alive_SVh');
            new_h_aux(1,gen)=alive_H(pose_i,gen);
        end
        new_h(i,:)=new_h_aux(randperm(length(new_h_aux)));
        new_fh(i)=f(new_h(i,:),list);           
    end
    H(K_idx,:)=new_h;
    f_h(K_idx)=new_fh;
end
