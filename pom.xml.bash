<project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://maven.apache.org/POM/4.0.0" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <groupId>org.sonatype.oss</groupId>
        <artifactId>oss-parent</artifactId>
        <version>5</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <groupId>io.swagger.codegen.v3</groupId>
    <artifactId>swagger-codegen-project</artifactId>
    <packaging>pom</packaging>
    <name>swagger-codegen-project</name>
    <version>3.0.2-SNAPSHOT</version>
    <url>https://github.com/swagger-api/swagger-codegen</url>
    <scm>
        <connection>scm:git:git@github.com:swagger-api/swagger-codegen.git</connection>
        <developerConnection>scm:git:git@github.com:swagger-api/swagger-codegen.git</developerConnection>
        <url>https://github.com/swagger-api/swagger-codegen</url>
    </scm>
    <developers>
        <developer>
            <id>fehguy</id>
            <name>Tony Tam</name>
            <email>fehguy@gmail.com</email>
        </developer>
        <developer>
            <id>wing328</id>
            <name>William Cheng</name>
            <email>wing328hk@gmail.com</email>
        </developer>
    </developers>
    <issueManagement>
        <system>github</system>
        <url>https://github.com/swagger-api/swagger-codegen/issues</url>
    </issueManagement>
    <mailingLists>
        <mailingList>
            <name>swagger-swaggersocket</name>
            <archive>https://groups.google.com/forum/#!forum/swagger-swaggersocket</archive>
        </mailingList>
    </mailingLists>
    <licenses>
        <license>
            <name>Apache License 2.0</name>
            <url>http://www.apache.org/licenses/LICENSE-2.0.html</url>
            <distribution>repo</distribution>
        </license>
    </licenses>
    <build>
        <sourceDirectory>src/main/java</sourceDirectory>
        <outputDirectory>target/classes</outputDirectory>
        <extensions>
            <extension>
                <groupId>org.jvnet.wagon-svn</groupId>
                <artifactId>wagon-svn</artifactId>
                <version>1.8</version>
            </extension>
            <extension>
                <groupId>org.apache.maven.wagon</groupId>
                <artifactId>wagon-ssh-external</artifactId>
                <version>1.0-alpha-6</version>
            </extension>
            <extension>
                <groupId>org.apache.maven.wagon</groupId>
                <artifactId>wagon-webdav</artifactId>
                <version>1.0-beta-1</version>
            </extension>
        </extensions>
        <defaultGoal>install</defaultGoal>
        <directory>target</directory>
        <finalName>${project.artifactId}-${project.version}</finalName>
        <plugins>
            <plugin>
                <groupId>net.revelc.code</groupId>
                <artifactId>formatter-maven-plugin</artifactId>
                <!-- Uncomment this to format before checkstyle -->
                <!-- <executions>
                    <execution>
                        <id>format</id>
                        <phase>validate</phase>
                        <goals>
                            <goal>format</goal>
                        </goals>
                    </execution>
                </executions> -->
                <configuration>
                    <compilerSource>1.7</compilerSource>
                    <compilerCompliance>1.7</compilerCompliance>
                    <compilerTargetPlatform>1.7</compilerTargetPlatform>
                    <lineEnding>LF</lineEnding>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-checkstyle-plugin</artifactId>
                <version>2.17</version>
                <executions>
                    <execution>
                        <id>validate</id>
                        <phase>validate</phase>
                        <configuration>
                            <configLocation>google_checkstyle.xml</configLocation>
                            <!-- Don't include generated sources a la http://stackoverflow.com/a/30406454 -->
                            <sourceDirectory>${project.build.sourceDirectory}</sourceDirectory>
                            <encoding>UTF-8</encoding>
                            <consoleOutput>true</consoleOutput>
                            <failsOnError>true</failsOnError>
                            <linkXRef>false</linkXRef>
                        </configuration>
                        <goals>
                            <goal>check</goal>
                        </goals>
                    </execution>
                </executions>
                <dependencies>
                    <dependency>
                        <groupId>com.puppycrawl.tools</groupId>
                        <artifactId>checkstyle</artifactId>
                        <version>6.19</version>
                    </dependency>
                </dependencies>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>${surefire-version}</version>
                <configuration>
                    <testNGArtifactName>none:none</testNGArtifactName>
                    <argLine>-XX:+StartAttachListener</argLine>
                    <argLine>
                        -javaagent:${settings.localRepository}/org/jmockit/jmockit/${jmockit-version}/jmockit-${jmockit-version}.jar
                    </argLine>
                </configuration>
                <executions>
                    <execution>
                        <id>test-testng</id>
                        <phase>test</phase>
                        <goals>
                            <goal>test</goal>
                        </goals>
                        <configuration>
                            <junitArtifactName>none:none</junitArtifactName>
                            <testNGArtifactName>org.testng:testng</testNGArtifactName>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <artifactId>maven-dependency-plugin</artifactId>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>copy-dependencies</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>${project.build.directory}/lib</outputDirectory>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.6.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.0.2</version>
                <configuration>
                    <archive>
                        <manifestEntries>
                            <mode>development</mode>
                            <url>${project.url}</url>
                            <implementation-version>${project.version}</implementation-version>
                            <package>io.swagger</package>
                        </manifestEntries>
                    </archive>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-site-plugin</artifactId>
                <version>3.5.1</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-release-plugin</artifactId>
                <version>2.5.3</version>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version>3.0.1</version>
                <configuration>
                    <aggregate>true</aggregate>
                    <source>1.8</source>
                    <encoding>UTF-8</encoding>
                    <maxmemory>1g</maxmemory>
                    <links>
                        <link>http://docs.oracle.com/javase/8/docs/api</link>
                    </links>
                    <excludePackageNames>${javadoc.package.exclude}</excludePackageNames>
                    <additionalOptions>
                        <additionalOption>-Xdoclint:none</additionalOption>
                    </additionalOptions>
                </configuration>
                <executions>
                    <execution>
                        <id>attach-javadocs</id>
                        <phase>verify</phase>
                        <goals>
                            <goal>jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-source-plugin</artifactId>
                <version>3.0.1</version>
                <executions>
                    <execution>
                        <id>attach-sources</id>
                        <phase>verify</phase>
                        <goals>
                            <goal>jar-no-fork</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-enforcer-plugin</artifactId>
                <version>1.4.1</version>
                <executions>
                    <execution>
                        <id>enforce-versions</id>
                        <goals>
                            <goal>enforce</goal>
                        </goals>
                        <configuration>
                            <rules>
                                <requireMavenVersion>
                                    <version>3.2.5</version>
                                </requireMavenVersion>
                            </rules>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>net.revelc.code</groupId>
                    <artifactId>formatter-maven-plugin</artifactId>
                    <version>0.5.2</version>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
    <profiles>
        <profile>
            <id>release-profile</id>
            <properties>
                <skipTests>true</skipTests>
            </properties>
            <build>
                <plugins>
                    <plugin>
                        <groupId>net.alchim31.maven</groupId>
                        <artifactId>scala-maven-plugin</artifactId>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>compile</goal>
                                    <goal>testCompile</goal>
                                </goals>
                            </execution>
                        </executions>
                        <configuration/>
                    </plugin>
                    <plugin>
                        <groupId>org.codehaus.mojo</groupId>
                        <artifactId>build-helper-maven-plugin</artifactId>
                        <executions>
                            <execution>
                                <id>add-source</id>
                                <phase>prepare-package</phase>
                                <goals>
                                    <goal>add-source</goal>
                                </goals>
                                <configuration>
                                    <sources>
                                        <source>src/main/scala</source>
                                    </sources>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
        <profile>
            <id>release-sign-artifacts</id>
            <activation>
                <property>
                    <name>performRelease</name>
                    <value>true</value>
                </property>
            </activation>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-gpg-plugin</artifactId>
                        <executions>
                            <execution>
                                <id>sign-artifacts</id>
                                <phase>verify</phase>
                                <goals>
                                    <goal>sign</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
        <!-- Samples -->
        <profile>
            <id>android-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/android/volley</module>
            </modules>
        </profile>
        <profile>
            <id>bash-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/bash</module>
            </modules>
        </profile>
        <profile>
            <id>clojure-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>clojure</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/clojure</module>
            </modules>
        </profile>
        <profile>
            <id>haskell-http-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>haskell-http-client</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/haskell-http-client</module>
            </modules>
        </profile>
        <profile>
            <id>haskell-http-client-integration-test</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>haskell-http-client</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/haskell-http-client/tests-integration</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-jersey1</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/jersey1</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-jersey2</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/jersey2</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-jersey2-java6</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/jersey2-java6</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-okhttp-gson</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/okhttp-gson</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-okhttp-gson-parcelable</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/okhttp-gson/parcelableModel</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-retrofit</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/retrofit</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-retrofit2</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/retrofit2</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-retrofit2-rx</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/retrofit2rx</module>
            </modules>
        </profile>
        <profile>
            <id>java-client-feign</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/java/feign</module>
            </modules>
        </profile>
        <profile>
            <id>javascript-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>javascript</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/javascript</module>
            </modules>
        </profile>
        <profile>
            <id>scala-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>scala</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/scala</module>
            </modules>
        </profile>
        <profile>
            <id>objc-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>objc</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/objc/default/SwaggerClientTests</module>
            </modules>
        </profile>
        <profile>
            <id>swift-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>swift</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/swift/default/SwaggerClientTests</module>
            </modules>
        </profile>
        <profile>
            <id>java-msf4j-server</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/java-msf4/</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-cxf-server</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs-cxf</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-resteasy-server</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs-resteasy/default</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-resteasy-server-joda</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs-resteasy/joda</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-resteasy-eap-server</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs-resteasy/eap</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-resteasy-eap-server-joda</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs-resteasy/eap-joda</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-server</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs/jersey2</module>
            </modules>
        </profile>
        <profile>
            <id>jaxrs-server-jersey1</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/jaxrs/jersey1</module>
            </modules>
        </profile>
        <profile>
            <id>typescript-fetch-client-tests-default</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/typescript-fetch/tests/default</module>
            </modules>
        </profile>
        <profile>
            <id>typescript-fetch-client-builds-default</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/typescript-fetch/builds/default</module>
            </modules>
        </profile>
        <profile>
            <id>typescript-fetch-client-builds-es6-target</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/typescript-fetch/builds/es6-target</module>
            </modules>
        </profile>
        <profile>
            <id>typescript-fetch-client-builds-with-npm-version</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/typescript-fetch/builds/with-npm-version</module>
            </modules>
        </profile>
        <profile>
            <id>typescript-angularjs-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/typescript-angularjs/npm</module>
            </modules>
        </profile>
        <profile>
            <id>typescript-node-npm-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/typescript-node/npm</module>
            </modules>
        </profile>
        <profile>
            <id>python-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/python</module>
            </modules>
        </profile>
        <profile>
            <id>ruby-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/ruby</module>
            </modules>
        </profile>
        <profile>
            <id>go-client</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/go</module>
            </modules>
        </profile>
        <profile>
            <id>spring-mvc</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/spring-mvc</module>
            </modules>
        </profile>
        <profile>
            <id>springboot-beanvalidation</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/springboot-beanvalidation</module>
            </modules>
        </profile>
        <profile>
            <id>springboot</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/springboot</module>
            </modules>
        </profile>
        <profile>
            <id>spring-cloud</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/spring-cloud</module>
            </modules>
        </profile>
        <profile>
            <id>scalatra-server</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/scalatra</module>
            </modules>
        </profile>
        <profile>
            <id>java-inflector</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/java-inflector</module>
            </modules>
        </profile>
        <profile>
            <id>java-undertowr</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>java</value>
                </property>
            </activation>
            <modules>
                <module>samples/server/petstore/undertow</module>
            </modules>
        </profile>
        <profile>
            <id>samples</id>
            <activation>
                <property>
                    <name>env</name>
                    <value>samples</value>
                </property>
            </activation>
            <modules>
                <module>samples/client/petstore/bash</module>
            </modules>
        </profile>
    </profiles>
    <modules>
        <module>modules/swagger-codegen</module>
        <module>modules/swagger-codegen-cli</module>
        <module>modules/swagger-codegen-maven-plugin</module>
        <module>modules/swagger-generator</module>
    </modules>
    <reporting>
        <outputDirectory>target/site</outputDirectory>
        <plugins>
            <plugin>
                <groupId>net.alchim31.maven</groupId>
                <artifactId>scala-maven-plugin</artifactId>
                <version>${scala-maven-plugin-version}</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jxr-plugin</artifactId>
                <version>2.5</version>
                <configuration>
                    <aggregate>true</aggregate>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-project-info-reports-plugin</artifactId>
                <version>2.9</version>
                <reportSets>
                    <reportSet>
                        <reports>
                            <report>project-team</report>
                        </reports>
                    </reportSet>
                </reportSets>
            </plugin>
        </plugins>
    </reporting>
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>${junit-version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.testng</groupId>
                <artifactId>testng</artifactId>
                <version>${testng-version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.jmockit</groupId>
                <artifactId>jmockit</artifactId>
                <version>${jmockit-version}</version>
                <scope>test</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
    <repositories>
        <repository>
            <id>sonatype-snapshots</id>
            <url>https://oss.sonatype.org/content/repositories/snapshots</url>
            <snapshots>
                <enabled>true</enabled>
            </snapshots>
            <releases>
                <enabled>false</enabled>
            </releases>
        </repository>
        <repository>
            <id>sonatype-releases</id>
            <url>https://oss.sonatype.org/content/repositories/releases</url>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
            <releases>
                <enabled>true</enabled>
            </releases>
        </repository>
    </repositories>
    <properties>
        <swagger-parser-version>2.0.5</swagger-parser-version>
        <scala-version>2.11.1</scala-version>
        <felix-version>3.3.0</felix-version>
        <swagger-core-version>2.0.4</swagger-core-version>
        <commons-io-version>2.4</commons-io-version>
        <commons-cli-version>1.2</commons-cli-version>
        <junit-version>4.8.1</junit-version>
        <jackson-version>2.8.9</jackson-version>
        <maven-plugin-version>1.0.0</maven-plugin-version>
        <commons-lang-version>3.4</commons-lang-version>
        <slf4j-version>1.7.25</slf4j-version>
        <logback-version>1.2.3</logback-version>
        <scala-maven-plugin-version>3.2.1</scala-maven-plugin-version>
        <jmustache-version>1.12</jmustache-version>
        <testng-version>6.9.6</testng-version>
        <surefire-version>2.22.0</surefire-version>
        <jmockit-version>1.25</jmockit-version>
        <reflections-version>0.9.10</reflections-version>
        <swagger-codegen-generators-version>1.0.2-SNAPSHOT</swagger-codegen-generators-version>
        <jmockit-version>1.42</jmockit-version>
    </properties>
</project>
