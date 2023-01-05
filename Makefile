install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt
format:
	#format code
	black *.py lib/*.py
lint:
	#flake8 or #pylint
	pylint --disable=R,C *.py lib/*.py
test:
	#test
	python -m pytest -vv --cov=lib --cov=main test_*.py
build:
	#build container
	docker build -t rokiis1/deploy-fastapi .
run:
	#run docker
	#docker run -p 127.0.0.1:8080:8080 38da9bfd1849
deploy:
	#deploy
all: install lint test deploy