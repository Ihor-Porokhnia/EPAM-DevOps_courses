#!/bin/bash
function dircomp() {
	local	CUR_P=$1
	local	DIRS=$S_DIR$CUR_P'/*'
	
	for f in $DIRS
	do
		local TARGET=$B_DIR$CUR_P'/'$(echo $f | rev | cut -d "/" -f 1 | rev)
		
		if [[ -d $f ]]; then
			
			if [[ -d $TARGET  ]]; then

					if [ "$(ls -A $f)" ]; then
    						dircomp $CUR_P'/'$(echo $f | rev | cut -d "/" -f 1 |rev)

					fi
				
			else	
				echo "$( date '+%F_%H:%M:%S' ) Backup dir hasn't been found. $f has been copeid" >> $JFILE
				cp -R  --verbose --preserve=timestamps $f $TARGET >> $JFILE
			fi

		
		elif [[ -f $f ]]; then
			filecomp $f $TARGET
			#echo "Filecomp br here: CURP: $CUR_P  DIRS: $DIRS TARGET: $TARGET"
		else
			echo "$f is not valid"
		fi 
	done
}
function filecomp() {
	local SFILE=$1
	local TFILE=$2
	
	if [[ -f $TFILE ]]; then
                                if [[ $(cksum $SFILE | cut -d " " -f 1) == $(cksum $TFILE | cut -d " " -f 1) ]]; then
                                        return
                                else	
					echo "$( date '+%F_%H:%M:%S' ) Newer file version has been found. $SFILE has been copeid" >> $JFILE
                                       	cp -R --preserve=timestamps $SFILE $TFILE
                                fi
                        else	
				echo "$( date '+%F_%H:%M:%S' ) Backup file hasn't been found. $f has been copeid" >> $JFILE
                                cp -R --preserve=timestamps $SFILE $TFILE
                        fi

}

function delcomp() {
        local   CUR_P=$1
        local   DIRS=$B_DIR$CUR_P'/*'

        for f in $DIRS
        do
                local TARGET=$S_DIR$CUR_P'/'$(echo $f | rev | cut -d "/" -f 1 | rev)

                if [[ -d $f ]]; then

                        if [[ -d $TARGET  ]]; then

                                        if [ "$(ls -A $f)" ]; then
                                                delcomp $CUR_P'/'$(echo $f | rev | cut -d "/" -f 1 |rev)

                                        fi

                        else
                                echo "$( date '+%F_%H:%M:%S' ) Dir $f has been copeid" >> $JFILE

                        fi


                elif [[ -f $f ]]; then
                        filedel $f $TARGET
                        #echo "Filecomp br here: CURP: $CUR_P  DIRS: $DIRS TARGET: $TARGET"
                else
                        echo "$f is not valid"
                fi
        done
}
function filedel() {
        local SFILE=$1
        local TFILE=$2
	if [[ $(echo $TFILE | rev | cut -d "/" -f 1 |rev) == 'journal' ]]; then
		return
	fi
        if [[ ! -f $TFILE ]]; then
                    KOSTYL=$(cat $JFILE | grep $SFILE | tail -n 1 | grep "has been removed" | cut -d " " -f 2)
 	#		echo $KOSTYL
		     if [[ "$KOSTYL" -eq '' ]]; then
                   	 echo "$( date '+%F_%H:%M:%S' )  File  $SFILE has been removed" >> $JFILE
                    fi
        fi

}


#S_DIR=/home/student/source
#B_DIR=/home/student/back

S_DIR=$1
B_DIR=$2
JFILE=$B_DIR'/journal'
touch $JFILE
dircomp
delcomp
