# UrgentPath
An IOS application designed to provide navigation guidance to pilots when the plane experienced all-engine failure.
The application used code from [Aircraft_Trajectory_Generation](https://github.com/enjoybeta/Aircraft_Trajectory_Generation) to generate trajectories for emergency situations.
---
<img src="https://github.com/enjoybeta/UrgentPath/blob/master/Data/demo1.jpg" alt="demoImage1" width="400"/> <img src="https://github.com/enjoybeta/UrgentPath/blob/master/Data/demo2.jpg" alt="demoImage2" width="400"/>

## Build Prerequisite
Name | Version
------------ | -------------
Xcode | 9.4.1
Cocoapods | 1.5.3
X-Plane 9 | optional
X-Plane 11 | optional

Please install other modules referenced to ***"Podfile"*** in the root directory of the project

## X-Plane related
### 1.How to test the app with X-Plane simulator?
1. Make sure both IOS device and machine running X-Plane are on a same LAN
2. Exexcute "make" to run the *"Makefile"* under XPlane/ (using GNU make)
3. Exexcute "./udp_redirect_xplane11.out 192.168.1.3" to redirect UDP packets(details check out #2)
4. Start the X-Plane application and the IOS application
5. Switch the button *"Override with X-Plane data"* to ON at the second tab of IOS application
6. All set

### 2.How to properly run the executable file?
***Example***: Execute the command **"./udp_redirect_xplane9.out 192.168.1.3"** <br/>
**"udp_redirect_xplane9.out"** is executable file based on X-Plane 9, **"udp_redirect_xplane11.out"** is for X-Plane 11 <br/>
**"192.168.1.3"** is the ip address of the IOS device inside the LAN, change accordingly

### 3. How the connection works?
 UDP protocol is used throughout the communication.
##### The data stream first send from X-Plane to "*.out"
The X-Plane application send the data to port 50000 (default on X-Plane) on the same machine, than received by the ".out" app
##### Than the ".out" send the data to IOS application.
The ".out" app send the data to port 60000 on the IOS device, than received by the IOS application
