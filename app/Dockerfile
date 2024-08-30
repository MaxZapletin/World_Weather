FROM python:3.8-alpine

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY app.py /app/app.py

RUN mkdir -p /app/template
COPY template/index.html /app/template/index.html

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD ["app.py" ]