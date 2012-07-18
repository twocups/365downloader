365downloader
=============

A script for Mac OSX that allows you to download your photos from 365project.org.

Requires: a little understanding of the OS X terminal application!

To run this script download/check it out into a directory on your Mac then find it in terminal. 

You need to make it executable, so run this command to do that:
chmod 755 365download.sh

To run the script simply run this command:
./365download.sh

Pro Users
---------

For Pro users you can download the original hi-res images if you provide the authentication cookie.

To do this:
- log into 365project.org with Chrome web browser, then right click any where and choose'Inspect Element'
- Click the resources tab in the window that appears
- Click "Cookies" in the tree on the left and select "365project.org"
- This will list the cookies, find the one called 'auth' and copy its value to clipboard
- At the right place in the script paste that value in


No warranties with this script - use at your own risk! It was mainly built for my own purposes of archiving my project.

My 365 handle: @twocups

