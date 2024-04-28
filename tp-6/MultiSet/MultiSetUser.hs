import MultiSet 

ocurrencesMSUser :: [Char] -> MultiSet Char 
ocurrencesMSUser []     = emptyMS 
ocurrencesMSUser (s:ss) = addMS s (ocurrencesMSUser ss)