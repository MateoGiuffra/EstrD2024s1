import MaxHeap

heap = crearHeap [10,50,100,1,8] emptyH

tripulantesMH :: Ord a => MaxHeap a -> [a]
tripulantesMH mh =  if isEmptyH mh 
                        then [] 
                        else (maxH mh) : (tripulantesMH (deleteMaxH mh))

insertarEnOrden :: Ord a => a -> [a] -> [a]
insertarEnOrden e []     = [e]
insertarEnOrden e (x:xs) = if e < x  then e:x:xs else x : insertarEnOrden e xs  

crearHeap :: Ord a => [a] -> MaxHeap a -> MaxHeap a
crearHeap []     mh = mh 
crearHeap (n:ns) mh =  insertH n (crearHeap ns mh)

-- MaxHeap, siendo M la cantidad de elementos en la heap:

-- emptyH :: MaxHeap a                              O(1)
-- isEmptyH :: MaxHeap a -> Bool                    O(1)
-- insertH :: a -> MaxHeap a -> MaxHeap a           O(log M)
-- maxH :: MaxHeap a -> a                           O(1)
-- deleteMaxH :: MaxHeap a -> MaxHeap a             O(log M)
 