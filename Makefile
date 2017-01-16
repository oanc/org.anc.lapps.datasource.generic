VERSION=$(shell cat VERSION)
WAR=target/FDRDatasource\#$(VERSION).war
IMAGE=lappsgrid/fdr-datasource

war:
	mvn package

test:
	src/test/lsd/test.lsd

login:
	docker exec -it fdr /bin/bash

docker:
	cd src/main/docker && ./build.sh

push:
	docker push $(IMAGE)

tag:
	@echo "Tagging Docker image $VERSION"
	cd src/main/docker && ./build.sh
	docker push $(IMAGE):$(VERSION)

clean:
	mvn clean
	if [ -e src/main/docker/*.war ] ; then rm src/main/docker/*.war ; fi

