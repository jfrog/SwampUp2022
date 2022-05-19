# config Maven
jf mvnc --server-id-resolve SUP016 --server-id-deploy SUP016 --repo-resolve-releases sup016-maven-virtual --repo-resolve-snapshots sup016-maven-virtual --repo-deploy-releases sup016-maven-virtual --repo-deploy-snapshots sup016-maven-virtual

# Build Maven Project
jf rt mvn clean install -f ../example-projects/maven-example/pom.xml --build-name sup016-maven --build-number 2.0.0

jf rt bce sup016-maven 2.0.0
jf rt bag sup016-maven 2.0.0 checkout-dir
jf rt bp sup016-maven 2.0.0

# Config NPM
jf npmc --server-id-resolve rtsaas --server-id-deploy rtsaas --repo-resolve sup016-npm-virtual --repo-deploy sup016-npm-virtual

# Build NPM Project
jf npm install --build-name sup016-npm --build-number 3.0.0
jf npm publish --build-name sup016-npm --build-number 3.0.0

jf rt bce sup016-npm 3.0.0
jf rt bag sup016-npm 3.0.0
jf rt bp sup016-npm 3.0.0