365downloader
=============

A script for Mac OSX that allows you to download your photos from 365project.org.

Requires: a little understanding of the OS X terminal application!

How to install and run
----------------------

- Goto the Applications/Utilities folder and run the Terminal application.
- Type the following command to download the files:
  - git clone https://github.com/twocups/365downloader.git
- And to run the script run these commands:
  - cd 365downloader
  - ./365download.sh
- And now follow the prompts to run the downloader/



Pro Users - Original photos
---------------------------

For Pro users you can download the original hi-res images if you provide the authentication cookie.

To do this:
- log into 365project.org with Chrome web browser, then right click any where and choose'Inspect Element'
- Click the resources tab in the window that appears
- Click "Cookies" in the tree on the left and select "365project.org"
- This will list the cookies, find the one called 'auth' and copy its value to clipboard
- At the right place in the script paste that value in


No warranties with this script - use at your own risk! It was mainly built for my own purposes of archiving my project.

My 365 handle: @twocups


Linux Update
------------
Heres some changes you might want to make to get it to work on linux not os x. Thanks to Andrew Phelps

Line Number – What the line should now say:

46 – startdate=$(date -d”${day}/${month}/${year}” “+%d/%m/%Y”)
47 – enddate=$(date -d”${day}/${month}/${year} +${numdays} days” “+%d/%m/%Y”)

73 – current_date=$(date -d”${day}/${month}/${year} +${current_iteration} days” “+%d/%m/%Y”)
74 – current_date_365=$(date -d”${day}/${month}/${year} +${current_iteration} days” “+%d-%m-%Y”)


