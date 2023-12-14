# EC311_FinalProject
Final Project with an FPGA in Digital Logic Design

Typing Turmoil: Escape from Photonics

We created a Type Racer game that a player can play until they mistyp any of the words. Following the mistake, the user can view the words per minute with which they typed at. 

The hierarchy of our code is as follows:

Top.v

VGA
The logic for the VGA module is decided by the SegmentDecoder. This decoder is called once per character and decides which of the 16 hard coded boundaries should be filled in.
The VGA driver reads line by line and if the current pixel is in within one of the boundaries that is designated to go high by the SegmentDecoder, that area is colored in.
