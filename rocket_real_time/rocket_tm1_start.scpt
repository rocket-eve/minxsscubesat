FasdUAS 1.101.10   ��   ��    k             l     ��  ��      rocket_tlm1_start     � 	 	 $   r o c k e t _ t l m 1 _ s t a r t   
  
 l     ��  ��      created May 5, 2016, DLW     �   2   c r e a t e d   M a y   5 ,   2 0 1 6 ,   D L W      l     ��  ��    ( " Update for 36.389 Apr 7, 2023 DLW     �   D   U p d a t e   f o r   3 6 . 3 8 9   A p r   7 ,   2 0 2 3   D L W      l     ��  ��    Z T Prerequisites: IDLDE must be running, Terminal must be running (like a new session)     �   �   P r e r e q u i s i t e s :   I D L D E   m u s t   b e   r u n n i n g ,   T e r m i n a l   m u s t   b e   r u n n i n g   ( l i k e   a   n e w   s e s s i o n )      l    	 ����  I    	��  
�� .sysonotfnull��� ��� TEXT  m        �   0 R u n n i n g   r o c k e t _ t m 1 _ s t a r t  ��   !
�� 
appr   m     " " � # #   r o c k e t _ t m 1 _ s t a r t ! �� $��
�� 
subt $ m     % % � & &  R U N N I N G . . .��  ��  ��     ' ( ' l     ��������  ��  ��   (  ) * ) l     �� + ,��   + ? 9say "Connecting T M 1" using "Samantha" speaking rate 300    , � - - r s a y   " C o n n e c t i n g   T   M   1 "   u s i n g   " S a m a n t h a "   s p e a k i n g   r a t e   3 0 0 *  . / . l     ��������  ��  ��   /  0 1 0 l     �� 2 3��   2   rocket_tlm_start    3 � 4 4 "   r o c k e t _ t l m _ s t a r t 1  5 6 5 l  
� 7���� 7 O   
� 8 9 8 k   � : :  ; < ; I   ������
�� .aevtrappnull��� ��� null��  ��   <  = > = I   ������
�� .miscactvnull��� ��� null��  ��   >  ? @ ? O    * A B A r   ! ) C D C 4   ! %�� E
�� 
ttab E m   # $����  D 1   % (��
�� 
tcnt B 4   �� F
�� 
cwin F m    ����  @  G H G I  + 5�� I J
�� .coredoscnull��� ��� ctxt I m   + , K K � L L 
 c l e a r J �� M��
