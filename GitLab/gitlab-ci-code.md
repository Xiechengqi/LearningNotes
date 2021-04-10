# GitLab CI Code

**`Jfrog + Maven`**

``` yaml
image: maven:latest
before_script:
  # Install JFrog CLI
  -  curl -fL https://getcli.jfrog.io | sh
  # Configure Artifactory instance with JFrog CLI
  - ./jfrog rt config --url=$ARTIFACTORY_URL --user=$ARTIFACTORY_USER --password=$ARTIFACTORY_PASS
  - ./jfrog rt c show
  # Set the M2_HOME environment variable
  - export M2_HOME=/usr/share/maven
  - export MAVEN_HOME=/usr/share/maven
  - ls -l /usr/share/maven
  # Replace the repository name in the configuration.yml to the correct one.
  # - sed -i 's,MAVEN_REPO_KEY,'"$MAVEN_REPO_KEY"',g' configuration.yml
  - git clone https://gitlab.com/guoyunzong/pipeline-example.git
  - ls -l project-examples/maven-example
  - ls -l /tmp
  - echo $M2_HOME

build:
  script:
    # Run the MVN command
    - ./jfrog rt mvn "clean install -Dmaven.repo.local=/build-cache/.m2/repository -f project-examples/maven-example/pom.xml" project-examples/maven-example/maven.conf --build-name=gitlabci-maven-artifactory --build-number=$CI_JOB_ID
    # Collect the environment variables
    - ./jfrog rt bce gitlabci-maven-artifactory $CI_JOB_ID
    # Pass the build information to Artifactory
    - ./jfrog rt bp gitlabci-maven-artifactory $CI_JOB_ID
  only:
    - master

```



**`Gitlab-Ci + Jfrog`**

``` yaml
image: docker:git
services:
- docker:dind

stages:
- build
- package
- clean

build:
  image: maven:3.5.4-jdk-8-alpine
  stage: build
  script:
    # - apk update && apk upgrade && apk add git 
    - apk add git 

    # Set the M2_HOME environment variable 
    - export M2_HOME=/usr/share/maven
    
    # Download JFrog CLI
    - curl -fL https://getcli.jfrog.io | sh

    # Configure Artifactory instance with JFrog CLI
    - ./jfrog rt config --url=$ARTIFACTORY_URL --user=$ARTIFACTORY_USER --password=$ARTIFACTORY_PASS
    - ./jfrog rt c show
    
    # - mvn clean install
    # - ./jfrog rt mvn "clean install sonar:sonar -Dsonar.language=java -Dsonar.projectKey=gitlabci-maven-artifactory -Dsonar.java.binaries=* -Dsonar.host.url=http://10.0.0.173:9000 -Dsonar.login=308aa92369500dbfff00b38283e358031bfea8aa" maven.conf --build-name=gitlabci-maven-artifactory --build-number=$CI_JOB_ID
    - ./jfrog rt mvn "clean install" maven.conf --build-name=gitlabci-maven-artifactory --build-number=$CI_JOB_ID
  
    # Collect the environment variables 
    - ./jfrog rt bce gitlabci-maven-artifactory $CI_JOB_ID
        
    # Add jira issue
    - ./jfrog rt bag gitlabci-maven-artifactory $CI_JOB_ID --config jira-cli.conf
    
    # Add sonar
    - ./jfrog rt sp "maven-dev-local/org/jfrog/test/multi3/3.7-SNAPSHOT/*.war" "qulity.gate.sonarUrl=http://192.168.230.156:9000/dashboard/index/"
    
    # Add properties
    - ./jfrog rt sp "maven-dev-local/org/jfrog/test/multi3/3.7-SNAPSHOT/*.war" "deploy.tool=ansible"
    - ./jfrog rt sp "maven-dev-local/org/jfrog/test/multi3/3.7-SNAPSHOT/*.war" "ip=127.0.0.1"
    
    # Pass the build information to Artifactory   
    - ./jfrog rt bp gitlabci-maven-artifactory $CI_JOB_ID
    
    # Promote 
    - ./jfrog rt bpr gitlabci-maven-artifactory $CI_JOB_ID maven-pro-local
    
    # Xray scan
    # - ./jfrog rt bs gitlabci-maven-artifactory $CI_JOB_ID --fail=false
    
    # Download
    # - ./jfrog rt dl maven-dev-local/org/jfrog/test/multi3/3.7-SNAPSHOT/multi3-3.7-20191213.050538-8.war all-my-frogs/

  when: manual

```





``` yaml
sonar_preview:
  stage: test
  script:
    - /usr/local/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=java -Dsonar.sources=. -Dsonar.host.url=http://172.16.68.154:9000  -Dsonar.login=13585323c4c8ac257c590d6e49c7b59dda5192f8
  only:
    - master
  tags:
    - my-runner
```



``` yaml

image: maven:latest
 
stages:
  - test
 
job_test:
  stage: test
  script:
    - mvn test
  tags:
- '193'
```

