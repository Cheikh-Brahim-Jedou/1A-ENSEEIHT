% fonction prediction_kmoyennes (pour l'exercice 1)

function Y_pred = prediction_kmoyennes(X,k)

    % x est une matrice de données (chaque ligne est un point de données, chaque colonne est une caractéristique)
    % k est le nombre de clusters que tu veux former

    % Utilisation de la fonction kmeans de MATLAB pour appliquer l'algorithme des k-moyennes
    [Y_pred, ~] = kmeans(X, k, 'MaxIter', 1000); % Y_pred contient les indices des clusters

end