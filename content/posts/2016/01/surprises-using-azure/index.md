---
title: "Surprises Using Azure"
author: "Chris C"
date: 2016-01-22
---

Are you a [MSDN](https://msdn.microsoft.com/) subscriber?  Thinking about using [Azure](https://azure.microsoft.com/) because of the [sweet sweet credits](https://azure.microsoft.com/en-us/pricing/member-offers/msdn-benefits/) you get for being a MSDN subscriber?  Maybe you want to switch because they are one of few cloud providers that have Windows operating systems.

Well I did switch.  Below are features, or missing features, in Azure that surprised me.

## Azure has two interfaces and APIs

When login to Azure for the first time it asks if you want to use the new portal.  Sure you say, why not.  Then you go to create a new virtual machine in the new interface.  When creating the virtual machine you get asked if you want a legacy VM or a fancy new type of VM.  A new VM you say.  Great says Azure and you create the VM.

It’s only much later that you find out the new VMs won’t work with any existing tools.  They have their own API and Powershell commands so plugins like the TeamCity one don’t work.  Hurray.  Also all the documentation you will find will mostly talk about the old lecacy system.  Finally the new GUI interface is still missing some stuff, like creating a IP address.  You can only do that with PowerShell commands.

## Starting a Virtual Machine is Slow but Gets Better

When you start a virtual machine in Azure it takes longer then you think it would.  That said once it’s up and running performance is acceptable.

## You can’t create snapshot of Azure

This was my biggest surprise.  I was used to creating a snapshot, doing something crazy on the virtual machine, then restore the snapshot.  Super useful for testing a new upgrade for staging.  For some reason you can’t do this with Azure.  I have no idea why.

## Azure Has Lots of Ready to Go VM Images

Although you can’t take snapshots Azure does have lots of ready to go out the box virtual machine images.  This includes development images such as VS 2015, Windows Servers, and even various flavours of Linux such as Ubuntu.
