FasdUAS 1.101.10   ��   ��    k             l     ��  ��      rocket_tlm1_start     � 	 	 $   r o c k e t _ t l m 1 _ s t a r t   
  
 l     ��  ��      created May 5, 2016, DLW     �   2   c r e a t e d   M a y   5 ,   2 0 1 6 ,   D L W      l     ��  ��    ( " Update for 36.389 Apr 7, 2023 DLW     �   D   U p d a t e   f o r   3 6 . 3 8 9   A p r   7 ,   2 0 2 3   D L W      l     ��  ��    Z T Prerequisites: IDLDE must be running, Terminal must be running (like a new session)     �   �   P r e r e q u i s i t e s :   I D L D E   m u s t   b e   r u n n i n g ,   T e r m i n a l   m u s t   b e   r u n n i n g   ( l i k e   a   n e w   s e s s i o n )      l    	 ����  I    	��  
�� .sysonotfnull��� ��� TEXT  m        �   0 R u n n i n g   r o c k e t _ t m 1 _ s t a r t  ��   !
�� 
appr   m     " " � # #   r o c k e t _ t m 1 _ s t a r t ! �� $��
�� 
subt $ m     % % � & &  R U N N I N G . . .��  ��  ��     ' ( ' l  
  )���� ) I  
 �� * +
�� .sysottosnull���     TEXT * m   
  , , � - -   C o n n e c t i n g   T   M   1 + �� . /
