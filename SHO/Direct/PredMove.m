function [P] = PredMove(P,H,SV_h,n,xl,xu)
    for i = 1:size(P,1)
        move=(H(rws((1-SV_h)'),:)-P(i,:));
        omega=rand(1,n);
        P(i,:)=P(i,:)+2*(omega.*move);  % update Predator's position
    end
    P(P<xl)=xl;
    P(P>xu)=xu;
end