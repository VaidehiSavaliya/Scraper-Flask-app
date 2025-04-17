============ Scraper Flask App ============

This project is a multi-stage Docker application that :

Uses Node.js + Puppeteer + Chromium to scrape a given URL.
Uses Python Flask to serve the scraped data as a JSON API.

🛠 Tech Stack :
Node.js (Puppeteer for scraping)
Python Flask (to host JSON data)
Docker (Multi-stage build)

📦 How to Build the Docker Image :
docker build -t vaidehisavaliya8/scraper-flask-app .

🚀 How to Run the Container :
Pass the URL you want to scrape using an environment variable (SCRAPE_URL):
docker run -e SCRAPE_URL=https://example.com -p 5000:5000 vaidehisavaliya8/scraper-flask-app

🌐 How to Access the Data :
Once the container is running, open your browser and go to:
http://localhost:5000

You’ll see the scraped data (page title and first heading) in JSON format.

📁 Project Structure :
.
├── Dockerfile           # Multi-stage Dockerfile
├── scrape.js            # Puppeteer script
├── scraped_data.json    # Output file (auto-generated)
├── server.py            # Flask server
├── package.json         # Node.js dependencies
├── requirements.txt     # Python dependencies
