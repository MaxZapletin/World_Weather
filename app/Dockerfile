FROM python:3.8-alpine

WORKDIR /app

COPY /app/requirements.txt /app/requirements.txt
COPY /app/app.py /app/app.py
COPY /app/template /app/

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD ["app.py" ]