clear all;clc;clf;

start = 1;
stop = 47;
nodes = 400;

distance = Inf(1, nodes);
distance(start) = 0;

open = zeros(0);
open(1) = start;
close = zeros(0);
path = zeros(0);
watched = zeros(0);
previous = zeros(1, nodes);
previous(start) = Inf; 

map = imread('map.bmp');                        
load seed.mat;       
map = map+map.*rand(20);
[A,H] = makegraph2(map);
G = graph(A);
counter = 0;
disp(map)

while (true)
    counter = counter + 1;
    minIndex = open(1);
    min = distance(minIndex) + H(minIndex, stop);
    
    for i = 2 : size(open, 2)
        if min > distance(open(i)) + H(open(i), stop)
            min = distance(open(i)) + H(open(i), stop);
            minIndex = open(i);
        end
    end
    watched = [watched minIndex];
    if minIndex == stop
        break;
    end
    open = open(find(open~=minIndex));
    close = [close minIndex];
    
    for i = 1 : nodes
        if A(minIndex, i) == 0 && A(i, minIndex) == 0
            continue;
        end
        if ismember(i, close)
            continue;
        end
        weight = max(A(minIndex, i), A(i, minIndex));
        tempDist = distance(minIndex) + weight;
        open = [open i];
        if tempDist < distance(i)
            distance(i) = tempDist;
            previous(i) = minIndex;
        end
    end
end

currentVertex = stop;

while (true)
    disp(currentVertex)
    path = [path currentVertex];
    currentVertex = previous(currentVertex);
    if isinf(currentVertex)
        break;
    end
end

disp(path)

