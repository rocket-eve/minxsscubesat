FasdUAS 1.101.10   ��   ��    k             l     ��  ��      rocket_tlm1_start     � 	 	 $   r o c k e t _ t l m 1 _ s t a r t   
  
 l     ��  ��      created May 5, 2016, DLW     �   2   c r e a t e d   M a y   5 ,   2 0 1 6 ,   D L W      l     ��������  ��  ��        l    	 ����  I    	��  
�� .sysonotfnull��� ��� TEXT  m        �   0 R u n n i n g   r o c k e t _ t m 1 _ s t a r t  ��  
�� 
appr  m       �     r o c k e t _ t m 1 _ s t a r t  �� ��
�� 
subt  m       �    R U N N I N G . . .��  ��  ��         l     ��������  ��  ��      ! " ! l     �� # $��   #   rocket_tlm_start    $ � % % "   r o c k e t _ t l m _ s t a r t "  & ' & l  
� (���� ( O   
� ) * ) k   � + +  , - , I   ������
�� .aevtrappnull��� ��� null��  ��   -  . / . I   ������
�� .miscactvnull��� ��� null��  ��   /  0 1 0 O    * 2 3 2 r   ! ) 4 5 4 4   ! %�� 6
�� 
ttab 6 m   # $����  5 1   % (��
�� 
tcnt 3 4   �� 7
�� 
cwin 7 m    ����  1  8 9 8 l  + +�� : ;��   :   delay 1    ; � < <    d e l a y   1 9  = > = l  + +�� ? @��   ? C = do script ("echo \"Starting rocket_tlm_start\"") in window 1    @ � A A z   d o   s c r i p t   ( " e c h o   \ " S t a r t i n g   r o c k e t _ t l m _ s t a r t \ " " )   i n   w i n d o w   1 >  B C B l  + +�� D E��   D #  do script "date" in window 1    E � F F :   d o   s c r i p t   " d a t e "   i n   w i n d o w   1 C  G H G l  + +�� I J��   I   delay 1    J � K K    d e l a y   1 H  L M L l  + +�� N O��   N , & send 3 ping packets as a wake up call    O � P P L   s e n d   3   p i n g   p a c k e t s   a s   a   w a k e   u p   c a l l M  Q R Q l  + +�� S T��   S 7 1 do script "ping -c 2 169.254.17.237" in window 1    T � U U b   d o   s c r i p t   " p i n g   - c   2   1 6 9 . 2 5 4 . 1 7 . 2 3 7 "   i n   w i n d o w   1 R  V W V l  + +�� X Y��   X 1 + open telnet session to the altair computer    Y � Z Z V   o p e n   t e l n e t   s e s s i o n   t o   t h e   a l t a i r   c o m p u t e r W  [ \ [ I  + 5�� ] ^
�� .coredoscnull��� ��� ctxt ] m   + , _ _ � ` ` 2 t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 3   8 9 9 9 ^ �� a��
�� 
kfil a 4   - 1�� b
�� 
cwin b m   / 0���� ��   \  c d c I  6 ;�� e��
�� .sysodelanull��� ��� nmbr e m   6 7���� ��   d  f g f l  < <�� h i��   h A ; list the used channels P1_RAW and P2_RAW should be 4 and 5    i � j j v   l i s t   t h e   u s e d   c h a n n e l s   P 1 _ R A W   a n d   P 2 _ R A W   s h o u l d   b e   4   a n d   5 g  k l k I  < H�� m n
�� .coredoscnull��� ��� ctxt m m   < ? o o � p p  l i s t u s e d c h s n �� q��
�� 
kfil q 4   @ D�� r
�� 
cwin r m   B C���� ��   l  s t s I  I U�� u v
�� .coredoscnull��� ��� ctxt u m   I L w w � x x ( / s t x   p r e p a r e t r a n s f e r v �� y��
�� 
kfil y 4   M Q�� z
�� 
cwin z m   O P���� ��   t  { | { l  V V�� } ~��   }   delay 1    ~ �      d e l a y   1 |  � � � l  V V�� � ���   �  megs-p temperature A97    � � � � , m e g s - p   t e m p e r a t u r e   A 9 7 �  � � � I  V b�� � �
�� .coredoscnull��� ��� ctxt � m   V Y � � � � � 
 c h   9 8 � �� ���
�� 
kfil � 4   Z ^�� �
�� 
cwin � m   \ ]���� ��   �  � � � l  c c�� � ���   �  megsaheater+28v A99    � � � � & m e g s a h e a t e r + 2 8 v   A 9 9 �  � � � I  c o�� � �
�� .coredoscnull��� ��� ctxt � m   c f � � � � �  c h   1 0 0 � �� ���
�� 
kfil � 4   g k�� �
�� 
cwin � m   i j���� ��   �  � � � l  p p�� � ���   �  xrs+5v A103    � � � �  x r s + 5 v   A 1 0 3 �  � � � I  p |�� � �
�� .coredoscnull��� ��� ctxt � m   p s � � � � �  c h   1 0 4 � �� ���
�� 
kfil � 4   t x�� �
�� 
cwin � m   v w���� ��   �  � � � l  } }�� � ���   �  solarsectionpressure A108    � � � � 2 s o l a r s e c t i o n p r e s s u r e   A 1 0 8 �  � � � I  } ��� � �
�� .coredoscnull��� ��� ctxt � m   } � � � � � �  c h   1 0 9 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   � # cryoCoolerColdFingerTemp A110    � � � � : c r y o C o o l e r C o l d F i n g e r T e m p   A 1 1 0 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 0 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  megsbHeater+28v A110    � � � � ( m e g s b H e a t e r + 2 8 v   A 1 1 0 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 1 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  XRSTemp1 A111    � � � �  X R S T e m p 1   A 1 1 1 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 2 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  MACCDTemp A115    � � � �  M A C C D T e m p   A 1 1 5 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 6 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  MBCCDTemp A116    � � � �  M B C C D T e m p   A 1 1 6 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 7 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  CryCoolerHotSideTemp A118    � � � � 2 C r y C o o l e r H o t S i d e T e m p   A 1 1 8 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 9 � �� ��
�� 
kfil  4   � ���
�� 
cwin m   � ����� ��   �  l  � �����    Exp+28V A119    �  E x p + 2 8 V   A 1 1 9  I  � ���	

