% fonction estim_param_vraisemblance (pour l'exercice 1)

function [mu,Sigma] = estim_param_vraisemblance(X)
r= mean(X(:,1));
v= mean(X(:,2));
mu=(r,v);
Xe=X-repmat(mu,2);
Sigma=1/2*Xe*Xe';


end