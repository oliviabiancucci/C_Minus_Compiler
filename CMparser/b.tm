0:    LD 6, 0(0)    
  1:   LDA 5, 0(6)    
  2:    ST 0, 0(0)    
  4:    ST 0, -1(5)    
  5:    IN 0, 0, 0    
  6:    LD 7, -1(5)    
  7:    ST 0, -1(5)    
  8:    LD 0, 1(5)    
  9:   OUT 0, 0, 0    
 10:    LD 7, -1(5)    
  3:   LDA 7, 7(7)    
* start: main()
 12:    ST 0, -1(5)    store return addr
* allocated space for local var x@FP-2
* allocated space for local var y@FP-3
* absyn.VarExpr@13221655 = absyn.IntExpr@2f2c9b19
 13:   LDC 0, 10(0)    
 14:    ST 0, -4(5)    
 15:    LD 0, -4(5)    
 16:    ST 0, -3(5)    
* absyn.VarExpr@31befd9f = absyn.OpExpr@1c20c684
 17:   LDC 0, 5(0)    
 18:    ST 0, -4(5)    
 19:    LD 0, -3(5)    
 20:    ST 0, -5(5)    
 21:    LD 0, -4(5)    
 22:    LD 1, -5(5)    
* absyn.IntExpr@1fb3ebeb PLUS absyn.VarExpr@548c4f57
 23:   ADD 0, 0, 1    
 24:    ST 0, -4(5)    
 25:    LD 0, -4(5)    
 26:    ST 0, -2(5)    
 27:    LD 7, -1(5)    load return addr
* end: main()
 11:   LDA 7, 16(7)    jump main body
 28:    ST 5, -1(5)    
 29:   LDA 5, -1(5)    
 30:   LDA 0, 1(7)    
 31:   LDA 7, -20(7)    jump to main
 32:    LD 5, 0(5)    
 33:  HALT 0, 0, 0 