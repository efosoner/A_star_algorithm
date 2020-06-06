function [ A,H ] = makegraph2(map)
    s = size(map);
    gsize=s(1)*s(2);
    A = zeros(gsize,gsize);
    H = zeros(gsize,gsize);
    for i = 1 : s(1)
        for j = 1 : s(2)
            if map(i,j) == 0
                continue;
            end
            vn = translator(i,j,s(2));
            if i > 1 
                vnup = translator(i-1,j,s(2));
                if map(i-1,j) > 0
                    A(vn, vnup) = 1;
                end
                if j > 1
                    vnleftup = translator(i-1,j-1,s(2));
                    if map(i-1,j-1) > 0
                        A(vn, vnleftup) = 1.44;
                    end
                end
                if j < s(2)
                    vnrightup = translator(i-1,j+1,s(2));
                    if map(i-1,j+1) > 0
                        A(vn, vnrightup) = 1.44;
                    end
                end
            end
            if i < s(1)
                vndown = translator(i+1,j,s(2));
                if map(i+1,j) > 0
                    A(vn, vndown) = 1;
                end
                if j > 1
                    vnleftdown = translator(i+1,j-1,s(2));
                    if map(i+1,j-1) > 0
                        A(vn, vnleftdown) = 1.44;
                    end
                end
                if j < s(2)
                    vnrightdown = translator(i+1,j+1,s(2));
                    if map(i+1,j+1) > 0
                        A(vn, vnrightdown) = 1.44;
                    end
                end
            end
            if j < s(2)
                vnright = translator(i,j+1,s(2));
                if map(i,j+1) > 0
                    A(vn, vnright) = 1;
                end
            end
            if j > 1
                vnleft = translator(i,j-1,s(2));
                if map(i,j-1) > 0
                    A(vn, vnleft) = 1;
                end
            end    
        end
    end
    for i=1:s(1)
        for j=1:s(2)
            for k=1:s(1)
                for l=1:s(2)
                   ij = translator(i,j,s(2));
                   kl = translator(k,l,s(2));
                   H(ij,kl) = sqrt((i-k)^2+(j-l)^2);
                end
            end
        end
    end
end

function [vertexnumber] = translator(i, j, size)
    vertexnumber = (i-1) * size + j;
end
