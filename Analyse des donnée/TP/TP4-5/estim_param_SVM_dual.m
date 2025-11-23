% fonction estim_param_SVM_dual (pour l'exercice 1)

function [X_VS,w,c,code_retour] = estim_param_SVM_dual(X,Y)

A = Y';
b=0 ;
beq=zeros(sizes(X,1),1) ;
f=-ones(sizes(X,1),1) ;
H=diag(Y)*(X*X')*diag(Y) ;
[alpha ,~ ,code_retour]= quadprog(H,f,[],[],A,b,beq,[]);
ind_alpha_positif=(alpha > 10^-6);
K=alpha(ind_alpha_positif);
X_VS=X(ind_alpha_positif , :);
Y_VS=Y(ind_alpha_positif );
h=X_VS.*Y_VS.K
w=sum()
end
