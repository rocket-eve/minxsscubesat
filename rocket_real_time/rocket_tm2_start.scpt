FasdUAS 1.101.10   ��   ��    k             l     ��  ��      rocket_tlm_start     � 	 	 "   r o c k e t _ t l m _ s t a r t   
  
 l     ��  ��      created May 5, 2016, DLW     �   2   c r e a t e d   M a y   5 ,   2 0 1 6 ,   D L W      l     ��  ��    : 4 altair ip change to 192.168.50.101 Apr 13, 2023 DLW     �   h   a l t a i r   i p   c h a n g e   t o   1 9 2 . 1 6 8 . 5 0 . 1 0 1   A p r   1 3 ,   2 0 2 3   D L W      l     ��  ��    7 1 to check connectivity $ ping -c 2 192.168.50.166     �   b   t o   c h e c k   c o n n e c t i v i t y   $   p i n g   - c   2   1 9 2 . 1 6 8 . 5 0 . 1 6 6      l     ��������  ��  ��        l    	 ����  I    	��  
�� .sysonotfnull��� ��� TEXT  m          � ! ! 0 R u n n i n g   r o c k e t _ t m 2 _ s t a r t  �� " #
�� 
appr " m     $ $ � % %   r o c k e t _ t m 2 _ s t a r t # �� &��
�� 
subt & m     ' ' � ( (  R U N N I N G . . .��  ��  ��     ) * ) l     ��������  ��  ��   *  + , + l     �� - .��   -   rocket_tlm_start    . � / / "   r o c k e t _ t l m _ s t a r t ,  0 1 0 l  
 l 2���� 2 O   
 l 3 4 3 k    k 5 5  6 7 6 I   ������
