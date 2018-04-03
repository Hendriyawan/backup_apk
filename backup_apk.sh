#! /system/bin/sh
# bourne shell script for android apps backup WITHOUT ROOT
# © 21/03/2018 created by Hendriyawan 
# see my github : https://github.com/Hendriyawan


# usage sh backup_apk.sh -pkg <package name> <destination>
# usage sh backup_apk.sh --get-pkg  : for get list of package names

# example :
# sh backup_apk.sh -pkg com.whatsapp /download
# sh backup_apk.sh --get-pkg

# -- COLOR --
R='\x1b[31m'
G='\x1b[32m'
B='\x1b[34m'
Y='\x1b[33m'
C='\x1b[36m'
L_R='\x1b[1;31m'
L_G='\x1b[1;32m'
L_B='\x1b[1;34m'
L_Y='\x1b[1;33m'
L_C='\x1b[1;36m'

D='\x1b[0m'

#print Process
Proc(){
    messages="$*"
    echo -e "${L_B}[*]${D} $messages"
}

#print Error
Err(){
    messages="$*"
    echo -e "${R}[-]${D} $messages"
}

#print Succeed
Succ(){
    messages="$*"
    echo -e "${G}[+]${D} $messages"
}


# print all packages
Packages(){

    TOTAL_PKG=$(pm list packages | cut -d : -f 2 | wc -l)
    Succ "TOTAL PACKAGES : $TOTAL_PKG"
    
    number=0
    for pkg in $(pm list packages | cut -d : -f 2); do
        number=$((number+1))
        echo -e "[${Y}$number${D}] $pkg"
    done
}

Copy(){
    
    file=$1
    destination=$2
    
    if [ ! -f $file ]; then
        Err "Failed !\n"
        exit 1
    else
        if [ ! -d $destination ] || [ -z $destination ]; then
            Err "failed ! no such directory $destination !\n"
            exit 1
        else
            cp $file $destination
            if [ $? -eq 0 ]; then
                Succ "Sucess !\n"
            else
                Err "Failed !\n"
                exit 1
            fi
        fi
    fi
}

options=$1
package=$2
destination=$3

if [ -z $options ]; then
    Err "Usage :\nsh backup_apk.sh -pkg <packages> <destination>\nsh backup_apk.sh --get-pkg \n"
    exit 1
fi

if [ $options == "--get-pkg" ]; then
    Packages
elif [ $options == "-pkg" ]; then

    if [ ! -z $packages ] || [ ! -z $destination ]; then
        file=$(pm path $package | cut -d : -f 2)
        Copy $file $destination
    else
        Err "usage sh backup_apk.sh -pkg <package name> <destination> !\n"
        exit 1
    fi
fi