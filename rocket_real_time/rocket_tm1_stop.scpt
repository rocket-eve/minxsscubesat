FasdUAS 1.101.10   ��   ��    k             l      ��  ��    #  stop the rocket data for tm      � 	 	 :   s t o p   t h e   r o c k e t   d a t a   f o r   t m     
  
 l     ��������  ��  ��        l    	 ����  I    	��  
�� .sysonotfnull��� ��� TEXT  m        �   . R u n n i n g   r o c k e t _ t m 1 _ s t o p  ��  
�� 
appr  m       �    r o c k e t _ t m 1 _ s t o p  �� ��
�� 
subt  m       �    R U N N I N G . . .��  ��  ��        l     ��������  ��  ��        l     ��  ��    ! tell application "Terminal"     �     6 t e l l   a p p l i c a t i o n   " T e r m i n a l "   ! " ! l     �� # $��   #  reopen    $ � % %  r e o p e n "  & ' & l     �� ( )��   (  activate    ) � * *  a c t i v a t e '  + , + l     �� - .��   - = 7 stop the spa_realtime display and return to the prompt    . � / / n   s t o p   t h e   s p a _ r e a l t i m e   d i s p l a y   a n d   r e t u r n   t o   t h e   p r o m p t ,  0 1 0 l     �� 2 3��   2 L Ftell application "System Events" to keystroke "2" using {command down}    3 � 4 4 � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " 2 "   u s i n g   { c o m m a n d   d o w n } 1  5 6 5 l     �� 7 8��   7  
delay 0.01    8 � 9 9  d e l a y   0 . 0 1 6  : ; : l     �� < =��   < L Ftell application "System Events" to keystroke "c" using {control down}    = � > > � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " c "   u s i n g   { c o n t r o l   d o w n } ;  ? @ ? l     �� A B��   A  
delay 0.01    B � C C  d e l a y   0 . 0 1 @  D E D l     �� F G��   F  reopen    G � H H  r e o p e n E  I J I l     �� K L��   K  activate    L � M M  a c t i v a t e J  N O N l     �� P Q��   P L Ftell application "System Events" to keystroke "2" using {command down}    Q � R R � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " 2 "   u s i n g   { c o m m a n d   d o w n } O  S T S l     �� U V��   U  
delay 0.01    V � W W  d e l a y   0 . 0 1 T  X Y X l     �� Z [��   Z L Ftell application "System Events" to keystroke "c" using {control down}    [ � \ \ � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " c "   u s i n g   { c o n t r o l   d o w n } Y  ] ^ ] l     �� _ `��   _  
delay 0.01    ` � a a  d e l a y   0 . 0 1 ^  b c b l     �� d e��   d - 'do script "exit" & linefeed in window 1    e � f f N d o   s c r i p t   " e x i t "   &   l i n e f e e d   i n   w i n d o w   1 c  g h g l     �� i j��   i A ;tell application "System Events" to keystroke (key code 36)    j � k k v t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   ( k e y   c o d e   3 6 ) h  l m l l     �� n o��   n  delay 2    o � p p  d e l a y   2 m  q r q l     �� s t��   s  end tell    t � u u  e n d   t e l l r  v w v l     �� x y��   x  delay 1    y � z z  d e l a y   1 w  { | { l     ��������  ��  ��   |  } ~ } l  
 ( ����  O   
 ( � � � O    ' � � � k    & � �  � � � I   ������
�� .aevtrappnull��� ��� null��  ��   �  � � � I    ������
�� .miscactvnull��� ��� null��  ��   �  ��� � r   ! & � � � m   ! "��
�� boovtrue � 1   " %��
�� 
pisf��   � 4    �� �
�� 
prcs � m     � � � � �  I D L � m   
  � ��                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��   ~  � � � l  ) . ����� � I  ) .�� ���
