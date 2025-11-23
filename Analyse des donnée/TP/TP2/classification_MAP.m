% fonction classification_MAP (pour l'exercice 3)

function Y_pred_MAP = classification_MAP(X,p1,mu_1,Sigma_1,mu_2,Sigma_2)

Vc1=modelisation_vraisemblance(X,mu_1,Sigma_1);
Vc2=modelisation_vraisemblance(X,mu_2,Sigma_2); 
[~ , Y_pred_MAP]= max([p1*Vc1 , (1-p1)*Vc2] , [],2) ;
end
