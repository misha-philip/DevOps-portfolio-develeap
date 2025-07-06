FROM python:3.9-slim as builder

WORKDIR /app

COPY requirements.txt . 
COPY Application/ ./app/

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.9-slim

WORKDIR /app

RUN pip install --no-cache-dir gunicorn

COPY --from=builder /app .
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

RUN useradd -m -r --uid 1000 appuser && \
    chown -R appuser:appuser /app

USER appuser

ENV port=8080

EXPOSE $port

CMD ["gunicorn", "--bind=0.0.0.0:$PORT", "--log-level=info", "service:app"]