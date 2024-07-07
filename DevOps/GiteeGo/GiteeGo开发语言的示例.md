[TOC]

## 临时

git config user.name test123  
git config user.email test123@qq.com  
FIRST_COMMIT_ID=$(git log --reverse   --pretty=format:"%H" | head -n 1)  
git reset --soft $FIRST_COMMIT_ID  
git add . && git commit --amend -m "add files"  


https://gitee.com/organizations/code-repo-example/projects




## Java Maven


git push -f https://username:password@gitee.com/code-repo-example/java-maven-example.git

测试

mvn -B test -Dmaven.test.failure.ignore=true
mvn surefire-report:report-only
mvn site -DgenerateReports=false
./target/site/surefire-report.html



## Java Gradle    


git push -f https://username:password@gitee.com/code-repo-example/java-gradle-example.git



## Java Ant    


git push -f https://username:password@gitee.com/code-repo-example/java-ant-example.git

ant -f build.xml



## Java Jacoco

mvn test -Dmaven.test.failure.ignore=true

git push -f https://username:password@gitee.com/code-repo-example/java-jacoco-example.git



## Java Cobertura

git push -f https://username:password@gitee.com/code-repo-example/java-cobertura-example.git

mvn -B cobertura:cobertura -Dmaven.test.failure.ignore=true



## Python


git push -f https://username:password@gitee.com/code-repo-example/python-example.git

pip install pytest pytest-html
pytest --html=report/index.html



## Golang

git push -f https://username:password@gitee.com/code-repo-example/golang-example.git

mkdir -p golang-report
go test -v -json -cover -coverprofile cover.out ./... > golang-report/report.jsonl
go tool cover -html=cover.out -o golang-report/index.html

test:
	mkdir -p golang-report
	go test -v -json -cover -coverprofile cover.out ./... > golang-report/report.jsonl
	go tool cover -html=cover.out -o golang-report/index.html



## PHP

git push -f https://username:password@gitee.com/code-repo-example/php-example.git

composer init
composer global require phpunit/phpunit

vendor/bin/phpunit
vendor/bin/phpunit --testdox-html index.html
phpunit --testdox-html index.html



## Ruby

git push -f https://username:password@gitee.com/code-repo-example/ruby-example.git

rails new ruby-example

bundle install
chmod +x -R bin
bin/rails webpacker:install
bin/rails db:migrate RAILS_ENV=test
bin/rails test
RAILS_ENV=production bin/rails assets:precompile




## Nodejs


git push -f https://username:password@gitee.com/code-repo-example/nodejs-example.git

npm install
npm run build
npm install && npm run test



## C++ GCC


git push -f https://username:password@gitee.com/code-repo-example/c-gcc-example.git

mkdir build && cd build
cmake -G 'Unix Makefiles' ../ && make -j



## DotNetCore

git push -f https://username:password@gitee.com/code-repo-example/dotnet-core-example.git
