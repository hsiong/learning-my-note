## Base Guide
https://cloud.tencent.com/developer/article/1670611
https://www.zhaowenyu.com/maven-doc/maven-deploy.html
https://segmentfault.com/a/1190000023781503
https://blog.csdn.net/flyzing/article/details/112806458
https://segmentfault.com/a/1190000023781503

# GPG Guide
https://segmentfault.com/a/1190000023781503
https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key

### gpg: signing failed: Inappropriate ioctl for device
https://gist.github.com/repodevs/a18c7bb42b2ab293155aca889d447f1b

### Delete Keys
https://www.zhihu.com/question/60520344

## Unable to build Maven project due to Javadoc error?
https://stackoverflow.com/questions/23542876/unable-to-build-maven-project-due-to-javadoc-error
`-Dmaven.javadoc.skip=true` 

u can't use, or else 'Missing: no javadoc jar found in folder'

## Received status code 403 from server: Forbidden
https://central.sonatype.org/faq/403-error/

You are trying to update/republish an existing artifact.

Unfortunately Sonatype policy prohibits the removal or any other modification of artifacts after they have been released. In cases like this, we recommend that you check the values in your publishing job and verify that the version or name of the artifact is correct and it has not been already uploaded in your project.

## MojoExecutionException: Exit code: 2
+ gpg key expire 
```
regenerate key & delete old key
```

+ gpg: signing failed: Screen or window too small
```
expand windows size
```

##  Deployment failed: repository element was not specified in the POM inside distributionManagement element or in -DaltDeploymentRepository=id::layout::url parameter  
http://www.javawenti.com/?post=6783

## Already released in Sonatype, but not found in Maven repository
Sync Sonatype to Maven repository would cost 5 ~ 20 minutes.

## Beware this, you cant remove a artifact which already realeased to maven central
https://stackoverflow.com/questions/9789611/removing-an-artifact-from-maven-central

## gpg auth 401
+ generate gpg
```
gpg --list-keys
gpg --delete-secret-keys 123
gpg --delete-keys 123

gpg --list-keys

gpg --generate-key

gpg --keyserver http://keys.openpgp.org --send-keys 234

gpg --keyserver http://keys.openpgp.org:11371 --send-keys 234

```

+ change idea setting.xml
```

<server>
    <!-- jira account & pwd -->
    <id>maven-res</id>
    <username>name</username>
    <password>pwd</password>
</server>

```

> Becareful:   
> idea maven setting.xml not equals mvn settings  
> mvn clean deploy --settings F:\Maven\settings.xml
> https://cloud.tencent.com/developer/article/1522574#:~:text=settings.xml%20%E6%96%87%E4%BB%B6%E4%BD%8D%E7%BD%AE,%7D%2F.m2%2Fsettings.xml

## progressed file size cannot be greater than size
原因：在多模块项目中，在父pom.xml中写发布配置，并在父目录下执行mvn deploy会报上述错误

解决办法：在要上传的模块的pom.xml中写发布配置，并在要上传模块目录下执行mvn deploy命令