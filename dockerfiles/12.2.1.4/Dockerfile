#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This is the Dockerfile for Oracle SOA Suite Quick Start
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# See soasuite.download file in the install directory
# Also see soapatches.download file in the patches directory
#
# Pull base image
# ---------------
#FROM oracle/serverjre:8 as builder
FROM store/oracle/serverjre:1.8.0_241-b07 as builder

# Maintainer
# ----------
MAINTAINER Rodrigo Moura <rodrigo.moura@gmail.com>


# Common environment variables required for this build
# ----------------------------------------------------
ENV ORACLE_HOME=/u01/oracle \
    USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom" \
    PATH=$PATH:${JAVA_HOME}/bin:/u01/oracle/oracle_common/common/bin:/u01/oracle/wlserver/common/bin

# Setup subdirectory for FMW install package and container-dummy.sh
# -----------------------------------------------------------------
RUN mkdir -p /u01 && \
    chmod a+xr /u01 && \
    useradd -b /u01 -d /u01/oracle -m -s /bin/bash oracle


#
# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
USER root
ENV FMW_JAR1=fmw_12.2.1.4.0_soa_quickstart.jar \
    FMW_JAR2=fmw_12.2.1.4.0_soa_quickstart2.jar

#
# Copy installers and patches for install
# -------------------------------------------
ADD install/* /u01/
RUN mkdir /u01/patches && \
    chown oracle:oracle -R /u01
COPY patches/* /u01/patches/
COPY container-scripts/* /u01/oracle/container-scripts/
RUN  cd /u01 && chmod 755 *.jar && \
     chmod +xr /u01/oracle/container-scripts/*.*


#
# install
# -----------------------------------
USER oracle
RUN cd /u01 && \
  $JAVA_HOME/bin/java -jar $FMW_JAR1 -silent -responseFile /u01/soasuite.response -invPtrLoc /u01/oraInst.loc -jreLoc $JAVA_HOME -ignoreSysPrereqs -force -novalidation ORACLE_HOME=$ORACLE_HOME


#
# Apply SOA Patches
# -----------------
RUN patchzips=`ls /u01/patches/p*.zip 2>/dev/null`; \
    if [ ! -z "$patchzips" ]; then \
      cd /u01/patches;  \
      echo -e "\nBelow patches present in patches directory. Applying these patches:"; \
      ls p*.zip; \
      echo -e ""; \
      for filename in `ls p*.zip`; do echo "Extracting patch: ${filename}"; $JAVA_HOME/bin/jar xf ${filename}; done; \
      rm -f /u01/patches/p*.zip; \
      $ORACLE_HOME/OPatch/opatch napply -silent -oh $ORACLE_HOME -jre $JAVA_HOME -invPtrLoc /u01/oraInst.loc -phBaseDir /u01/patches; \
      $ORACLE_HOME/OPatch/opatch util cleanup -silent; \
      rm -rf /u01/patches /u01/oracle/cfgtoollogs/opatch/*; \
      echo -e "\nPatches applied in SOA oracle home are:"; \
      cd $ORACLE_HOME/OPatch; \
      $ORACLE_HOME/OPatch/opatch lspatches; \
    else \
      echo -e "\nNo patches present in patches directory. Skipping patch application."; \
    fi


#
# Rebuild from base image
# -----------------------
# FROM oracle/serverjre:8
FROM store/oracle/serverjre:1.8.0_241-b07

#
# Maintainer
# ----------
LABEL maintainer="Rodrigo Moura <rodrigo.moura@gmail.com>"

# Common environment variables required for this build
# ----------------------------------------------------
ENV ORACLE_HOME=/u01/oracle \
    USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom" \
    PATH=$PATH:${JAVA_HOME}/bin:/u01/oracle/oracle_common/common/bin:/u01/oracle/wlserver/common/bin\
    PATH=$PATH:/u01/oracle/oracle_common/modules/org.apache.maven_3.2.5/bin

# Setup subdirectory for FMW install package and container-dummy.sh
# -----------------------------------------------------------------
RUN mkdir -p /u01 && \
    chmod a+xr /u01 && \
    useradd -b /u01 -d /u01/oracle -m -s /bin/bash oracle

COPY --from=builder --chown=oracle:oracle /u01/oracle /u01/oracle

#
# Install the required packages
# -----------------------------
USER root
RUN yum install -y hostname ant xorg-x11-apps vim nano && \
    rm -rf /var/cache/yum


#
# Define default command to start bash.
# 
USER oracle
WORKDIR $ORACLE_HOME
CMD ["/u01/oracle/jdeveloper/jdev/bin/jdev"]

