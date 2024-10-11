#!/bin/bash


#Total CPU usage
cpu() {
    cpu_var=$(top -b -n 1 | grep "%Cpu")

    # Dividing the output of top command to make it look nicer
    us=$(echo "$cpu_var" | awk '{print $2}')  # User time
    sy=$(echo "$cpu_var" | awk '{print $4}')  # System time
    ni=$(echo "$cpu_var" | awk '{print $6}')  # Nice time
    id=$(echo "$cpu_var" | awk '{print $8}')  # Idle time
    wa=$(echo "$cpu_var" | awk '{print $10}') # I/O wait time
    hi=$(echo "$cpu_var" | awk '{print $12}') # Hardware interrupts
    si=$(echo "$cpu_var" | awk '{print $14}') # Software interrupts
    st=$(echo "$cpu_var" | awk '{print $16}') # Stolen time

    # printing the output
    echo -e "Total CPU usage is:\n"
    echo -e "User time (us):       $us%"
    echo -e "System time (sy):     $sy%"
    echo -e "Nice time (ni):       $ni%"
    echo -e "Idle time (id):       $id%"
    echo -e "I/O wait time (wa):   $wa%"
    echo -e "Hardware interrupts (hi): $hi%"
    echo -e "Software interrupts (si): $si%"
    echo -e "Stolen time (st):     $st%"
      
}

memory() {
    memory_var=$(free -h)
    total=$(free | awk '/^Mem:/ {print $2}')
    used=$(free | awk '/^Mem:/ {print $3}')
    free=$(free | awk '/^Mem:/ {print $4}')
    swap_total=$(free | awk '/^Swap:/ {print $2}')
    swap_used=$(free | awk '/^Swap:/ {print $3}')
    swap_free=$(free | awk '/^Swap:/ {print $4}')

    echo -e "Memory usage is:\n"
    free -h

    used_percentage=$(echo "scale=2; ($used/$total) * 100" | bc)
    echo "Used memory percentage: $used_percentage %"
    free_percentage=$(echo "scale=2; ($free/$total)*100"| bc)
    echo "Free memory percentage: $free_percentage %"

}

disk() {
    disk_usage=$(df -h --total)
    total=$(df -h --total | awk '/^total/ {print $2}')
    used=$(df -h --total | awk '/^total/ {print $3}')
    free=$(df -h --total | awk '/^total/ {print $4}')
    used_percentage=$(df -h --total | awk '/^total/ {print $5}')
    used_percentage=$(echo "$used_percentage" | awk '{gsub("%", ""); print}')
    free_percentage=$((100-$used_percentage))

    echo -e "Disk usage per mounted Filesystem is:\n"
    df -h --total
    echo -e "Used disk percentage: $used_percentage %"
    echo "Free disk percentage: $free_percentage %"   
}

processes_by_cpu() {
    echo -e "The top 5 processes by CPU usage are:\n"
    ps aux --sort=-%cpu | head -n 6

}

processes_by_memory() {
    echo -e "The top 5 processes by memory usage are:\n"
    ps aux --sort=-%mem | head -n 6
}


############################## MAIN #####################################

cpu
echo "###############################################################################################################"
memory
echo "###############################################################################################################"
disk
echo "###############################################################################################################"
processes_by_cpu
echo "###############################################################################################################"
processes_by_memory
echo "###############################################################################################################"
