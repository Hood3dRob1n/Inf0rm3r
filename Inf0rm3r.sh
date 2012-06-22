#!/bin/sh
#Th3 Inf0rm3r v1
#Created by Hood3dRob1n
#Linux x86 System Enumeration Tool to grab a solid understanding of what your working with
#Special Shoutout to th3breacher
#Greetz to and from INTRA!

#Begin magic...
#create banner function
banner(){
ascii(){
cat <<"EOT"
|<><><><><><><><><><><><><><><><><><><><><><><>|
|            can       *       y0u             |
|   /\~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~/\    |
|  (o )                .                ( o)   |
|   \/               .` `.               \/    |
|   /\             .`     `.             /\    |
|  (             .`         `.             )   |
|   )          .`      N      `.          (    |
|  (         .`   A    |        `.         )   |
|   )      .`     <\> )|(         `.      (    |
|  (     .`         \  |  (         `.     )   |
|   )  .`         )  \ |    (         `.  (    |
|    .`         )     \|      (         `.     |
|  .`     W---)--------O--------(---E     `.   |
|   `.          )      |\     (          .`    |
|   ) `.          )    | \  (          .` (    |
|  (    `.          )  |  \          .`    )   |
|   )     `.          )|( <\>      .`     (    |
|  (        `.         |         .`        )   |
|   )         `.       S       .`         (    |
|  (            `.           .`            )   |
|   \/            `.       .`            \/    |
|   /\              `.   .`              /\    |
|  (o )               `.`               ( o)   |
|   \/~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~\/    |
|            find     -|-     r00t?            |
|<><><><><><><><><><><><><><><><><><><><><><><>|		
EOT
}
#print banner by calling art banner function
ascii | grep --color -i -E 'can||y0u||find||r00t'
#print message below pic
echo 'Th3 Inf0rm3r v1' | grep --color -i 'Th3 Inf0rm3r v1'
echo '........by Hood3dRob1n' | grep --color 'by Hood3dRob1n'
echo ''
}

#set email to send report to if desired, where $# references passed argument position for email
#EMAIL="$1"

#Bash trap command & function
trap bashtrap INT

bashtrap(){
echo ''
echo ''
echo 'CTRL+C has been detected!.....shutting down now' | grep --color '.....shutting down now'
#remove any partial report file to avoid confusion or problems if re-run shortly after
if [ -f inf0rm3d.txt ]; then
	rm -f inf0rm3d.txt
fi
#exit entire script
exit 0
}

#NOT BEING CALLED UNTIL FIXXED!
#Actual Email function to handle above variable and send report details
#Thanks to code ideas from th3breacher for this section
action_send_mail_done()
{
#Check if argument was passed by checking $# (Argument array value) value. If nothing passed it will be set to 0, so...
#if argument array is less than 1, i.e. 0, then no email needed as nothing passed. Otherwise send email and assume argument passed is email
if [ -z $EMAIL ]; then
	echo 'No email provided...' | grep --color -i -E 'No email provided'
	echo ''
else
	echo 'Sending finished report...' | grep --color 'Sending finished report'
		SUBJECT='$(hostname) - Your Inf0rm3r Report has been completed'
	# Email the finished report
		EMAILMESSAGE="inf0rm3d.txt"
	# send an email using /bin/mail which is available on most web servers ;)
	mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
	echo 'Report has been emailed to' $EMAIL | grep --color 'Report has been emailed to'
	echo ''
fi
}

