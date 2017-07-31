# Health Care

`Health Care` is a simple container with HEALTHCHECK turned on.

## Usage

Build docker image:

	build.sh

Run:

	docker run -p 3333:3333 oblac/health-care

Enjoy!

## API

| Endpoint      | Description   |
| ------------- | ------------- |
| /             | Healtcheck endpoint, Returns 200 or 500 |
| /switch       | Switch healthchecks between success and error |
| /count        | Returns the number of healtcheck requests |

## Publish

To publish & update the image on docker hub:

	docker login --username=igorspasic
	docker push oblac/health-care
