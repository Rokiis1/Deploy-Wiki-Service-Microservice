install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt
post-install:
	python -m textblob.download_corpora
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
	aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 184489571052.dkr.ecr.eu-west-2.amazonaws.com
	docker build -t fastapi-wiki .
	docker tag fastapi-wiki:latest 184489571052.dkr.ecr.eu-west-2.amazonaws.com/fastapi-wiki:latest
	docker push 184489571052.dkr.ecr.eu-west-2.amazonaws.com/fastapi-wiki:latest

all: install post-install lint test deploy