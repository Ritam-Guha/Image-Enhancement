function [sel] = rws(x)
    roulette=cumsum(x/sum(x));
    prob=rand;
    sel=size(find(roulette<prob),2)+1;
end