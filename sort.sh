#!/bin/sh

files="$1/*"
fileary=()
dirary=()

for filepath in $files; do
  if [ -d $filepath ] ; then
   dirary+=("$filepath")
  elif [ -f $filepath ] ; then
   fileary+=("$filepath")
  fi
done

for i in ${fileary[@]}; do
    flag=0
    unset dirary
    for filepath in $files; do
        if [ -d $filepath ] ; then
            dirary+=("$filepath")
        fi
    done
    student_number=`echo $i | cut -c 5-14`
    for j in ${dirary[@]}; do
        if [ ${j} = $1/${student_number} ] ; then
            flag=1
        fi
    done
    if [ "$flag" -eq  0 ]; then
        mkdir $1/$student_number
        mv $i  $1/$student_number/
    else
        mv $i $1/$student_number/
    fi
done