�� .coredoscnull��� ��� ctxt	 m   � � �  c h   1 2 0
 ����
�� 
kfil 4   � ���
�� 
cwin m   � ����� ��    l  � �����    VacValvePos A124    �   V a c V a l v e P o s   A 1 2 4  I  � ���
�� .coredoscnull��� ��� ctxt m   � � �  c h   1 2 5 ����
�� 
kfil 4   � ���
�� 
cwin m   � ����� ��    l  � ���    HVSPressure A126    �     H V S P r e s s u r e   A 1 2 6 !"! I  � ��~#$
�~ .coredoscnull��� ��� ctxt# m   � �%% �&&  c h   1 2 7$ �}'�|
�} 
kfil' 4   � ��{(
�{ 
cwin( m   � ��z�z �|  " )*) l  � ��y+,�y  +  Exp+15V A120   , �--  E x p + 1 5 V   A 1 2 0* ./. I  ��x01
�x .coredoscnull��� ��� ctxt0 m   �22 �33  c h   1 2 11 �w4�v
�w 
kfil4 4  �u5
�u 
cwin5 m  �t�t �v  / 676 l �s89�s  8  DataFPGA+5V A121   9 �::   D a t a F P G A + 5 V   A 1 2 17 ;<; I �r=>
�r .coredoscnull��� ��� ctxt= m  ?? �@@  c h   1 2 2> �qA�p
�q 
kfilA 4  �oB
�o 
cwinB m  �n�n �p  < CDC l �mEF�m  E  TV+12V A122   F �GG  T V + 1 2 V   A 1 2 2D HIH I %�lJK
�l .coredoscnull��� ��� ctxtJ m  LL �MM  c h   1 2 3K �kN�j
�k 
kfilN 4  !�iO
�i 
cwinO m   �h�h �j  I PQP l &&�gRS�g  R  MAFFLEDV A123   S �TT  M A F F L E D V   A 1 2 3Q UVU I &2�fWX
�f .coredoscnull��� ��� ctxtW m  &)YY �ZZ  c h   1 2 4X �e[�d
�e 
kfil[ 4  *.�c\
�c 
cwin\ m  ,-�b�b �d  V ]^] l 33�a_`�a  _  MBFFLEDV A124   ` �aa  M B F F L E D V   A 1 2 4^ bcb I 3?�`de
�` .coredoscnull��� ��� ctxtd m  36ff �gg  c h   1 2 6e �_h�^
�_ 
kfilh 4  7;�]i
�] 
cwini m  9:�\�\ �^  c jkj l @@�[lm�[  l $ ExpBusCurrent/TotalCurrent A12   m �nn < E x p B u s C u r r e n t / T o t a l C u r r e n t   A 1 2k opo I @L�Zqr
�Z .coredoscnull��� ��� ctxtq m  @Css �tt 
 c h   1 3r �Yu�X
�Y 
kfilu 4  DH�Wv
�W 
cwinv m  FG�V�V �X  p wxw l MM�Uyz�U  y  ShutterDoorBusVoltage A15   z �{{ 2 S h u t t e r D o o r B u s V o l t a g e   A 1 5x |}| I MY�T~
�T .coredoscnull��� ��� ctxt~ m  MP�� ��� 
 c h   1 6 �S��R
�S 
kfil� 4  QU�Q�
�Q 
cwin� m  ST�P�P �R  } ��� l ZZ�O���O  � &  ExpBusMonitor/BatteryMonitor A47   � ��� @ E x p B u s M o n i t o r / B a t t e r y M o n i t o r   A 4 7� ��� I Zf�N��
�N .coredoscnull��� ��� ctxt� m  Z]�� ��� 
 c h   4 8� �M��L
�M 
kfil� 4  ^b�K�
�K 
cwin� m  `a�J�J �L  � ��� l gg�I���I  �  ESPSerialStream S2   � ��� $ E S P S e r i a l S t r e a m   S 2� ��� I gs�H��
�H .coredoscnull��� ��� ctxt� m  gj�� ���  c h   1 3 4� �G��F
�G 
kfil� 4  ko�E�
�E 
cwin� m  mn�D�D �F  � ��� l tt�C���C  �  MEGSPSerialStream S3   � ��� ( M E G S P S e r i a l S t r e a m   S 3� ��� I t��B��
�B .coredoscnull��� ��� ctxt� m  tw�� ���  c h   1 3 5� �A��@
�A 
kfil� 4  x|�?�
�? 
cwin� m  z{�>�> �@  � ��� I ���=��
�= .coredoscnull��� ��� ctxt� m  ���� ���  / e t x� �<��;
�< 
kfil� 4  ���:�
�: 
cwin� m  ���9�9 �;  � ��8� I ���7��6
�7 .sysodelanull��� ��� nmbr� m  ���5�5 �6  �8   * m   
 ���                                                                                      @ alis    B  MacL4131                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c L 4 1 3 1  *System/Applications/Utilities/Terminal.app  / ��  ��  ��   ' ��� l     �4�3�2�4  �3  �2  � ��� l     �1���1  � #  assume IDL is already opened   � ��� :   a s s u m e   I D L   i s   a l r e a d y   o p e n e d� ��� l ����0�/� O  ����� k  ���� ��� I ���.�-�,
�. .aevtrappnull��� ��� null�-  �,  � ��+� I ���*�)�(
�* .miscactvnull��� ��� null�)  �(  �+  � m  �����                                                                                  scut  alis    l  MacL4131                       BD ����AppleScript Utility.app                                        ����            ����  
 cu             CoreServices  6/:System:Library:CoreServices:AppleScript Utility.app/  0  A p p l e S c r i p t   U t i l i t y . a p p    M a c L 4 1 3 1  3System/Library/CoreServices/AppleScript Utility.app   / ��  �0  �/  � ��� l ����'�&� I ���%��$
�% .sysodelanull��� ��� nmbr� m  ���#�# �$  �'  �&  � ��� l     �"���"  � !  move to IDL Console window   � ��� 6   m o v e   t o   I D L   C o n s o l e   w i n d o w� ��� l ����!� � O  ����� O  ����� k  ���� ��� I �����
� .aevtrappnull��� ��� null�  �  � ��� I �����
� .miscactvnull��� ��� null�  �  � ��� r  ����� m  ���
� boovtrue� 1  ���
� 
pisf�  � 4  ����
� 
prcs� m  ���� ���  I D L� m  �����                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  �!  �   � ��� l ������ I �����
� .sysodelanull��� ��� nmbr� m  ���� �  �  �  � ��� l ������ O ����� I �����
� .prcskprsnull���     ctxt� m  ���� ���  i� ���
� 
faal� J  ���� ��� m  ���

�
 eMdsKcmd�  �  � m  �����                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  �  �  � ��� l ����	�� I �����
� .sysodelanull��� ��� nmbr� m  ���� �  �	  �  � ��� l ����� O ���� I ����
� .prcskprsnull���     ctxt� m  ��� ��� @ r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a y�  � m  ��  �                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  �  �  �  l � �� I ����
�� .sysodelanull��� ��� nmbr m  ���� ��  �   ��    l     ����     now hit the return key    �		 .   n o w   h i t   t h e   r e t u r n   k e y 

 l ���� O  I ����
�� .prcskprsnull���     ctxt l ���� I ����
�� .prcskcodnull���     **** m  ���� $��  ��  ��  ��   m  �                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��    l  %���� I  %����
�� .sysodelanull��� ��� nmbr m   !���� ��  ��  ��    l     ��������  ��  ��    l &����� O  &� k  *�   I */������
�� .aevtrappnull��� ��� null��  ��    !"! I 05������
�� .miscactvnull��� ��� null��  ��  " #$# I 6;��%��
�� .sysodelanull��� ��� nmbr% m  67���� ��  $ &'& I <H��()
�� .coredoscnull��� ��� ctxt( m  <?** �++ $ s t a r t t r a n s f e r   8 0 0 2) ��,��
�� 
kfil, 4  @D��-
�� 
cwin- m  BC���� ��  ' ./. I IN��0��
�� .sysodelanull��� ��� nmbr0 m  IJ���� ��  / 121 I O[��34
�� .coredoscnull��� ��� ctxt3 m  OR55 �66  s e t m o d e   14 ��7��
�� 
kfil7 4  SW��8
�� 
cwin8 m  UV���� ��  2 9:9 I \a��;��
�� .sysodelanull��� ��� nmbr; m  \]���� ��  : <=< I bn��>?
�� .coredoscnull��� ��� ctxt> m  be@@ �AA , s e t a s y n c t i m e s t a m p s   o f f? ��B��
�� 
kfilB 4  fj��C
�� 
cwinC m  hi���� ��  = DED I ot��F��
�� .sysodelanull��� ��� nmbrF m  op���� ��  E GHG I u���IJ
�� .coredoscnull��� ��� ctxtI m  uxKK �LL  s t a r t a c qJ ��M��
�� 
kfilM 4  y}��N
�� 
cwinN m  {|���� ��  H O��O I ����P��
�� .sysodelanull��� ��� nmbrP m  ������ ��  ��   m  &'QQ�                                                                                      @ alis    B  MacL4131                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c L 4 1 3 1  *System/Applications/Utilities/Terminal.app  / ��  ��  ��   RSR l     ��������  ��  ��  S TUT l     ��VW��  V   resume IDL   W �XX    r e s u m e   I D LU YZY l ��[����[ O  ��\]\ O  ��^_^ k  ��`` aba I ��������
�� .aevtrappnull��� ��� null��  ��  b cdc I ��������
�� .miscactvnull��� ��� null��  ��  d e��e r  ��fgf m  ����
�� boovtrueg 1  ����
�� 
pisf��  _ 4  ����h
�� 
prcsh m  ��ii �jj  I D L] m  ��kk�                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  Z lml l ��n����n O ��opo I ����q��
�� .prcskprsnull���     ctxtq m  ��rr �ss  . c o n t i n u e��  p m  ��tt�                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  m uvu l ��w����w I ����x��
�� .sysodelanull��� ��� nmbrx m  ������ ��  ��  ��  v yzy l     ��{|��  {   now hit the return key   | �}} .   n o w   h i t   t h e   r e t u r n   k e yz ~~ l �������� O ����� I �������
�� .prcskprsnull���     ctxt� l �������� I �������
�� .prcskcodnull���     ****� m  ������ $��  ��  ��  ��  � m  �����                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��   ��� l     ������  �   delay 1   � ���    d e l a y   1� ��� l     ��������  ��  ��  � ��� l �������� I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  ��  ��  � ��� l     ��������  ��  ��  � ��� l �z������ O  �z��� k  �y�� ��� I ��������
�� .aevtrappnull��� ��� null��  ��  � ��� I ��������
�� .miscactvnull��� ��� null��  ��  � ��� O ���� I �����
�� .prcskprsnull���     ctxt� m  ���� ���  t� �����
�� 
faal� J  ���� ���� m  ����
�� eMdsKcmd��  ��  � m  �����                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  � ��� I 
�����
�� .sysodelanull��� ��� nmbr� m  �� ��  � ��� O !��� I  �~��
�~ .prcskprsnull���     ctxt� m  �� ���  2� �}��|
�} 
faal� J  �� ��{� m  �z
�z eMdsKcmd�{  �|  � m  ���                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  � ��� I "'�y��x
�y .sysodelanull��� ��� nmbr� m  "#�w�w �x  � ��� I (4�v��
�v .coredoscnull��� ��� ctxt� m  (+�� ��� � c d   / U s e r s / r o c k e t a d m i n / D r o p b o x / m i n x s s _ d r o p b o x / c o d e / r o c k e t _ r e a l _ t i m e /� �u��t
�u 
kfil� 4  ,0�s�
�s 
cwin� m  ./�r�r �t  � ��� I 5<�q��p
�q .sysodelanull��� ��� nmbr� m  58�� ?ə������p  � ��� I =I�o��
�o .coredoscnull��� ��� ctxt� m  =@�� ���  i d l� �n��m
�n 
kfil� 4  AE�l�
�l 
cwin� m  CD�k�k �m  � ��� I JQ�j��i
�j .sysodelanull��� ��� nmbr� m  JM�� ?ə������i  � ��� I R^�h��
�h .coredoscnull��� ��� ctxt� m  RU�� ���  s p a _ r e a l t i m e� �g��f
�g 
kfil� 4  VZ�e�
�e 
cwin� m  XY�d�d �f  � ��� I _f�c��b
�c .sysodelanull��� ��� nmbr� m  _b�� ?ə������b  � ��a� O gy��� I mx�`��_
�` .prcskprsnull���     ctxt� l mt��^�]� I mt�\��[
�\ .prcskcodnull���     ****� m  mp�Z�Z $�[  �^  �]  �_  � m  gj���                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  �a  � m  �����                                                                                      @ alis    B  MacL4131                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c L 4 1 3 1  *System/Applications/Utilities/Terminal.app  / ��  ��  ��  � ��� l {���Y�X� I {��W��V
�W .sysodelanull��� ��� nmbr� m  {|�U�U �V  �Y  �X  � ��� l ����T�S� O  ����� O  ����� k  ���� ��� I ���R�Q�P
�R .aevtrappnull��� ��� null�Q  �P  � ��� I ���O�N�M
�O .miscactvnull��� ��� null�N  �M  � ��L� r  ����� m  ���K
�K boovtrue� 1  ���J
�J 
pisf�L  � 4  ���I�
�I 
prcs� m  ���� ���  I D L� m  �����                                                                                  sevs  alis    T  MacL4131                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 1 3 1  -System/Library/CoreServices/System Events.app   / ��  �T  �S  � � � l ���H�G I ���F
�F .sysonotfnull��� ��� TEXT m  �� � 2 r o c k e t _ t m 1 _ s t a r t   f i n i s h e d �E
�E 
appr m  �� �		   r o c k e t _ t m 1 _ s t a r t �D
�C
�D 
subt
 m  �� �  D O N E�C  �H  �G    �B l     �A�@�?�A  �@  �?  �B       �>�>   �=
�= .aevtoappnull  �   � **** �<�;�:�9
�< .aevtoappnull  �   � **** k    �    & � � � � � � �  
     Y!! l"" u## ~$$ �%% �&& �'' �(( ��8�8  �;  �:     G �7 �6 �5�4��3�2�1�0�/ _�.�-�, o w � � � � � � � � � �%2?LYfs��������+��*��)�(�'��&�%*5@Kir�������
�7 
appr
�6 
subt�5 
�4 .sysonotfnull��� ��� TEXT
�3 .aevtrappnull��� ��� null
�2 .miscactvnull��� ��� null
�1 
cwin
�0 
ttab
�/ 
tcnt
�. 
kfil
�- .coredoscnull��� ��� ctxt
�, .sysodelanull��� ��� nmbr
�+ 
prcs
�* 
pisf
�) 
faal
�( eMdsKcmd
�' .prcskprsnull���     ctxt�& $
�% .prcskcodnull���     ****�9������� O��*j O*j 	O*�k/ 
*�k/*�,FUO��*�k/l Omj Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa  �*�k/l Oa !�*�k/l Oa "�*�k/l Oa #�*�k/l Oa $�*�k/l Oa %�*�k/l Oa &�*�k/l Oa '�*�k/l Oa (�*�k/l Oa )�*�k/l Oa *�*�k/l Okj UOa + *j O*j 	UOkj Oa , !*a -a ./ *j O*j 	Oe*a /,FUUOkj Oa , a 0a 1a 2kvl 3UOkj Oa , 	a 4j 3UOkj Oa , a 5j 6j 3UOlj O� _*j O*j 	Okj Oa 7�*�k/l Okj Oa 8�*�k/l Okj Oa 9�*�k/l Okj Oa :�*�k/l Okj UOa , !*a -a ;/ *j O*j 	Oe*a /,FUUOa , 	a <j 3UOkj Oa , a 5j 6j 3UOlj O� �*j O*j 	Oa , a =a 1a 2kvl 3UOkj Oa , a >a 1a 2kvl 3UOkj Oa ?�*�k/l Oa @j Oa A�*�k/l Oa @j Oa B�*�k/l Oa @j Oa , a 5j 6j 3UUOlj Oa , !*a -a C/ *j O*j 	Oe*a /,FUUOa D�a E�a F� ascr  ��ޭ