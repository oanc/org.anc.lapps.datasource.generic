VERSION=$(shell cat VERSION)
WAR=target/GenericDatasource\#$(VERSION).war
IMAGE=lappsgrid/generic-datasource
COREF=/private/var/corpora/BIONLP2016-LIF/bionlp-st-ge-2016-coref

war:
	mvn package

test-fdr:
	./src/test/lsd/test.lsd fdr /private/var/corpora/FDR

#	src/test/lsd/test.lsd

test-squad:
	#src/test/lsd/squad.lsd
	./src/test/lsd/test.lsd squad /private/var/corpora/Squad-dev-1.1

test-bionlp:
	./src/test/lsd/test.lsd bionlp /var/corpora/BIONLP2016-LIF/bionlp-st-ge-2016-coref

docker:
	cd src/main/docker && ./build.sh

login:
	docker exec -it tomcat /bin/bash

start:
	docker run -d -p 8080:8080 --name tomcat -v $COREF:/var/lib/datasource lappsgrid/generic-datasource

stop:
	docker rm -f tomcat

push:
	docker push $(IMAGE):latest

tag:
	@echo "Tagging Docker image $VERSION"
	cd src/main/docker && ./build.sh
	docker tag $(IMAGE) $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)

clean:
	mvn clean
	if [ -e src/main/docker/*.war ] ; then rm src/main/docker/*.war ; fi

