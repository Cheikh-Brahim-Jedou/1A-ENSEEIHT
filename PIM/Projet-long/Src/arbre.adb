with Ada.Integer_Text_IO ;  use Ada.Integer_Text_IO ;
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body arbre is

    procedure Free is
     new Ada.Unchecked_Deallocation (Object => Noeud, Name => T_Arb);

    procedure Initialiser_A ( Arb : out T_Arb ) is
    begin
        Arb := null ;
    end Initialiser_A ;
    
    Procedure Detruire_A (Arb : in out T_Arb) is  
      
   begin
   
     if Est_Feuille(Arb) then 
         Free(Arb) ;
     else 
        Detruire_A(Arb.Gauche);
        Detruire_A(Arb.Droite);
        Free(Arb);
     end if ; 
     
   end Detruire_A;

    procedure Ajouter (Arb : in out T_Arb; Caractere : in T_Octet ; Occurrence : in Integer ) is
    begin
        Arb := new Noeud ;
        Arb.all.Caractere := Caractere ;
        Arb.all.Occurence := Occurrence ;
    end Ajouter ;

    function Fusionner (Arb_1 : in  T_Arb ; Arb_2 : in T_Arb) return T_Arb is
        Resultat : T_Arb ;
    begin
        Resultat := new Noeud ;
        Resultat.all.Gauche := Arb_2 ;
        Resultat.all.Droite := Arb_1 ;
        Resultat.all.Occurence := Arb_1.all.Occurence + Arb_2.all.Occurence ;
        return Resultat ;
    end Fusionner ;

    function Caracter (Arb : in T_Arb) return T_Octet is
    begin
        return Arb.all.Caractere ;
    end Caracter ;

    function Occurrence (Arb : in T_Arb) return Integer is
    begin
        return Arb.all.Occurence ;
   end Occurrence;

   function Gauche ( Arb : in T_Arb ) return T_Arb is
   begin
      return Arb.Gauche ;
   end Gauche ;

   function Droite ( Arb : in T_Arb ) return T_Arb is
   begin
      return Arb.Droite ;
   end Droite ;

   function Est_Feuille ( Arb : in T_Arb ) return Boolean is
   begin
      return ( Arb.Gauche = null ) or ( Arb.Droite = null ) ;
   end Est_Feuille;

   procedure Signature(Arb : in T_Arb ; Code : in out T_signature)  is

   begin

      if not Est_Feuille(Arb) then

         Code.Taill := Code .Taill +1 ;
         Code.Tab(Code.Taill) := 0 ;
         Signature(Gauche(Arb),Code) ;
         Code.Taill := Code .Taill + 1 ;
         Code.Tab(Code.Taill) := 1 ;
         Signature(Droite(Arb),Code) ;

      else
         null ;
      end if ;

   end Signature ;


   procedure Afficher_A (Arb : in T_Arb ; Tab_str : in T_Tab_str ; Est_Gauche : in Boolean ; Debut : in Boolean) is


      function Empiler (T : in  T_Tab_str ; str : in String) return T_Tab_str is
         Sorti : T_Tab_str := T;
      begin
         Sorti.long := T.long + 1 ;
         Sorti.Tab(Sorti.long) := str ;
         return Sorti ;
      end Empiler ;

      procedure Afficher_tab_str(T : in T_Tab_str)is
      begin
         if T.long = 0 then
            null ;
         else
            for i in 1..T.long loop
               put(T.Tab(i)) ;
            end loop ;
         end if ;
      end Afficher_tab_str ;

      procedure Afficher_occ (Arb : in T_Arb) is
      begin
         put("(") ;
         put(Arb.all.Occurence,1) ;
         put(")  ") ;

      end Afficher_occ ;
      
      procedure afficher_car(Arb : in T_Arb) is
      begin
         if Arb.all.Caractere = 255 then
            Put("\$") ;
         elsif Arb.all.Caractere = 10 then
            Put("\n") ;
         else
            Put(Character'Val(Arb.all.Caractere));
         end if ;
      end afficher_car ;

   begin


      if Est_Feuille(Arb) then
         if Est_Gauche  then
            Afficher_tab_str(Tab_str) ;
            put("\--0--");
            Afficher_occ(Arb) ;
            put("'") ;
            afficher_car(Arb) ;
            put("'") ;
            New_Line ;
         else
            Afficher_tab_str(Tab_str) ;
            put("\--1--") ;
            Afficher_occ(Arb);
            put("'") ;
            afficher_car(Arb) ;
            put("'") ;
            New_Line;

         end if ;
      else
         if Debut then
            Afficher_occ(Arb) ;
            New_Line ;
            Afficher_A(Arb.all.Gauche,Tab_str,True,FALSE);
            Afficher_A(Arb.all.Droite,Tab_str,FALSE,FALSE);
         elsif Est_Gauche  then
            Afficher_tab_str(Tab_str) ;
            put("\--0--") ;
            Afficher_occ(Arb) ;
            New_Line ;
            Afficher_A(Arb.all.Gauche,Empiler(Tab_str,"|     "),True,False);
            Afficher_A(Arb.all.Droite,Empiler(Tab_str,"|     "),False,False);
         else
            Afficher_tab_str(Tab_str) ;
            put("\--1--");
            Afficher_occ(Arb) ;
            New_Line ;
            Afficher_A(Arb.all.Gauche,Empiler(Tab_str,"      "),True,False);

            Afficher_A(Arb.all.Droite,Empiler(Tab_str,"      "),False,False);
         end if ;

      end if ;
   end Afficher_A ;
   
   procedure Afficher_signature ( Code : in T_signature) is
   begin
        for i in 1..Code.Taill loop
            put(Integer(Code.Tab(i)),1) ;
        end loop ;
   end Afficher_signature ;
   
   function cree_Arb(Carcs : in liste_carctere ; sign : in T_signature ) return T_Arb is
     Arb : T_Arb ;
     i_car : Integer := 1 ;
     i_bit : Integer := 0 ;
     procedure cree_sgn_arb (i_car : in out Integer ;Carcs : in liste_carctere ; sign : in T_signature ;i_bit : in out Integer ;Arb : in out T_Arb ) is
     begin
      
      if i_bit = 0 then
         Arb := new Noeud ;
         Arb.Occurence := 0 ;   
         i_bit := i_bit + 1 ;
         cree_sgn_arb(i_car,Carcs,sign,i_bit,Arb.Gauche);
         i_bit := i_bit + 1 ;
         cree_sgn_arb(i_car,Carcs,sign,i_bit,Arb.Droite);
      elsif ( i_bit = sign.Taill ) or ( i_car =  Carcs.Taille ) then 
            Arb := new Noeud ;
            Arb.Occurence := 0 ;  
            Arb.Caractere := Carcs.Carc(i_car) ;
      elsif (sign.Tab(i_bit)=0) and (sign.Tab(i_bit+1) = 1 ) then
            Arb := new Noeud ;
            Arb.Occurence := 0 ;  
            Arb.all.Caractere := Carcs.Carc(i_car);
            i_car := i_car + 1 ;
      elsif (sign.Tab(i_bit)=1) and (sign.Tab(i_bit+1) = 1 ) then
            Arb := new Noeud ;
            Arb.Occurence := 0 ;  
            Arb.all.Caractere := Carcs.Carc(i_car);
            i_car := i_car + 1 ;
      else
            Arb := new Noeud ;
            Arb.Occurence := 0 ;  
         i_bit := i_bit + 1 ;
         cree_sgn_arb(i_car,Carcs,sign,i_bit,Arb.Gauche);
         i_bit := i_bit + 1 ;
         cree_sgn_arb(i_car,Carcs,sign,i_bit,Arb.Droite);
      end if ;
     end cree_sgn_arb ;
      
   begin
      cree_sgn_arb(i_car,Carcs,sign,i_bit,Arb);
      return Arb ;
   end cree_Arb;
   
   procedure aller_gauche( curseur : in out T_Arb) is
   begin
      curseur := curseur.all.Gauche ;
   end aller_gauche ;
   
   procedure aller_droite(curseur : in out T_Arb) is
   begin
      curseur := curseur.all.Droite ;
   end aller_droite ;
   
end arbre ;

