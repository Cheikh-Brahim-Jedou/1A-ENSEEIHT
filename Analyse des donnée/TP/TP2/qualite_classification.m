% fonction qualite_classification (pour l'exercice 2)

function [pourcentage_bonnes_classifications_total,pourcentage_bonnes_classifications_fibrome, ...
          pourcentage_bonnes_classifications_melanome] = qualite_classification(Y_pred,Y)
nb_fibromes_totaux=sum(Y==1);
pourcentage_bonnes_classifications_fibrome=(sum(Y_pred==1&Y==1)/nb_fibromes_totaux)*100 ;
nb_melanome_totaux=sum(y~=1) ;
pourcentage_bonnes_classifications_melanome=(sum(Y_pred~=1&Y~=1))/nb_melanome_totaux/100

end