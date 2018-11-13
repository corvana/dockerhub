[Greenplum OSS](https://greenplum.org/install-greenplum-oss-on-ubuntu/)

This image is designed to be suitable to run a local greenplum-oss database.

```
docker run -p 5432:5432 --ulimit nofile=4096:4096 -d corvana/greenplum-oss:TAG [DATABASE_NAME=YOUR_DB_NAME] [DATABASE_USER=YOUR_DB_USER] [DATABASE_PASSWORD=YOUR_DB_PASSWORD] /gpdb/start-singlenode.sh
```
