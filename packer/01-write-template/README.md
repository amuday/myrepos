# urls
    https://github.com/btkrausen/hashicorp/tree/master/packer
    https://github.com/btkrausen/hashicorp/blob/master/packer/Lab%2001%20-%20Writing%20Packer%20Template.md
    https://developer.hashicorp.com/packer/plugins/builders/amazon/ebs

# AWS 
    https://github.com/btkrausen/hashicorp/blob/master/vault/packer/vault.pkr.hcl

# Multiple regions
    https://github.com/btkrausen/hashicorp/blob/master/packer/Lab%2003%20-%20Building%20Images%20in%20Multiple%20Regions.md
    ami_regions   = ["us-west-2", "us-east-1", "eu-central-1"]

# Building Images for Different Operating Systems
    https://github.com/btkrausen/hashicorp/blob/master/packer/Lab%2007%20-%20Building%20Multiple%20Image%20Types%20-%20Linux.md
    https://github.com/btkrausen/hashicorp/blob/master/packer/Lab%2007%20-%20Building%20Multiple%20Image%20Types%20-%20Windows.md

    sources = ["source.amazon-ebs.windows-2012r2", "source.amazon-ebs.windows-2019", ]

# Building Images in Multiple Clouds
    https://github.com/btkrausen/hashicorp/blob/master/packer/Lab%2009%20-%20Building%20Images%20in%20Multiple%20Clouds.md

    Multiple source blocks, one for each cloud
    sources = [
        "source.amazon-ebs.ubuntu",
        "source.azure-arm.ubuntu", 
    ]

# provisioners
    https://github.com/btkrausen/hashicorp/blob/master/packer/Lab%2004%20-%20Provisioners.md
    
# codebuild 

    Tried manually in AWS console, it worked as expected. File used - packer\01-write-template\buildspec.yml

    Upload the zip file to the S3 and use S3 as source in the build pipeline

https://notificare.com/blog/2021/10/15/automating-packer-with-codepipeline/
https://www.infracloud.io/blogs/automate-building-golden-ami/

