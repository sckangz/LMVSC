function [U,labels] = lmv(X,y,H,alpha)
nv=size(X,2);
num=size(X{1},1);
[r,~]=size(H{1});
k=length(unique(y));


Sbar=[];
options = optimset( 'Algorithm','interior-point-convex','Display','off');
for j=1:nv
A=2*alpha*eye(r)+2*H{j}*H{j}';
        A=(A+A')/2;
        B=X{j}';
parfor ji=1:num
     ff=-2*B(:,ji)'*H{j}';
Z(:,ji)=quadprog(A,ff',[],[],ones(1,r),1,zeros(r,1),ones(r,1),[],options);
end
S{j}=Z;
    Sbar=cat(1,Sbar,1/sqrt(nv)*S{j});
%  f(j)=(norm(X{j}'-H{j}'*S{j},'fro'))^2+alpha*(norm(S{j},'fro'))^2;
end
% for ji=1:nv
%     f(ji)/sum(f)
%      Sbar=cat(1,Sbar,1/sqrt(nv)*S{ji}/f(ji));
% end

[U,Sig,V] = mySVD(Sbar',k); 

rand('twister',5489)
labels=litekmeans(U, k, 'MaxIter', 100,'Replicates',10);%kmeans(U, c, 'emptyaction', 'singleton', 'replicates', 100, 'display', 'off');