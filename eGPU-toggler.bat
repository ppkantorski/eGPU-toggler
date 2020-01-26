@echo off
set mypath=%~dp0

echo #========================================================================#
echo #                ___ ___ _   _     _                  _                  #
echo #           ___ / __^| _ \ ^| ^| ^|___^| ^|_ ___  __ _ __ _^| ^|___ _ _          #
echo #          / -_) (_ ^|  _/ ^|_^| ^|___^|  _/ _ \/ _` / _` ^| / -_) '_^|         #
echo #          \___^|\___^|_^|  \___/     \__\___/\__, \__, ^|_\___^|_^|           #
echo #                                          ^|___/^|___/                    #
echo #========================================================================#
echo # Description: This program repeatedly toggles the eGPU PCIe controller  #
echo #              in order to trigger a proper eGPU detection and resolve   #
echo #              "Error 12".                                               #
echo #========================================================================#
echo # Programmer: Patrick Kantorski      ^| Date: 01/26/20                   #
echo #========================================================================#

REM start devmgmt.msc

"%mypath%"devcon.exe status "PCI\VEN_1002&DEV_66AF&SUBSYS_081E1002" > "%mypath%"eGPU-status.txt
findstr /c:"12" "%mypath%eGPU-status.txt" && (echo ^> eGPU is not working properly!) || (goto :eof)

echo ^> Starting eGPU PCIe controller toggler.
timeout /t 1 >nul


for /l %%i in (1,1,500) do (

  "%mypath%"devcon.exe status "PCI\VEN_1002&DEV_66AF&SUBSYS_081E1002" > "%mypath%"eGPU-status.txt
  findstr /c:"12" "%mypath%eGPU-status.txt" && (echo ^> eGPU still not working yet...) || (goto :complete)

  "%mypath%"devcon.exe disable "PCI\VEN_8086&DEV_0D05"
  "%mypath%"devcon.exe enable "PCI\VEN_8086&DEV_0D05"

  timeout /t 1 >nul
)

:notconnected
echo ^> No issues with eGPU.
goto :eof

:complete
echo ^> eGPU issues have been resolved!
