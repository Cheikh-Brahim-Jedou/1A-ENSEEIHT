% fonction classification_MV (pour l'exercice 2)

function Y_pred_MV = classification_MV(X,mu_1,Sigma_1,mu_2,Sigma_2)
Vc1=modelisation_vraisemblance(X,mu_1,Sigma_1);
Vc2= modelisation_vraisemblance(X,mu_2,Sigma_2) ;
[,indice]=max(Vc1,Vc2,[],2);
Y_pred_MV= indice;
end