�� 
kfil M 4   - 1�� N
�� 
cwin N m   / 0���� ��   H  O P O l  6 6��������  ��  ��   P  Q R Q l  6 6�� S T��   S , & send 3 ping packets as a wake up call    T � U U L   s e n d   3   p i n g   p a c k e t s   a s   a   w a k e   u p   c a l l R  V W V l  6 6�� X Y��   X 7 1 do script "ping -c 2 169.254.17.237" in window 1    Y � Z Z b   d o   s c r i p t   " p i n g   - c   2   1 6 9 . 2 5 4 . 1 7 . 2 3 7 "   i n   w i n d o w   1 W  [ \ [ l  6 6��������  ��  ��   \  ] ^ ] l  6 6�� _ `��   _ 1 + open telnet session to the altair computer    ` � a a V   o p e n   t e l n e t   s e s s i o n   t o   t h e   a l t a i r   c o m p u t e r ^  b c b I  6 B�� d e
�� .coredoscnull��� ��� ctxt d m   6 9 f f � g g 4 t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 0 1   8 9 9 9 e �� h��
�� 
kfil h 4   : >�� i
�� 
cwin i m   < =���� ��   c  j k j I  C H�� l��
�� .sysodelanull��� ��� nmbr l m   C D���� ��   k  m n m l  I I�� o p��   o A ; list the used channels P1_RAW and P2_RAW should be 4 and 5    p � q q v   l i s t   t h e   u s e d   c h a n n e l s   P 1 _ R A W   a n d   P 2 _ R A W   s h o u l d   b e   4   a n d   5 n  r s r I  I U�� t u
�� .coredoscnull��� ��� ctxt t m   I L v v � w w  l i s t u s e d c h s u �� x��
�� 
kfil x 4   M Q�� y
�� 
cwin y m   O P���� ��   s  z { z l  V V�� | }��   | ] W the above command take longer to produce output on TM1 than TM2, wait for it to finish    } � ~ ~ �   t h e   a b o v e   c o m m a n d   t a k e   l o n g e r   t o   p r o d u c e   o u t p u t   o n   T M 1   t h a n   T M 2 ,   w a i t   f o r   i t   t o   f i n i s h {   �  I  V [�� ���
�� .sysodelanull��� ��� nmbr � m   V W���� ��   �  � � � I  \ h�� � �
�� .coredoscnull��� ��� ctxt � m   \ _ � � � � � ( / s t x   p r e p a r e t r a n s f e r � �� ���
�� 
kfil � 4   ` d�� �
�� 
cwin � m   b c���� ��   �  � � � l  i i�� � ���   �   delay 1    � � � �    d e l a y   1 �  � � � l  i i��������  ��  ��   �  � � � l  i i�� � ���   � L F The ORDER of these statements defines the tlm ORDER in decomposition.    � � � � �   T h e   O R D E R   o f   t h e s e   s t a t e m e n t s   d e f i n e s   t h e   t l m   O R D E R   i n   d e c o m p o s i t i o n . �  � � � l  i i��������  ��  ��   �  � � � l  i i�� � ���   � 2 ,megs-p temperature A97  --DeweSoft Channel 1    � � � � X m e g s - p   t e m p e r a t u r e   A 9 7     - - D e w e S o f t   C h a n n e l   1 �  � � � I  i u�� � �
�� .coredoscnull��� ��� ctxt � m   i l � � � � �  c h   1 2 7 � �� ���
�� 
kfil � 4   m q�� �
�� 
cwin � m   o p���� ��   �  � � � l  v v��������  ��  ��   �  � � � l  v v�� � ���   �  megsaheater+28v A99    � � � � & m e g s a h e a t e r + 2 8 v   A 9 9 �  � � � I  v ��� � �
�� .coredoscnull��� ��� ctxt � m   v y � � � � �  c h   1 2 9 � �� ���
�� 
kfil � 4   z ~�� �
�� 
cwin � m   | }���� ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  xrs+5v A103    � � � �  x r s + 5 v   A 1 0 3 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 3 3 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  solarsectionpressure A108    � � � � 2 s o l a r s e c t i o n p r e s s u r e   A 1 0 8 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 3 8 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � # cryoCoolerColdFingerTemp A110    � � � � : c r y o C o o l e r C o l d F i n g e r T e m p   A 1 1 0 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 3 9 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  megsbHeater+28v A110    � � � � ( m e g s b H e a t e r + 2 8 v   A 1 1 0 �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 4 0 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � l  � ���~�}�  �~  �}   �  � � � l  � ��| � ��|   �  XRSTemp1 A111    � � � �  X R S T e m p 1   A 1 1 1 �  � � � I  � ��{ � �
�{ .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 4 1 � �z ��y
�z 
kfil � 4   � ��x �
�x 
cwin � m   � ��w�w �y   �  �  � l  � ��v�u�t�v  �u  �t     l  � ��s�s    MACCDTemp1 A115    �  M A C C D T e m p 1   A 1 1 5  I  � ��r	
�r .coredoscnull��� ��� ctxt m   � �

 �  c h   1 4 5	 �q�p
�q 
kfil 4   � ��o
�o 
cwin m   � ��n�n �p    l  � ��m�l�k�m  �l  �k    l  � ��j�j    MBCCDTemp1 A116    �  M B C C D T e m p 1   A 1 1 6  I  � ��i
�i .coredoscnull��� ��� ctxt m   � � �  c h   1 4 6 �h�g
�h 
kfil 4   � ��f
�f 
cwin m   � ��e�e �g    l  � ��d�c�b�d  �c  �b     l  � ��a!"�a  !  MACCDTemp2 A106   " �##  M A C C D T e m p 2   A 1 0 6  $%$ I  � ��`&'
�` .coredoscnull��� ��� ctxt& m   � �(( �))  c h   1 3 6' �_*�^
�_ 
kfil* 4   � ��]+
�] 
cwin+ m   � ��\�\ �^  % ,-, l  � ��[�Z�Y�[  �Z  �Y  - ./. l  � ��X01�X  0  MBCCDTemp2 A107   1 �22  M B C C D T e m p 2   A 1 0 7/ 343 I  � ��W56
�W .coredoscnull��� ��� ctxt5 m   � �77 �88  c h   1 3 76 �V9�U
�V 
kfil9 4   � ��T:
�T 
cwin: m   � ��S�S �U  4 ;<; l  � ��R�Q�P�R  �Q  �P  < =>= l  � ��O?@�O  ?   CryoCoolerHotSideTemp A118   @ �AA 4 C r y o C o o l e r H o t S i d e T e m p   A 1 1 8> BCB I  ��NDE
�N .coredoscnull��� ��� ctxtD m   � �FF �GG  c h   1 4 8E �MH�L
�M 
kfilH 4   � �KI
�K 
cwinI m   � ��J�J �L  C JKJ l �I�H�G�I  �H  �G  K LML l �FNO�F  N  Exp+28V A119   O �PP  E x p + 2 8 V   A 1 1 9M QRQ I �EST
�E .coredoscnull��� ��� ctxtS m  UU �VV  c h   1 4 9T �DW�C
�D 
kfilW 4  	�BX
�B 
cwinX m  �A�A �C  R YZY l �@�?�>�@  �?  �>  Z [\[ l �=]^�=  ]  VacValvePos A124   ^ �__   V a c V a l v e P o s   A 1 2 4\ `a` I �<bc
�< .coredoscnull��� ��� ctxtb m  dd �ee  c h   1 5 4c �;f�:
�; 
kfilf 4  �9g
�9 
cwing m  �8�8 �:  a hih l �7�6�5�7  �6  �5  i jkj l �4lm�4  l  HVSPressure A126   m �nn   H V S P r e s s u r e   A 1 2 6k opo I +�3qr
�3 .coredoscnull��� ��� ctxtq m  "ss �tt  c h   1 5 6r �2u�1
�2 
kfilu 4  #'�0v
�0 
cwinv m  %&�/�/ �1  p wxw l ,,�.�-�,�.  �-  �,  x yzy l ,,�+{|�+  {  Exp+15V A120   | �}}  E x p + 1 5 V   A 1 2 0z ~~ I ,8�*��
�* .coredoscnull��� ��� ctxt� m  ,/�� ���  c h   1 5 0� �)��(
�) 
kfil� 4  04�'�
�' 
cwin� m  23�&�& �(   ��� l 99�%�$�#�%  �$  �#  � ��� l 99�"���"  �  DataFPGA+5V A121   � ���   D a t a F P G A + 5 V   A 1 2 1� ��� I 9E�!��
�! .coredoscnull��� ��� ctxt� m  9<�� ���  c h   1 5 1� � ��
�  
kfil� 4  =A��
� 
cwin� m  ?@�� �  � ��� l FF����  �  �  � ��� l FF����  �  TV+12V A122   � ���  T V + 1 2 V   A 1 2 2� ��� I FR���
� .coredoscnull��� ��� ctxt� m  FI�� ���  c h   1 5 2� ���
� 
kfil� 4  JN��
� 
cwin� m  LM�� �  � ��� l SS����  �  �  � ��� l SS����  �  MAFFLEDV A123   � ���  M A F F L E D V   A 1 2 3� ��� I S_���
� .coredoscnull��� ��� ctxt� m  SV�� ���  c h   1 5 3� ���
� 
kfil� 4  W[��
� 
cwin� m  YZ�� �  � ��� l ``�
�	��
  �	  �  � ��� l ``����  �  MBFFLEDV A125   � ���  M B F F L E D V   A 1 2 5� ��� I `l���
� .coredoscnull��� ��� ctxt� m  `c�� ���  c h   1 5 5� ���
� 
kfil� 4  dh��
� 
cwin� m  fg�� �  � ��� l mm�� ���  �   ��  � ��� l mm������  � $ ExpBusCurrent/TotalCurrent A12   � ��� < E x p B u s C u r r e n t / T o t a l C u r r e n t   A 1 2� ��� I my����
�� .coredoscnull��� ��� ctxt� m  mp�� ��� 
 c h   2 2� �����
�� 
kfil� 4  qu���
�� 
cwin� m  st���� ��  � ��� l zz��������  ��  ��  � ��� l zz������  �  ShutterDoorBusVoltage A15   � ��� 2 S h u t t e r D o o r B u s V o l t a g e   A 1 5� ��� I z�����
�� .coredoscnull��� ��� ctxt� m  z}�� ��� 
 c h   2 5� �����
�� 
kfil� 4  ~����
�� 
cwin� m  ������ ��  � ��� l ����������  ��  ��  � ��� l ��������  � M GExpBusMonitor/BatteryMonitor A47 --This is scaled data (float, 4-bytes)   � ��� � E x p B u s M o n i t o r / B a t t e r y M o n i t o r   A 4 7   - - T h i s   i s   s c a l e d   d a t a   ( f l o a t ,   4 - b y t e s )� ��� l ��������  � $   It is CH 75 if want raw data   � ��� <     I t   i s   C H   7 5   i f   w a n t   r a w   d a t a� ��� I ������
�� .coredoscnull��� ��� ctxt� m  ���� ��� 
 c h   7 4� �����
�� 
kfil� 4  �����
�� 
cwin� m  ������ ��  � ��� l ����������  ��  ��  � ��� l ��������  � 8 2 The ESP and MEGSP serial streams need to be last.   � ��� d   T h e   E S P   a n d   M E G S P   s e r i a l   s t r e a m s   n e e d   t o   b e   l a s t .� ��� l ����������  ��  ��  � ��� l ����� ��  � . (ESPSerialStream S2 --DeweSoft Channel 23     � P E S P S e r i a l S t r e a m   S 2   - - D e w e S o f t   C h a n n e l   2 3�  I ����
�� .coredoscnull��� ��� ctxt m  �� �  c h   1 9 2 ����
�� 
kfil 4  ����	
�� 
cwin	 m  ������ ��   

 l ����������  ��  ��    l ������    MEGSPSerialStream S3    � ( M E G S P S e r i a l S t r e a m   S 3  I ����
�� .coredoscnull��� ��� ctxt m  �� �  c h   1 9 3 ����
�� 
kfil 4  ����
�� 
cwin m  ������ ��    l ����������  ��  ��    I ����
�� .coredoscnull��� ��� ctxt m  �� �    / e t x ��!��
�� 
kfil! 4  ����"
�� 
cwin" m  ������ ��   #��# I ����$��
�� .sysodelanull��� ��� nmbr$ m  ������ ��  ��   9 m   
 %%�                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��   6 &'& l     ��������  ��  ��  ' ()( l     ��*+��  * #  assume IDL is already opened   + �,, :   a s s u m e   I D L   i s   a l r e a d y   o p e n e d) -.- l ��/����/ O  ��010 k  ��22 343 I ��������
�� .aevtrappnull��� ��� null��  ��  4 5��5 I ��������
�� .miscactvnull��� ��� null��  ��  ��  1 m  ��66�                                                                                  scut  alis    l  MacD3921                       BD ����AppleScript Utility.app                                        ����            ����  
 cu             CoreServices  6/:System:Library:CoreServices:AppleScript Utility.app/  0  A p p l e S c r i p t   U t i l i t y . a p p    M a c D 3 9 2 1  3System/Library/CoreServices/AppleScript Utility.app   / ��  ��  ��  . 787 l ��9����9 I ����:��
�� .sysodelanull��� ��� nmbr: m  ������ ��  ��  ��  8 ;<; l     ��������  ��  ��  < =>= l ��?����? I  ���������� (0 getidlconsolefocus getIDLConsoleFocus��  ��  ��  ��  > @A@ l     ��������  ��  ��  A BCB l     ��DE��  D !  move to IDL Console window   E �FF 6   m o v e   t o   I D L   C o n s o l e   w i n d o wC GHG l     ��IJ��  I &  tell application "System Events"   J �KK @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "H LML l     ��NO��  N  	tell process "IDL"   O �PP & 	 t e l l   p r o c e s s   " I D L "M QRQ l     ��ST��  S  		reopen   T �UU  	 	 r e o p e nR VWV l     ��XY��  X  
		activate   Y �ZZ  	 	 a c t i v a t eW [\[ l     ��]^��  ]  		set frontmost to true   ^ �__ . 	 	 s e t   f r o n t m o s t   t o   t r u e\ `a` l     ��bc��  b  		end tell   c �dd  	 e n d   t e l la efe l     ��gh��  g  end tell   h �ii  e n d   t e l lf jkj l     ��������  ��  ��  k lml l     ��no��  n > 8-- cmd-i in IDL sets the focus to the IDL Console window   o �pp p - -   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o wm qrq l     ��st��  s L Ftell application "System Events" to keystroke "i" using {command down}   t �uu � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " i "   u s i n g   { c o m m a n d   d o w n }r vwv l     ��������  ��  ��  w xyx l     ��z{��  z    start the processing code   { �|| 4   s t a r t   t h e   p r o c e s s i n g   c o d ey }~} l ������ O ����� I �������
�� .prcskprsnull���     ctxt� b  ����� m  ���� ��� @ r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a y� 1  ����
�� 
lnfd��  � m  �����                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  ~ ��� l     ������  � % option to record tm1 raw binary   � ��� > o p t i o n   t o   r e c o r d   t m 1   r a w   b i n a r y� ��� l     ������  � i ctell application "System Events" to keystroke "rocket_eve_tm1_real_time_display,/record" & linefeed   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a y , / r e c o r d "   &   l i n e f e e d� ��� l     ��������  ��  ��  � ��� l �g������ O  �g��� k  �f�� ��� I ��������
�� .aevtrappnull��� ��� null��  ��  � ��� I �������
�� .miscactvnull��� ��� null��  ��  � ��� O  ��� r  ��� 4  ���
�� 
ttab� m  ���� � 1  ��
�� 
tcnt� 4 ���
�� 
cwin� m  �� � ��� I �~��}
�~ .sysodelanull��� ��� nmbr� m  �|�| �}  � ��� I '�{��
�{ .coredoscnull��� ��� ctxt� m  �� ��� $ s t a r t t r a n s f e r   8 0 0 2� �z��y
�z 
kfil� 4  #�x�
�x 
cwin� m  !"�w�w �y  � ��� I (-�v��u
�v .sysodelanull��� ��� nmbr� m  ()�t�t �u  � ��� I .:�s��
�s .coredoscnull��� ��� ctxt� m  .1�� ���  s e t m o d e   1� �r��q
�r 
kfil� 4  26�p�
�p 
cwin� m  45�o�o �q  � ��� I ;@�n��m
�n .sysodelanull��� ��� nmbr� m  ;<�l�l �m  � ��� I AM�k��
�k .coredoscnull��� ��� ctxt� m  AD�� ��� , s e t a s y n c t i m e s t a m p s   o f f� �j��i
�j 
kfil� 4  EI�h�
�h 
cwin� m  GH�g�g �i  � ��� I NS�f��e
�f .sysodelanull��� ��� nmbr� m  NO�d�d �e  � ��� I T`�c��
�c .coredoscnull��� ��� ctxt� m  TW�� ���  s t a r t a c q� �b��a
�b 
kfil� 4  X\�`�
�` 
cwin� m  Z[�_�_ �a  � ��^� I af�]��\
�] .sysodelanull��� ��� nmbr� m  ab�[�[ �\  �^  � m  �����                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��  � ��� l     �Z�Y�X�Z  �Y  �X  � ��� l     �W���W  �   resume IDL   � ���    r e s u m e   I D L� ��� l     �V���V  � &  tell application "System Events"   � ��� @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "� ��� l     �U���U  �  	tell process "IDL"   � ��� & 	 t e l l   p r o c e s s   " I D L "� ��� l     �T���T  �  		reopen   � ���  	 	 r e o p e n� ��� l     �S���S  �  
		activate   � ���  	 	 a c t i v a t e� ��� l     �R���R  �  		set frontmost to true   � ��� . 	 	 s e t   f r o n t m o s t   t o   t r u e� ��� l     �Q���Q  �  		end tell   � ���  	 e n d   t e l l� ��� l     �P���P  �  end tell   � ���  e n d   t e l l� � � l     �O�O   > 8-- cmd-i in IDL sets the focus to the IDL Console window    � p - -   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w   l     �N�N   L Ftell application "System Events" to keystroke "i" using {command down}    � � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " i "   u s i n g   { c o m m a n d   d o w n } 	
	 l     �M�L�K�M  �L  �K  
  l hm�J�I I  hm�H�G�F�H (0 getidlconsolefocus getIDLConsoleFocus�G  �F  �J  �I    l     �E�D�C�E  �D  �C    l n��B�A O n� I t�@�?
�@ .prcskprsnull���     ctxt b  t{ m  tw �  . c o n t i n u e 1  wz�>
�> 
lnfd�?   m  nq�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �B  �A    l ���=�< I ���;�:
�; .sysodelanull��� ��� nmbr m  ���9�9 �:  �=  �<     l     �8�7�6�8  �7  �6    !"! l     �5#$�5  # ( " moved spa_realtime to rocket_nuc2   $ �%% D   m o v e d   s p a _ r e a l t i m e   t o   r o c k e t _ n u c 2" &'& l     �4()�4  ( "  tell application "Terminal"   ) �** 8   t e l l   a p p l i c a t i o n   " T e r m i n a l "' +,+ l     �3-.�3  -   	reopen   . �//    	 r e o p e n, 010 l     �223�2  2  		activate   3 �44  	 a c t i v a t e1 565 l     �178�1  7 1 +	-- create a new tab (this is a second one)   8 �99 V 	 - -   c r e a t e   a   n e w   t a b   ( t h i s   i s   a   s e c o n d   o n e )6 :;: l     �0<=�0  < M G	tell application "System Events" to keystroke "t" using {command down}   = �>> � 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " t "   u s i n g   { c o m m a n d   d o w n }; ?@? l     �/AB�/  A  	delay 1   B �CC  	 d e l a y   1@ DED l     �.FG�.  F " 	-- switch to the second tab   G �HH 8 	 - -   s w i t c h   t o   t h e   s e c o n d   t a bE IJI l     �-KL�-  K M G	tell application "System Events" to keystroke "2" using {command down}   L �MM � 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " 2 "   u s i n g   { c o m m a n d   d o w n }J NON l     �,PQ�,  P  	--tell front window   Q �RR ( 	 - - t e l l   f r o n t   w i n d o wO STS l     �+UV�+  U # 	--	set selected tab to tab 2   V �WW : 	 - - 	 s e t   s e l e c t e d   t a b   t o   t a b   2T XYX l     �*Z[�*  Z  	--end tell   [ �\\  	 - - e n d   t e l lY ]^] l     �)_`�)  _  	delay 1   ` �aa  	 d e l a y   1^ bcb l     �(de�(  d } w	do script "cd /Users/rocketadmin/Dropbox/minxss_dropbox/rocket_eve/36.389/minxsscubesat/rocket_real_time/" in window 1   e �ff � 	 d o   s c r i p t   " c d   / U s e r s / r o c k e t a d m i n / D r o p b o x / m i n x s s _ d r o p b o x / r o c k e t _ e v e / 3 6 . 3 8 9 / m i n x s s c u b e s a t / r o c k e t _ r e a l _ t i m e / "   i n   w i n d o w   1c ghg l     �'ij�'  i  
	delay 0.2   j �kk  	 d e l a y   0 . 2h lml l     �&no�&  n A ;	do script "/Applications/harris/idl87/bin/idl" in window 1   o �pp v 	 d o   s c r i p t   " / A p p l i c a t i o n s / h a r r i s / i d l 8 7 / b i n / i d l "   i n   w i n d o w   1m qrq l     �%st�%  s  
	delay 0.2   t �uu  	 d e l a y   0 . 2r vwv l     �$xy�$  x + %	do script "spa_realtime" in window 1   y �zz J 	 d o   s c r i p t   " s p a _ r e a l t i m e "   i n   w i n d o w   1w {|{ l     �#}~�#  }  
	delay 0.2   ~ �  	 d e l a y   0 . 2| ��� l     �"���"  � B <	tell application "System Events" to keystroke (key code 36)   � ��� x 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   ( k e y   c o d e   3 6 )� ��� l     �!���!  �  	 end tell   � ���    e n d   t e l l� ��� l     � ���   �   delay 2   � ���    d e l a y   2� ��� l     ����  �  �  � ��� l ������ O  ����� O  ����� k  ���� ��� I �����
� .aevtrappnull��� ��� null�  �  � ��� I �����
� .miscactvnull��� ��� null�  �  � ��� r  ����� m  ���
� boovtrue� 1  ���
� 
pisf�  � 4  ����
� 
prcs� m  ���� ���  I D L� m  �����                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �  �  � ��� l ������ I �����
� .sysonotfnull��� ��� TEXT� m  ���� ��� 2 r o c k e t _ t m 1 _ s t a r t   f i n i s h e d� ���
� 
appr� m  ���� ���   r o c k e t _ t m 1 _ s t a r t� ���
� 
subt� m  ���� ���  D O N E�  �  �  � ��� l     �
�	��
  �	  �  � ��� l     ����  �  �  � ��� l     ����  � / ) function to get IDL console window focus   � ��� R   f u n c t i o n   t o   g e t   I D L   c o n s o l e   w i n d o w   f o c u s� ��� l     ����  �  �  � ��� i     ��� I      � �����  (0 getidlconsolefocus getIDLConsoleFocus��  ��  � k     -�� ��� l     ������  � !  move to IDL Console window   � ��� 6   m o v e   t o   I D L   C o n s o l e   w i n d o w� ��� O     ��� O    ��� k    �� ��� I   ������
�� .aevtrappnull��� ��� null��  ��  � ��� I   ������
�� .miscactvnull��� ��� null��  ��  � ���� r    ��� m    ��
�� boovtrue� 1    ��
�� 
pisf��  � 4    ���
�� 
prcs� m    �� ���  I D L� m     ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  � ��� l   ��������  ��  ��  � ��� l   ������  � < 6 cmd-i in IDL sets the focus to the IDL Console window   � ��� l   c m d - i   i n   I D L   s e t s   t h e   f o c u s   t o   t h e   I D L   C o n s o l e   w i n d o w� ���� O   -��� I  # ,����
�� .prcskprsnull���     ctxt� m   # $�� ���  i� �����
�� 
faal� J   % (�� ���� m   % &��
�� eMdsKcmd��  ��  � m     ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  � ���� l     ��������  ��  ��  ��       �������  � ������ (0 getidlconsolefocus getIDLConsoleFocus
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
�� .aevtoappnull  �   � ****� k    ���  ��  5�� -�� 7�� =�� }�� ��� �� �� �� ��� �����  ��  ��  �  � ? �� "�� %����%���������� K���� f�� v � � � � � � � �
(7FUds��������6��������������������
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT
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
prcs
�� 
pisf��������� O��*j O*j 	O*�k/ 
*�k/*�,FUO��*�k/l Oa �*�k/l Omj Oa �*�k/l Okj Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa  �*�k/l Oa !�*�k/l Oa "�*�k/l Oa #�*�k/l Oa $�*�k/l Oa %�*�k/l Oa &�*�k/l Oa '�*�k/l Oa (�*�k/l Oa )�*�k/l Oa *�*�k/l Oa +�*�k/l Oa ,�*�k/l Oa -�*�k/l Okj UOa . *j O*j 	UOkj O*j+ /Oa 0 a 1_ 2%j 3UO� p*j O*j 	O*�k/ 
*�k/*�,FUOkj Oa 4�*�k/l Okj Oa 5�*�k/l Okj Oa 6�*�k/l Okj Oa 7�*�k/l Okj UO*j+ /Oa 0 a 8_ 2%j 3UOlj Oa 0 !*a 9a :/ *j O*j 	Oe*a ;,FUUOa <�a =�a >�  ascr  ��ޭ