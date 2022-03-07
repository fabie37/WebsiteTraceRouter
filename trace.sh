#! /bin/bash

# lookup contents -> lines 
readarray -t lines < lookup

# iterate through results
for ((i=0; i<${#lines[@]}; i++))
do
    line=${lines[$i]}
    
    # Make space delimited
    read -ra data <<< $line
    url=${data[0]}
    family=${data[1]}
    addr=${data[2]}
    
    # Check ip family
    if [[ "$family" == "IPv4" ]]; then
        traceroute -4 -q 1 -n $addr > "ipv4/${url}_4.tr"
    else 
        traceroute -6 -q 1 -n $addr >  "ipv6/${url}_6.tr"
    fi
done