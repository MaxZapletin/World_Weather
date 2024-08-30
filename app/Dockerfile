FROM python:3.8-alpine

WORKDIR /app

COPY requirements.txt .
COPY app.py .
COPY index.html .

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD ["app.py" ]