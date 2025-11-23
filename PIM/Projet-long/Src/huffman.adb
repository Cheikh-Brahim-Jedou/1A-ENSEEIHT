with Ada.Text_IO ;   use Ada.Text_IO ;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO ;

package body Huffman is


    -- Obtenir le minimum des occurrences associees a des arbres
   function min(Tableau : in Tab_Arb_t) return Integer is
       i : Integer := 1;
       min : Integer := Occurrence(Tableau.Tab(1));
   begin
       for j in 1..Tableau.longeur loop
                if min > Occurrence(Tableau.Tab(j)) then
                    i := j;
                    min := Occurrence(Tableau.Tab(j));
                end if;
       end loop;
       return i;
   end min;
   
   procedure Creation_Arbre_Huffman_dic(dic : in out T_LCA ; Arb : out T_Arb)  is
      Tab_H : Tab_Arb_t ;  -- Structure pour contenir les arbres
      remplacement : T_Arb;
      pp : Integer;
   begin
        -- Initialisation des arbres dans le tableau
        Tab_H.longeur := Taille(Dic) ;
        for i in 1..Taille(Dic) loop
            Initialiser_A(Tab_H.Tab(i));  -- Initialiser chaque arbre
            Ajouter(Tab_H.Tab(i), D_Cle(dic), D_Valeur(dic));  -- Ajouter les clés et valeurs du dictionnaire
            Depiler(dic);  -- Depiler l'élément 
            
        end loop;
         
        -- Fusionner les arbres pour créer l'arbre de Huffman
        while Tab_H.longeur > 1 loop
            pp := min(Tab_H);  -- Trouver l'arbre avec la fréquence minimale
            remplacement := Tab_H.Tab(pp);
            Tab_H.Tab(pp) := Tab_H.Tab(Tab_H.longeur);  -- Remplacer l'arbre
            Tab_H.Tab(Tab_H.longeur) := remplacement;
            Tab_H.longeur := Tab_H.longeur - 1;
            pp := min(Tab_H);  -- Trouver à nouveau l'arbre avec la fréquence minimale
            Tab_H.Tab(pp) := Fusionner(Tab_H.Tab(pp), Tab_H.Tab(Tab_H.longeur + 1));  -- Fusionner les deux arbres
        end loop;

        -- Retourner l'arbre final
        Arb := Tab_H.Tab(1);
   end Creation_Arbre_Huffman_dic;

   function Taille_H ( Ficher : in T_Ficher ; Taill : in Integer ) return Integer is
      Tab_occ : T_LCA ;
      result : Integer ;
   begin
      Tab_occurence(Ficher,Taill,Tab_occ);
      result := Taille(Tab_occ) ;
      Detruire(Tab_occ);
      return result ;
   end Taille_H ;

   procedure Creation_Tableau_Huffman(Arb_H : in T_Arb ; Tab_Huff : in out Tab_Code ; i : in out Integer ; Code : in out T_Code)  is

      procedure Depiler_s (C : in out T_Code ) is
      begin
         if C.long = 0 then
            null ;
         else
            C.long := C.long - 1 ;
         end if ;
      end Depiler_s ;

   begin

      if not Est_Feuille(Arb_H) then

         Code.long := Code.long + 1;
         Code.Tab(Code.long) := 0 ;
         Creation_Tableau_Huffman(Gauche(Arb_H),Tab_Huff,i,Code) ;
         Depiler_s(Code) ;
         Code.long := Code.long + 1;
         Code.Tab(Code.long) := 1 ;
         Creation_Tableau_Huffman(Droite(Arb_H),Tab_Huff,i,Code) ;
         Depiler_s(Code) ;
      else
         Tab_Huff(i).Caracter := Caracter(Arb_H) ;
         Tab_Huff(i).Code := Code ;
         i := i + 1 ;
      end if ;

   end Creation_Tableau_Huffman ;


   -- obtenir l'indice d'un octets dans le tableau de Huffman
   function Place ( Tab_Huff : in Tab_Code ; Car : in T_Octet) return Integer is
            i : Integer := 1;
   begin
      while Tab_Huff(i).Caracter /= Car loop
               i := i+1 ;
      end loop ;
      return i ;

   end Place ;

   function Code_parcourir ( Tab_Huff : in Tab_Code ; Caracter : in T_Octet  ; indice : in Integer ) return T_Octet is
          i : Constant Integer := Place(Tab_Huff,Caracter) ;
   begin
      return Tab_Huff(i).Code.Tab(indice) ;
   end Code_parcourir ;

   function Lenght_Code (Tab_Huff : in Tab_Code ; Caracter : in T_Octet ) return Integer is
         i : Constant Integer := Place(Tab_Huff,Caracter) ;
   begin
         return Tab_Huff(i).Code.long ; --pour acceder a la longueur du code
   end Lenght_Code ;

   function Carctere_h (Tab_Huff : in Tab_Code ; i : in Integer) return T_Octet is
   begin
         return Tab_Huff(i).Caracter ;
   end Carctere_h ;
   
   -- Obtenir un dictionnaire constitue des caracteres et leurs occurrences a l'aide d'un fichier et son taille 
   procedure Tab_occurence (Ficher : in T_Ficher ; Taill : in Integer; Tab_occ : out T_LCA) is
      Val : Integer ;
      fin_ficher : T_Octet ;
   begin
      Initialiser(Tab_occ) ;
      for i in 1..Taill loop
      
          if Cle_Presente(Tab_occ,Ficher(i)) then
             Val := La_Valeur(Tab_occ,Ficher(i)) + 1;
             Enregistrer(Tab_occ,Ficher(i),Val);
          else
             Enregistrer(Tab_occ,Ficher(i),1);
          end if ;
      end loop ;
      fin_ficher := 255;
      Enregistrer(Tab_occ, fin_ficher, 0);

   end Tab_occurence ;

  procedure Aff_C ( C : in T_Octet) is
  begin
       Put(Integer(C), Base => 2);
  end Aff_C ;
  
  procedure Aff_V (V : in Integer) is
  begin
       Put(V,1);
  end Aff_V ;
  
  -- creer l'arbre de huffman directement a partir d'un fichier 
  procedure Creation_Arbre_Huffman(Ficher : in T_Ficher ; Taill : in Integer; Arb : in out T_Arb) is
         Tab_occ : T_LCA ;
  begin
         Tab_occurence(Ficher,Taill,Tab_occ);
     
         Creation_Arbre_Huffman_dic(Tab_occ,Arb) ;
         Detruire(Tab_occ);

  end Creation_Arbre_Huffman;

  procedure Aff_Tab_Huffman ( T : in Tab_Code ; i : in Integer) is
       -- sous_proceduire introduite afin de faciliter l'afficiliter l'affichage de tableau de huffman
       procedure Afficher_Code( C : in T_Code )is
       begin
           for j in 1..C.long loop
                Put(Integer(C.Tab(j)),1);
           end loop ;
       end Afficher_Code ;
       procedure afficher_car(T : in Tab_code ; j : in integer) is
      begin
         if T(j).Caracter = 255 then
            Put("\$") ;
         elsif T(j).Caracter = 10 then
            Put("\n") ;
         else
            Put(Character'Val(T(j).Caracter));
         end if ;
      end afficher_car ;
  begin
      for j in 1..i loop
          Put("'");
          afficher_car(T,j);
          Put("' --> ") ;
          Afficher_Code(T(j).Code);
          new_Line ;
      end loop ;
  end Aff_Tab_Huffman ;
  
  function Transformer_Octet(Val : T_Octet) return Bit_Array is
      Resultat : Bit_Array := (others => 0);  
   begin
      for i in 0 .. 7 loop
         Resultat(i+1) := Integer((Val / (2 ** (7 - i))) mod 2);
      end loop;
      return Resultat;
   end Transformer_Octet;
   
end Huffman;
