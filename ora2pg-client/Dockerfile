FROM ubuntu:14.04
LABEL authors="Johannes Eiseler, Adrian Riobo Lorenzo <adrian.riobo.lorenzo@gmail.com>, Micheal Waltz <ecliptik@gmail.com>"
# see http://eiseler.de/wordpress/?p=844, http://www.ecliptik.com/Containerizing-a-Perl-Script/ and https://github.com/adrianRiobo/ora2pg-dockerized

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
      "perl", \
      "build-essential", \
      "cpanminus" ]
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]

#RUN ["cpanm", "Proc::ProcessTable", "Data::Dumper" ]

COPY [ "./scripts/oracle_test.pl", "/app/oracle_test.pl" ]
RUN [ "chmod", "+x",  "/app/oracle_test.pl" ]

COPY scripts/chkconfig /sbin/chkconfig
chmod 755 /sbin/chkconfig


# now Oracle
# see http://www.aboutmonitoring.com/install-dbd-oracle-perl-modules-in-linux/

ENV ORACLE_CLIENT_VERSION 12.2
ENV ORACLE_CLIENT_VERSION_EXTENDED 12.2.0.1.0
COPY [ "./oracle/*.rpm", "/app/" ]

WORKDIR /app
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "libaio-dev", "libaio1", "unixodbc", "wget", "make", "libdbi-perl", "bzip2", "libstdc++5", "bc" ]
RUN ["apt-get", "install", "-qy", "--force-yes", "alien" ]

RUN alien --scripts /app/oracle-instantclient$ORACLE_CLIENT_VERSION-basic-$ORACLE_CLIENT_VERSION_EXTENDED-1.x86_64.rpm
RUN alien --scripts /app/oracle-instantclient$ORACLE_CLIENT_VERSION-devel-$ORACLE_CLIENT_VERSION_EXTENDED-1.x86_64.rpm
RUN alien --scripts /app/oracle-instantclient$ORACLE_CLIENT_VERSION-sqlplus-$ORACLE_CLIENT_VERSION_EXTENDED-1.x86_64.rpm

RUN dpkg -i /app/oracle-instantclient$ORACLE_CLIENT_VERSION-basic_$ORACLE_CLIENT_VERSION_EXTENDED-2_amd64.deb
RUN dpkg -i /app/oracle-instantclient$ORACLE_CLIENT_VERSION-devel_$ORACLE_CLIENT_VERSION_EXTENDED-2_amd64.deb
RUN dpkg -i /app/oracle-instantclient$ORACLE_CLIENT_VERSION-sqlplus_$ORACLE_CLIENT_VERSION_EXTENDED-2_amd64.deb

ENV ORACLE_SID=XE 
ENV ORACLE_HOME /usr/lib/oracle/$ORACLE_CLIENT_VERSION/client64
ENV NLS_LANG=$ORACLE_HOME/bin/nls_lang.sh 
ENV PATH $PATH:$HOME/bin:$ORACLE_HOME/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ORACLE_HOME/lib
ENV TNS_ADMIN $ORACLE_HOME/network/admin
ENV ORACLE_BASE=/app/oracleexport 

# now perl oracle
RUN ["apt-get", "install", "-qy", "--force-yes", "libdbi-perl" ]
RUN ["cpan", "DBD::Oracle"]
RUN ["cpan", "DBD::Pg"]

ENV ORA2PG_VERSION 18.2

RUN wget https://sourceforge.net/projects/ora2pg/files/$ORA2PG_VERSION/ora2pg-$ORA2PG_VERSION.tar.bz2/download -O /tmp/ora2pg-$ORA2PG_VERSION.tar.bz2 &&\
    cd /tmp &&\
    tar jxf ora2pg-$ORA2PG_VERSION.tar.bz2 &&\
    cd ora2pg-$ORA2PG_VERSION &&\
    perl Makefile.PL &&\
    make && make install &&\
    cd /etc/ora2pg &&\
    cp ora2pg.conf.dist ora2pg.conf


RUN apt-get update && apt-get install -y unzip alien libaio1 unixodbc wget perl-modules-5.22 make libdbi-perl bzip2 libstdc++5 bc &&\


COPY configuration/ora2pg.conf /etc/ora2pg/ora2pg.conf    
COPY run.sh /usr/local/bin/run.sh

ENTRYPOINT ["run.sh"]
# if you wan't to use it interactivly comment the next line
#ENTRYPOINT [ "/app/oracle_test.pl" ]