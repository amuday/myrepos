# manual setup
1. create two VMS in different virtual networks
2. Install apache2 on both
3. Disassociate public IP of VM2. 
    Go to network interface of your VM -> IP configurations -> ipconfig1 -> public ip address disassociate
4. try to connect to vm2 from vm1, you will not ba able to connect.
5. Go to second vm overview -> Virtual network/subnet -> peerings -> add -> 
    Enter peering links names, it will create 2 peerings, one for each virtual network.
    one from vn1 -> vn2
    second from vn2 -> vn1

6. Now repeat the step 4, you will be able to connect.

# terraform 
1. Run the script
2. Verify peerings
    your vm -> overview -> Virtual network/subnet -> settings -> peerings 
3. Check connectivity
    Go to staging VM which has public ip and curl to test vm with private IP