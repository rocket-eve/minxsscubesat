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
cwin z m   O P���� ��   t  { | { l  V V�� } ~��   }   delay 1    ~ �      d e l a y   1 |  � � � I  V b�� � �
�� .coredoscnull��� ��� ctxt � m   V Y � � � � � 
 c h   9 8 � �� ���
�� 
kfil � 4   Z ^�� �
�� 
cwin � m   \ ]���� ��   �  � � � I  c o�� � �
�� .coredoscnull��� ��� ctxt � m   c f � � � � �  c h   1 0 0 � �� ���
�� 
kfil � 4   g k�� �
�� 
cwin � m   i j���� ��   �  � � � I  p |�� � �
�� .coredoscnull��� ��� ctxt � m   p s � � � � �  c h   1 0 4 � �� ���
�� 
kfil � 4   t x�� �
�� 
cwin � m   v w���� ��   �  � � � I  } ��� � �
�� .coredoscnull��� ��� ctxt � m   } � � � � � �  c h   1 0 9 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 0 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 1 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 2 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 6 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 7 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 1 9 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 2 0 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 2 5 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  c h   1 2 7 � �� ���
�� 
kfil � 4   � ��� �
�� 
cwin � m   � ����� ��   �  � � � I  ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � �  c h   1 2 1 � �� ���
�� 
kfil � 4  �� �
�� 
cwin � m  ���� ��   �  � � � I �� � �
�� .coredoscnull��� ��� ctxt � m   � � � � �  c h   1 2 2 � �� ��
�� 
kfil � 4  �~ �
�~ 
cwin � m  �}�} �   �  � � � I %�| � �
�| .coredoscnull��� ��� ctxt � m   � � � � �  c h   1 2 3 � �{ ��z
�{ 
kfil � 4  !�y �
�y 
cwin � m   �x�x �z   �    I &2�w
�w .coredoscnull��� ��� ctxt m  &) �  c h   1 2 4 �v�u
�v 
kfil 4  *.�t
�t 
cwin m  ,-�s�s �u   	 I 3?�r

�r .coredoscnull��� ��� ctxt
 m  36 �  c h   1 2 6 �q�p
�q 
kfil 4  7;�o
�o 
cwin m  9:�n�n �p  	  I @L�m
�m .coredoscnull��� ��� ctxt m  @C � 
 c h   1 6 �l�k
�l 
kfil 4  DH�j
�j 
cwin m  FG�i�i �k    I MY�h
�h .coredoscnull��� ��� ctxt m  MP � 
 c h   1 3 �g�f
�g 
kfil 4  QU�e
�e 
cwin m  ST�d�d �f    !  I Zf�c"#
�c .coredoscnull��� ��� ctxt" m  Z]$$ �%% 
 c h   4 8# �b&�a
�b 
kfil& 4  ^b�`'
�` 
cwin' m  `a�_�_ �a  ! ()( I gs�^*+
�^ .coredoscnull��� ��� ctxt* m  gj,, �--  c h   1 3 4+ �].�\
�] 
kfil. 4  ko�[/
�[ 
cwin/ m  mn�Z�Z �\  ) 010 I t��Y23
�Y .coredoscnull��� ��� ctxt2 m  tw44 �55  c h   1 3 53 �X6�W
�X 
kfil6 4  x|�V7
�V 
cwin7 m  z{�U�U �W  1 898 I ���T:;
�T .coredoscnull��� ��� ctxt: m  ��<< �==  / e t x; �S>�R
�S 
kfil> 4  ���Q?
�Q 
cwin? m  ���P�P �R  9 @�O@ I ���NA�M
�N .sysodelanull��� ��� nmbrA m  ���L�L �M  �O   * m   
 BB�                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��   ' CDC l     �K�J�I�K  �J  �I  D EFE l     �HGH�H  G #  assume IDL is already opened   H �II :   a s s u m e   I D L   i s   a l r e a d y   o p e n e dF JKJ l ��L�G�FL O  ��MNM k  ��OO PQP I ���E�D�C
�E .aevtrappnull��� ��� null�D  �C  Q R�BR I ���A�@�?
�A .miscactvnull��� ��� null�@  �?  �B  N m  ��SS�                                                                                  scut  alis    l  MacD3921                       BD ����AppleScript Utility.app                                        ����            ����  
 cu             CoreServices  6/:System:Library:CoreServices:AppleScript Utility.app/  0  A p p l e S c r i p t   U t i l i t y . a p p    M a c D 3 9 2 1  3System/Library/CoreServices/AppleScript Utility.app   / ��  �G  �F  K TUT l ��V�>�=V I ���<W�;
�< .sysodelanull��� ��� nmbrW m  ���:�: �;  �>  �=  U XYX l     �9Z[�9  Z !  move to IDL Console window   [ �\\ 6   m o v e   t o   I D L   C o n s o l e   w i n d o wY ]^] l ��_�8�7_ O  ��`a` O  ��bcb k  ��dd efe I ���6�5�4
�6 .aevtrappnull��� ��� null�5  �4  f ghg I ���3�2�1
�3 .miscactvnull��� ��� null�2  �1  h i�0i r  ��jkj m  ���/
�/ boovtruek 1  ���.
�. 
pisf�0  c 4  ���-l
�- 
prcsl m  ��mm �nn  I D La m  ��oo�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �8  �7  ^ pqp l ��r�,�+r I ���*s�)
�* .sysodelanull��� ��� nmbrs m  ���(�( �)  �,  �+  q tut l ��v�'�&v O ��wxw I ���%yz
�% .prcskprsnull���     ctxty m  ��{{ �||  iz �$}�#
�$ 
faal} J  ��~~ �" m  ���!
�! eMdsKcmd�"  �#  x m  �����                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �'  �&  u ��� l ���� �� I �����
� .sysodelanull��� ��� nmbr� m  ���� �  �   �  � ��� l ����� O ���� I ����
� .prcskprsnull���     ctxt� m  ��� ��� @ r o c k e t _ e v e _ t m 1 _ r e a l _ t i m e _ d i s p l a y�  � m  �����                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �  �  � ��� l ���� I ���
� .sysodelanull��� ��� nmbr� m  �� �  �  �  � ��� l     ����  �   now hit the return key   � ��� .   n o w   h i t   t h e   r e t u r n   k e y� ��� l ���� O ��� I ���
� .prcskprsnull���     ctxt� l ���� I ���

� .prcskcodnull���     ****� m  �	�	 $�
  �  �  �  � m  ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �  �  � ��� l  %���� I  %���
� .sysodelanull��� ��� nmbr� m   !�� �  �  �  � ��� l     ����  �  �  � ��� l &��� ��� O  &���� k  *��� ��� I */������
�� .aevtrappnull��� ��� null��  ��  � ��� I 05������
�� .miscactvnull��� ��� null��  ��  � ��� I 6;�����
�� .sysodelanull��� ��� nmbr� m  67���� ��  � ��� I <H����
�� .coredoscnull��� ��� ctxt� m  <?�� ��� $ s t a r t t r a n s f e r   8 0 0 2� �����
�� 
kfil� 4  @D���
�� 
cwin� m  BC���� ��  � ��� I IN�����
�� .sysodelanull��� ��� nmbr� m  IJ���� ��  � ��� I O[����
�� .coredoscnull��� ��� ctxt� m  OR�� ���  s e t m o d e   1� �����
�� 
kfil� 4  SW���
�� 
cwin� m  UV���� ��  � ��� I \a�����
�� .sysodelanull��� ��� nmbr� m  \]���� ��  � ��� I bn����
�� .coredoscnull��� ��� ctxt� m  be�� ��� , s e t a s y n c t i m e s t a m p s   o f f� �����
�� 
kfil� 4  fj���
�� 
cwin� m  hi���� ��  � ��� I ot�����
�� .sysodelanull��� ��� nmbr� m  op���� ��  � ��� I u�����
�� .coredoscnull��� ��� ctxt� m  ux�� ���  s t a r t a c q� �����
�� 
kfil� 4  y}���
�� 
cwin� m  {|���� ��  � ���� I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  ��  � m  &'���                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  �   ��  � ��� l     ��������  ��  ��  � ��� l     ������  �   resume IDL   � ���    r e s u m e   I D L� ��� l �������� O  ����� O  ����� k  ���� ��� I ��������
�� .aevtrappnull��� ��� null��  ��  � ��� I ��������
�� .miscactvnull��� ��� null��  ��  � ���� r  ����� m  ����
�� boovtrue� 1  ����
�� 
pisf��  � 4  �����
�� 
prcs� m  ���� ���  I D L� m  �����                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  � ��� l �������� O ����� I �������
�� .prcskprsnull���     ctxt� m  ���� �    . c o n t i n u e��  � m  ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��  �  l ������ I ������
�� .sysodelanull��� ��� nmbr m  ������ ��  ��  ��    l     ��	��     now hit the return key   	 �

 .   n o w   h i t   t h e   r e t u r n   k e y  l ������ O �� I ������
�� .prcskprsnull���     ctxt l ������ I ������
�� .prcskcodnull���     **** m  ������ $��  ��  ��  ��   m  ���                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��    l     ����     delay 1    �    d e l a y   1  l     ��������  ��  ��    l ������ I ������
�� .sysodelanull��� ��� nmbr m  ������ ��  ��  ��     l     ��������  ��  ��    !"! l �z#����# O  �z$%$ k  �y&& '(' I ��������
�� .aevtrappnull��� ��� null��  ��  ( )*) I ��������
�� .miscactvnull��� ��� null��  ��  * +,+ O �-.- I ���/0
�� .prcskprsnull���     ctxt/ m  ��11 �22  t0 ��3��
�� 
faal3 J  ��44 5��5 m  ����
�� eMdsKcmd��  ��  . m  ��66�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  , 787 I 
��9��
�� .sysodelanull��� ��� nmbr9 m  ���� ��  8 :;: O !<=< I  ��>?
�� .prcskprsnull���     ctxt> m  @@ �AA  2? ��B��
�� 
faalB J  CC D��D m  ��
�� eMdsKcmd��  ��  = m  EE�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ; FGF I "'��H��
�� .sysodelanull��� ��� nmbrH m  "#���� ��  G IJI I (4��KL
�� .coredoscnull��� ��� ctxtK m  (+MM �NN � c d   / U s e r s / r o c k e t a d m i n / D r o p b o x / m i n x s s _ d r o p b o x / c o d e / r o c k e t _ r e a l _ t i m e /L ��O��
�� 
kfilO 4  ,0��P
�� 
cwinP m  ./���� ��  J QRQ I 5<��S��
�� .sysodelanull��� ��� nmbrS m  58TT ?ə�������  R UVU I =I��WX
�� .coredoscnull��� ��� ctxtW m  =@YY �ZZ  i d lX ��[��
�� 
kfil[ 4  AE��\
�� 
cwin\ m  CD���� ��  V ]^] I JQ��_��
�� .sysodelanull��� ��� nmbr_ m  JM`` ?ə�������  ^ aba I R^�cd
� .coredoscnull��� ��� ctxtc m  RUee �ff  s p a _ r e a l t i m ed �~g�}
�~ 
kfilg 4  VZ�|h
�| 
cwinh m  XY�{�{ �}  b iji I _f�zk�y
�z .sysodelanull��� ��� nmbrk m  _bll ?ə������y  j m�xm O gynon I mx�wp�v
�w .prcskprsnull���     ctxtp l mtq�u�tq I mt�sr�r
�s .prcskcodnull���     ****r m  mp�q�q $�r  �u  �t  �v  o m  gjss�                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  �x  % m  ��tt�                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��  " uvu l {�w�p�ow I {��nxy
�n .sysonotfnull��� ��� TEXTx m  {~zz �{{ 2 r o c k e t _ t m 1 _ s t a r t   f i n i s h e dy �m|}
�m 
appr| m  �~~ �   r o c k e t _ t m 1 _ s t a r t} �l��k
�l 
subt� m  ���� ���  D O N E�k  �p  �o  v ��j� l     �i�h�g�i  �h  �g  �j       �f���f  � �e
�e .aevtoappnull  �   � ****� �d��c�b���a
�d .aevtoappnull  �   � ****� k    ���  ��  &�� J�� T�� ]�� p�� t�� ��� ��� ��� ��� ��� ��� ��� ��� �� �� �� !�� u�`�`  �c  �b  �  � F �_ �^ �]�\B�[�Z�Y�X�W _�V�U�T o w � � � � � � � � � � � � � � � �$,4<So�Sm�R{�Q�P�O��N�M������1@MTYez~�
�_ 
appr
�^ 
subt�] 
�\ .sysonotfnull��� ��� TEXT
�[ .aevtrappnull��� ��� null
�Z .miscactvnull��� ��� null
�Y 
cwin
�X 
ttab
�W 
tcnt
�V 
kfil
�U .coredoscnull��� ��� ctxt
�T .sysodelanull��� ��� nmbr
�S 
prcs
�R 
pisf
�Q 
faal
�P eMdsKcmd
�O .prcskprsnull���     ctxt�N $
�M .prcskcodnull���     ****�a������� O��*j O*j 	O*�k/ 
*�k/*�,FUO��*�k/l Omj Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa �*�k/l Oa  �*�k/l Oa !�*�k/l Oa "�*�k/l Oa #�*�k/l Oa $�*�k/l Oa %�*�k/l Oa &�*�k/l Oa '�*�k/l Oa (�*�k/l Oa )�*�k/l Oa *�*�k/l Okj UOa + *j O*j 	UOkj Oa , !*a -a ./ *j O*j 	Oe*a /,FUUOkj Oa , a 0a 1a 2kvl 3UOkj Oa , 	a 4j 3UOkj Oa , a 5j 6j 3UOlj O� _*j O*j 	Okj Oa 7�*�k/l Okj Oa 8�*�k/l Okj Oa 9�*�k/l Okj Oa :�*�k/l Okj UOa , !*a -a ;/ *j O*j 	Oe*a /,FUUOa , 	a <j 3UOkj Oa , a 5j 6j 3UOlj O� �*j O*j 	Oa , a =a 1a 2kvl 3UOkj Oa , a >a 1a 2kvl 3UOkj Oa ?�*�k/l Oa @j Oa A�*�k/l Oa @j Oa B�*�k/l Oa @j Oa , a 5j 6j 3UUOa C�a D�a E� ascr  ��ޭ