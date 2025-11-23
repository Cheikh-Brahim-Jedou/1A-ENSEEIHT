with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with LCA ;

Procedure test_lca is
    
   package lca_string_entier is new LCA(T_Cle => Unbounded_String, T_Valeur => Integer);
   use lca_string_entier;

   -- Retourner une chaine avec des guillemets autour de S
   function Avec_Guillemets (S: Unbounded_String) return String is
	begin
		return '"' & To_String (S) & '"';
   end Avec_Guillemets;

   Procedure Afficher_Cle (Cle : in Unbounded_String) is
   begin
      put(Avec_Guillemets(Cle));
   end Afficher_Cle;

   Procedure Afficher_Valeur(Valeur : in Integer) is
   begin
      Put(Valeur,1);
   end Afficher_Valeur;

  -- Instancie la procedure Afficher_Debug
  procedure Afficher is new Afficher_Debug(Afficher_Cle => Afficher_Cle , Afficher_Valeur => Afficher_Valeur );


   Sda: T_LCA ;
begin
   -- Initialisation de la  Sda
   Initialiser(Sda);
   -- Enregistrement du premier couple dans Sda
   Enregistrer( Sda , To_Unbounded_String("un") , 1 );
   -- Enregistrement du deuxieme couple dans Sda
   Enregistrer(Sda , To_Unbounded_String("deux") , 2);
   -- affichage du contenu de Sda
   Afficher(Sda);
   Detruire(Sda);
   Pragma Assert(Est_Vide(Sda));

end test_lca;


