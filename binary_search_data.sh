#!/bin/bash

# $1 is database

declare -a ARRAY_D
declare -i NUM
declare -i MIN
declare -i MAX
declare -i CNT
declare VAR

function try_s () {
    VAR=$1
    # 0 LOW
    # 1 HIGH
    # 2 STOP
    
    return $(( RANDOM%2 )) # RANDOM RETURN
}

ARRAY_D=( $( cat $1 ) ) # Input file

until (( ${#ARRAY_D[@]} <= 4 ))
do
    # echo $(( ${#ARRAY_D[@]}/2 ))
    CODE=$( try_s ${ARRAY_D[$(( ${#ARRAY_D[@]}/2 ))]} )
    if (( $? == 0 )) 
    then
    	# echo 'NO'
	for CNT in ${!ARRAY_D[@]}
	do
	    if (( CNT > ( ${#ARRAY_D[@]}/2 ) ))
	    then
		unset ARRAY_D[$CNT]
	    fi
	done
    elif (( $? == 1 ))
    then
    	# echo 'YES'
	for CNT in ${!ARRAY_D[@]}
	do
	    if (( CNT <= ( ${#ARRAY_D[@]}/2 ) ))
	    then
		unset ARRAY_D[$CNT]
	    fi
	done
    else
	break
    fi
    # echo $CODE
    # echo ${ARRAY_D[@]}
    # echo ${!ARRAY_D[@]}
    ARRAY_D=( ${ARRAY_D[@]} )
done

echo "Minimus"
echo ${ARRAY_D[*]} | tr ' ' '\n'

exit 0
