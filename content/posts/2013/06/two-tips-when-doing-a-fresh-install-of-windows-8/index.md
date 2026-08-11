---
title: "Two Tips When Doing a Fresh Install of Windows 8"
author: "Chris C"
date: 2013-06-09
---

I have two tips when you are doing a fresh install of [Windows 8](http://windows.microsoft.com/en-ca/windows/home "Windows 8") on a [new laptop](http://www.dell.com/ca/p/xps-13-l321x-mlk/pd "Dell XPS 13 Ultrabook") with UEFI BIOS.  Sorry, I mean with [UEFI](http://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface "UEFI") firmware interface instead of [BIOS](http://en.wikipedia.org/wiki/BIOS "BIOS") firmware interface.  I think that is more correcter or the correstest way.  I just can’t stop saying “UEFI BIOS”.   “UEFI BIOS”.  See I just did it again.  Next I’ll be saying use “[The Google](http://www.theonion.com/articles/google-launches-the-google-for-older-adults,5850/ "The Google")”.

Let us get back to the two tips.  The first tip is booting your new laptop with UEFI and secure boot enabled from a USB stick with Windows 8 on it.  The problem is the USB stick needs to be formatted as [FAT32](https://en.wikipedia.org/wiki/File_Allocation_Table "FAT32") because UEFI does not recognize [NTFS](http://en.wikipedia.org/wiki/NTFS "NTFS").  I wonder why this is.  I couldn’t find a reason on The Google.

I used the [Windows 7 USB/DVD Tool](http://www.microsoftstore.com/store/msus/html/pbPage.Help_Win7_usbdvd_dwnTool/ "Windows 7 USB/DVD Tool") to get the Windows 8 installer on the USB drive.  You can ignore the “Windows 7” part; it works for Windows 8 just fine.  The problem is the USB drive is formatted as NTFS by the tool.  To get around this problem take the following steps outlined below which I got from [Thomas Dbasinskas’s](http://blog.dabasinskas.net/installing-windows-8-in-uefi-mode-from-usb/ "Installing Windows 8 in UEFI mode from USB") blog:

1. Run the Windows 7 USB/DVD tool and select the Window 8 iso.
2. Copy all the files on your USB drive back to the harddrive on your computer.
3. Format the USB drive as FAT32.
4. Copy the Windows 8 files from your computer back to the USB drive.

The second tip is that the [Windows 8 key is stored in the BIOS](http://superuser.com/questions/513904/how-to-extract-win-8-oem-key-embedded-in-the-bios "Windows 8 Key Stored in the BIOS").  I mean the UEFI.  Maybe the UEFI BIOS.  Anyway, it’s stored in the firmware of the laptop.  This is not a problem if you want to reinstall the same version of Windows 8 but in my case I wanted to upgrade from Windows 8 to Windows 8 Pro using my MSDN key.

I was confused because during the Windows 8 install I was never asked for a key.  I thought I would be asked after the install but never was.  After some confusion I figured out the key was stuffed in the firmware.  To upgrade my version of Windows I had to enter in the Windows 8 Pro key and then Windows auto-magically upgraded itself.
