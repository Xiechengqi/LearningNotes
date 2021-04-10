``` yaml
before_script:
  - echo "before-script!!"

variables:
  DOMAIN: example.com

cache: 
  paths:
   - target/

stages:
  - build
  - test
  - deploy
  
build:
  before_script:
    - echo "before-script in job"
  stage: build
  tags:
    - build
  only:
    - master
  script:
    - ls
    - id
    - cat target/a.txt
    - mvn clean package -DskipTests
    - ls target
    - echo "$DOMAIN"
    - false && true ; exit_code=$?
    - if [ $exit_code -ne 0 ]; then echo "Previous command failed"; fi;
    - sleep 2;
  after_script:
    - echo "after script in job"
  cache:
    policy: pull   #不下载缓存


unittest:
  stage: test
  tags:
    - build
  only:
    - master
  script:
    - echo "run test"
    - echo 'test' >> target/a.txt
    - ls target
    - cat target/a.txt
  retry:
    max: 2
    when:
      - script_failure
  
deploy:
  stage: deploy
  tags:
    - build
  only:
    - master
  script:
    - cat target/a.txt
    - echo "run deploy"
    - ls target
    - echo "deploy" >> target/a.txt
  retry:
    max: 2
    when:
      - script_failure
      

after_script:
  - echo "after-script"
```



```yaml
stages:
- build
- cleanup_build
- test
- deploy
- cleanup

build_job:
  stage: build
  script:
  - make build

cleanup_build_job:
  stage: cleanup_build
  script:
  - cleanup build when failed
  when: on_failure

test_job:
  stage: test
  script:
  - make test

deploy_job:
  stage: deploy
  script:
  - make deploy
  when: manual

cleanup_job:
  stage: cleanup
  script:
  - cleanup after jobs
  when: always
```





```yaml
job1:
  stage: test
  script:
  - execute_script_that_will_fail
  allow_failure: true

job2:
  stage: test
  script:
  - execute_script_that_will_succeed

job3:
  stage: deploy
  script:
  - deploy_to_staging
```