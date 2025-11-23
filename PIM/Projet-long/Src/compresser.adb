with Ada.Streams.Stream_IO;  use Ada.Streams.Stream_IO;
with Huffman;                 use Huffman ;-- Package générique pour implémenter la compression Huffman
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with arbre ; use arbre ;
with Ada.Command_Line;   use Ada.Command_Line ;

procedure Compresser is

    -- Variables
    File_Name : Unbounded_String; -- Nom du fichier à traiter
    File      : Ada.Streams.Stream_IO.File_Type;  -- Type pour la gestion des fichiers
    S         : Stream_Access; -- Accès au flux de données
    Octet     : T_Octet;      -- Variable temporaire pour stocker un octet lu

    a : Integer;     -- Compteur temporaire d'occurrences

    -- Variables pour l'arbre et le tableau de codage Huffman
    Arbre_Huffman : T_Arb;
    Tableau_Huffman : Tab_Code;

    -- Variables pour traiter les octets compressés
    i : Integer := 0;           -- Indice pour parcourir le fichier
    Code : T_Code;    -- Code compressé pour chaque octet
    Signatur : T_signature;          -- Signature du fichier compressé
    Ficher : T_Ficher;          -- Tableau des octets lus

    k : Integer := 1;           -- Indice pour parcourir les octets compressés
    bit : T_Octet;              -- Bit temporaire pour la compression
    Nb_octet : Integer := 0;    -- Compteur du nombre de bits accumulés
    octet_courant : T_Octet := 0; -- Octet temporaire en cours de construction
    i_fin_ficher : Integer;     -- Position du caractère de fin dans le tableau Huffman
    fin_ficher : T_Octet;       -- Octet spécial pour marquer la fin du fichier

    l : Integer := 1 ;
    long : Integer ;
   
    Invalid_argument : Exception ;
    Pas_argument : Exception ;
    Silence : Boolean ; -- Variable qui pricise l'option 
   
    Tab : T_Tab_str ;

begin
   -- Initialisation du dictionnaire
   Tab.long := 0 ;
   Code.long := 0 ;

   if  Argument_Count  = 0 then
      raise pas_argument ;
   elsif Argument_Count = 1 then 
       File_Name := To_Unbounded_String(Argument(Argument_Count)) ;
       silence := False ;   
   else
      File_Name := To_Unbounded_String(Argument(Argument_Count)) ;
      if Argument(Argument_Count - 1) = "-s" then
         Silence := True ;
      elsif (Argument(Argument_Count - 1) = "-b") then
         Silence := False ;
      else
         raise Invalid_argument ;
      end if ;
   end if ;

     fin_ficher := 255;
    -- Ouverture du fichier en mode lecture
    Open(File, In_File, To_String(File_Name));
    S := Stream(File);  -- Accès au flux de données

    -- Boucle de lecture des octets du fichier
    while not End_Of_File(File) loop
      Octet := T_Octet'Input(S); -- Lire un octet
      i := i + 1 ;
      Ficher(i) := Octet;


    end loop;
    
    -- Fermeture du fichier en lecture
   Close(File);
      
    a := Taille_H(Ficher,i);

    -- Création de l'arbre de Huffman à partir du dictionnaire
    Creation_Arbre_Huffman(Ficher,i,Arbre_Huffman);
    Creation_Tableau_Huffman(Arbre_Huffman, Tableau_Huffman, l, Code);
    
    -- Identifier la position du caractère de fin dans le tableau Huffman
    Ficher(i+1) := fin_ficher ;
    i:= i+ 1 ;
    i_fin_ficher := Place(Tableau_Huffman, fin_ficher);
    if not Silence then
        Afficher_A(Arbre_Huffman,Tab,True,True);
        Aff_Tab_Huffman(Tableau_Huffman,l-1);
      
    end if ;
    Append(File_Name,".hff");
    -- Ouverture du fichier en mode écriture pour la sortie compressée
    Create(File, Out_File,To_String(File_Name) );
    S := Stream(File);

    -- Écriture des informations de compression
   T_Octet'Write(S, T_Octet(i_fin_ficher));

   for m in 1 .. a loop
        octet_courant := Carctere_h(Tableau_Huffman, m);
        if octet_courant /= 255 then
           T_Octet'Write(S, octet_courant);
        end if ;
   end loop;
   octet_courant := Carctere_h(Tableau_Huffman, a);
   T_Octet'Write(S, octet_courant);


   -- Gestion de la signature
    Signatur.Taill := 0 ;
    Signature(Arbre_Huffman,Signatur);
    --Afficher_signature(Signatur) 
    for n in 1 .. Signatur.Taill loop
        bit := Signatur.Tab(n);
        Nb_octet := Nb_octet + 1;
        octet_courant := (octet_courant * 2) or bit;
        if Nb_octet = 8 then
            T_Octet'Write(S, octet_courant);
            octet_courant := 0;
            Nb_octet := 0;
        end if;
    end loop ;


    -- Compression des données principales
    k := 1;
    while k < (i+1) loop
        long := Lenght_Code(Tableau_Huffman, Ficher(k));
        for n in 1 .. long loop
            bit := Code_parcourir(Tableau_Huffman, Ficher(k), n);
            octet_courant := (octet_courant * 2) or bit;
            Nb_octet := Nb_octet + 1;
            if Nb_octet = 8 then
                T_Octet'Write(S, octet_courant);
                octet_courant := 0;
                Nb_octet := 0;
            end if;
        end loop;
        k := k + 1;
    end loop;
    if Nb_octet > 0 then
        for i in 1 .. (8 - Nb_octet) loop
            octet_courant := (octet_courant * 2) or 0;
        end loop;
        T_Octet'Write(S, octet_courant);
    end if;

    -- Fermeture du fichier en écriture
    Close(File);
    Detruire_A(Arbre_Huffman);

end Compresser;

