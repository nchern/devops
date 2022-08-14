IMAGE_NAME=jailsh


.PHONY: container-image
container-image:
	$(EDITOR) users.conf
	docker build -t $(IMAGE_NAME) .

.PHONY: install
install:
	install ./$(IMAGE_NAME) /usr/local/bin/

.PHONY: all
all: container-image install

.PHONY: clean
clean:
	rm /usr/local/bin/$(IMAGE_NAME) || true
	docker rmi $(IMAGE_NAME) || true
