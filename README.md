# minxsscubesat
Code for use in uplink during SDO-EVE rocket underflights. This set contains lots of changes for 36.383 and bug fixes from 36.353 and prior rockets.

There are two sets of code that communicate with the Altairs for TM1 and TM2. 
Another set exists for communicating over RS-232/serial. 

For TM1, the main program is rocket_eve_tm1_real_time_display.pro.
For TM2, the main program is rocket_eve-tm2_real_time_display.pro.

For the FPGA/dualsps both are run on Windows using Hydra (x2).
