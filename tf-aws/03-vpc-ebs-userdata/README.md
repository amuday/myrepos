
# Create EBS volume and attach it
    * Uses cloud init to mount ebs volume.
    **** volume need to be mounted before using it. Use manual steps or userdata script.
    **** ebs creation  is one time, create before ec2 instnace creation and use user data to mount it.


https://github.com/wardviaene/terraform-course/tree/master/demo-10
https://github.com/amuday/terraform-course/tree/master/demo-10

https://github.com/GSA/devsecops-example/blob/03067f68ee2765f8477ae84235f7faa1d2f2cb70/terraform/files/attach-data-volume.sh

https://github.com/hashicorp/terraform/issues/2740
https://gist.github.com/codeinthehole/c91e48f341af36162f12


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

# Manual steps to mount the volume
    mkfs.ext4 /dev/xvdh
    mkdir /data
    mount /dev/xvdh /data
    df -h
    echo '/dev/xvdh /data ext4 defaults 0 0' >> /etc/fstab
    umount /data
    mount /data