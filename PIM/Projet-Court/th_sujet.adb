with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
With  TH ;


procedure th_sujet is

   package TH_string_entier is new TH(T_Cle    => Unbounded_String,
                                      T_Valeur => Integer,
                                      Capacite => 11,
                                      hachage  => Length ) ;
   use TH_string_entier ;
   function Avec_Guillemets (S: Unbounded_String) return String is
	begin
		return '"'& To_String (S) &'"';
   end Avec_Guillemets;

   Procedure Afficher_Cle (Cle : in Unbounded_String) is
   begin
      put(Avec_Guillemets(Cle));
   end Afficher_Cle;

   Procedure Afficher_Donnee(Valeur : in Integer) is
   begin
      Put(Valeur , 1);
   end Afficher_Donnee;

   procedure Afficher is new Afficher_Debug_TH(Afficher_Cle => Afficher_Cle , Afficher_Donnee => Afficher_Donnee );

   Sda : T_TH ;
begin

    -- Initialisation de la  Sda
   Initialiser(Sda);
   -- Enregistrement du premier couple dans Sda
   Enregistrer( Sda , To_Unbounded_String("Un") , 1);
   Enregistrer(Sda , To_Unbounded_String("deux") , 2);

   Enregistrer(Sda,To_Unbounded_String("trois"),3);
   Enregistrer(Sda,To_Unbounded_String("cinq"),4);
   Enregistrer(Sda,To_Unbounded_String("quatre"),6) ;
   Enregistrer(Sda,To_Unbounded_String("vingt-et-un"),21);
   Enregistrer(Sda,To_Unbounded_String("quatre-vingt-dix-neuf"),99);
   -- Affichage la table de hachage
   Afficher(Sda);

   Detruire(Sda);

end th_sujet ;
