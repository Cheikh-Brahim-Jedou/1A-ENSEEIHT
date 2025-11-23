with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;


package body LCA is


   procedure Free is
     new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null ;
	end Initialiser;

   --------------------------------------------------------------------------------

   procedure Detruire(Sda : in out T_LCA) is
   
      Sda_suivant : T_LCA;  -- Ce pointeur sert à ne pas perdre l'accès au reste de la LCA
      
   begin
   
     while Sda /= null loop
     
       Sda_suivant := Sda.all.Suivant;  -- Sauvegarde du pointeur suivant
       Free(Sda);                 -- Libère l'élément courant
       Sda := Sda_suivant;               -- Avance au prochain élément
       
     end loop;
     
     
   end Detruire;

   --------------------------------------------------------------------------------



   function Est_Vide (Sda : T_LCA) return Boolean is
	begin	
		return Sda = null;		
	end;

   --------------------------------------------------------------------------------

   function Taille (Sda : in T_LCA) return Integer is
           Taille_I : Integer; -- Le taille de LCA 
   begin	
      if Est_Vide(Sda) then      
         Taille_I := 0; -- pas des élements                   
      elsif Sda.all.Suivant = null then    
         Taille_I := 1; -- pour arreter la recrusivite a derniere cellule                   
      else      
         Taille_I := Taille(Sda.all.Suivant) + 1; -- le taille egale le taille des precedent plus restants         
      end if ;      
      return Taille_I ;      
   end Taille;

   --------------------------------------------------------------------------------

   procedure Enregistrer(Sda : in out T_LCA; Cle : in T_Cle; Valeur : in T_Valeur) is

      curseur : T_LCA; -- pour parcourir Sda en cas de Cle presente et pour ajouter de cellule 

   begin

      if Cle_Presente(Sda,Cle) then      
         curseur := Sda ;
         while curseur.all.Cle /= Cle loop         
            curseur := curseur.all.Suivant ;            
         end loop;
         curseur.all.Valeur := Valeur;
         
      else
      
         curseur := new T_Cellule; -- allocation de mémoire
         curseur.all.Cle := Cle;
         curseur.all.Valeur := Valeur ;
         curseur.all.Suivant := Sda ;
         Sda := curseur;
         
      end if ;
      
   end Enregistrer;


   --------------------------------------------------------------------------------
   function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
      Curseur : T_LCA;
   begin
        Curseur := Sda;
        while Curseur /= null and then Curseur.all.Cle/=Cle loop

              Curseur := Curseur.all.suivant ;

        end loop;

        return Curseur /= null ;

	end Cle_Presente;

   
   --------------------------------------------------------------------------------


   function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur is



        cruseur : T_LCA ;
        
      begin
      
      if not Cle_Presente(Sda,Cle) then         
            raise Cle_Absente_Exception ; -- léver l'exception si le cle n'est pas precense             
      else         
            null;            
      end if ;         

          
      cruseur := Sda ;
      while cruseur.all.Cle /= Cle loop
         cruseur := cruseur.all.Suivant ;        
      end loop ;
      return cruseur.all.Valeur ;

   end La_Valeur;

   --------------------------------------------------------------------------------

    
    function D_Valeur(Sda : in T_LCA) return T_Valeur is
    begin
        return Sda.all.Valeur ;
    end D_Valeur ;
    
    -------------------------------------------------------------------------------
    
    function D_Cle(Sda : in T_LCA) return T_Cle is
    begin
        return Sda.all.Cle ;
    end D_Cle ;
    
    -------------------------------------------------------------------------------
    
    procedure Depiler (Sda : in out T_LCA) is
        C_supprimer : T_LCA ;
   begin
      if Sda /= null then
        C_supprimer := Sda ;
        Sda := Sda.all.Suivant ;
        Free(C_supprimer) ;
      end if;
    end Depiler ;
    
    



	procedure Afficher_Debug (Sda : in T_LCA) is
	begin
         if Sda /= null then
            put("-->[");
            Afficher_Cle(Sda.all.Cle) ;
            put(" : ");
            Afficher_Valeur(Sda.all.Valeur);
            put("]");
            Afficher_Debug(Sda.all.Suivant);
         else
         put("--E");
         end if ;
	end Afficher_Debug;
end LCA;
