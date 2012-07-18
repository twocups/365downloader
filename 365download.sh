#!/bin/bash


#
# A shell script for downloading your images from 365 project
# (For Mac OSX)
#
# To run this script download it to a directory on your Mac then find it in terminal. 
# You need to make it executable, so run this command:
# 
# chmod 755 365download.sh
#
# To run the script simply run this command:
# ./365download.sh
#
#
# For Pro users you can download the orginal hi-res images if you provide the authentication cookie.
#
# To do this:
# 	- log into 365project.org with Chrome web browser, then right click any where and choose'Inspect Element'
# 	- Click the resources tab in the window that appears
#	- Click "Cookies" in the tree on the left and select "365project.org"
#	- This will list the cookies, find the one caaled 'auth' and copy its value to clipboard
#	- At the right place in the script paste that value in
#
#
# No warranites with this script - use at your own risk! It was mainly build for my own purposes!
# -  @twocups July 2012


printf "\n\n*******************************"
printf "\n365project.org Photo Downloader"
printf "\n*******************************"

printf "\n\nFill in the details below to get your photos downloaded\n\n"


echo -n "Project user name: "
read username

echo -n "Album name: "
read album

echo -n "Start year: "
read year

echo -n "Start month [1-12]: "
read month

echo -n "Start day [1-31]: "
read day

echo -n "Number of days to download (up to 366): "
read numdays

echo -n "Auth cookie value (for pro user originals, leave blank if you dont understand!):"
read cookie

if [ $numdays -gt 366 ]; then
	echo "!!! Too many days, exiting !!!";
	exit 1
fi
startdate=$(date -v${day}d -v${month}m -v${year}y "+%d/%m/%Y")
enddate=$(date -v${day}d -v${month}m -v${year}y -v+${numdays}d "+%d/%m/%Y")

export_dir="${year}-${month}-${day}"

printf "\n\n*** Please confirm the follow is correct ***\n\n"
printf "Project: %s\n" $username
printf "Album: %s\n" $album
printf "Start date: %s\n" $startdate
printf "Days to download: %s (ending %s)\n" $numdays $enddate
printf "Export directory: %s" $export_dir
printf "\n\nIs this all correct? [y/n]"

read -n 1 correct

if [ "$correct" != "y" ]; then
	printf "\n\nExiting now\n\n"
	exit 0
fi

printf "\n\n Beginning download, this might take some time...\n\n"

#Loops over the days
current_iteration=0

while [ $current_iteration -lt $numdays ]; do
	
	current_date=$(date -v${day}d -v${month}m -v${year}y -v+${current_iteration}d "+%d/%m/%Y")
	current_date_365=$(date -v${day}d -v${month}m -v${year}y -v+${current_iteration}d "+%Y-%m-%d")
	printf "\n\nDay %s: %s\n" $current_iteration $current_date
	
	#Check that a page for today exists (200 response code)
	todays_page_url="http://365project.org/${username}/${album}/${current_date_365}"
	http_code=$(curl -s "${todays_page_url}" -o /dev/null -w "%{http_code}")
	printf "\tAnalyzing page: %s" $todays_page_url
	
	if [ $http_code == "200" ]; then
		printf " (found!)"
		
		#Get the image ID by analyzing the page
		image_id=$(curl -s "${todays_page_url}" | grep -o -E "showExif\([0-9]*\)" | grep -o -E "[0-9]+")
		printf "\n\tImage ID is %s" $image_id
		
		
		#Use the image id to get the sizes		
		sizes_url="http://365project.org/media/show_sizes/${image_id}"
		image_size="large"
		if [ $cookie == "" ]; then
			#standrd large images
			image_path=$(curl -s "${sizes_url}" | grep -o -E "${image_id}_([^_]+)_l.jpg" | uniq)
		else
			#original size images
			image_size="orginal"
			image_path=$(curl -s -b "auth=${cookie}" "${sizes_url}" | grep -o -E "${image_id}_([^_]+)_o.jpg" | uniq)
		fi
		full_image_path="http://media.365project.org/1/${image_path}"
		printf "\n\tDownloading %s image: %s" $image_size $full_image_path
		
		#create export directory
		mkdir -p ${export_dir}
		curl -s "${full_image_path}" -o "${export_dir}/${current_date_365}.jpg" 
		printf " done."
		
	else
		printf " NOT FOUND (code %s), skipping to next day\n" $http_code
	fi

	
	
	
	current_iteration=$[$current_iteration +1]
done

printf "\n\nDownload complete. Files should be in the %s directory\n\n" ${export_dir}





