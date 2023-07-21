debug:
	uvicorn main:app --reload --host=0.0.0.0

compile:
	docker build -t randomizer:latest .

down:
	docker stop $$(docker ps -aq) && \
	docker rm $$(docker ps -aq)

run: compile
	docker run -d -p 9000:8080 randomizer:latest
