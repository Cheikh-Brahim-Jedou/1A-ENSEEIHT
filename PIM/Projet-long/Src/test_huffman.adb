with Huffman;       use Huffman;
with arbre ;        use arbre ;

procedure Test_Huffman is
   Ficher : T_Ficher ;
   Arb : T_Arb ;
   Tab : T_Tab_str ;
   
   Code : T_Code ;
   Tableau_Huffman : Tab_Code ;
   i : Integer := 1 ;
   C : T_signature ;
   sign: T_signature ; -- variable pour reconstruire l'arbre de huffman a partir de signature est d'autres parametres 
   list_c : liste_carctere ; -- liste des caracteres qui permet de la reconstruction de l'arbre de huffman a partir des ces caracteres et la signature 
   Arb_test : T_Arb ; -- l'arbre obtenu a partir d'une liste de caractere et une signature 
begin
   C.Taill := 0 ;
   Ficher(1) := 125 ;
   Ficher(2) := 125 ;
   Ficher(3) := 135 ;
   Ficher(4) := 145 ;
   Ficher(5) := 125 ;
   Ficher(6) := 125 ;
   Ficher(7) := 126 ;

   Creation_Arbre_Huffman(Ficher,7,Arb);
   Tab.long := 0 ;
   Afficher_A(Arb,Tab,True,True) ;
   Code.long := 0;
   Creation_Tableau_Huffman(Arb,Tableau_Huffman,i,Code) ;
   i := i - 1 ;
   Aff_Tab_Huffman(Tableau_Huffman,i);
   Signature(Arb, C) ;
   Afficher_signature(C) ;
   
   -- Reconstitution de l'arbre a partir d'une signature et un tableau de caracteres 
   sign.Taill:= 10 ;
   sign.Tab(1) := 0 ;
   sign.Tab(2) := 0 ;
   sign.Tab(3) := 0 ;
   sign.Tab(4) := 1 ;
   sign.Tab(5) := 1 ;
   sign.Tab(6) := 1 ;
   sign.Tab(7) := 0 ;
   sign.Tab(8) := 1 ;
   sign.Tab(9) := 0 ;
   sign.Tab(10) := 1 ;
   list_c.Carc(1) := 121 ;
   list_c.Carc(2) := 122 ;
   list_c.Carc(3) := 123;
   list_c.Carc(4) :=  120;
   list_c.Carc(5) := 110;
   list_c.Carc(6) := 100 ;
   Arb_test := cree_Arb(list_c,sign);
   Tab.long := 0 ;
   Afficher_A(Arb_test,Tab,True,True) ;

end Test_Huffman;