�� .aevtrappnull��� ��� null��  ��   7  8 9 8 I   ������
�� .miscactvnull��� ��� null��  ��   9  : ; : l   �� < =��   < 1 + open telnet session to the altair computer    = � > > V   o p e n   t e l n e t   s e s s i o n   t o   t h e   a l t a i r   c o m p u t e r ;  ? @ ? l   �� A B��   A 8 2do script "telnet 192.168.50.166 8999" in window 1    B � C C d d o   s c r i p t   " t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 6 6   8 9 9 9 "   i n   w i n d o w   1 @  D E D l   �� F G��   F 8 2do script "telnet 192.168.50.166 8999" in window 1    G � H H d d o   s c r i p t   " t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 6 6   8 9 9 9 "   i n   w i n d o w   1 E  I J I l   $ K L M K I   $�� N O
�� .coredoscnull��� ��� ctxt N m     P P � Q Q 4 t e l n e t   1 9 2 . 1 6 8 . 5 0 . 1 6 6   8 9 9 9 O �� R��
�� 
kfil R 4     �� S
�� 
cwin S m    ���� ��   L   I lab altair    M � T T    I   l a b   a l t a i r J  U V U I  % *�� W��
�� .sysodelanull��� ��� nmbr W m   % &���� ��   V  X Y X l  + +�� Z [��   Z A ; list the used channels P1_RAW and P2_RAW should be 4 and 5    [ � \ \ v   l i s t   t h e   u s e d   c h a n n e l s   P 1 _ R A W   a n d   P 2 _ R A W   s h o u l d   b e   4   a n d   5 Y  ] ^ ] I  + 5�� _ `
�� .coredoscnull��� ��� ctxt _ m   + , a a � b b  l i s t u s e d c h s ` �� c��
�� 
kfil c 4   - 1�� d
�� 
cwin d m   / 0���� ��   ^  e f e I  6 B�� g h
�� .coredoscnull��� ��� ctxt g m   6 9 i i � j j ( / s t x   p r e p a r e t r a n s f e r h �� k��
�� 
kfil k 4   : >�� l
�� 
cwin l m   < =���� ��   f  m n m l  C C�� o p��   o  delay 1    p � q q  d e l a y   1 n  r s r I  C O�� t u
�� .coredoscnull��� ��� ctxt t m   C F v v � w w  c h   7 u �� x��
�� 
kfil x 4   G K�� y
�� 
cwin y m   I J���� ��   s  z { z I  P \�� | }
�� .coredoscnull��� ��� ctxt | m   P S ~ ~ �    c h   8 } �� ���
�� 
kfil � 4   T X�� �
�� 
cwin � m   V W���� ��   {  � � � l  ] ]�� � ���   � " do script "ch 9" in window 1    � � � � 8 d o   s c r i p t   " c h   9 "   i n   w i n d o w   1 �  � � � I  ] i�� � �
�� .coredoscnull��� ��� ctxt � m   ] ` � � � � �  / e t x � �� ���
�� 
kfil � 4   a e�� �
�� 
cwin � m   c d���� ��   �  ��� � l  j j�� � ���   �  delay 1    � � � �  d e l a y   1��   4 m   
  � ��                                                                                      @ alis    ^  Rocket9                    �߿�H+  
Ϯ(Terminal.app                                                   
��>���        ����  	                	Utilities     ��"%      ��r!    
Ϯ(
�~  -Rocket9:Applications: Utilities: Terminal.app     T e r m i n a l . a p p    R o c k e t 9  #Applications/Utilities/Terminal.app   / ��  ��  ��   1  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � #  assume IDL is already opened    � � � � :   a s s u m e   I D L   i s   a l r e a d y   o p e n e d �  � � � l  m  ����� � O   m  � � � k   s ~ � �  � � � I  s x������
�� .aevtrappnull��� ��� null��  ��   �  ��� � I  y ~������
�� .miscactvnull��� ��� null��  ��  ��   � m   m p � �                                                                                       @ alis    �  Rocket9                    �߿�H+  �T�idlde.darwin.x86_64.app                                        �X�X��        ����  	                idlde     ��"%      �YF    �T��&��&�
�~  CRocket9:Applications: harris: idl86: idlde: idlde.darwin.x86_64.app   0  i d l d e . d a r w i n . x 8 6 _ 6 4 . a p p    R o c k e t 9  7Applications/harris/idl86/idlde/idlde.darwin.x86_64.app   / ��  ��  ��   �  � � � l  � � ����� � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��  ��  ��   �  � � � l  � � ����� � O  � � � � � I  � ��� � �
�� .prcskprsnull���     ctxt � m   � � � � � � �  i � �� ���
�� 
faal � J   � � � �  ��� � m   � ���
�� eMdsKcmd��  ��   � m   � � � ��                                                                                  sevs  alis    �  Rocket9                    �߿�H+  
�^System Events.app                                              
��C�¸�        ����  	                CoreServices    ��"%      ��1    
�^
�]
�\  8Rocket9:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    R o c k e t 9  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l  � � ����� � O  � � � � � I  � ��� ���
�� .prcskprsnull���     ctxt � b   � � � � � m   � � � � � � � d r o c k e t _ e v e _ t m 2 _ r e a l _ t i m e _ d i s p l a y , / d o m e g s a , / d o m e g s b � 1   � ���
�� 
lnfd��   � m   � � � ��                                                                                  sevs  alis    �  Rocket9                    �߿�H+  
�^System Events.app                                              
��C�¸�        ����  	                CoreServices    ��"%      ��1    
�^
�]
�\  8Rocket9:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    R o c k e t 9  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l     �� � ���   � | v tell application "System Events" to keystroke "rocket_eve_tm2_real_time_display,/domegsa,/domegsb,/record" & linefeed    � � � � �   t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " r o c k e t _ e v e _ t m 2 _ r e a l _ t i m e _ d i s p l a y , / d o m e g s a , / d o m e g s b , / r e c o r d "   &   l i n e f e e d �  � � � l  � � ����� � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l  � ����� � O   � � � � k   � � �  � � � I  � �������
�� .aevtrappnull��� ��� null��  ��   �  � � � I  � �������
�� .miscactvnull��� ��� null��  ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � � $ s t a r t t r a n s f e r   8 0 0 2 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  s e t m o d e   1 � �� ���
�� 
kfil � 4   � �� �
� 
cwin � m   � ��~�~ ��   �  � � � I  � ��} ��|
�} .sysodelanull��� ��� nmbr � m   � ��{�{ �|   �  � � � I  � ��z � �
�z .coredoscnull��� ��� ctxt � m   � � � � � � � , s e t a s y n c t i m e s t a m p s   o f f � �y ��x
�y 
kfil � 4   � ��w �
�w 
cwin � m   � ��v�v �x   �  � � � I  � �u ��t
�u .sysodelanull��� ��� nmbr � m   � ��s�s �t   �  � � � I �r � �
�r .coredoscnull��� ��� ctxt � m   � � � � �  s t a r t a c q � �q ��p
�q 
kfil � 4  	�o 
�o 
cwin  m  �n�n �p   � �m I �l�k
�l .sysodelanull��� ��� nmbr m  �j�j �k  �m   � m   � ��                                                                                      @ alis    ^  Rocket9                    �߿�H+  
Ϯ(Terminal.app                                                   
��>���        ����  	                	Utilities     ��"%      ��r!    
Ϯ(
�~  -Rocket9:Applications: Utilities: Terminal.app     T e r m i n a l . a p p    R o c k e t 9  #Applications/Utilities/Terminal.app   / ��  ��  ��   �  l     �i�h�g�i  �h  �g    l �f�e I �d	�c
�d .sysodelanull��� ��� nmbr	 m  �b�b �c  �f  �e   

 l *�a�` I *�_
�_ .sysonotfnull��� ��� TEXT m   � 2 r o c k e t _ t m 2 _ s t a r t   f i n i s h e d �^
�^ 
appr m  " �   r o c k e t _ t m 2 _ s t a r t �]�\
�] 
subt m  #& �  D O N E�\  �a  �`   �[ l     �Z�Y�X�Z  �Y  �X  �[       �W�W   �V
�V .aevtoappnull  �   � **** �U�T�S�R
�U .aevtoappnull  �   � **** k    *    0    �!!  �""  �##  �$$  �%%  �&& '' 
�Q�Q  �T  �S     $  �P $�O '�N�M ��L�K P�J�I�H�G a i v ~ � ��F � ��E�D�C ��B � � � �
�P 
appr
�O 
subt�N 
�M .sysonotfnull��� ��� TEXT
�L .aevtrappnull��� ��� null
�K .miscactvnull��� ��� null
�J 
kfil
�I 
cwin
�H .coredoscnull��� ��� ctxt
�G .sysodelanull��� ��� nmbr�F 
�E 
faal
�D eMdsKcmd
�C .prcskprsnull���     ctxt
�B 
lnfd�R+������ O� _*j O*j 	O��*�k/l Omj O��*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l OPUOa  *j O*j 	UOa j Oa  a a a kvl UOa  a _ %j UOlj O� Y*j O*j 	Oa �*�k/l Okj Oa �*�k/l Okj Oa �*�k/l Okj Oa  �*�k/l Okj UOkj Oa !�a "�a #�  ascr  ��ޭ