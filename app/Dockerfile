FROM python:3.8-alpine

WORKDIR /app

COPY ./requirements.txt .
COPY ./app.py .
COPY ./template ./template

RUN pip install -r requirements.txt

CMD ["python", "app.py"]