% function ACP (pour exercice_2.m)

function [C,bornes_C,coefficients_RVG2gris] = ACP(X)
r= mean(X(:,1));
v= mean(X(:,2));
b= mean(X(:,3));
x=[r,v,b];
[nombre_ligne , nombre_colonne]=size(X);

Xe=X-repmat(x',nombre_ligne,1);
sigma=1/3*Xe'*Xe;
[W,D]=eig(sigma);
[valeur_propre_trier,indice]=sort(diag(D),'descend');
W_trier=W(:,indice);
C=X*W_trier;
bornes_C=[min(C,'all'),max(C,'all')];
coefficients_RVG2gris=W_trier(:,1)/norm(W_trier(:,1),1);

    
end
