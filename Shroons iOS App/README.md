IF THIS APP REFUSES TO LOAD SHOWS OR ANYTHING FROM THE API, PLEASE DO NOT FAIL ME!!!!!
MY WEB SERVER THAT I HOST FROM MY OWN HOME ON MY OWN INTERNET IS AN OLD LENOVO DESKTOP TOWER RUNNING LINUX
THE WEBSERVER FRAMEWORK IS DJANGO, AND IT IS OFTEN INTENTIONALLY CRASHED BY BOTS DESPITE MY ATTEMPTS TO MITIGATE IT
IT IS SET TO SOFT REBOOT THE WEB SERVER EVERY 6 HOURS TO TRY TO MAINTAIN SERVICE AS MUCH AS POSSIBLE.
TRY AGAIN LATER, AND IF IT STILL DOESN'T WORK, PLEASE EMAIL ME @ eric@shroons.com TO HARD REBOOT THE SERVER.

Since we kind of jumped the gun and basically completed the app and all of it's functionality, for the next checkpoint
we are going to add an upload photos feature and attach it to the past shows so fans can upload their photos from the shows
and it will show up on the app. There will be an approval process on the website for administrators so no NSFW photos get through.
This will require me to update my database to support fan photos as attachments for the shows model, and a way of accepting uploads with a max of 5 photos per IP address (5 photos in the awaiting approval queue, after photos are approved the limit gets reset) ((this is to prevent bots from maliciously uploading files to my website)). Maybe we can figure out a way to use the login functionality I have on my website to also work within the app? Maybe I can have the app render a webpage for the upload section instead of have it be swift code, so I can require users to login to prevent bots from uploading?? If you are a TA reading this, please give me feedback on what you think will be the best. I already have login functionality with OAuth2 via Google, and it is very easy to make it so a page or feature only works when you have an active session token (AKA logged in with an account). This would make malicious activity easy to track and easy to associate names to photos kind of like in social media. 
