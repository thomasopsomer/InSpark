# @Author: thomasopsomer
# @Date:   2016-05-12 12:19:14
# @Last Modified by:   thomasopsomer
# @Last Modified time: 2016-05-13 15:43:14

# ENV
export export SPARK_VERSION=1.6.2
export HADOOP_VERSION=2.6
export SPARK_PACKAGE=$SPARK_VERSION-bin-hadoop$HADOOP_VERSION
export SPARK_HOME=/usr/local/spark-$SPARK_PACKAGE
export PATH=$PATH:$SPARK_HOME/bin

##################
# DL SPARK
##################

echo " ---- Downloading SPARK ----"

curl -sL --retry 3 \
  "http://mirrors.ibiblio.org/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_PACKAGE.tgz" \
  | gunzip \
  | tar x -C /usr/local/ \
  && ln -s $SPARK_HOME /usr/local/spark

##################
# Add jars (S3, mysql, cassandra ...)
##################

echo " ---- DL and ADD jars ----"

mkdir -p $SPARK_HOME/jars && cd $_ \
  && wget \
    "http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar" \
    "http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.1/hadoop-aws-2.7.1.jar" \
    "http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar" \
  	"http://central.maven.org/maven2/com/datastax/spark/spark-cassandra-connector_2.10/1.6.0-M2/spark-cassandra-connector_2.11-1.6.0-M2.jar"


##################
# Set conf files
##################

echo " ---- Set conf files ----"

sudo cp ./spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf
sudo cp ./hdfs-site.xml $SPARK_HOME/conf/hdfs-site.xml



