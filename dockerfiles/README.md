SOA Suite QuickStart on Docker
=============

Sample Docker configurations to facilitate installation, configuration, and environment setup for Docker users. This project includes quick start dockerfiles for SOA 12.2.1.x based on Oracle Linux 7, Oracle JRE 8 (Server).

You will be able to build the SOA images based on the version which is required using the build scripts provided. 

## SOA 12.2.1.x Docker image Creation and Running

To build a SOA image either you can start from building Oracle JDK image.

## How to build the Oracle Java image

Please refer [README.md](https://github.com/oracle/docker-images/blob/master/OracleJava/README.md) under docker/OracleJava for details on how to build Oracle Database image.

https://github.com/oracle/docker-images/tree/master/OracleJava/README.md

## Building Docker Image for SOA Suite QuickStart

IMPORTANT: To build the Oracle SOA Suite QuickStart image, you must first download the required version of the Oracle SOA Suite Quick Start binaries. This install binary is required to create the Oracle SOA Suite Quick Start image. This binary must be downloaded unzipped and copied into the folder with the same version for e.g. 12.2.1.4.0 binaries need to be dropped into `../dockerfiles/12.2.1.4/install`.

The binaries can be downloaded from the [Oracle Software Delivery Cloud](https://edelivery.oracle.com). Search for "Oracle SOA Suite" and download the version which is required, for e.g. 12.2.1.4.0 is available under `Oracle Fusion Middleware 12c (12.2.1.4.0) Business Process Management Quick Start for Developers` software. This installation is divided into two files. 

Extract the downloaded zip files and copy `fmw_12.2.1.4.0_soa_quickstart.jar`, `fmw_12.2.1.4.0_soa_quickstart2.jar` files under `dockerfiles/12.2.1.4/install` for building Oracle SOA 12.2.1.4 image.

>IMPORTANT: To build the SOA image with patches, you need to download and drop the patch zip files (for e.g. `p29928100_122130_Generic.zip`) into the `patches/` folder under the version which is required, for e.g. for `12.2.1.4.0` the folder is `12.2.1.4/patches`. Then run docker build as mentioned below: 

Build the Oracle SOA Quick Start12.2.1.4 image using:

$ docker build -t soaquickstart:12.2.1.4 .

   Usage: docker build -t soaquickstart:[version] .
   Builds a Docker Image for Oracle SOA Suite Quick Start.


Verify you now have the image `soaquickstart:12.2.1.4` in place with 

$ docker images | grep "soa"

If you are building the SOA image with patches, you can verify the patches applied with:

$ docker run soaquickstart:12.2.1.4 sh -c '$ORACLE_HOME/OPatch/opatch lspatches'


