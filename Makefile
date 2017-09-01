VERSION=$(shell cat VERSION)
WAR=target/GenericDatasource\#$(VERSION).war
IMAGE=lappsgrid/generic-datasource

war:
	mvn package

test-fdr:
	./src/test/lsd/test.lsd fdr /private/var/corpora/FDR

#	src/test/lsd/test.lsd

test-squad:
	#src/test/lsd/squad.lsd
	./src/test/lsd/test.lsd squad /private/var/corpora/Squad-dev-1.1

test-bionlp:
	./src/test/lsd/test.lsd bionlp /private/var/corpora/BIONLP2016-LIF/bionlp-st-ge-2016-coref

login:
	docker exec -it fdr /bin/bash

docker:
	cd src/main/docker && ./build.sh

push:
	docker push $(IMAGE)

tag:
	@echo "Tagging Docker image $VERSION"
	cd src/main/docker && ./build.sh
	docker tag $(IMAGE) $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)

clean:
	mvn clean
	if [ -e src/main/docker/*.war ] ; then rm src/main/docker/*.war ; fi

