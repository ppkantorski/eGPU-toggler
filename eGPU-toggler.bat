@echo off
set mypath=%~dp0

echo #========================================================================#
echo #                                      )                (                #
echo #             (  (  (          (    ( /(     (  ( (  (  )\  (            #
echo #            ))\ )\))( `  )   ))\   )\())(   )\))()\))(((_)))\           #
echo #           /((_^|(_))\ /(/(  /((_) (_))/ )\ ((_))((_))\ _ /((_)          #
echo #          (_))  (()(_^|(_)_\(_))(  ^| ^|_ ((_) (()(_^|()(_) (_))            #
echo #          / -_)/ _` ^|^| '_ \) ^|^| ^| ^|  _/ _ \/ _` / _` ^|^| / -_)           #
echo #          \___^|\__, ^|^| .__/ \_,_^|  \__\___/\__, \__, ^|^|_\___^|           #
echo #               ^|___/ ^|_^|                   ^|___/^|___/                   #
echo #========================================================================#
echo # Description: This program repeatedly toggles the eGPU PCIe controller  #
echo #              in order to trigger a proper eGPU detection and resolve   #
echo #              "error 12".                                               #
echo #========================================================================#
echo # Programmer: Patrick Kantorski      ^| Date: 01/25/20                   #
echo #========================================================================#

start devmgmt.msc

echo ^> Starting PCIe controller toggler...
timeout /t 1 >nul
echo ^> 3
timeout /t 1 >nul
echo ^> 2
timeout /t 1 >nul
echo ^> 1


for /l %%i in (1,1,500) do (

  "%mypath%"devcon.exe disable "PCI\VEN_8086&DEV_0D05"
  "%mypath%"devcon.exe enable "PCI\VEN_8086&DEV_0D05"

  timeout /t 1 >nul

  "%mypath%"devcon.exe status "PCI\VEN_1002&DEV_66AF&SUBSYS_081E1002" > "%mypath%"eGPU-status.txt
  findstr /c:"12" "%mypath%eGPU-status.txt" && (echo ^> egpu not connected...) || (echo ^> egpu is now connected! && goto :complete)
)

:complete
pause