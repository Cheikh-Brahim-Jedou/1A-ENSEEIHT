% fonction modelisation_vraisemblance (pour l'exercice 1)

function modele_V = modelisation_vraisemblance(X,mu,Sigma)

Xc= X-repmat(mu,size(X,1),1);
modele_V=Zeros(size(X,1) ,1) ;
for i=1..size(X,1)
    modele_V(i)=((1/2*pi)^(size(X,2)))*(sqrt(det(Sigma))))*exp(-(1/2)*Xc(i,:)*(inverse(Sigma)*Xc(i,:)')
end
