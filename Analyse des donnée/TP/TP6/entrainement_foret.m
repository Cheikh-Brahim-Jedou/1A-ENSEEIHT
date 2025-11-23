% fonction entrainement_foret (pour l'exercice 2)

function foret = entrainement_foret(X,Y,nb_arbres,proportion_individus)
 foret=cell(nb_arbre,1);
 [n_individus , n_variables]=size(X);
 for i = 1 : nb_arbres
     nb_individus_selectionnes=round(n_individus*proportion_individus);
     ind= randperm (n_indivudus,nb_individus_selectionnes);
     x_t=X(ind ,:);
     y_t=Y(ind);
     foret{i}=fitctree(x_t ,y_t );
 end
end