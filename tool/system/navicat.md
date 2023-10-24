# mac
16.0.12

## rm reg key

cd ~/Library/Application\ Support/PremiumSoft\ CyberTech/Navicat\ CC/Navicat\ Premium  &&\
rm .`your reg key`

## rm plist key-id

+ query parent key with `your reg key`
/usr/libexec/PlistBuddy -c "print" ~/Library/Preferences/com.navicat.NavicatPremium.plist 

+ rm parent key
/usr/libexec/PlistBuddy -c 'Delete :`your parent key`' ~/Library/Preferences/com.navicat.NavicatPremium.plist

+ query parent key
/usr/libexec/PlistBuddy -c "print" ~/Library/Preferences/com.navicat.NavicatPremium.plist 

# windows 
16.0.14

https://www.cnblogs.com/zktww/p/16229690.html

```shell

@echo off

echo Delete HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Registration[version and language]
for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium" /s | findstr /L Registration"') do (
    reg delete %%i /va /f
)
echo.

echo Delete Info folder under HKEY_CURRENT_USER\Software\Classes\CLSID
for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E Info"') do (
    reg delete %%i /va /f
)
echo.

echo Finish

pause

```