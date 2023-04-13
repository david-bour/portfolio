debug:
	uvicorn main:app --reload --host=0.0.0.0

compile:
	docker build -t api:latest .

run: compile
	docker run -port 8000:8000 api:latest