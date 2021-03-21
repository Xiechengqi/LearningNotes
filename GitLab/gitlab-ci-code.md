# GitLab CI Code



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

