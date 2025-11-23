with LCA ;
with arbre ; use arbre ;

package Huffman is


   package Dic is new LCA(T_Cle => T_Octet , T_Valeur => Integer ) ;
   use Dic ;
   -- Déclaration d'un type de tableau pour représenter un fichier de taille 1 million d'octets
   type T_Ficher is array(1..1000000) of T_octet ;
   
   -- declaration d'un type tableau de taille 8 
   type Bit_Array is array (1 .. 8) of Integer;

   -- Definition d'un type pour stocker les arbres initiales .
   type Tab_Arb is array(1..300) of T_Arb;  -- Tableau des arbres
   type Tab_Arb_t is 
        record
            longeur : Integer;  -- Longueur du tableau
            Tab : Tab_Arb;      -- Tableau des arbres
        end record;
        
   -- Defintion des types pour construire le type du code de huffman
   type Tab_code_d is array(1..300) of T_Octet ;
   type T_Code is 
   record
      long : Integer ;
      Tab : Tab_code_d ;
   end record ;
   --defintion d'un type auxilaire pour construire le type du tableau de huffman 
   type colone is
      record
         Caracter : T_Octet ;
         Code : T_Code  ;
      end record ;
   
   type Tab_Code is array(1..300) of colone ;
   -- fonction pour obtenir l'indice de l'arbre avec le poids minimal dans un tableau d'arbres
   function min(Tableau : in Tab_Arb_t) return Integer ;

   procedure Creation_Arbre_Huffman_dic(dic : in out T_LCA ; Arb : out T_Arb)  ;
   
   procedure Creation_Arbre_Huffman(Ficher : in T_Ficher ; Taill : in Integer; Arb : in out T_Arb)  ;
   
   -- procedure pour creer le tableau de huffman a partir de l'arbre de huffman
   procedure Creation_Tableau_Huffman(Arb_H : in T_Arb ; Tab_Huff : in out Tab_Code ; i : in out Integer ; Code : in out T_Code) ;
   -- procedure pour determiner le tableau d'occurrance des caracteres d'un fichier 
   procedure Tab_occurence (Ficher : in T_Ficher ; Taill : in Integer; Tab_occ : out T_LCA) ;
   -- Fonction  permettant de retourner l'indice d'un octets dans le tableau de huffman 
   function Place ( Tab_Huff : in Tab_Code ; Car : T_Octet) return Integer ;

   function Code_parcourir ( Tab_Huff : in Tab_Code ; Caracter :  in T_Octet  ; indice : in Integer ) return T_Octet ;
    -- fonction permettant de retourner la longueur d'un code 
   function Lenght_Code (Tab_Huff : in Tab_Code ; Caracter : in T_Octet) return Integer ;
   -- fonction permettant de retourner le caractere situe a l'indice i dans le tableau de huffman
   function Carctere_h (Tab_Huff : in Tab_Code ; i : in Integer) return T_Octet ;
   
   function Taille_H ( Ficher : in T_Ficher ; Taill : in Integer) return Integer ;
   
   procedure Aff_C ( C : in T_Octet) ;
   
   procedure Aff_V ( V : in Integer) ;
   -- procedure pour afficher le tableau de huffman
   procedure Aff_Tab_Huffman ( T : in Tab_Code ; i : in Integer) ;
   
   function Transformer_Octet(Val : T_Octet) return Bit_Array  ;

end Huffman ;

