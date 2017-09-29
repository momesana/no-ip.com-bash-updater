README
======

Bash script to update the ip of an account on no-ip.com.

This script is just a modification of no-ip.com bash-updater provided by
AntionCS, to be found at 'https://github.com/AntonioCS/no-ip.com-bash-updater'
with the purpose of making it aware of multiple hostsites.

How to use
----------

* At the minimum you have to configure the script with the correct username, password and hostnames
* Optionally you can also configure the name and location of the cache(current IP) and log file
* Make it executable (`chmod +x`)
* Run it (`./noipupdater.sh`)

Tips!
-----

Place this in your cron file (for example using `crontab -e` with superuser privileges):

    */15 * * * * /dir/where/file/is/noipupdater.sh

This will run the script every fifteen minutes.

Note: Some users have had problem executing the cron. If that is your case, remove the `.sh` extension.

Happy updating!
