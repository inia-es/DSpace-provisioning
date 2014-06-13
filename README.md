# DSpace provisioning

**DSpace provisioning** is a project to ease installation of [DSpace](http://dspace.org/).

## You will need:

* Virtual Box or another virtualization option
* Vagrant installed in your machine
* Make some customizations to the providen files

## Installing

    git clone https://github.com/inia-es/dspace_provision.git

Now you have to do some configruations to the files provided:

    cd dspace_provisioning

Edit create.sql with your favourite editor, and change password for a strong one.

Now edit build.xml, and fill it with your DSpace site info, including the new password you updated in the sql file.

Now, the virtual machine is ready to be created:

    vagrant up

## Access

You can access your DSpace site from http://localhost:8080 from the host machine.
