FROM python:3.11-slim-bullseye

ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .
RUN apt-get update && apt-get upgrade -y && apt-get clean && \
  pip install --no-cache-dir -r requirements.txt
COPY app.py .

RUN useradd -m appuser
USER appuser


EXPOSE 8080
CMD ["python", "app.py"]