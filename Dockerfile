FROM maven:3.6.3-jdk-11
WORKDIR /usr/src/app
COPY pom.xml /usr/src/app/
COPY ./src/test/java /usr/src/app/test/java


# and then run comment 'docker build -t karatetest .' this will download and set up all the dependensies
# docker run -it karatetest  it will run a container that you created
