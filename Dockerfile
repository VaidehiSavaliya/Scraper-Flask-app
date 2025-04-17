# --- Scraper Stage ---
FROM node:18-slim AS scraper

# Prevent Puppeteer from downloading Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true
WORKDIR /app

COPY scrape.js package*.json ./
RUN npm install

# Install Chromium manually
RUN apt-get update && \
    apt-get install -y wget gnupg ca-certificates && \
    echo "deb [arch=amd64] http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
    chromium \
    fonts-liberation \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libnspr4 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils && \
    rm -rf /var/lib/apt/lists/*

# Set executable path
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Run the scraper
ENV SCRAPE_URL="https://example.com"
RUN node scrape.js

# --- Server Stage ---
FROM python:3.10-slim AS server

WORKDIR /app
COPY server.py requirements.txt ./
COPY --from=scraper /app/scraped_data.json ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python3", "server.py"]

