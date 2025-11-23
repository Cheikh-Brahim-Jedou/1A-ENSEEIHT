with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null;
   end Initialiser ;

   procedure Detruire(Sda: in out T_LCA) is
           A_Detruire: T_LCA; -- pointeur sur la cellule à détruire
      begin
           while Sda /= null loop
           A_Detruire := Sda;
           Sda := Sda.all.Suivant;
           Free (A_Detruire);
           end loop;
      end Detruire;


	procedure Afficher_Debug (Sda : in T_LCA) is
	begin
         if Sda /= null then
            put("-->[");
            Afficher_Cle(Sda.all.Cle);
            put(" : ");
            Afficher_Donnee(Sda.all.Valeur) ;
            put("]");
            Afficher_Debug(Sda.all.Suivant);
         else
         put("--E");
         end if ;
	end Afficher_Debug;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return Sda = null ;
	end;

   function Taille (Sda : in T_LCA) return Integer is
      curseur : T_LCA;
      Nombre_Cellule: Integer ;
	begin
      Curseur := Sda ;
      Nombre_Cellule := 0;
      while curseur /= null loop
         curseur:= curseur.all.Suivant ;
         Nombre_Cellule := Nombre_Cellule + 1 ;
      end loop ;

      return Nombre_Cellule ;

	end Taille;


   procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is

   begin
         if Sda = null then
            Sda := new T_Cellule'(Cle,Valeur, null);
         elsif Sda.all.Cle = Cle then
            Sda.all.Valeur := Valeur;
         else
            Enregistrer(Sda.all.Suivant,Cle,Valeur);
         end if ;

	end Enregistrer;

   function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
      Curseur : T_LCA;
   begin
        Curseur := Sda;
        while Curseur /= null and then Curseur.all.Cle/=Cle loop

              Curseur := Curseur.all.suivant ;

        end loop;

        return Curseur /= null ;

	end Cle_Presente;



   function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur is
          Curseur : T_LCA ;
   begin

         Curseur := Sda ;
         while Curseur /= null and then  Curseur.all.Cle /= Cle  loop
               Curseur := Curseur.all.suivant ;
         end loop ;

         if Curseur = null then
               raise Cle_Absente_Exception;
         else
               return Curseur.all.Valeur ;
         end if ;

	end La_Valeur;

   procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
            Curseur: T_LCA ;

    begin
         if Sda = null then
               raise Cle_Absente_Exception;
         elsif Sda.all.Cle = Cle then
               Curseur := Sda;
               Sda := Sda.all.suivant;
               Free(Curseur);
         else
               Supprimer(Sda.all.Suivant , Cle);

         end if ;
	end Supprimer;

   procedure Pour_Chaque (Sda : in T_LCA) is
      Curseur: T_LCA;
	begin
      Curseur := Sda ;
      while Curseur /= null loop
         begin
            Traiter(Curseur.all.Cle ,Curseur.all.Valeur);
         exception
            when others =>
                null;
         end;
         Curseur := Curseur.all.Suivant;
      end loop;

   end Pour_Chaque;

end LCA;
