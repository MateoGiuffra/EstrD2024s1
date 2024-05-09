module SetV1 
        (Set,
        emptyS,
        addS,
        belongsS,
        sizeS,
        removeS,
        unionS,
        setToList)where

import TripulanteEnterprise
t1 = crearT "T1" 20 
t2 = crearT "T2" 20 
t3 = crearT "T3" 220 
t4 = crearT "T4" 203 
t5 = crearT "T5" 10 

data Set a = S [a] Int 
        deriving Show
            -- elementos, cantidad de elementos



set = addS t5 
        $ addS t4
        $ addS t2 
        $ addS t4 emptyS

-- O(1) ya que se usa el constructor de Set 
emptyS :: Set a
-- Crea un conjunto vacío.
emptyS = S [] 0 

-- O(n) # porque se usa elem en xs, siendo xs la cantidad de elementos que representa n en (S xs n) 
addS :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto. 
addS e (S xs n) = if elem e xs 
                       then S xs n   
                       else S (e:xs) (n+1)

--O(n) # de costo n por elem, siendo n la longitud de xs en (S xs _)
belongsS :: Eq a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongsS e (S xs _) = elem e xs 

-- O(1) ya que se abre el constructor del Set. 
sizeS :: Eq a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.
sizeS (S _ n) = n  

-- (O n) # por usar borrarElemEn xs 
removeS :: Eq a => a -> Set a -> Set a
-- Borra un elemento del conjunto.
removeS e (S xs n) = (S (borrarElemEn e xs) n)


-- O ( n # siendo n la longitud de la lista ya que se hace RE sobre la misma. 
--  *( 1 # ya que se comparan dos elementos con == 
--     + 
--     1 # ya que se utiliza el cons     
-- ))
-- O(n*(1+1))
-- O(n*(1))
-- O(n)
borrarElemEn :: Eq a => a -> [a] -> [a]
borrarElemEn _ [] = []
borrarElemEn e (x:xs) = if e == x 
                           then borrarElemEn e xs 
                           else x : borrarElemEn e xs
                           
-- O(n^2) siendo n la longitud de xs ya que se usa unirListaConSet de costo lineal
unionS :: Eq a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos. conjuntos.
unionS (S xs n) set = unirListaConSet xs set 

-- O(n # siendo n la longitud de la lista ya que se hace RE sobre la misma. 
-- *   # por cada elemento de la RE  
-- (n  # por usar addS en por cada elemento de la RE    
-- ))
--O(n*n)
--O(n^2)
unirListaConSet :: Eq a => [a] -> Set a -> Set a 
unirListaConSet [] set     = set 
unirListaConSet (x:xs) set = addS x (unirListaConSet xs set)

-- O(1) # Ya que se abre el constructor. 
setToList :: Eq a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (S xs _) = xs 


