           
package arbre is

    type T_Octet is mod 2 ** 8;  -- Definition d'un type pour l'octet (0 - 255)
    for T_Octet'Size use 8;
    
    -- Declaration d'un type enregistrement qui se composent d'un tableau qui contient les octets deux a deux distincts qui constitue le fichier  et le taille du tableau
    type tableau is array(1..300) of T_Octet ;
    type liste_carctere is
      record
         Taille : Integer ;
         Carc : tableau ;
      end record ;
     -- Structure introduite pour faciliter l'affichage de l'arbre de huffman ,
    subtype Fixed_String is String(1 .. 6); -- Chaines de 6 caracteres ,par exemple "\--0--" contient  6 caracteres
    type T_arr is array(1 .. 200) of Fixed_String;
    type T_Tab_str is 
       record
         Tab : T_arr ;
         long : Integer ;
       end record ;
       
       --Declaration d'un type signature
    type T_tab is array(1..10000) of  T_Octet;
    type T_signature is 
       record
        Taill :  Integer ;
        Tab : T_tab ;
       end record ;
       
    type T_Arb is private ; 
     
    -- Initialiser un arbre . l'arbre est vide  
    procedure Initialiser_A( Arb : out T_Arb  ) ;
    
    Procedure Detruire_A( Arb : in out T_Arb) ;
    
    -- ajouter une feuille avec un caractere et nombre d'occurrence
    procedure Ajouter (Arb : in out T_Arb; Caractere : in T_Octet ; Occurrence : in Integer ) ;
    
     -- Fusionner deux arbres
    function Fusionner (Arb_1 : in  T_Arb ; Arb_2 : in T_Arb) return T_Arb ;
    
    -- fonction permettant de retourner le charctere d'une feuille
    function Caracter (Arb : in T_Arb) return T_Octet ;
    
    -- obtenir le nombre d'occurrence associe a un Noeud 
    function Occurrence (Arb : in T_Arb) return Integer ; 
    
    -- Afficher l'arbre de Huffman
    procedure Afficher_A (Arb : in T_Arb ; Tab_str : in T_Tab_str ; Est_Gauche : in Boolean ; Debut : in Boolean) ; 
     
    -- verifier si un Noeud correspond a une Feuille
    function Est_Feuille ( Arb : in T_Arb ) return Boolean ;
    
    -- retourn le sous-arbre gauche
    function Gauche ( Arb : in T_Arb ) return T_Arb ;
    
    --retourn le sous-arbre droite
    function Droite ( Arb : in T_Arb ) return T_Arb ;
    
    -- Obtenir la signature d'un arbre
    procedure Signature(Arb : in T_Arb ; Code : in out T_signature) ;
    
    -- Afficher la signature 
    procedure Afficher_signature ( Code : in T_signature);
    
   -- Obtenir l'arbre de Huffman a partir d'une liste d'octets avec la signature 
   function cree_Arb(Carcs : in liste_carctere ; sign : in T_signature ) return T_Arb ;
   
   
   
   procedure aller_gauche(curseur : in out T_Arb) ; 
   
   procedure aller_droite(curseur : in out T_Arb) ; 

private 
 
     type Noeud ;
     type T_Arb is access Noeud ;
     type Noeud is
        record 
            Caractere : T_Octet ;
            Occurence : Integer ;
            Gauche : T_Arb ;
            Droite : T_Arb ;
        end record ;
   
   
end arbre ;