#Now we setup a master() so we can encase everything. This will allow us later to run everything to terminal with color enabled and then re-runs with redirect to create report file. See main() for more details.
master(){
basic_101
check_local_tools
user_enumeration
group_enumeration
host_file_enumeration
check_open_ports
check_running_processes
find_world_writable_dir
find_SUID
find_GUID
find_pass_and_configs
SSH_check

#Grab basic info
basic_101(){
echo 'Hostname: ' $(hostname) | grep --color 'Hostname'
echo 'Current Shell in Use: ' $SHELL | grep --color 'Current Shell in Use'
echo 'Current User: ' $(whoami) | grep --color 'Current User'
echo 'User ID: ' $(id) | grep --color 'User ID'
echo 'User Home Directory: ' $HOME | grep --color 'User Home Directory'
echo 'PWD: ' $(pwd) | grep --color 'PWD'
echo 'Kernel: ' $(uname -a) | grep --color 'Kernel' 
echo ''
echo 'Known Interfaces: ' | grep --color 'Known Interfaces'
ifconfig -a | grep --color -E 'eth||lo||tun||P-t-P||wlan||vmnet||inet addr||inet6 addr||Bcast||Mask||Link encap||HWaddr'
}

#Check what local tools are installed and version info, may be useful
check_local_tools(){
echo 'Possible Local Tools for use: ' | grep --color 'Possible Local Tools for use'
which gcc nc nmap ncat lynx curl wget php perl python ruby /etc/valiases | grep --color -i -E '/usr/bin|/etc/valiases|/bin'
echo ''
echo 'Grabbing Local Tools Version Info: ' | grep --color 'Grabbing Local Tools Version Info'
gcc --version | grep --color 'gcc'
mysql --version | grep --color -i -E 'mysql||Ver'
perl -v | grep --color -i -E 'This is perl|version|subversion|built for'
python --version | grep --color -i 'Python' 2> /dev/null
php --version | grep --color -i -E 'PHP||Zend Engine||Copyright' 2> /dev/null
java -version | grep --color 'java version' 2> /dev/null
echo ''
}

#Grab users with paths and then pure user list
user_enumeration(){
echo 'User Enumeration: ' | grep --color 'User Enumeration'
cat /etc/passwd | grep --color -i -E '/home||/vhosts||/bin/bash||/var/www'
echo ''
echo 'Straight User List: ' | grep --color 'Straight User List'
cat /etc/passwd | cut -d: -f1 
echo ''
}
#Group info
group_enumeration(){
echo 'Group Enumeration: ' | grep --color 'Group Enumeration'
cat /etc/group
echo ''
}
#hosts file info
host_file_enumeration(){
echo 'Hosts File Enumeration: ' | grep --color 'Hosts File Enumeration'
cat /etc/hosts
echo ''
}
#Open Port Check
check_open_ports(){
echo 'Open Ports on Host: ' | grep --color 'Open Ports on Host'
netstat -an | grep --color -i -E 'listen|listening' && echo ''
}
#ps aux - running processes (Can I hide script better to avoid showing up here?)
check_running_processes(){
echo 'Active Running Processes: ' | grep --color 'Active Running Processes'
ps aux | grep --color -E 'USER||PID||%CPU||%MEM||VSZ||RSS||TTY||STAT||START||TIME||COMMAND||root||postgresql||postgres||mysql||apache||www||www-data||vpn'
echo ''
}
#Find writable directories
find_world_writable_dir(){
echo 'Looking for all writable folders:' | grep --color 'Looking for all writable folders'
find / -type d -perm -2 -ls 2> /dev/null | grep --color -i -E 'root||/etc||/bin||/vaar/www||/home||/vhosts'
echo ''
}
#Find SUID files
find_SUID(){
echo 'Find all SUID files: ' | grep --color 'Find all SUID files'
find / -type f -perm -04000 -ls 2> /dev/null | grep --color -i -E 'root||/usr/bin||/bin||/usr/sbin||/sbin'
echo ''
echo 'SUID files in current dir: ' | grep --color 'SUID files in current dir'
find . -type f -perm -04000 -ls 2> /dev/null | grep --color -i -E 'root||/usr/bin||/bin||/usr/sbin||/sbin'
echo ''
}
#Find GUID Files
find_GUID(){
echo 'Find all GUID files: ' | grep --color 'Find all GUID files'
find / -type f -perm -02000 -ls 2> /dev/null | grep --color -i -E 'root||/usr/bin||/bin||/usr/sbin||/sbin'
echo ''
echo 'GUID files in current dir:' | grep --color 'GUID files in current dir'
find . -type f -perm -02000 -ls 2> /dev/null | grep --color -i -E 'root||/usr/bin||/bin||/usr/sbin||/sbin'
}

#Run check for known config and pass files for possible easy grabbing of juicy info
find_pass_and_configs(){
echo ''
echo 'Check and see if your luckiest man alive...' | grep --color 'Check and see if your luckiest man alive'
echo 'Looking for config files in current directory...' | grep --color 'Looking for config files in current directory'
find . -type f -name 'config'*'.'*'' 2> /dev/null | grep --color -i -E 'config.php||configuration.php||config.inc.php||wp-config.php'
echo ''
echo 'Looking for config.php...' | grep --color 'Looking for config.php'
find / -type f -name config.php 2> /dev/null | grep --color -i 'config.php'
echo ''
echo 'Looking for config.inc.php...' | grep --color 'Looking for config.inc.php'
find / -type f -name config.inc.php 2> /dev/null | grep --color -i 'config.inc.php'
echo ''
echo 'Looking for wp-config.php...' | grep --color 'Looking for wp-config.php'
find / -type f -name wp-config.php 2> /dev/null | grep --color -i 'wp-config.php'
echo ''
echo 'Looking for db.php...' | grep --color 'Looking for db.php'
find / -type f -name db.php 2> /dev/null | grep --color -i 'db.php'
echo ''
echo 'Looking for db-conn.php...' | grep --color 'Looking for db-conn.php'
find / -type f -name db-conn.php 2> /dev/null | grep --color -i 'db-conn.php'
echo ''
echo 'Looking for sql.php...' | grep --color 'Looking for sql.php'
find / -type f -name sql.php 2> /dev/null | grep --color -i 'sql.php'
echo ''
echo 'Looking for security.php...' | grep --color 'Looking for security.php'
find / -type f -name security.php 2> /dev/null | grep --color -i 'security.php'
echo ''
echo 'Looking for service.pwd files...' | grep --color 'Looking for service.pwd files'
find / -type f -name service.pwd 2> /dev/null | grep --color -i 'service.pwd'
echo ''
echo 'Looking for .htpasswd files...' | grep --color 'Looking for .htpasswd files'
find / -type f -name .htpasswd 2> /dev/null | grep --color -i '.htpasswd'
echo ''
echo 'Looking for .bash_history files...' | grep --color 'Looking for .bash_history files'
find / -type f -name .bash_history 2> /dev/null | grep --color -i '.bash_history'
echo ''
echo 'Looking for any possible config files...' | grep --color 'Looking for any possible config files' 
find / -type f -name 'config*' 2> /dev/null | grep --color -i -E 'config||configuration'
echo ''
echo 'Checking for readable Shadow File...' | grep --color 'Checking for readable Shadow File'
echo '/etc/shadow...' | grep --color '/etc/shadow'
cat /etc/shadow 2> /dev/null
echo '/etc/master.passwd...' | grep --color '/etc/master.passwd'
cat /etc/master.passwd 2> /dev/null
echo '/etc/gshadow...' | grep --color '/etc/gshadow'
cat /etc/gshadow 2> /dev/null
echo ''
}

#Quick Check for SSH info which might give info or further access (Needs imrpovements)
SSH_check(){
echo 'Checking SSH...' | grep --color 'Checking SSH'
echo '/home/*/.ssh/authorized_keys' | grep --color '/home/*/.ssh/authorized_keys' && cat /home/*/.ssh/authorized_keys
echo '/home/*/.ssh/known_hosts' | grep --color '/home/*/.ssh/known_hosts' && cat /home/*/.ssh/known_hosts
echo ''
}

#close master()
}

