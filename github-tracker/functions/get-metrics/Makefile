BUCKET_NAME=juan-lambda-sec-web
BUILD_NAME=get-metrics.zip

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bootstrap main.go
	zip -r $(BUILD_NAME) bootstrap

publish: build
	aws s3 cp $(BUILD_NAME) s3://$(BUCKET_NAME)/$(BUILD_NAME)
