% This code runs the LMVSC algorithm on Caltech7 dataset and records its
% performance. The results are output in *.txt format.

% Notice: The dataset is organized in a cell array with each element being
% a view. Each view is represented by a matrix, each row of which is a
% sample.

% The core of LMVSC is encapsulated in an independent matlab function.
% Visit lmv.m directly, if you want to learn the details of its
% implementation.

clear;

addpath('./datasets');
load('Caltech101-7.mat');

X=data;
y=labels;

nv=length(X);
    
ns=length(unique(y));

% Parameter 1: number of anchors (tunable)
numanchor=[ns 50 100];

% Parameter 2: alpha (tunable)
alpha=[.01 1 100];

for j=1:length(numanchor)
    
    % Perform K-Means on each view
    parfor i=1:nv
        rand('twister',5489);
        [~, H{i}] = litekmeans(X{i},numanchor(j),'MaxIter', 100,'Replicates',10);
    end

    for i=1:length(alpha)
        fprintf('params:\tnumanchor=%d\t\talpha=%f\n',numanchor(j),alpha(i));
        tic;
        
        % Core part of this code (LMVSC)
        [F,ids] = lmv(X',y,H,alpha(i));
        
        % Performance evaluation of clustering result
        result=ClusteringMeasure(ids,y);
        
        t=toc;
        fprintf('result:\t%12.6f %12.6f %12.6f %12.6f\n',[result t]);
        
        % Write the evaluation results to a text file
        dlmwrite('Caltech.txt',[alpha(i) numanchor(j) result t],'-append','delimiter','\t','newline','pc');
        
    end
end