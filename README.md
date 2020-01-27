# eGPU-toggler v1.0 (Windows 10 Bootcamp)
Workaround to fix the eGPU driver issue "Error 12" on the 2015 MBP 15" running Windows 10 Bootcamp.

# Features
Here's a Windows Batch script that will toggle on and off the eGPU PCIe controller until a successful connection is made.  This program has only been tested with the 2015 MBP 15", the Razer Core X eGPU enclosure and Windows 10 Pro build 1903.

# How To Use Program
1. Extract the files from the .zip to its own folder.

2. Right click on "eGPU-toggler.bat" file and create a .lnk shortcut.

3. Right click on the .lnk shortcut and click Properties, Advanced, then turn on Run as Admin.

4. Make sure the eGPU enclosure is turned on and plugged into your MBP through the TB2 port.  Then double click on the .lnk shortcut and click "Yes".  It may take a few minutes.  After a successful bridge is made or the eGPU is disconnected, the script will automatically close itself.

# Installing Program to Startup
Installing this program into the Windows 10 Task Scheduler is the most ideal way to use eGPU-toggler.  By doing this, it will automatically run the script at startup so you do not need to open your computer up to get past the login screen.  If no eGPU is connected, the program will close.  If an eGPU with Error 12 pops-up, it will automatically execute.  Give it a few minutes, it will close automatically when the connection is made.  If a successful connection is not made within the first few minutes, try restarting your computer.

1. Click on the search bar and type in "Task Scheduler".
2. Open Task Scheduler, then under Actions click "Create Task...".
3. For the name of the task, type in "eGPU-toggler".  Then click on "Run with highest priviledges" to enable it.
4. Click on the Triggers tab, then click on "New...".  Set "Begin the task:" to "At startup".
5. Click on the Actions tab, then click on "New...".  Click "Browse..." and navigate to the "eGPU-toggler.bat" file contained in the eGPU-toggler directory.
6. Click on the Settings tab and make sure "Allow task to be run on demand" is enabled.  It should be on by default.
7. Now click "OK" at the bottom and your task will be set!  You can check it out in "Task Scheduler Library".  If you want to disable it, right-click on the task and click disable.  If you want to delete it, do the same but click delete.

# Support for Other MBPs
1. Track down the PCIE controller connecting your eGPU in Device Manager.  To test out which one is connecting your eGPU, try toggling off and on the PCIE controllers one by one in Device Manager to see which one makes your eGPU disappear.
2. Right-click that particular PCIE controller, go to "Properties", "Details", "Hardware Ids".  Copy and replace the driver name in eGPU-toggler.bat with everything up until the 2nd "&" symbol.  It should look similar to "PCI\VEN_8086&DEV_0D05".
3. On the actual eGPU (not the PCIE controller), copy the Hardware Ids that looks similar to "PCI\VEN_1002&DEV_66AF&SUBSYS_081E1002" and replace it in eGPU-toggler.bat. This will allow eGPU-toggler to detect changes to the status of Error 12.

# Side-notes
IMPORTANT: If you do not get a successful connection within the first few minutes, you may have to restart your computer then run the program again right when it boots up.

The script should work with other eGPUs and TB1/TB2 MBPs, but I have not tested it.  A few simple modifications (changing driver IDs) would be required for different MBP models.

DevCon (Devcon.exe), the Device Console, is a command-line tool that displays detailed information about devices on computers running Windows.  It is a free Microsoft package and not my own script. I do not proclaim ownership of it.
