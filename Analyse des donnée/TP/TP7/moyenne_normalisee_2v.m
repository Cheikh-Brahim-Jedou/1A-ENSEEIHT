% fonction moyenne_normalisee_2v (pour l'exercice 1)

function x = moyenne_normalisee_2v(I)
    
    
    [rows, cols, ~] = size(I); % On obtient la taille de l'image (nombre de lignes et colonnes)
    
    I = double(I); % On convertit l'image en type double pour effectuer les calculs
    
    % On extrait les canaux de couleur (R, V, B) de l'image
    r = I(:,:,1); % Canal rouge
    g = I(:,:,2); % Canal vert
    b = I(:,:,3); % Canal bleu

    % Normalisation des niveaux de couleur pour chaque pixel
    % Le dénominateur est max(1, R + V + B), calculé pixel par pixel
    denom = max(1, r + g + b);
    
    % r_norm est la version normalisée du rouge : r / (R+V+B)
    r_norm = r ./ denom;
    
    % b_norm est la version normalisée du bleu : b / (R+V+B)
    b_norm = b ./ denom;

    % Calculer la moyenne de chaque canal normalisé
    moyenne_r = mean(r_norm(:)); % Moyenne des valeurs rouge normalisé sur tous les pixels
    moyenne_b = mean(b_norm(:)); % Moyenne des valeurs bleu normalisé sur tous les pixels

    % Renvoi du vecteur 2D (moyenne_r, moyenne_b)
    x = [moyenne_r, moyenne_b];
end

