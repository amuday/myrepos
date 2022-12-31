
# Create EBS volume and attach it
    * Uses cloud init to mount ebs volume.
    **** volume need to be mounted before using it. Use manual steps or userdata script.
    **** ebs creation  is one time, create before ec2 instnace creation and use user data to mount it.


https://github.com/wardviaene/terraform-course/tree/master/demo-10

# validation
    * ssh into the EC2 instance
    * run below commands
        sudo -s
        ls /dev/data/volume1
        df -h
            /dev/mapper/data-volume1   20G   24K   19G   1% /data
        cat /var/log/cloud-init-output.log
        pvdisplay  # physical volume
        lvdisplay  # logical volume
04-user-data