�� .sysodelanull��� ��� nmbr � m   ) *���� ��  ��  ��   �  � � � l  / ? ����� � O  / ? � � � I  3 >�� � �
�� .prcskprsnull���     ctxt � m   3 4 � � � � �  i � �� ���
�� 
faal � J   5 : � �  ��� � m   5 8��
�� eMdsKcmd��  ��   � m   / 0 � ��                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l  @ E ����� � I  @ E�� ���
�� .sysodelanull��� ��� nmbr � m   @ A���� ��  ��  ��   �  � � � l     �� � ���   �   send a control-c to IDL    � � � � 0   s e n d   a   c o n t r o l - c   t o   I D L �  � � � l  F X ����� � O  F X � � � I  J W�� � �
�� .prcskprsnull���     ctxt � m   J M � � � � �  c � �� ���
�� 
faal � J   N S � �  ��� � m   N Q��
�� eMdsKctl��  ��   � m   F G � ��                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l  Y ^ ����� � I  Y ^�� ���
�� .sysodelanull��� ��� nmbr � m   Y Z���� ��  ��  ��   �  � � � l  _ o ����� � O  _ o � � � I  c n�� ���
�� .prcskprsnull���     ctxt � b   c j � � � m   c f � � � � �  . r e s e t _ s e s s i o n � 1   f i��
�� 
lnfd��   � m   _ ` � ��                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l     �� � ���   �  delay 2    � � � �  d e l a y   2 �  � � � l     �� � ���   �   send the return key    � � � � (   s e n d   t h e   r e t u r n   k e y �  � � � l     �� � ���   � A ;tell application "System Events" to keystroke (key code 36)    � � � � v t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   ( k e y   c o d e   3 6 ) �  � � � l     �� � ���   �  delay 2    � � � �  d e l a y   2 �  � � � l     ��������  ��  ��   �  � � � l  p ����� � O   p � � � k   v
 � �  � � � I  v {������
�� .aevtrappnull��� ��� null��  ��   �  � � � I  | �������
�� .miscactvnull��� ��� null��  ��   �  � � � O  � � � � � I  � ��� � �
�� .prcskprsnull���     ctxt � m   � � � � � � �  1 � �� ���
�� 
faal � J   � � � �  ��� � m   � ���
�� eMdsKcmd��  ��   � m   � � � ��                                                                                  sevs  alis    T  MacD3921                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c D 3 9 2 1  -System/Library/CoreServices/System Events.app   / ��   �  � � � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��   �  � � � I  � ��� � �
�� .coredoscnull��� ��� ctxt � m   � � � � � � �  s t o p � �� ���
�� 
kfil � n   � � � � � 4   � ��� �
�� 
ttab � m   � �����  � 4  � ��� �
�� 
cwin � m   � ����� ��   �    I  � �����
�� .sysodelanull��� ��� nmbr m   � ����� ��    I  � ���
�� .coredoscnull��� ��� ctxt m   � � � " s t o p t r a n s f e r   8 0 0 2 ��	��
�� 
kfil	 n   � �

 4   � ���
�� 
ttab m   � �����  4  � ���
�� 
cwin m   � ����� ��    I  � �����
�� .sysodelanull��� ��� nmbr m   � ����� ��    I  � ���
�� .coredoscnull��� ��� ctxt m   � � �  s e t m o d e   0 ���
�� 
kfil n   � � 4   � ��~
�~ 
ttab m   � ��}�}  4  � ��|
�| 
cwin m   � ��{�{ �    I  � ��z�y
�z .sysodelanull��� ��� nmbr m   � ��x�x �y     I  ��w!"
�w .coredoscnull��� ��� ctxt! b   � �#$# m   � �%% �&&  e x i t$ 1   � ��v
�v 
lnfd" �u'�t
�u 
kfil' n   �()( 4   ��s*
�s 
ttab* m  �r�r ) 4  � ��q+
�q 
cwin+ m   � ��p�p �t    ,-, l 		�o./�o  .   close tab 2   / �00    c l o s e   t a b   2- 121 l 		�n34�n  3 L Ftell application "System Events" to keystroke "2" using {command down}   4 �55 � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " 2 "   u s i n g   { c o m m a n d   d o w n }2 6�m6 l 		�l78�l  7 L Ftell application "System Events" to keystroke "W" using {command down}   8 �99 � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " W "   u s i n g   { c o m m a n d   d o w n }�m   � m   p s::�                                                                                      @ alis    4  MacD3921                       BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    M a c D 3 9 2 1  #Applications/Utilities/Terminal.app   / ��  ��  ��   � ;<; l     �k=>�k  =  delay 2   > �??  d e l a y   2< @A@ l     �jBC�j  B A ;tell application "System Events" to keystroke (key code 36)   C �DD v t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   ( k e y   c o d e   3 6 )A EFE l     �iGH�i  G  delay 1   H �II  d e l a y   1F JKJ l     �hLM�h  L ! tell application "Terminal"   M �NN 6 t e l l   a p p l i c a t i o n   " T e r m i n a l "K OPO l     �gQR�g  Q  	reopen   R �SS  	 r e o p e nP TUT l     �fVW�f  V  		activate   W �XX  	 a c t i v a t eU YZY l     �e[\�e  [ M G	tell application "System Events" to keystroke "q" using {command down}   \ �]] � 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " q "   u s i n g   { c o m m a n d   d o w n }Z ^_^ l     �d`a�d  `  end tell   a �bb  e n d   t e l l_ cdc l     �c�b�a�c  �b  �a  d e�`e l f�_�^f I �]gh
�] .sysonotfnull��� ��� TEXTg m  ii �jj 0 r o c k e t _ t m 1 _ s t o p   f i n i s h e dh �\kl
�\ 
apprk m  mm �nn  r o c k e t _ t m 1 _ s t o pl �[o�Z
�[ 
subto m  pp �qq  D O N E�Z  �_  �^  �`       �Yrs�Y  r �X
�X .aevtoappnull  �   � ****s �Wt�V�Uuv�T
�W .aevtoappnull  �   � ****t k    ww  xx  }yy  �zz  �{{  �||  �}}  �~~  �  ��� e�S�S  �V  �U  u  v # �R �Q �P�O ��N ��M�L�K�J ��I�H�G ��F ��E: � ��D�C�B�A%imp
�R 
appr
�Q 
subt�P 
�O .sysonotfnull��� ��� TEXT
�N 
prcs
�M .aevtrappnull��� ��� null
�L .miscactvnull��� ��� null
�K 
pisf
�J .sysodelanull��� ��� nmbr
�I 
faal
�H eMdsKcmd
�G .prcskprsnull���     ctxt
�F eMdsKctl
�E 
lnfd
�D 
kfil
�C 
cwin
�B 
ttab
�A .coredoscnull��� ��� ctxt�T������ O� *��/ *j 
O*j Oe*�,FUUOkj O� ��a kvl UOkj O� a �a kvl UOlj O� a _ %j UOa  �*j 
O*j O� a �a kvl UOkj Oa a *a k/a k/l Olj Oa a *a k/a k/l Olj Oa a *a k/a k/l Olj Oa _ %a *a k/a k/l OPUOa  �a !�a "�  ascr  ��ޭ