�� 
VOIC . m     0 0 � 1 1  A v a / �� 2��
�� 
RATE 2 m    ����,��  ��  ��   (  3 4 3 l     ��������  ��  ��   4  5 6 5 l     �� 7 8��   7   rocket_tlm_start    8 � 9 9 "   r o c k e t _ t l m _ s t a r t 6  : ; : l  E <���� < O   E = > = k   D ? ?  @ A @ I   ������
�� .aevtrappnull��� ��� null��  ��   A  B C B I   #������
�� .miscactvnull��� ��� null��  ��   C  D E D O   $ : F G F r   - 9 H I H 4   - 3�� J
�� 
ttab J m   1 2����  I 1   3 8��
�� 
tcnt G 4  $ *�� K
�� 
cwin K m   ( )����  E  L M L I  ; K�� N O
�� .coredoscnull��� ��� ctxt N m   ; > P P � Q Q 
 c l e a r O �� R��
�� 
kfil R 4   A G�� S
�� 
cwin S m   E F���� ��   M  T U T l  L L��������  ��  ��   U  V W V l  L L�� X Y��   X , & send 3 ping packets as a wake up call    Y � Z Z L   s e n d   3   p i n g   p a c k e t s   a s   a   w a k e   u p   c a l l W  [ \ [ l  L L�� ] ^��   ] 7 1 do script "ping -c 2 169.254.17.237" in window 1    ^ � _ _ b   d o   s c r i p t   " p i n g   - c   2   1 6 9 . 2 5 4 . 1 7 . 2 3 7 "   i n   w i n d o w   1 \  ` a ` l  L L��������  ��  ��   a  b c b l  L L�� d e��   d 1 + open telnet session to the altair computer    e � f f V   o p e n   t e l n e t   s e s s i o n   t o   t h e   a l t a i r   c o m p u t e r c  g h g I  L \�� i j
�� .coredoscnull��� ��� ctxt i m   L O k k � l l 2 t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 3   8 9 9 9 j �� m��
�� 
kfil m 4   R X�� n
�� 
cwin n m   V W���� ��   h  o p o I  ] b�� q��
�� .sysodelanull��� ��� nmbr q m   ] ^���� ��   p  r s r l  c c�� t u��   t A ; list the used channels P1_RAW and P2_RAW should be 4 and 5    u � v v v   l i s t   t h e   u s e d   c h a n n e l s   P 1 _ R A W   a n d   P 2 _ R A W   s h o u l d   b e   4   a n d   5 s  w x w I  c s�� y z
�� .coredoscnull��� ��� ctxt y m   c f { { � | |  l i s t u s e d c h s z �� }��
�� 
kfil } 4   i o�� ~
�� 
cwin ~ m   m n���� ��   x   �  I  t ��� � �
�� .coredoscnull��� ��� ctxt � m   t w � � � � � ( / s t x   p r e p a r e t r a n s f e r � �� ���
�� 
kfil � 4   z ��� �
�� 
cwin � m   ~ ���� ��   �  � � � l  � ��� � ���   �   delay 1    � � � �    d e l a y   1 �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � L F The ORDER of these statements defines the tlm ORDER in decomposition.    � � � � �   T h e   O R D E R   o f   t h e s e   s t a t e m e n t s   d e f i n e s   t h e   t l m   O R D E R   i n   d e c o m p o s i t i o n . �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  megs-p temperature A97    � � � � , m e g s - p   t e m p e r a t u r e   A 9 7 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 2 7 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  megsaheater+28v A99    � � � � & m e g s a h e a t e r + 2 8 v   A 9 9 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 2 9 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  xrs+5v A103    � � � �  x r s + 5 v   A 1 0 3 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 3 3 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  solarsectionpressure A108    � � � � 2 s o l a r s e c t i o n p r e s s u r e   A 1 0 8 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 3 8 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   � # cryoCoolerColdFingerTemp A110    � � � � : c r y o C o o l e r C o l d F i n g e r T e m p   A 1 1 0 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 4 0 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  megsbHeater+28v A110    � � � � ( m e g s b H e a t e r + 2 8 v   A 1 1 0 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 4 0 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  XRSTemp1 A111    � � � �  X R S T e m p 1   A 1 1 1 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 4 1 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ��� � ���   �  MACCDTemp1 A115    � � � �  M A C C D T e m p 1   A 1 1 5 �  � � � I  ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 4 5 � �� ���
�� 
kfil � 4  �� �
�� 
cwin � m  ���� ��   �  � � � l �� � ��   �  MBCCDTemp1 A116     �  M B C C D T e m p 1   A 1 1 6 �  I ��
�� .coredoscnull��� ��� ctxt m   �  c h   1 4 6 ����
�� 
kfil 4  �	
� 
cwin	 m  �~�~ ��   

 l �}�|�{�}  �|  �{    l �z�z    MACCDTemp2 A106    �  M A C C D T e m p 2   A 1 0 6  I .�y
�y .coredoscnull��� ��� ctxt m  ! �  c h   1 3 6 �x�w
�x 
kfil 4  $*�v
�v 
cwin m  ()�u�u �w    l //�t�t    MBCCDTemp2 A107    �  M B C C D T e m p 2   A 1 0 7  I /?�s !
�s .coredoscnull��� ��� ctxt  m  /2"" �##  c h   1 3 7! �r$�q
�r 
kfil$ 4  5;�p%
�p 
cwin% m  9:�o�o �q   &'& l @@�n�m�l�n  �m  �l  ' ()( l @@�k*+�k  *   CryoCoolerHotSideTemp A118   + �,, 4 C r y o C o o l e r H o t S i d e T e m p   A 1 1 8) -.- I @P�j/0
�j .coredoscnull��� ��� ctxt/ m  @C11 �22  c h   1 4 80 �i3�h
�i 
kfil3 4  FL�g4
�g 
cwin4 m  JK�f�f �h  . 565 l QQ�e78�e  7  Exp+28V A119   8 �99  E x p + 2 8 V   A 1 1 96 :;: I Qa�d<=
�d .coredoscnull��� ��� ctxt< m  QT>> �??  c h   1 4 9= �c@�b
�c 
kfil@ 4  W]�aA
�a 
cwinA m  [\�`�` �b  ; BCB l bb�_DE�_  D  VacValvePos A124   E �FF   V a c V a l v e P o s   A 1 2 4C GHG I br�^IJ
�^ .coredoscnull��� ��� ctxtI m  beKK �LL  c h   1 5 4J �]M�\
�] 
kfilM 4  hn�[N
�[ 
cwinN m  lm�Z�Z �\  H OPO l ss�YQR�Y  Q  HVSPressure A126   R �SS   H V S P r e s s u r e   A 1 2 6P TUT I s��XVW
�X .coredoscnull��� ��� ctxtV m  svXX �YY  c h   1 5 6W �WZ�V
�W 
kfilZ 4  y�U[
�U 
cwin[ m  }~�T�T �V  U \]\ l ���S^_�S  ^  Exp+15V A120   _ �``  E x p + 1 5 V   A 1 2 0] aba I ���Rcd
�R .coredoscnull��� ��� ctxtc m  ��ee �ff  c h   1 5 0d �Qg�P
�Q 
kfilg 4  ���Oh
�O 
cwinh m  ���N�N �P  b iji l ���Mkl�M  k  DataFPGA+5V A121   l �mm   D a t a F P G A + 5 V   A 1 2 1j non I ���Lpq
�L .coredoscnull��� ��� ctxtp m  ��rr �ss  c h   1 5 1q �Kt�J
�K 
kfilt 4  ���Iu
�I 
cwinu m  ���H�H �J  o vwv l ���Gxy�G  x  TV+12V A122   y �zz  T V + 1 2 V   A 1 2 2w {|{ I ���F}~
�F .coredoscnull��� ��� ctxt} m  �� ���  c h   1 5 2~ �E��D
�E 
kfil� 4  ���C�
�C 
cwin� m  ���B�B �D  | ��� l ���A���A  �  MAFFLEDV A123   � ���  M A F F L E D V   A 1 2 3� ��� I ���@��
�@ .coredoscnull��� ��� ctxt� m  ���� ���  c h   1 5 3� �?��>
�? 
kfil� 4  ���=�
�= 
cwin� m  ���<�< �>  � ��� l ���;���;  �  MBFFLEDV A125   � ���  M B F F L E D V   A 1 2 5� ��� I ���:��
�: .coredoscnull��� ��� ctxt� m  ���� ���  c h   1 5 5� �9��8
�9 
kfil� 4  ���7�
�7 
cwin� m  ���6�6 �8  � ��� l ���5���5  � $ ExpBusCurrent/TotalCurrent A12   � ��� < E x p B u s C u r r e n t / T o t a l C u r r e n t   A 1 2� ��� I ���4��
�4 .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   2 2� �3��2
�3 
kfil� 4  ���1�
�1 
cwin� m  ���0�0 �2  � ��� l ���/���/  �  ShutterDoorBusVoltage A15   � ��� 2 S h u t t e r D o o r B u s V o l t a g e   A 1 5� ��� I ���.��
�. .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   2 4� �-��,
�- 
kfil� 4  ���+�
�+ 
cwin� m  ���*�* �,  � ��� l ���)���)  � &  ExpBusMonitor/BatteryMonitor A47   � ��� @ E x p B u s M o n i t o r / B a t t e r y M o n i t o r   A 4 7� ��� I ��(��
�( .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   7 4� �'��&
�' 
kfil� 4  �%�
�% 
cwin� m  �$�$ �&  � ��� l �#�"�!�#  �"  �!  � ��� l � ���   � 8 2 The ESP and MEGSP serial streams need to be last.   � ��� d   T h e   E S P   a n d   M E G S P   s e r i a l   s t r e a m s   n e e d   t o   b e   l a s t .� ��� l ����  �  �  � ��� l ����  �  ESPSerialStream S2   � ��� $ E S P S e r i a l S t r e a m   S 2� ��� I ���
� .coredoscnull��� ��� ctxt� m  �� ���  c h   1 9 2� ���
� 
kfil� 4  ��
� 
cwin� m  �� �  � ��� l ����  �  MEGSPSerialStream S3   � ��� ( M E G S P S e r i a l S t r e a m   S 3� ��� I -���
� .coredoscnull��� ��� ctxt� m   �� ���  c h   1 9 3� ���
� 
kfil� 4  #)��
� 
cwin� m  '(�� �  � ��� I .>���
� .coredoscnull��� ��� ctxt� m  .1�� ���  / e t x� ���
� 
kfil� 4  4:��
� 
cwin� m  89�� �  � ��� I ?D�
��	
�
 .sysodelanull��� ��� nmbr� m  ?@�� �	  �   > m    ���                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��   ; ��� l     ����  �  �  � ��� l     ����  � #  assume IDL is already opened   � ��� :   a s s u m e   I D L   i s   a l r e a d y   o p e n e d� ��� l FX���� O  FX��� k  LW�� � � I LQ�� ��
� .aevtrappnull��� ��� null�   ��    �� I RW������
�� .miscactvnull��� ��� null��  ��  ��  � m  FI�                                                                                  scut  alis    l  MacD3921                       BD ����AppleScript Utility.app                                        ����            ����  
 cu             CoreServices  6/:System:Library:CoreServices:AppleScript Utility.app/  0  A p p l e S c r i p t   U t i l i t y . a p p    M a c D 3 9 2 1  3System/Library/CoreServices/AppleScript Utility.app   / ��  �  �  �  l Y^���� I Y^����
�� .sysodelanull��� ��� nmbr m  YZ���� ��  ��  ��    l     ��������  ��  ��   	
	 l _d���� I  _d�������� (0 getidlconsolefocus getIDLConsoleFocus��  ��  ��  ��  
  l     ��������  ��  ��    l     ����   !  move to IDL Console window    � 6   m o v e   t o   I D L   C o n s o l e   w i n d o w  l     ����   &  tell application "System Events"    � @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "  l     ����    	tell process "IDL"    � & 	 t e l l   p r o c e s s   " I D L "  l     �� ��    		reopen     �!!  	 	 r e o p e n "#" l     ��$%��  $  
		activate   % �&&  	 	 a c t i v a t e# '(' l     ��)*��  )  		set frontmost to true   * �++ . 	 	 s e t   f r o n t m o s t   t o   t r u e( ,-, l     ��./��  .  		end tell   / �00  	 e n d   t e l l- 121 l     ��34��  3  end tell   4 �55  e n d   t e l l2 676 l     ��������  ��  ��  7 898 l     ��:;��  : > 8-- cmd-i in IDL sets the focus to the IDL Console window   ; �<< p - -   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w9 =>= l     ��?@��  ? L Ftell application "System Events" to keystroke "i" using {command down}   @ �AA � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " i "   u s i n g   { c o m m a n d   d o w n }> BCB l     ��������  ��  ��  C DED l     ��FG��  F    start the processing code   G �HH 4   s t a r t   t h e   p r o c e s s i n g   c o d eE IJI l ewK����K O ewLML I kv��N��
�� .prcskprsnull���     ctxtN b  krOPO m  knQQ �RR @ r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a yP 1  nq��
�� 
lnfd��  M m  ehSS�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  J TUT l     ��������  ��  ��  U VWV l xX����X O  xYZY k  | [[ \]\ I |�������
�� .aevtrappnull��� ��� null��  ��  ] ^_^ I ��������
�� .miscactvnull��� ��� null��  ��  _ `a` O  ��bcb r  ��ded 4  ����f
�� 
ttabf m  ������ e 1  ����
�� 
tcntc 4 ����g
�� 
cwing m  ������ a hih I ����j��
�� .sysodelanull��� ��� nmbrj m  ������ ��  i klk I ����mn
�� .coredoscnull��� ��� ctxtm m  ��oo �pp $ s t a r t t r a n s f e r   8 0 0 2n ��q��
�� 
kfilq 4  ����r
�� 
cwinr m  ������ ��  l sts I ����u��
�� .sysodelanull��� ��� nmbru m  ������ ��  t vwv I ����xy
�� .coredoscnull��� ��� ctxtx m  ��zz �{{  s e t m o d e   1y ��|��
�� 
kfil| 4  ����}
�� 
cwin} m  ������ ��  w ~~ I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��   ��� I ������
�� .coredoscnull��� ��� ctxt� m  ���� ��� , s e t a s y n c t i m e s t a m p s   o f f� �����
�� 
kfil� 4  �����
�� 
cwin� m  ������ ��  � ��� I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  � ��� I ������
�� .coredoscnull��� ��� ctxt� m  ���� ���  s t a r t a c q� �����
�� 
kfil� 4  �����
�� 
cwin� m  ������ ��  � ���� I � �����
�� .sysodelanull��� ��� nmbr� m  ������ ��  ��  Z m  xy���                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��  W ��� l     ��������  ��  ��  � ��� l     ������  �   resume IDL   � ���    r e s u m e   I D L� ��� l     ������  � &  tell application "System Events"   � ��� @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "� ��� l     ������  �  	tell process "IDL"   � ��� & 	 t e l l   p r o c e s s   " I D L "� ��� l     ������  �  		reopen   � ���  	 	 r e o p e n� ��� l     ������  �  
		activate   � ���  	 	 a c t i v a t e� ��� l     ������  �  		set frontmost to true   � ��� . 	 	 s e t   f r o n t m o s t   t o   t r u e� ��� l     ������  �  		end tell   � ���  	 e n d   t e l l� ��� l     ������  �  end tell   � ���  e n d   t e l l� ��� l     ������  � > 8-- cmd-i in IDL sets the focus to the IDL Console window   � ��� p - -   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w� ��� l     ������  � L Ftell application "System Events" to keystroke "i" using {command down}   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " i "   u s i n g   { c o m m a n d   d o w n }� ��� l     ��������  ��  ��  � ��� l ������ I  �������� (0 getidlconsolefocus getIDLConsoleFocus��  ��  ��  ��  � ��� l     ��������  ��  ��  � ��� l ������ O ��� I �����
�� .prcskprsnull���     ctxt� b  ��� m  �� ���  . c o n t i n u e� 1  ��
�� 
lnfd��  � m  ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  � ��� l  ������ I  �����
�� .sysodelanull��� ��� nmbr� m  �� ��  ��  ��  � ��� l     �~�}�|�~  �}  �|  � ��� l !���{�z� O  !���� k  %��� ��� I %*�y�x�w
�y .aevtrappnull��� ��� null�x  �w  � ��� I +0�v�u�t
�v .miscactvnull��� ��� null�u  �t  � ��� l 11�s���s  � . ( create a new tab (this is a second one)   � ��� P   c r e a t e   a   n e w   t a b   ( t h i s   i s   a   s e c o n d   o n e )� ��� O 1G��� I 7F�r��
�r .prcskprsnull���     ctxt� m  7:�� ���  t� �q��p
�q 
faal� J  =B�� ��o� m  =@�n
�n eMdsKcmd�o  �p  � m  14���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  � ��� I HM�m �l
�m .sysodelanull��� ��� nmbr  m  HI�k�k �l  �  l NN�j�j     switch to the second tab    � 2   s w i t c h   t o   t h e   s e c o n d   t a b  O Nd	 I Tc�i

�i .prcskprsnull���     ctxt
 m  TW �  2 �h�g
�h 
faal J  Z_ �f m  Z]�e
�e eMdsKcmd�f  �g  	 m  NQ�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��    l ee�d�d    tell front window    � " t e l l   f r o n t   w i n d o w  l ee�c�c     	set selected tab to tab 2    � 4 	 s e t   s e l e c t e d   t a b   t o   t a b   2  l ee�b�b    end tell    �    e n d   t e l l !"! I ej�a#�`
�a .sysodelanull��� ��� nmbr# m  ef�_�_ �`  " $%$ I k{�^&'
�^ .coredoscnull��� ��� ctxt& m  kn(( �)) � c d   / U s e r s / r o c k e t a d m i n / D r o p b o x / m i n x s s _ d r o p b o x / r o c k e t _ e v e / 3 6 . 3 8 9 / m i n x s s c u b e s a t / r o c k e t _ r e a l _ t i m e /' �]*�\
�] 
kfil* 4  qw�[+
�[ 
cwin+ m  uv�Z�Z �\  % ,-, I |��Y.�X
�Y .sysodelanull��� ��� nmbr. m  |// ?ə������X  - 010 I ���W23
�W .coredoscnull��� ��� ctxt2 m  ��44 �55 D / A p p l i c a t i o n s / h a r r i s / i d l 8 7 / b i n / i d l3 �V6�U
�V 
kfil6 4  ���T7
�T 
cwin7 m  ���S�S �U  1 898 I ���R:�Q
�R .sysodelanull��� ��� nmbr: m  ��;; ?ə������Q  9 <=< I ���P>?
�P .coredoscnull��� ��� ctxt> m  ��@@ �AA  s p a _ r e a l t i m e? �OB�N
�O 
kfilB 4  ���MC
�M 
cwinC m  ���L�L �N  = DED I ���KF�J
�K .sysodelanull��� ��� nmbrF m  ��GG ?ə������J  E H�IH O ��IJI I ���HK�G
�H .prcskprsnull���     ctxtK l ��L�F�EL I ���DM�C
�D .prcskcodnull���     ****M m  ���B�B $�C  �F  �E  �G  J m  ��NN�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �I  � m  !"OO�                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  �{  �z  � PQP l ��R�A�@R I ���?S�>
�? .sysodelanull��� ��� nmbrS m  ���=�= �>  �A  �@  Q TUT l ��V�<�;V O  ��WXW O  ��YZY k  ��[[ \]\ I ���:�9�8
�: .aevtrappnull��� ��� null�9  �8  ] ^_^ I ���7�6�5
�7 .miscactvnull��� ��� null�6  �5  _ `�4` r  ��aba m  ���3
�3 boovtrueb 1  ���2
�2 
pisf�4  Z 4  ���1c
�1 
prcsc m  ��dd �ee  I D LX m  ��ff�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �<  �;  U ghg l �i�0�/i I ��.jk
�. .sysonotfnull��� ��� TEXTj m  ��ll �mm 2 r o c k e t _ t m 1 _ s t a r t   f i n i s h e dk �-no
�- 
apprn m  ��pp �qq   r o c k e t _ t m 1 _ s t a r to �,r�+
�, 
subtr m  �ss �tt  D O N E�+  �0  �/  h uvu l     �*�)�(�*  �)  �(  v wxw l     �'�&�%�'  �&  �%  x yzy l     �${|�$  { / ) function to get IDL console window focus   | �}} R   f u n c t i o n   t o   g e t   I D L   c o n s o l e   w i n d o w   f o c u sz ~~ l     �#�"�!�#  �"  �!   ��� i     ��� I      � ���  (0 getidlconsolefocus getIDLConsoleFocus�  �  � k     -�� ��� l     ����  � !  move to IDL Console window   � ��� 6   m o v e   t o   I D L   C o n s o l e   w i n d o w� ��� O     ��� O    ��� k    �� ��� I   ���
� .aevtrappnull��� ��� null�  �  � ��� I   ���
� .miscactvnull��� ��� null�  �  � ��� r    ��� m    �
� boovtrue� 1    �
� 
pisf�  � 4    ��
� 
prcs� m    �� ���  I D L� m     ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  � ��� l   ����  �  �  � ��� l   ����  � < 6 cmd-i in IDL sets the focus to the IDL Console window   � ��� l   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w� ��� O   -��� I  # ,���
� .prcskprsnull���     ctxt� m   # $�� ���  i� ���
� 
faal� J   % (�� ��
� m   % &�	
�	 eMdsKcmd�
  �  � m     ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �  � ��� l     ����  �  �  �       �����  � ��� (0 getidlconsolefocus getIDLConsoleFocus
� .aevtoappnull  �   � ****� ��� ������� (0 getidlconsolefocus getIDLConsoleFocus�   ��  �  � 
�����������������
�� 
prcs
�� .aevtrappnull��� ��� null
�� .miscactvnull��� ��� null
�� 
pisf
�� 
faal
�� eMdsKcmd
�� .prcskprsnull���     ctxt�� .� *��/ *j O*j Oe*�,FUUO� ���kvl 	U� �����������
�� .aevtoappnull  �   � ****� k    ��  ��  '��  :�� ��� �� 	�� I�� V�� ��� ��� ��� ��� P�� T�� g����  ��  ��  �  � O �� "�� %���� ,�� 0����������������� P���� k�� { � � � � � � � � �"1>KXer����������SQ����oz��������(/4@������d��lps
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT
�� 
VOIC
�� 
RATE��,
�� .sysottosnull���     TEXT
�� .aevtrappnull��� ��� null
�� .miscactvnull��� ��� null
�� 
cwin
�� 
ttab
�� 
tcnt
�� 
kfil
�� .coredoscnull��� ��� ctxt
�� .sysodelanull��� ��� nmbr�� (0 getidlconsolefocus getIDLConsoleFocus
�� 
lnfd
�� .prcskprsnull���     ctxt
�� 
faal
�� eMdsKcmd�� $
�� .prcskcodnull���     ****
�� 
prcs
�� 
pisf�������� O������ O�.*j O*j O*a k/ *a k/*a ,FUOa a *a k/l Oa a *a k/l Omj Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa  a *a k/l Oa !a *a k/l Oa "a *a k/l Oa #a *a k/l Oa $a *a k/l Oa %a *a k/l Oa &a *a k/l Oa 'a *a k/l Oa (a *a k/l Oa )a *a k/l Oa *a *a k/l Oa +a *a k/l Oa ,a *a k/l Oa -a *a k/l Oa .a *a k/l Oa /a *a k/l Oa 0a *a k/l Oa 1a *a k/l Oa 2a *a k/l Oa 3a *a k/l Okj UOa 4 *j O*j UOkj O*j+ 5Oa 6 a 7_ 8%j 9UO� �*j O*j O*a k/ *a k/*a ,FUOkj Oa :a *a k/l Okj Oa ;a *a k/l Okj Oa <a *a k/l Okj Oa =a *a k/l Okj UO*j+ 5Oa 6 a >_ 8%j 9UOlj O� �*j O*j Oa 6 a ?a @a Akvl 9UOkj Oa 6 a Ba @a Akvl 9UOkj Oa Ca *a k/l Oa Dj Oa Ea *a k/l Oa Dj Oa Fa *a k/l Oa Dj Oa 6 a Gj Hj 9UUOlj Oa 6 !*a Ia J/ *j O*j Oe*a K,FUUOa L�a M�a N�  ascr  ��ޭ