# ora2pg-dockerized

Docker container to migrate oracle dabatabase into postgres

## Intro

This container is based in [ora2pg](http://ora2pg.darold.net/) solution to migrate from oracle into postgres. It uses oracle-xe-11.2.0-1.0.x86_64.rpm.zip as Oracle client and install ora2pg and BDB-Oracle.

## Construccion

To build de image [download](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html) oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm,  oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm, and oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm and place it in ora2pg-client/oracle

Then use docker-compose file to construct... docker-compose build

## Execution

Configure Oracle Database parameters... edit docker-compose and change:

         - DB_HOST
         - DB_SID
         - ORA2PG_USER (BD user)
         - ORA2PG_PASSWD (BD password)
         
Then use docker-compose... docker-compose up -d. This will create a folder in the current path (pg) with the database export in postgres syntax.

## Changes

- Updated Dockerfile based on Johannes' [Dockerfile for Oracle and perl](http://eiseler.de/wordpress/?p=844).
- Upgraded to [ora2pg 18.2](https://github.com/darold/ora2pg/releases)
