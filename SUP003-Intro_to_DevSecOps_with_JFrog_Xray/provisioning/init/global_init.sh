
#!/bin/bash

# inputs :
#   - $1 : saas_hostname (example sup011epsu21)
#   - $2 : username

saas_hostname=$1
username=$2
provisioning_folder=/home/ubuntu/SwampUp2022/SUP003-Intro_to_DevSecOps_with_JFrog_Xray/provisioning
# pass=""

echo "======================================================="
echo "STEP 1 : PREPARATION ..."
cd ${provisioning_folder}/init
git pull
chmod +x init_java.sh init_js.sh init_python.sh 
echo "======================================================="
echo "STEP 2 : INIT SAAS ..."

./init.sh \
  "https://${saas_hostname}.jfrog.io" \
  "fabienl${saas_hostname}@jfrog.com" 'SwampUp2022!' \
  jfrog-training \
  "$username" 'SwampUp2022!'

echo "======================================================="
echo "STEP 3 : PROVISION JAVA DATA ..."

./init_java.sh \
  "$provisioning_folder/java-demo" \
  one-mvn one-docker \
  jfrog-training \
  "$username" 'SwampUp2022!'

echo "======================================================="
echo "STEP 4 : PROVISION JS DATA ..."

./init_js.sh \
  "$provisioning_folder/js-demo" \
  man-npm man-docker \
  jfrog-training \
  "$username" 'SwampUp2022!' \
  man-generic


echo "======================================================="
echo "STEP 5 : PROVISION PYTHON DATA ..."

./init_python.sh \
  "$provisioning_folder/python-demo/src" \
  punch-python punch-docker \
  jfrog-training \
  "$username" 'SwampUp2022!' \
  punch-generic

echo "======================================================="
echo "END"
echo "======================================================="
