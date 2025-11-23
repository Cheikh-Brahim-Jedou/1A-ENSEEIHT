% fonction classification_SVM (pour l'exercice 1)

function Y_pred = classification_SVM(X,w,c)

A=zeros(length(X),1)
for i=1..length(X)
    Y_pred(i)=signe(w'X(i,:)-c)
end