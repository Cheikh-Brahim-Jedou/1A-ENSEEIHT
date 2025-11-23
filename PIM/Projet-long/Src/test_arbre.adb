with arbre ;    use arbre ;


procedure Test_arbre is

   Arb_1 : T_Arb;
   Arb_2 : T_Arb;
   Arb_3 : T_Arb;
   Arb_4 : T_Arb;
   Arb_12 : T_Arb;
   Arb_Final : T_Arb;

   a : Constant T_Octet := 165 ;
   b : Constant T_Octet := 123 ;
   T : T_Tab_str ;
begin
   T.long := 0 ;
   Initialiser_A(Arb_1) ;
   Initialiser_A(Arb_2) ;
   Initialiser_A(Arb_3) ;
   Initialiser_A(Arb_4) ;
   Ajouter(Arb_1, a , 100);
   Ajouter(Arb_2, b ,200);
   Ajouter(Arb_3, b ,200);
   Ajouter(Arb_4, b ,200);
   Arb_12 := Fusionner(Arb_1 , Arb_2) ;
   Arb_Final := Fusionner(Arb_12 , Fusionner(Arb_4 , Arb_3)) ;
   Arb_Final := Fusionner(Arb_Final,Arb_12) ;

   Afficher_A(Arb_Final,T,True,True) ;
   
   
end Test_arbre ;
