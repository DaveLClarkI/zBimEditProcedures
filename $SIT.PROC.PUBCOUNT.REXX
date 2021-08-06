/*--------------------------------------------------------------------*/
/* SYPUBCNT - Count PUB entries and display information about each    */
/*--------------------------------------------------------------------*/

  !._AComRg =C2X(Storage("00000014",4))
  !._APUBTAB=C2X(Storage(D2X(X2D(!._AComRg)+X2D(40),8),2)) /* 00002F68*/

  /*********       1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16   ***/
  /*********       17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32  ***/
  /*********        33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 ***/
  !._DevTypeCode="11 12 20 21 22 23 30 31 32 90 6B 6C 6E 80 B0 00",
                  "DE 52 53 54 55 56 5A 7E 7D 7C 7E 40 42 43 45 46",
                   "F0 D0 D2 DC DF 81 FF E0"
  /********       1    2     3     4      5     6      7      8      9*/
  /********         10   11   12   13   14   15    16    17   18   19 */
  /********       20       21  22   23   24   25   26   27   28    29 */
  /********     30   31   32  33   34   35   36   37   38   39   40   */
  !._DevType="2540R 3505 2520B 2540P 1442N2 3525P 1442N1 2520B1 3525RP",
               "FBA(V) 3375 3380 ECKD 3540 3277 1050A 3791L 3420 3422",
             "3424/80/90 9347 TPA 9347 3890 3895 3886 3890 1403 1403U",
             "PRT1 3800 4248 AFP 2701 2703 3705 CTCA ESCD UNSP OSAX"
  DevTyp.0=0

  Say " Num  CUU Ty CC Fl Md Description"
  Cnt=0
  i=X2D(!._APUBTAB)
  Do forever
    t=C2X(Storage(D2X(i,8),8))
    If Left(t,1)="F" then
      Leave
    DevCUU =Left(t,4)
    DevType=Substr(t,9,2)
    DevCC  =Substr(t,11,2)
    Devfl  =Substr(t,13,2)
    DevMd  =Substr(t,15,2)
    d=WordPos(DevType,!._DevTypeCode)
    If d>0 then
      DeviceType=Word(!._DevType,d)
    else
      DeviceType="?????"
    Do j=1 to DevTyp.0
      If DevTyp.j=DevType then
        Leave
    End
    If j>DevTyp.0 then
      Do
        DevTyp.0=j
        DevTyp.j=DevType
        DevTyp.j._Cnt=1
      End
    else
      DevTyp.j._Cnt=DevTyp.j._Cnt+1
    Cnt=Cnt+1
    Say Right(Cnt,4) DevCUU DevType DevCC DevFl DevMd DeviceType
    i=i+8
  End
  Say "Total number of PUB entries:" Cnt
  Say
  Say "Count DevTyp Description"
  Do i=1 to DevTyp.0
    d=WordPos(DevTyp.i,!._DevTypeCode)
    If d>0 then
      DeviceType=Word(!._DevType,d)
    else
      DeviceType="?????"
    Say Right(DevTyp.i._Cnt,5) Right(DevTyp.i,6) DeviceType
  End
Exit
