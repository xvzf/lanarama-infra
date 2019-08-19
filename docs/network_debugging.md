# Helpful tools/commands

## FRR
> *NOTE* The CLI is similar to Quagga.

We are using [frrouting](https://frrouting.org) as a routing daemon on linux systems (more specific, advertising internal subnets via BGP). Frr is also configuring IP addresses of the interfaces.
Privileged users can enter the configuration shell (similar to cisco) with:
```
sudo vtysh
```
### Viewing installed routes with vtysh
> *NOTE* `ip` can be replaced with `ipv6`

All installed routes
```
heaven0# show ip route
Codes: K - kernel route, C - connected, S - static, R - RIP,
       O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, D - SHARP,
       F - PBR,
       > - selected route, * - FIB route

K>* 0.0.0.0/0 [0/0] via 172.16.0.1, eno1, 00:23:06
C>* 10.51.1.0/30 is directly connected, enp8s0f1, 00:23:17
S>* 10.52.1.2/32 [1/0] via 10.51.1.1, enp8s0f1, 00:23:17
C>* 10.64.50.1/32 is directly connected, lo, 00:23:17
B>* 10.64.66.6/32 [20/0] via 10.51.1.1, enp8s0f1, 00:23:16
B>* 10.64.66.7/32 [20/0] via 10.151.1.1, enp8s0f0, 00:23:16
B>* 10.64.70.1/32 [20/0] via 10.51.1.1, enp8s0f1, 00:22:03
  *                      via 10.151.1.1, enp8s0f0, 00:22:03
C>* 10.151.1.0/30 is directly connected, enp8s0f0, 00:23:17
S>* 10.152.1.2/32 [1/0] via 10.151.1.1, enp8s0f0, 00:23:17
C>* 172.16.0.0/24 is directly connected, eno1, 00:23:06
B>* 192.168.1.0/24 [20/0] via 10.51.1.1, enp8s0f1, 00:22:03
  *                       via 10.151.1.1, enp8s0f0, 00:22:03
```

BGP routes (note the Path, this is very useful to trace packets)
```
heaven0# show ip bgp
BGP table version is 17, local router ID is 10.64.50.1, vrf id 0
Status codes:  s suppressed, d damped, h history, * valid, > best, = multipath,
               i internal, r RIB-failure, S Stale, R Removed
Nexthop codes: @NNN nexthop's vrf id, < announce-nh-self
Origin codes:  i - IGP, e - EGP, ? - incomplete

   Network          Next Hop            Metric LocPrf Weight Path
*> 0.0.0.0/0        0.0.0.0                  0         32768 i
*> 10.64.50.1/32    0.0.0.0                  0         32768 i
*> 10.64.66.6/32    10.51.1.1                              0 64666 i
*                   10.151.1.1                             0 64667 64666 i
*> 10.64.66.7/32    10.151.1.1                             0 64667 i
*= 10.64.70.1/32    10.151.1.1                             0 64667 64701 i
*>                  10.51.1.1                              0 64666 64701 i
*= 192.168.1.0/24   10.151.1.1                             0 64667 64701 i
*>                  10.51.1.1                              0 64666 64701 i

Displayed  6 routes and 9 total paths
```

## Core switches
> The CLI is pretty similiar though not as powerful as FRR or Quagga

### Routes
Installed routes:
```
core0#show ip route

VRF: default
Codes: C - connected, S - static, K - kernel,
       O - OSPF, IA - OSPF inter area, E1 - OSPF external type 1,
       E2 - OSPF external type 2, N1 - OSPF NSSA external type 1,
       N2 - OSPF NSSA external type2, B I - iBGP, B E - eBGP,
       R - RIP, I L1 - IS-IS level 1, I L2 - IS-IS level 2,
       O3 - OSPFv3, A B - BGP Aggregate, A O - OSPF Summary,
       NG - Nexthop Group Static Route, V - VXLAN Control Service,
       DH - DHCP client installed default route, M - Martian,
       DP - Dynamic Policy Route

Gateway of last resort:
 B E    0.0.0.0/0 [200/0] via 10.51.1.2, Ethernet51/1

 C      10.0.1.0/30 is directly connected, Ethernet1
 C      10.51.1.0/30 is directly connected, Ethernet51/1
 C      10.52.1.0/30 is directly connected, Ethernet51/2
 B E    10.64.50.1/32 [200/0] via 10.51.1.2, Ethernet51/1
 C      10.64.66.6/32 is directly connected, Loopback1
 B E    10.64.66.7/32 [200/0] via 10.0.1.2, Ethernet1
                              via 10.51.1.2, Ethernet51/1
                              via 10.52.1.2, Ethernet51/2
 B E    10.64.70.1/32 [200/0] via 10.0.1.2, Ethernet1
 B E    10.64.80.1/32 [200/0] via 10.52.1.2, Ethernet51/2
 C      10.66.6.0/30 is directly connected, Port-Channel666
 B E    192.168.1.0/24 [200/0] via 10.0.1.2, Ethernet1
 B E    192.168.122.0/24 [200/0] via 10.52.1.2, Ethernet51/2
```

BGP routes:
```
core0#show ip bgp
BGP routing table information for VRF default
Router identifier 10.66.6.1, local AS number 64666
Route status codes: s - suppressed, * - valid, > - active, # - not installed, E - ECMP head, e - ECMP
                    S - Stale, c - Contributing to ECMP, b - backup, L - labeled-unicast
Origin codes: i - IGP, e - EGP, ? - incomplete
AS Path Attributes: Or-ID - Originator ID, C-LST - Cluster List, LL Nexthop - Link Local Nexthop

        Network                Next Hop              Metric  LocPref Weight  Path
 * >     0.0.0.0/0              10.51.1.2             0       100     0       65001 i
 * >     10.64.50.1/32          10.51.1.2             0       100     0       65001 i
 * >     10.64.66.6/32          -                     0       0       -       i
 * >Ec   10.64.66.7/32          10.51.1.2             0       100     0       65001 64667 i
 *  ec   10.64.66.7/32          10.0.1.2              0       100     0       64701 64667 i
 *  ec   10.64.66.7/32          10.52.1.2             0       100     0       64801 64667 i
 * >     10.64.70.1/32          10.0.1.2              0       100     0       64701 i
 * >     10.64.80.1/32          10.52.1.2             0       100     0       64801 i
 * >     192.168.1.0/24         10.0.1.2              0       100     0       64701 i
 * >     192.168.122.0/24       10.52.1.2             0       100     0       64801 i
```

### Interface status
```
core0#show interfaces status
Port       Name   Status       Vlan     Duplex Speed  Type         Flags Encapsulation
Et1               connected    routed   full   10G    10GBASE-LR
Et2               notconnect   routed   full   10G    10GBASE-LR
Et3               notconnect   routed   full   10G    10GBASE-LR
Et4               notconnect   routed   full   10G    10GBASE-LR
Et5               notconnect   routed   full   10G    10GBASE-LR
Et6               notconnect   routed   full   10G    10GBASE-LR
Et7               notconnect   routed   full   10G    10GBASE-LR
Et8               notconnect   routed   full   10G    Not Present
Et9               disabled     1        full   10G    Not Present
Et10              disabled     1        full   10G    Not Present
...
```

### Temperature / Fan speed / Power usage
```
core0#show environment all
System temperature status is: Ok
                                                                 Alert  Critical
                                               Temp    Setpoint  Limit     Limit
Sensor  Description                             (C)         (C)    (C)       (C)
------- ----------------------------------- ------- ----------- ------ ---------
1       Cpu temp sensor                        43.1    (60) N/A     90        95
2       Cpu board temp sensor                  33.0    (55) N/A     75        80
3       Back-panel temp sensor                 31.5    (50) N/A     75        85
4       Board sensor                           33.0   (N/A) N/A     55        70
5       Front-panel temp sensor                28.4   (N/A) N/A     65        75
6       Trident Bottom Right Outer             44.4   (N/A) N/A    100       110
7       Trident Bottom Left Outer              42.8   (N/A) N/A    100       110
8       Trident Top Left Outer                 45.0   (N/A) N/A    100       110
9       Trident Top Right Outer                44.4   (N/A) N/A    100       110
10      Trident Bottom Right Inner             42.8   (N/A) N/A    100       110
11      Trident Bottom Left Inner              43.3   (N/A) N/A    100       110
12      Trident Top Left Inner                 42.8   (N/A) N/A    100       110
13      Trident Top Right Inner                42.8   (N/A) N/A    100       110

PowerSupply 1:
                                                                 Alert  Critical
                                               Temp    Setpoint  Limit     Limit
Sensor  Description                             (C)         (C)    (C)       (C)
------- ----------------------------------- ------- ----------- ------ ---------
1       Hotspot temperature sensor              0.0    (80) N/A     95       100
2       Inlet temperature sensor                0.0    (55) N/A     70        75

PowerSupply 2:
                                                                 Alert  Critical
                                               Temp    Setpoint  Limit     Limit
Sensor  Description                             (C)         (C)    (C)       (C)
------- ----------------------------------- ------- ----------- ------ ---------
1       Hotspot temperature sensor             31.0    (80) N/A     95       100
2       Inlet temperature sensor               36.0    (55) N/A     70        75

System cooling status is: Ok
Ambient temperature: 31C
Fan speed override mode enabled at 30%
Airflow: port-side exhaust
                      Config Actual           Speed   Stable
Fan            Status  Speed  Speed  Uptime Stability  Uptime
-------------- ------ ------ ------ ------- --------- -------
1/1            Ok        30%    29% 0:34:40 Stable    0:33:54
2/1            Ok        30%    30% 0:34:40 Stable    0:33:54
3/1            Ok        30%    29% 0:34:40 Stable    0:33:56
4/1            Ok        30%    30% 0:34:40 Stable    0:33:56
PowerSupply1/1 Ok        30%    34% 0:34:27 Stable    0:32:04
PowerSupply2/1 Ok        30%    34% 0:34:28 Stable    0:32:05

Power                        Input  Output  Output
Supply Model       Capacity Current Current  Power Status      Uptime
------ ----------- -------- ------- ------- ------ ---------- -------
1      PWR-500AC-R     500W   0.00A   0.00A   0.0W Power Loss Offline
2      PWR-500AC-R     500W   0.39A   6.47A  77.8W Ok         0:34:28
Total  --              500W      --      --  77.8W --              --
```

### ASIC Resource usage
```
core0#show hardware capacity
Forwarding Resources Usage

Table         Feature       Chip                 Used      Used         Free      Committed      Best Case         High
                                              Entries       (%)      Entries        Entries            Max    Watermark
                                                                                                   Entries
------------- ------------- --------------- ------------ --------- ------------ -------------- -------------- ---------
EFP                         Linecard0/0             0        0%         1024              0           1024            0
EFP           Slice-0       Linecard0/0             0        0%          256              0            256            0
EFP           Slice-1       Linecard0/0             0        0%          256              0            256            0
EFP           Slice-2       Linecard0/0             0        0%          256              0            256            0
EFP           Slice-3       Linecard0/0             0        0%          256              0            256            0
Host                                               40        0%       147415              0         147455           40
Host          Multicast                             0        0%       147415              0         147455            0
Host          V4Hosts                              22        0%       147415              0         147455           22
Host          V6Hosts                              18        0%       147415              0         147455           18
IFP                         Linecard0/0           296        7%         3800              0           4096          296
IFP           Slice-0       Linecard0/0             0        0%          512              0            512            0
IFP           Slice-1       Linecard0/0             0        0%          512              0            512            0
IFP           Slice-10      Linecard0/0             0        0%          256              0            256            0
IFP           Slice-11      Linecard0/0             0        0%          256              0            256            0
IFP           Slice-2       Linecard0/0             0        0%          512              0            512            0
IFP           Slice-3       Linecard0/0             0        0%          512              0            512            0
IFP           Slice-4       Linecard0/0            47       18%          209              0            256           47
IFP           Slice-5       Linecard0/0            47       18%          209              0            256           47
IFP           Slice-6       Linecard0/0           101       39%          155              0            256          101
IFP           Slice-7       Linecard0/0           101       39%          155              0            256          101
IFP           Slice-8       Linecard0/0             0        0%          256              0            256            0
IFP           Slice-9       Linecard0/0             0        0%          256              0            256            0
LPM                                                17        0%         8173              0           8190           17
LPM           V4Routes                              5        0%         8173              0           8190            5
LPM           V6Routes                             12        0%         8173              0           8190           12
LagGroup      LAG                                   1        0%         1023              0           1024            1
LagMember     LAG                                   9        0%         2039              0           2048            9
MAC                         Linecard0/0            16        0%       163824              0         163840           16
MAC           L2            Linecard0/0            16        0%       163824              0         163840           16
NextHop                                            39        0%        49112              0          49151           39
NextHop       Multicast                             0        0%        49112              0          49151            0
NextHop       Unicast                              39        0%        49112              0          49151           39
NextHop       VxLan                                 0        0%        49112              0          49151            0
VFP                         Linecard0/0             0        0%         1024              0           1024            0
VFP           Slice-0       Linecard0/0             0        0%          256              0            256            0
VFP           Slice-1       Linecard0/0             0        0%          256              0            256            0
VFP           Slice-2       Linecard0/0             0        0%          256              0            256            0
VFP           Slice-3       Linecard0/0             0        0%          256              0            256            0
```

## Access Switches

### Routing
Same as with linux hosts running frr. Open `vtysh` and start typing

### Checking system units
```
xvzf@SW152:~$ sudo smonctl
Fan1                                              :  OK
Fan2                                              :  OK
Fan3                                              :  OK
PSU1                                              :  OK
PSU2                                              :  BAD
Temp1     (Temp Sensor close to Networking ASIC  ):  OK
Temp2     (Front Right Corner Ambient Temp Sensor):  OK
Temp3     (System Rear Outlet Temp Sensor        ):  OK
Temp4     (P2020 Temp Sensor                     ):  OK
Temp5     (Front Left Corner Ambient Temp Sensor ):  OK
```

More details:
```
xvzf@SW152:~$ sudo smonctl -v -s Fan1
Fan1:  OK
fan:8402 RPM   (max = 29000 RPM, min = 2500 RPM, limit_variance = 15%)
```