#Establish our Exit function to message and close things out
closer(){
echo 'You have been Inf0rm3d :p'
echo ''
echo 'You can download or cat inf0rm3d.txt file to see the full report in case you missed anything or have buffer or email problems' | grep --color -i -E 'You can download or || file to see the full report in case you missed anything or have buffer or email problems'
echo ''
echo 'Good luck finding your way to r00t, until next time Enjoy!' | grep --color -i -E 'Good luck finding your way to r00t, until next time Enjoy'
echo '' 
echo 'Greetz from INTRA!' | grep --color 'INTRA';
}

#MAIN FUNCTION to call all functions in needed order...
banner

#commenting out Email Functions till they get fixed... :(
#check if email passes or not
#EMAIL=$1
#if [ -z $EMAIL ]; then
#echo 'Not using mailer function...' | grep --color 'Not using mailer function' 
#else 
#echo "Setting email to $EMAIL" | grep --color -i 'Setting email to'
#fi

echo ''
echo 'Commence enumeration...' | grep --color 'Commence enumeration'
master 2> /dev/null	
#We do this to enable our functions within master() as otherwise we get errors when they are called sicne they were not initialized or set  - just calls functions which sets things and dumps errors to /dev/null so nothing is seen in terminal
#...
#Now we call master() for real
banner > inf0rm3d.txt 2>&1 & #so banner makes it in report :p
master >> inf0rm3d.txt 2>&1 & #Now we call master() once more now that everything has been initialized and now callable. We start the report generation thread first and run in background and redirect all output to the report file which we already created above when we sent out banner to it 
master	#This we run for visual in terminal to see pretty colors :)

#Comment out call to email function till its fixed... :(
#action_send_mail_done
closer


#TO-do List:
#Fix or confirm working Email Functionality
#EOF
