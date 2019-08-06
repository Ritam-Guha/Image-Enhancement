function [fitness] = evaluate(agent)
        
    agent = sort(agent);
    newImg = enhanceImage(agent);
    edgeImg=edge(newImg,'Canny');
    edgeImg=~edgeImg;
    stats=regionprops(~edgeImg,'BoundingBox','Area');
    [ccNo,~]=size(stats);
    [rows,cols] = size(newImg);

    gI=newImg;
    delH1=gI;
    for row=2:rows-1
        for col=2:cols-1
            delH1(row,col)=gI(row+1,col-1)+2*gI(row+1,col)+gI(row+1,col+1)-gI(row-1,col-1)-2*gI(row-1,col)-gI(row-1,col+1);
        end
    end

    gI=newImg;
    delV1=gI;
    for row=2:rows-1
        for col=2:cols-1
            delV1(row,col)=gI(row-1,col+1)+2*gI(row,col+1)+gI(row+1,col+1)-gI(row-1,col-1)-2*gI(row,col-1)-gI(row+1,col-1);
        end
    end

    EIX=0;
    for row=1:rows
        for col=1:cols
            s1=double(delH1(row,col)*delH1(row,col)+delV1(row,col)*delV1(row,col));
            if(s1~=0)                
                EIX=EIX+s1^.5;
            end
        end
    end
    if EIX ~=0
        fitness=log(log(EIX))*ccNo;    
    else
        fitness = 0;
    end
end