FasdUAS 1.101.10   ��   ��    k             l     ��  ��      rocket_tlm1_start     � 	 	 $   r o c k e t _ t l m 1 _ s t a r t   
  
 l     ��  ��      created May 5, 2016, DLW     �   2   c r e a t e d   M a y   5 ,   2 0 1 6 ,   D L W      l     ��  ��    ( " Update for 36.389 Apr 7, 2023 DLW     �   D   U p d a t e   f o r   3 6 . 3 8 9   A p r   7 ,   2 0 2 3   D L W      l     ��  ��    Z T Prerequisites: IDLDE must be running, Terminal must be running (like a new session)     �   �   P r e r e q u i s i t e s :   I D L D E   m u s t   b e   r u n n i n g ,   T e r m i n a l   m u s t   b e   r u n n i n g   ( l i k e   a   n e w   s e s s i o n )      l    	 ����  I    	��  
�� .sysonotfnull��� ��� TEXT  m        �   0 R u n n i n g   r o c k e t _ t m 1 _ s t a r t  ��   !
�� 
appr   m     " " � # #   r o c k e t _ t m 1 _ s t a r t ! �� $��
�� 
subt $ m     % % � & &  R U N N I N G . . .��  ��  ��     ' ( ' l     ��������  ��  ��   (  ) * ) l  
  +���� + I  
 �� , -
�� .sysottosnull���     TEXT , m   
  . . � / /   C o n n e c t i n g   T   M   1 - �� 0 1
�� 
VOIC 0 m     2 2 � 3 3  S a m a n t h a 1 �� 4��
�� 
RATE 4 m    ����,��  ��  ��   *  5 6 5 l     ��������  ��  ��   6  7 8 7 l     �� 9 :��   9   rocket_tlm_start    : � ; ; "   r o c k e t _ t l m _ s t a r t 8  < = < l  E >���� > O   E ? @ ? k   D A A  B C B I   ������
�� .aevtrappnull��� ��� null��  ��   C  D E D I   #������
�� .miscactvnull��� ��� null��  ��   E  F G F O   $ : H I H r   - 9 J K J 4   - 3�� L
�� 
ttab L m   1 2����  K 1   3 8��
�� 
tcnt I 4  $ *�� M
�� 
cwin M m   ( )����  G  N O N I  ; K�� P Q
�� .coredoscnull��� ��� ctxt P m   ; > R R � S S 
 c l e a r Q �� T��
�� 
kfil T 4   A G�� U
�� 
cwin U m   E F���� ��   O  V W V l  L L��������  ��  ��   W  X Y X l  L L�� Z [��   Z , & send 3 ping packets as a wake up call    [ � \ \ L   s e n d   3   p i n g   p a c k e t s   a s   a   w a k e   u p   c a l l Y  ] ^ ] l  L L�� _ `��   _ 7 1 do script "ping -c 2 169.254.17.237" in window 1    ` � a a b   d o   s c r i p t   " p i n g   - c   2   1 6 9 . 2 5 4 . 1 7 . 2 3 7 "   i n   w i n d o w   1 ^  b c b l  L L��������  ��  ��   c  d e d l  L L�� f g��   f 1 + open telnet session to the altair computer    g � h h V   o p e n   t e l n e t   s e s s i o n   t o   t h e   a l t a i r   c o m p u t e r e  i j i I  L \�� k l
�� .coredoscnull��� ��� ctxt k m   L O m m � n n 4 t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 0 1   8 9 9 9 l �� o��
�� 
kfil o 4   R X�� p
�� 
cwin p m   V W���� ��   j  q r q I  ] b�� s��
�� .sysodelanull��� ��� nmbr s m   ] ^���� ��   r  t u t l  c c�� v w��   v A ; list the used channels P1_RAW and P2_RAW should be 4 and 5    w � x x v   l i s t   t h e   u s e d   c h a n n e l s   P 1 _ R A W   a n d   P 2 _ R A W   s h o u l d   b e   4   a n d   5 u  y z y I  c s�� { |
�� .coredoscnull��� ��� ctxt { m   c f } } � ~ ~  l i s t u s e d c h s | �� ��
�� 
kfil  4   i o�� �
�� 
cwin � m   m n���� ��   z  � � � I  t ��� � �
�� .coredoscnull��� ��� ctxt � m   t w � � � � � ( / s t x   p r e p a r e t r a n s f e r � �� ���
�� 
kfil � 4   z ��� �
�� 
cwin � m   ~ ���� ��   �  � � � l  � ��� � ���   �   delay 1    � � � �    d e l a y   1 �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � L F The ORDER of these statements defines the tlm ORDER in decomposition.    � � � � �   T h e   O R D E R   o f   t h e s e   s t a t e m e n t s   d e f i n e s   t h e   t l m   O R D E R   i n   d e c o m p o s i t i o n . �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � 2 ,megs-p temperature A97  --DeweSoft Channel 1    � � � � X m e g s - p   t e m p e r a t u r e   A 9 7     - - D e w e S o f t   C h a n n e l   1 �  � � � I  � ��� � �
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
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 3 9 � �� ���
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
cwin � m  ���� ��   �  �  � l ����    MBCCDTemp1 A116    �  M B C C D T e m p 1   A 1 1 6   I �
� .coredoscnull��� ��� ctxt m   �		  c h   1 4 6 �~
�}
�~ 
kfil
 4  �|
