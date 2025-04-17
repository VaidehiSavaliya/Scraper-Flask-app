// scrape.js

const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL;

if (!url) {
  console.error("❌ SCRAPE_URL not provided");
  process.exit(1);
}

(async () => {
  try {
    const browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    await page.goto(url, { waitUntil: 'domcontentloaded' });

    const data = await page.evaluate(() => {
      return {
        title: document.title,
        heading: document.querySelector('h1')?.innerText || 'No <h1> found'
      };
    });

    fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
    await browser.close();

    console.log("✅ Scraping done. Data saved to scraped_data.json");
  } catch (error) {
    console.error("❌ Error during scraping:", error);
  }
})();

