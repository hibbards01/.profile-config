#!/bin/bash
################################################################################
# chmod-hidraw.sh
#
# Adding a fix to revoke the permissions of hidraw# for Xbox Wireless Controller
# so that it works correctly with xpadneo.
################################################################################

set -o errexit  # Exit the script when a command fails.
set -o pipefail # Returns the status of the last command that threw a non-zero 
# set -o nounset  # Exit the script when it tries to use undeclared variables.
# set -o xtrace   # Uncomment for debugging. Shows what gets executed.

##############################
# Generic Bash Functions/Vars
##############################
RED='\033[1;31m'
GRN='\033[1;32m'
BLU='\033[1;34m'
PRP='\033[1;35m'
YEL='\033[1;33m'
WHT='\033[1;37m'
NC='\033[0m'
OPTERR=85                 # Unix standard invalid options exit code
MC=$WHT                   # Basic message output
MT=$GRN                   # Message title
EC=$RED                   # Error message
CC=$PRP                   # Code excuted message
WC=$YEL                   # Warning message color
FMT="+%H:%M:%S_%d-%m-%Y"  # Time stamp formate for file naming
scriptName=$(basename $0) # Quick look output name

###
# Show a message to the console.
# $1 The message
# $2 The type of message
# $3 Exit code (-1 don't exit)
##
function message() {
    [ -z "$2" ] && echo -e $EC"[!] Programming error; message \$2: $1" && exit 1

    if [ "$2" -eq 1 ]; then
        # This is an error message
        echo -e $MC"\n[$EC 🖥️  $scriptName $MC] $1${NC}\n"
    elif [ "$2" -eq 0 ]; then
        # This is a general output message
        echo -e $MC"[$MT 🖥️  $scriptName $MC] $1${NC}"
    elif [ "$2" -eq 2 ]; then
        # This is a command output message
        echo -e $MC"[$MT 🖥️  $scriptName $MC] $1 [$WC bash $MC]${NC}"
    fi

    if [ -z "$3" ]; then
        return
    elif [ "$3" -ge 0 ]; then
        exit $3
    fi
}

# WARNING: You need to run as sudo for this script.
# First grab the correct hidraw number from dmesg.
hidraw=$(dmesg -dH | \
            grep "Xbox Wireless Controller" | \
            grep hidraw | \
            cut -d ',' -f 2 | \
            cut -d ':' -f 1 | \
            tail -n 1)

message "hidraw found: $hidraw" 0
message "Revoking permissions for /dev/$hidraw" 0

# Finally revoke the permissions
chmod a-rw "/dev/$hidraw"

ls -al /dev/ | grep hidraw

message "Done. Exiting script." 0

exit 0