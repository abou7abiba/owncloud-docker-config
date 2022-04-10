# How to build your ownCloud at Home

In this article, I will share with you my experience to build my [ownCloud][1] environment at home. 

My ownCloud environment now consists of ownCloud server using a docker image on an Ubuntu machine with 6TB storage connected to it. This environment is now connecting my personal machine, my business laptop, and our family mobile devices (android phones, and iOS ipad) with each other and be able to share personal family documents among them.

I tried to connect my Dropbox storage on it, but this is still under development as I am facing some challenges in it.

## Why I need to do so

I am doing this for the following reasons. So if you have any or all of these reasons, may be you should thing about doing the same at your side.

### 1. Transfer big files on local network across different platforms with no cost.

I had a problem that I need to transfer documents from my work laptop to my storage. These documents were mainly personal documents that was on my work laptop while they start to apply NO USB policy which make it not possible to write any data to the USB storage and can only read them. I had personal big files like VMs or movies that I used to watch during my travels. 

The only proposed solution from the company is to copy it to the company's cloud storage. That means that I have to transfer more than 100 GB to the cloud through my home connection and back again to my personal computer which is a laptop with Ubuntu 20.04 on it.

Then I had an idea to build my own cloud if there is an open source one. That is of course after I failed to get my laptop to be recognized over any network (personal or business) to be able to move the documents on a local network instead of a public network which will cost me extra money. I can across ownCloud platform and I decided to build my ownCloud

### 2. Build a secure private cloud environment that I am sure it is private.

All the cloud providers are keep saying they are maintaining the privacy of their data but every now and then we are facing an accident of data leakage due to error or hacking or even selling the data. 

I decided to keep my data at my home. No body will have access it any more. That is the real meaning of privacy

### 3. I need to build my Media Center at home.

I wanted to collect all my media into one big storage that contains all my personal contents like family images and videos as well as the downloaded movies that I would like to watch at home with the proper privacy. Specially with those with arabic subtitles (I am arabic speaker) that I collected over time. 

To do so I needed a way to have all my devices to be connected to this centralized storage so I can copy these media files to this storage. Then to build a media center so I can access my personal media at home from my big smartTV. The answer for this was [ownCloud][1] along with [Kodi][2] software 

[1]: https://owncloud.com/
[2]: https://kodi.tv/

## My solution architecture

