with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
package body TH is

   procedure Initialiser(Sda: out T_TH) is
   begin
      for i in 1..Capacite loop
         LCA_TH.Initialiser(Sda(i)) ;
      end loop ;
   end Initialiser ;

   procedure Detruire (Sda : in out T_TH) is
   begin
      for i in 1..Capacite loop
         LCA_TH.Detruire(Sda(i));
      end loop ;
   end Detruire;

   function Taille (Sda : in T_TH) return Integer is
      length:Integer ;
   begin

         length := 0 ;
         for i in 1..Capacite loop
            length := length +LCA_TH.Taille(Sda(i)) ;

         end loop ;
         return length ;
   end Taille ;

   function Est_Vide (Sda : in T_TH) return Boolean is
   begin

        for i in 1..Capacite loop
          if  Not LCA_TH.Est_Vide(Sda(i)) then
            return False ;
          end if ;
        end loop ;
       return True ;

   end Est_Vide ;

   function Block(Cle :in  T_Cle) return Integer is
   begin
      return (hachage(Cle) mod Capacite)+1;
   end Block;

   procedure Enregistrer (Sda : in out T_TH ; Cle : in T_Cle ; Valeur : in T_Valeur) is

   begin
         LCA_TH.Enregistrer(Sda(Block(cle)) , Cle ,Valeur);

   end Enregistrer ;

   procedure Supprimer (Sda : in out T_TH ; Cle : in T_Cle) is

   begin

           LCA_TH.Supprimer(Sda(Block(Cle)), Cle) ;

   end Supprimer;

   function Cle_Presente(Sda : in T_TH ; Cle : in T_Cle) return Boolean is 
   begin
      return LCA_TH.Cle_Presente(Sda(Block(Cle)), Cle) ;
   end Cle_Presente ;
   
   function La_Valeur (Sda : in T_TH ; Cle : in T_Cle) return T_Valeur is

   begin

         return LCA_TH.La_Valeur(Sda(Block(Cle)),Cle) ;

   end la_Valeur ;


   procedure Afficher_Debug_TH (Sda : in T_TH) is
     procedure Afficher is new LCA_TH.Afficher_Debug( Afficher_Cle => Afficher_Cle , Afficher_Donnee => Afficher_Donnee); 
   begin
        
         for i in 1..Capacite loop
            put(i-1,1);
            Afficher(Sda(i)) ;
            New_Line ;
         end loop ;
   end Afficher_Debug_TH;

   procedure Pour_Chaque_TH (Sda : in T_TH) is


   procedure Pour_Chaque_T is new LCA_TH.Pour_Chaque(Traiter => Traiter_TH ) ;

   begin
         for i in 1..Capacite loop
            Pour_Chaque_T(Sda(i)) ;
         end loop ;
   end Pour_Chaque_TH ;

end TH;
