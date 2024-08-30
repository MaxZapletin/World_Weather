FROM python:3.8-alpine

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY app.py /app/app.py
COPY template /app/

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD ["app.py" ]