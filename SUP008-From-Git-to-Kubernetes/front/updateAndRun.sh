#!/bin/sh

myfile=$(grep -ril "BACKAPP:80" build/)
sed -i "s/BACKAPP:80/$1/" $myfile

serve -l 80 -s build/