�| 
cwin m  �{�{ �}    l �z�y�x�z  �y  �x    l �w�w    MACCDTemp2 A106    �  M A C C D T e m p 2   A 1 0 6  I .�v
�v .coredoscnull��� ��� ctxt m  ! �  c h   1 3 6 �u�t
�u 
kfil 4  $*�s
�s 
cwin m  ()�r�r �t    l //�q�q    MBCCDTemp2 A107    �  M B C C D T e m p 2   A 1 0 7  !  I /?�p"#
�p .coredoscnull��� ��� ctxt" m  /2$$ �%%  c h   1 3 7# �o&�n
�o 
kfil& 4  5;�m'
�m 
cwin' m  9:�l�l �n  ! ()( l @@�k�j�i�k  �j  �i  ) *+* l @@�h,-�h  ,   CryoCoolerHotSideTemp A118   - �.. 4 C r y o C o o l e r H o t S i d e T e m p   A 1 1 8+ /0/ I @P�g12
�g .coredoscnull��� ��� ctxt1 m  @C33 �44  c h   1 4 82 �f5�e
�f 
kfil5 4  FL�d6
�d 
cwin6 m  JK�c�c �e  0 787 l QQ�b9:�b  9  Exp+28V A119   : �;;  E x p + 2 8 V   A 1 1 98 <=< I Qa�a>?
�a .coredoscnull��� ��� ctxt> m  QT@@ �AA  c h   1 4 9? �`B�_
�` 
kfilB 4  W]�^C
�^ 
cwinC m  [\�]�] �_  = DED l bb�\FG�\  F  VacValvePos A124   G �HH   V a c V a l v e P o s   A 1 2 4E IJI I br�[KL
�[ .coredoscnull��� ��� ctxtK m  beMM �NN  c h   1 5 4L �ZO�Y
�Z 
kfilO 4  hn�XP
�X 
cwinP m  lm�W�W �Y  J QRQ l ss�VST�V  S  HVSPressure A126   T �UU   H V S P r e s s u r e   A 1 2 6R VWV I s��UXY
�U .coredoscnull��� ��� ctxtX m  svZZ �[[  c h   1 5 6Y �T\�S
�T 
kfil\ 4  y�R]
�R 
cwin] m  }~�Q�Q �S  W ^_^ l ���P`a�P  `  Exp+15V A120   a �bb  E x p + 1 5 V   A 1 2 0_ cdc I ���Oef
�O .coredoscnull��� ��� ctxte m  ��gg �hh  c h   1 5 0f �Ni�M
�N 
kfili 4  ���Lj
�L 
cwinj m  ���K�K �M  d klk l ���Jmn�J  m  DataFPGA+5V A121   n �oo   D a t a F P G A + 5 V   A 1 2 1l pqp I ���Irs
�I .coredoscnull��� ��� ctxtr m  ��tt �uu  c h   1 5 1s �Hv�G
�H 
kfilv 4  ���Fw
�F 
cwinw m  ���E�E �G  q xyx l ���Dz{�D  z  TV+12V A122   { �||  T V + 1 2 V   A 1 2 2y }~} I ���C�
�C .coredoscnull��� ��� ctxt m  ���� ���  c h   1 5 2� �B��A
�B 
kfil� 4  ���@�
�@ 
cwin� m  ���?�? �A  ~ ��� l ���>���>  �  MAFFLEDV A123   � ���  M A F F L E D V   A 1 2 3� ��� I ���=��
�= .coredoscnull��� ��� ctxt� m  ���� ���  c h   1 5 3� �<��;
�< 
kfil� 4  ���:�
�: 
cwin� m  ���9�9 �;  � ��� l ���8���8  �  MBFFLEDV A125   � ���  M B F F L E D V   A 1 2 5� ��� I ���7��
�7 .coredoscnull��� ��� ctxt� m  ���� ���  c h   1 5 5� �6��5
�6 
kfil� 4  ���4�
�4 
cwin� m  ���3�3 �5  � ��� l ���2���2  � $ ExpBusCurrent/TotalCurrent A12   � ��� < E x p B u s C u r r e n t / T o t a l C u r r e n t   A 1 2� ��� I ���1��
�1 .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   2 2� �0��/
�0 
kfil� 4  ���.�
�. 
cwin� m  ���-�- �/  � ��� l ���,���,  �  ShutterDoorBusVoltage A15   � ��� 2 S h u t t e r D o o r B u s V o l t a g e   A 1 5� ��� I ���+��
�+ .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   2 4� �*��)
�* 
kfil� 4  ���(�
�( 
cwin� m  ���'�' �)  � ��� l ���&���&  � M GExpBusMonitor/BatteryMonitor A47 --This is scaled data (float, 4-bytes)   � ��� � E x p B u s M o n i t o r / B a t t e r y M o n i t o r   A 4 7   - - T h i s   i s   s c a l e d   d a t a   ( f l o a t ,   4 - b y t e s )� ��� I ��%��
�% .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   7 4� �$��#
�$ 
kfil� 4  �"�
�" 
cwin� m  �!�! �#  � ��� l � ���   �  �  � ��� l ����  � 8 2 The ESP and MEGSP serial streams need to be last.   � ��� d   T h e   E S P   a n d   M E G S P   s e r i a l   s t r e a m s   n e e d   t o   b e   l a s t .� ��� l ����  �  �  � ��� l ����  � . (ESPSerialStream S2 --DeweSoft Channel 23   � ��� P E S P S e r i a l S t r e a m   S 2   - - D e w e S o f t   C h a n n e l   2 3� ��� I ���
� .coredoscnull��� ��� ctxt� m  �� ���  c h   1 9 2� ���
� 
kfil� 4  ��
� 
cwin� m  �� �  � ��� l ����  �  MEGSPSerialStream S3   � ��� ( M E G S P S e r i a l S t r e a m   S 3� ��� I -���
� .coredoscnull��� ��� ctxt� m   �� ���  c h   1 9 3� ���
� 
kfil� 4  #)��
� 
cwin� m  '(�� �  � ��� I .>���
� .coredoscnull��� ��� ctxt� m  .1�� ���  / e t x� ���
� 
kfil� 4  4:�
�
�
 
cwin� m  89�	�	 �  � ��� I ?D���
� .sysodelanull��� ��� nmbr� m  ?@�� �  �   @ m    ���                                                                                      @ alis    B  MacL4025                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c L 4 0 2 5  *System/Applications/Utilities/Terminal.app  / ��  ��  ��   = ��� l     ����  �  �  � ��� l     ����  � #  assume IDL is already opened   � ��� :   a s s u m e   I D L   i s   a l r e a d y   o p e n e d� ��� l FX�� ��� O  FX��� k  LW    I LQ������
�� .aevtrappnull��� ��� null��  ��   �� I RW������
�� .miscactvnull��� ��� null��  ��  ��  � m  FI�                                                                                  scut  alis    l  MacL4025                       BD ����AppleScript Utility.app                                        ����            ����  
 cu             CoreServices  6/:System:Library:CoreServices:AppleScript Utility.app/  0  A p p l e S c r i p t   U t i l i t y . a p p    M a c L 4 0 2 5  3System/Library/CoreServices/AppleScript Utility.app   / ��  �   ��  �  l Y^���� I Y^����
�� .sysodelanull��� ��� nmbr m  YZ���� ��  ��  ��   	
	 l     ��������  ��  ��  
  l _d���� I  _d�������� (0 getidlconsolefocus getIDLConsoleFocus��  ��  ��  ��    l     ��������  ��  ��    l     ����   !  move to IDL Console window    � 6   m o v e   t o   I D L   C o n s o l e   w i n d o w  l     ����   &  tell application "System Events"    � @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "  l     ����    	tell process "IDL"    � & 	 t e l l   p r o c e s s   " I D L "   l     ��!"��  !  		reopen   " �##  	 	 r e o p e n  $%$ l     ��&'��  &  
		activate   ' �((  	 	 a c t i v a t e% )*) l     ��+,��  +  		set frontmost to true   , �-- . 	 	 s e t   f r o n t m o s t   t o   t r u e* ./. l     ��01��  0  		end tell   1 �22  	 e n d   t e l l/ 343 l     ��56��  5  end tell   6 �77  e n d   t e l l4 898 l     ��������  ��  ��  9 :;: l     ��<=��  < > 8-- cmd-i in IDL sets the focus to the IDL Console window   = �>> p - -   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w; ?@? l     ��AB��  A L Ftell application "System Events" to keystroke "i" using {command down}   B �CC � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " i "   u s i n g   { c o m m a n d   d o w n }@ DED l     ��������  ��  ��  E FGF l     ��HI��  H    start the processing code   I �JJ 4   s t a r t   t h e   p r o c e s s i n g   c o d eG KLK l ewM����M O ewNON I kv��P��
�� .prcskprsnull���     ctxtP b  krQRQ m  knSS �TT @ r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a yR 1  nq��
�� 
lnfd��  O m  ehUU�                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  ��  ��  L VWV l     ��XY��  X % option to record tm1 raw binary   Y �ZZ > o p t i o n   t o   r e c o r d   t m 1   r a w   b i n a r yW [\[ l     ��]^��  ] i ctell application "System Events" to keystroke "rocket_eve_tm1_real_time_display,/record" & linefeed   ^ �__ � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a y , / r e c o r d "   &   l i n e f e e d\ `a` l     ��������  ��  ��  a bcb l xd����d O  xefe k  | gg hih I |�������
�� .aevtrappnull��� ��� null��  ��  i jkj I ��������
�� .miscactvnull��� ��� null��  ��  k lml O  ��non r  ��pqp 4  ����r
�� 
ttabr m  ������ q 1  ����
�� 
tcnto 4 ����s
�� 
cwins m  ������ m tut I ����v��
�� .sysodelanull��� ��� nmbrv m  ������ ��  u wxw I ����yz
�� .coredoscnull��� ��� ctxty m  ��{{ �|| $ s t a r t t r a n s f e r   8 0 0 2z ��}��
�� 
kfil} 4  ����~
�� 
cwin~ m  ������ ��  x � I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  � ��� I ������
�� .coredoscnull��� ��� ctxt� m  ���� ���  s e t m o d e   1� �����
�� 
kfil� 4  �����
�� 
cwin� m  ������ ��  � ��� I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  � ��� I ������
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
�� .sysodelanull��� ��� nmbr� m  ������ ��  ��  f m  xy���                                                                                      @ alis    B  MacL4025                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c L 4 0 2 5  *System/Applications/Utilities/Terminal.app  / ��  ��  ��  c ��� l     ��������  ��  ��  � ��� l     ������  �   resume IDL   � ���    r e s u m e   I D L� ��� l     ������  � &  tell application "System Events"   � ��� @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "� ��� l     ������  �  	tell process "IDL"   � ��� & 	 t e l l   p r o c e s s   " I D L "� ��� l     ������  �  		reopen   � ���  	 	 r e o p e n� ��� l     ������  �  
		activate   � ���  	 	 a c t i v a t e� ��� l     ������  �  		set frontmost to true   � ��� . 	 	 s e t   f r o n t m o s t   t o   t r u e� ��� l     ������  �  		end tell   � ���  	 e n d   t e l l� ��� l     ������  �  end tell   � ���  e n d   t e l l� ��� l     ������  � > 8-- cmd-i in IDL sets the focus to the IDL Console window   � ��� p - -   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w� ��� l     ������  � L Ftell application "System Events" to keystroke "i" using {command down}   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " i "   u s i n g   { c o m m a n d   d o w n }� ��� l     ��������  ��  ��  � ��� l ������ I  �������� (0 getidlconsolefocus getIDLConsoleFocus��  ��  ��  ��  � ��� l     ��������  ��  ��  � ��� l ������ O ��� I �����
�� .prcskprsnull���     ctxt� b  ��� m  �� ���  . c o n t i n u e� 1  �
� 
lnfd��  � m  ���                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  ��  ��  � ��� l  ��~�}� I  �|��{
�| .sysodelanull��� ��� nmbr� m  �z�z �{  �~  �}  � ��� l     �y�x�w�y  �x  �w  � ��� l !���v�u� O  !���� k  %��� ��� I %*�t�s�r
�t .aevtrappnull��� ��� null�s  �r  � ��� I +0�q�p�o
�q .miscactvnull��� ��� null�p  �o  � ��� l 11�n���n  � . ( create a new tab (this is a second one)   � ��� P   c r e a t e   a   n e w   t a b   ( t h i s   i s   a   s e c o n d   o n e )� ��� O 1G   I 7F�m
�m .prcskprsnull���     ctxt m  7: �  t �l�k
�l 
faal J  =B �j m  =@�i
�i eMdsKcmd�j  �k   m  14		�                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  � 

 I HM�h�g
�h .sysodelanull��� ��� nmbr m  HI�f�f �g    l NN�e�e     switch to the second tab    � 2   s w i t c h   t o   t h e   s e c o n d   t a b  O Nd I Tc�d
�d .prcskprsnull���     ctxt m  TW �  2 �c�b
�c 
faal J  Z_ �a m  Z]�`
�` eMdsKcmd�a  �b   m  NQ�                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��    l ee�_ !�_     tell front window   ! �"" " t e l l   f r o n t   w i n d o w #$# l ee�^%&�^  %   	set selected tab to tab 2   & �'' 4 	 s e t   s e l e c t e d   t a b   t o   t a b   2$ ()( l ee�]*+�]  *  end tell   + �,,  e n d   t e l l) -.- I ej�\/�[
�\ .sysodelanull��� ��� nmbr/ m  ef�Z�Z �[  . 010 I k{�Y23
�Y .coredoscnull��� ��� ctxt2 m  kn44 �55 � c d   / U s e r s / r o c k e t a d m i n / D r o p b o x / m i n x s s _ d r o p b o x / r o c k e t _ e v e / 3 6 . 3 8 9 / m i n x s s c u b e s a t / r o c k e t _ r e a l _ t i m e /3 �X6�W
�X 
kfil6 4  qw�V7
�V 
cwin7 m  uv�U�U �W  1 898 I |��T:�S
�T .sysodelanull��� ��� nmbr: m  |;; ?ə������S  9 <=< I ���R>?
�R .coredoscnull��� ��� ctxt> m  ��@@ �AA D / A p p l i c a t i o n s / h a r r i s / i d l 8 7 / b i n / i d l? �QB�P
�Q 
kfilB 4  ���OC
�O 
cwinC m  ���N�N �P  = DED I ���MF�L
�M .sysodelanull��� ��� nmbrF m  ��GG ?ə������L  E HIH I ���KJK
�K .coredoscnull��� ��� ctxtJ m  ��LL �MM  s p a _ r e a l t i m eK �JN�I
�J 
kfilN 4  ���HO
�H 
cwinO m  ���G�G �I  I PQP I ���FR�E
�F .sysodelanull��� ��� nmbrR m  ��SS ?ə������E  Q T�DT O ��UVU I ���CW�B
�C .prcskprsnull���     ctxtW l ��X�A�@X I ���?Y�>
�? .prcskcodnull���     ****Y m  ���=�= $�>  �A  �@  �B  V m  ��ZZ�                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  �D  � m  !"[[�                                                                                      @ alis    B  MacL4025                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c L 4 0 2 5  *System/Applications/Utilities/Terminal.app  / ��  �v  �u  � \]\ l ��^�<�;^ I ���:_�9
�: .sysodelanull��� ��� nmbr_ m  ���8�8 �9  �<  �;  ] `a` l ��b�7�6b O  ��cdc O  ��efe k  ��gg hih I ���5�4�3
�5 .aevtrappnull��� ��� null�4  �3  i jkj I ���2�1�0
�2 .miscactvnull��� ��� null�1  �0  k l�/l r  ��mnm m  ���.
�. boovtruen 1  ���-
�- 
pisf�/  f 4  ���,o
�, 
prcso m  ��pp �qq  I D Ld m  ��rr�                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  �7  �6  a sts l �u�+�*u I ��)vw
�) .sysonotfnull��� ��� TEXTv m  ��xx �yy 2 r o c k e t _ t m 1 _ s t a r t   f i n i s h e dw �(z{
�( 
apprz m  ��|| �}}   r o c k e t _ t m 1 _ s t a r t{ �'~�&
�' 
subt~ m  � ���  D O N E�&  �+  �*  t ��� l     �%�$�#�%  �$  �#  � ��� l     �"�!� �"  �!  �   � ��� l     ����  � / ) function to get IDL console window focus   � ��� R   f u n c t i o n   t o   g e t   I D L   c o n s o l e   w i n d o w   f o c u s� ��� l     ����  �  �  � ��� i     ��� I      ���� (0 getidlconsolefocus getIDLConsoleFocus�  �  � k     -�� ��� l     ����  � !  move to IDL Console window   � ��� 6   m o v e   t o   I D L   C o n s o l e   w i n d o w� ��� O     ��� O    ��� k    �� ��� I   ���
� .aevtrappnull��� ��� null�  �  � ��� I   ���
� .miscactvnull��� ��� null�  �  � ��� r    ��� m    �
� boovtrue� 1    �
� 
pisf�  � 4    ��
� 
prcs� m    �� ���  I D L� m     ���                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  � ��� l   ����  �  �  � ��� l   �
���
  � < 6 cmd-i in IDL sets the focus to the IDL Console window   � ��� l   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w� ��	� O   -��� I  # ,���
� .prcskprsnull���     ctxt� m   # $�� ���  i� ���
� 
faal� J   % (�� ��� m   % &�
� eMdsKcmd�  �  � m     ���                                                                                  sevs  alis    T  MacL4025                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c L 4 0 2 5  -System/Library/CoreServices/System Events.app   / ��  �	  � ��� l     ��� �  �  �   �       �������  � ������ (0 getidlconsolefocus getIDLConsoleFocus
�� .aevtoappnull  �   � ****� ������������� (0 getidlconsolefocus getIDLConsoleFocus��  ��  �  � 
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
�� .aevtoappnull  �   � ****� k    ��  ��  )��  <�� ��� �� �� K�� b�� ��� ��� ��� ��� \�� `�� s����  ��  ��  �  � O �� "�� %���� .�� 2����������������� R���� m�� } � � � � � � � � �$3@MZgt�����������US����{��������4;@L������p��x|
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
pisf�������� O������ O�.*j O*j O*a k/ *a k/*a ,FUOa a *a k/l Oa a *a k/l Omj Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa a *a k/l Oa  a *a k/l Oa !a *a k/l Oa "a *a k/l Oa #a *a k/l Oa $a *a k/l Oa %a *a k/l Oa &a *a k/l Oa 'a *a k/l Oa (a *a k/l Oa )a *a k/l Oa *a *a k/l Oa +a *a k/l Oa ,a *a k/l Oa -a *a k/l Oa .a *a k/l Oa /a *a k/l Oa 0a *a k/l Oa 1a *a k/l Oa 2a *a k/l Oa 3a *a k/l Okj UOa 4 *j O*j UOkj O*j+ 5Oa 6 a 7_ 8%j 9UO� �*j O*j O*a k/ *a k/*a ,FUOkj Oa :a *a k/l Okj Oa ;a *a k/l Okj Oa <a *a k/l Okj Oa =a *a k/l Okj UO*j+ 5Oa 6 a >_ 8%j 9UOlj O� �*j O*j Oa 6 a ?a @a Akvl 9UOkj Oa 6 a Ba @a Akvl 9UOkj Oa Ca *a k/l Oa Dj Oa Ea *a k/l Oa Dj Oa Fa *a k/l Oa Dj Oa 6 a Gj Hj 9UUOlj Oa 6 !*a Ia J/ *j O*j Oe*a K,FUUOa L�a M�a N� ascr  ��ޭ