with arbre ; use arbre ;
with Ada.Command_Line;   use Ada.Command_Line ;
with Huffman;                 use Huffman ;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with Ada.Streams.Stream_IO;  use Ada.Streams.Stream_IO;


procedure decompresser is
   File_Name : Unbounded_String; -- Nom du fichier à traiter
   File      : Ada.Streams.Stream_IO.File_Type;  -- Type pour la gestion des fichiers
   S         : Stream_Access; -- Accès au flux de données
   Octet     : T_Octet;      -- Variable temporaire pour stocker un octet lu

   Pas_argument : Exception ;
   erreur_nb_argument : Exception ;
   non_huffman_file : Exception ;

   fin_ficher : Constant T_Octet := 255 ;
   i_fin_ficher : Integer ;
   Ficher : T_Ficher ;
   Nb_octet : Integer := 0 ;
   Caracters : liste_carctere ;

   carctere_a : T_Octet ;
   caratere_p : T_octet ;
   j : Integer ;


   Nb_uns : Integer := 1 ;
   bit : Bit_Array ;
   signatur : T_signature ;

   Arb_Huff : T_Arb ;
   Commence : Integer ;
   Caract : T_Octet := 0 ;
   curseur : T_Arb ;
   
   function verifier_extension (Arg : in String)  return Boolean is
       result : Boolean ;
       hff : Constant String(1..4) := ".hff" ;
   begin
       if Arg = hff then
            result := True ;
       else
          result := False ;
       end if ;
       return result ;
   end verifier_extension ;
   
begin
   
   
   Initialiser_A(Arb_Huff);
   Initialiser_A(curseur) ;
   signatur.Taill := 0 ;
   if Argument_Count = 0 then
      raise Pas_argument ;
   elsif Argument_Count /= 1 then
      raise erreur_nb_argument ;
   elsif Argument(1)'Length > 4 then
      if verifier_extension( Argument(1)(Argument(1)'Length - 3 .. Argument(1)'Length)) then
               File_Name := To_Unbounded_String(Argument(1)) ;
      else
           raise non_huffman_file  ;
      end if ; 
   else
       
      raise non_huffman_file  ;
   end if ;

   Open(File, In_File, To_String(File_Name));
   S := Stream(File);  -- Accès au flux de données

   while not End_Of_File(File) loop
      Octet := T_Octet'Input(S); -- Lire un octet
      Nb_octet := Nb_octet + 1 ;
      Ficher(Nb_octet) := Octet;


   end loop;
    -- Fermeture du fichier en lecture
   Close(File);
   i_fin_ficher := Integer(Ficher(1));

   Caracters.Taille := 1 ;
   caratere_p := Ficher(2) ;
   Caracters.Carc(Caracters.Taille) := caratere_p ;
   carctere_a := Ficher(3) ;
   j := 3 ;
   while carctere_a /= caratere_p loop
      if j = i_fin_ficher + 1 then
          Caracters.Taille := Caracters.Taille + 1 ;
          Caracters.Carc(Caracters.Taille) := fin_ficher ;
      end if ;
      caratere_p := carctere_a ;
      j:= j+1 ;
      carctere_a := Ficher(j);
      Caracters.Taille := Caracters.Taille + 1 ;
      Caracters.Carc(Caracters.Taille) := caratere_p ;
    
      
   end loop ;
   j := j+1 ;
   while Nb_uns < Caracters.Taille loop
      bit := Transformer_Octet(Ficher(j));
      for k in 1..8 loop
         if Caracters.Taille /= Nb_uns then
            signatur.Taill:= signatur.Taill + 1 ;
            signatur.Tab(signatur.Taill) := T_Octet(bit(k)) ;
            Nb_uns := Nb_uns + bit(k) ;
         end if ;
      end loop ;
      j := j + 1 ;
   end loop ;
   Commence := signatur.Taill mod 8 ;
   Arb_Huff := cree_Arb(Caracters,signatur);
   curseur := Arb_Huff ;
   Append(File_Name,".d");
   
    -- Ouverture du fichier en mode écriture pour la sortie compressée
   Create(File, Out_File,To_String(File_Name) );
   S := Stream(File);
   if Commence /= 0 then
        j :=  j - 1 ;
        bit := Transformer_Octet(Ficher(j));
        for k in (Commence+1)..8 loop
              if bit(k) = 1 and Caract /= fin_ficher then
                    aller_droite(curseur) ;
                    if Est_Feuille(curseur) then
                       Caract := Caracter(curseur);
                       if Caract /= fin_ficher then
                            T_Octet'Write(S,Caract );
                            curseur := Arb_Huff ;
                       end if;
                    end if ;
              elsif bit(k) = 0 and Caract /= fin_ficher then
                    aller_gauche(curseur) ;
                    if Est_Feuille(curseur) then
                       Caract := Caracter(curseur);
                       if Caract /= fin_ficher then
                            T_Octet'Write(S,Caract );
                            curseur := Arb_Huff ;
                       end if;
                    end if ;
              else 
                   null ;
              end if ;
         end loop ;
         j := j + 1 ;
    end if ;
    
    
    loop
        bit := Transformer_Octet(Ficher(j));
        for k in 1..8 loop
              
              if bit(k) = 1 and Caract /= fin_ficher then
                    aller_droite(curseur) ;
                    if Est_Feuille(curseur) then
                       Caract := Caracter(curseur);
                       if Caract /= fin_ficher then
                            T_Octet'Write(S,Caract );
                            curseur := Arb_Huff ;
                       end if;
                    end if ;
              elsif bit(k) = 0 and Caract /= fin_ficher then
                    aller_gauche(curseur) ;
                    if Est_Feuille(curseur) then
                       Caract := Caracter(curseur);
                       if Caract /= fin_ficher then
                            T_Octet'Write(S,Caract );
                            curseur := Arb_Huff ;
                       end if;
                    end if ;
              else 
                   null ;
              end if ;
         end loop ;
         j := j + 1 ;
        
         exit when (Caract = fin_ficher) or (j>Nb_octet) ;
    end loop ; 
   
   -- Fermeture du fichier en écriture
   Close(File);
   Detruire_A(Arb_Huff);

end decompresser ;
