with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Alea;

--------------------------------------------------------------------------------
--  Auteur   : Brahim Jedou Cheikh
--  Objectif : Jeu a 13 allumette
--------------------------------------------------------------------------------

procedure Allumettes is

	package Alea_1_3 is
		new Alea (1, 3);
   use Alea_1_3;

   niveau: Character; --  variable donnant le niveau de jeu.
   Reponse: Character;-- Variable indiquant celui qui commence en premier.
   Tour : Boolean; --Variable déterminant le tour de l'utilisateur ou de la machine.
   Nombre_Choisi: Integer; -- variable donnant le nombre d'allumettes choisi par la machine ou par l'utilisateur
   Gagne: Boolean;-- Variable indiquant celui qui gagne
   Nombre_Allumettes: Integer; -- variable determinant le nombre d'allumettes restants dans le tas
   groupe: Integer ; -- variable permettant de regrouper chaque 5 allumettes
begin

   -- Demander le niveau de jeu
   Put("Niveau de l'ordinateur (n)aïf, (d)istrait, (r)apide ou (e)xpert ? ");
   Get(niveau);
   
   Put("Mon niveau est ");

   case niveau is
      when 'n'| 'N' => Put("naif.");
      when 'd'| 'D' => Put(" distrait.");
      when 'r'| 'R' => Put("rapide.");
      when others => Put("expert.");

   end case;
   New_Line;
   -- Afficher celui qui commence
   put("Est-ce que vous commencez (o/n) ? ");
   Get(Reponse);
   if Reponse = 'O' or Reponse = 'o' then

      Tour:=True ;

   else
      Tour:= False ;
   end if ;

   Nombre_Allumettes:=13 ; -- nombre total d'allumettes
   gagne:=True; --variable qui indique le gagnant
   while Nombre_Allumettes>0 loop
      -- affichage du nombre d'allumettes restante
      New_Line;
      for j in 1..3 loop
        groupe:=Nombre_Allumettes ;
        while groupe>5 loop
           put("| | | | |   ") ;
           groupe:=groupe-5 ;
        end loop;
        for i in 1.. groupe loop
             put("| ");
        end loop;
        New_Line;
      end loop;

      if Tour then
         loop
            Put("Combien d'allumettes prenez-vous ? ");
            Get(Nombre_Choisi);
            if Nombre_Choisi>3 then
               Put_Line("Arbitre : Il est interdit de prendre plus de 3 allumettes.");
               New_Line;
            elsif Nombre_Choisi<1 then
               put("Arbitre : Il faut prendre au moins une allumette.");
               New_Line;
            elsif Nombre_Choisi>Nombre_Allumettes and Nombre_Allumettes >1 then
               put("Arbitre : Il reste seulement ");
               put(Nombre_Allumettes,1);
               put(" allumettes.");
               New_Line;
            elsif Nombre_choisi> Nombre_Allumettes and Nombre_Allumettes=1 then 
               put("Arbitre : Il reste une seule allumette."); 
               New_Line;
            else
               New_Line ;
            end if;
         exit when Nombre_Choisi<=3 and Nombre_Allumettes>=Nombre_Choisi and Nombre_Choisi>0;
         end loop;
         Nombre_Allumettes:= Nombre_Allumettes-Nombre_Choisi;
         Gagne:=False;
         New_Line ;
         if Nombre_Allumettes /= 0 then
         
          for j in 1..3 loop 
           groupe:=Nombre_Allumettes;
           while groupe>5 loop
              put("| | | | |   ") ;
              groupe:=groupe-5 ;
           end loop;
           for i in 1.. groupe loop
               put("| ");
           end loop;
           New_Line;
          end loop;
         end if ;
      end if;

      if Nombre_Allumettes>0 then
         gagne := True ;
         Tour:= True;
         if niveau ='d' or niveau='D' then
            loop
               -- Prendre un nombre aleatoire dans {1,2,3}
               Get_Random_Number(Nombre_Choisi);
               --Afficher le nombre choisi 
               put("Je prends ");
               put(Nombre_Choisi,1 );
               put(" allumettes.");
               New_Line ;
               if Nombre_Choisi> Nombre_Allumettes and Nombre_Allumettes>1 then
                  put("Arbite:Il reste seulement ");
                  put(Nombre_Choisi,1 );
                  put(" allumettes.");
                  New_Line ;
               elsif Nombre_choisi> Nombre_Allumettes and Nombre_Allumettes=1 then 
                  put("Arbitre : Il reste une seule allumette."); 

               else
                  Null ;
               end if;
            exit when Nombre_Choisi<=Nombre_Allumettes;
            end loop;
            Nombre_Allumettes:= Nombre_Allumettes-Nombre_Choisi ;
         elsif niveau='n' or niveau ='N' then
               if Nombre_Allumettes >=3 then
                  Get_Random_Number(Nombre_Choisi);
               else
                  Get_Random_Number(Nombre_Choisi);
                  Nombre_Choisi:=(Nombre_Choisi mod Nombre_Allumettes)+1 ;
               end  if ;
               put("Je prends ");
               put(Nombre_Choisi,1);
               put(" allumettes.");
               New_Line  ;
               Nombre_Allumettes:=Nombre_Allumettes-Nombre_Choisi ;


         elsif  niveau='r' or niveau='R' then
               if Nombre_Allumettes>=3 then
                  Nombre_Choisi:= 3;
               else
                  Nombre_Choisi:= Nombre_Allumettes;
               end if ;
               -- afficher le nombre choisi
               put("Je prends ");
               put(Nombre_Choisi,1);
               put("  allumettes."); 
               New_Line ;
               Nombre_Allumettes:=Nombre_Allumettes-Nombre_Choisi ;

         else
          if Nombre_Allumettes>=4 then
              Nombre_Choisi:=3;
          elsif Nombre_Allumettes=3 then
            Nombre_Choisi:=2;
          else
               Nombre_Choisi:=1;
          end if ;
          Nombre_Allumettes:=Nombre_Allumettes-Nombre_Choisi ;
          put("Je prends ");
          put(Nombre_Choisi,1);
          put(" allumettes.");
          New_Line ;
         end if ;
      else
         Null;
      end if ;
   end loop ;
   -- Afficher le gagnant.
   if gagne  then
      Put_Line("Vous avez gagné.");

   else
           Put_Line("J'ai gagné.");

   end if ;

end Allumettes;

