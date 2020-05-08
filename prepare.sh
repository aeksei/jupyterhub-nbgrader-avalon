#!/bin/sh

mkdir -p secrets && cd secrets
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout jupyterhub.key -out jupyterhub.crt

touch oauth.env
echo "GITHUB_CLIENT_ID=58a178f9896a95b7d712" >> oauth.env
echo "GITHUB_CLIENT_SECRET=913df72205c5f97f5d29fea42e0565e33d0ade8d" >> oauth.env
echo "OAUTH_CALLBACK_URL=https://10.211.55.13:443/hub/oauth_callback" >> oauth.env

cd ..

cp instructors-sample.csv instructors.csv
echo id,first_name,last_name,email > instructors.csv
echo aeksei,Aleksey,Pervushin,aeksei94@gmail.com >> instructors.csv

cp students-sample.csv students.csv
echo id,first_name,last_name,email > students.csv
echo aeksei,Aleksey,Pervushin,aeksei94@gmail.com >> students.csv

groupadd -g 5000 student
useradd student -u 5000 -g 5000

groupadd -g 15000 instructor
useradd instructor -u 15000 -g 15000

cp nbgrader-sample.env nbgrader.env
sed -i 's/COURSE_HOME=<absolute path of nbgrader compatible course directory.>/COURSE_HOME=\/home\/aeksei\/jupyterhub-deploy-docker/g' nbgrader.env

sed -i 's/INSTRUCTOR_UID=1001/INSTRUCTOR_UID=5000/g' nbgrader.env
sed -i 's/INSTRUCTOR_GID=1001/INSTRUCTOR_GID=5000/g' nbgrader.env

sed -i 's/STUDENT_UID=10000/STUDENT_UID=15000/g' nbgrader.env
sed -i 's/STUDENT_GID=10000/STUDENT_GID=15000/g' nbgrader.env