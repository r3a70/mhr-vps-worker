# mhr-vps-worker 🌐

[**English**](#english) | [**فارسی**](#persian)

---

<a name="persian"></a>
##  راهنمای فارسی

این پروژه نسخه‌ی بهبودیافته و تطبیق‌یافته‌ی موتور **mhr-cfw** است که به جای استفاده از Cloudflare Workers، از یک سرور شخصی (VPS) به عنوان ورکر استفاده می‌کند.

### 🌟 مزایا نسبت به نسخه‌ی کلادفلر
* **آی‌پی ثابت:** جلوگیری از مسدود شدن توسط سرویس‌هایی که به آی‌پی حساس هستند.
* **پشتیبانی کامل از هوش مصنوعی:** باز شدن بدون مشکل Gemini، ChatGPT و سایر ابزارهای AI.
* **بدون محدودیت روزانه:** عبور از محدودیت‌های رایگانِ روزانه‌ی کلادفلر ورکر.
* **پایداری بالا:** اجرای اختصاصی روی منابع سرور شما.

### 🛠 پیش‌نیازها
1. **نصب بودن پروژه اصلی:** این پروژه جایگزین بخش ورکر است. اگر هنوز کلاینت را ندارید، ابتدا [mhr-cfw](https://github.com/denuitt1/mhr-cfw) را نصب کنید.
2. **سرور لینوکس (VPS):** حتی ضعیف‌ترین سرور (Minimum Specs) با سیستم‌عامل Ubuntu/Debian کافی است.

---

### 🚀 مراحل نصب و راه‌اندازی

#### ۱. آماده‌سازی سرور (VPS)
ابتدا از طریق SSH به سرور خود متصل شوید و دستورات زیر را برای نصب Node.js و PM2 اجرا کنید:

```bash
# نصب Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# نصب PM2 برای مدیریت فرآیندها
sudo npm install pm2 -g
```

فایل `server.js` را در سرور قرار داده و اجرا کنید (حتماً پورت **8081** را در فایروال سرور باز کنید):

```bash
# اجرای ورکر
pm2 start server.js --name mhr-relay --node-args="--max-http-header-size=65536"
pm2 save
```

#### ۲. بروزرسانی Google Apps Script
در پنل Google Apps Script، فایل `Code.gs` را باز کرده و آدرس ورکر را به آی‌پی سرور خود تغییر دهید:

```javascript
// آی‌پی سرور خود را جایگزین کنید
const VPS_IP = "YOUR_SERVER_IP"; 
const WORKER_URL = "http://" + VPS_IP + ":8081";
```
سپس پروژه را مجدداً **Deploy** کنید و آیدی جدید را بردارید.

#### ۳. تنظیمات کلاینت (Local)
فایل `config.json` را در سیستم خود باز کرده و تغییرات زیر را اعمال کنید:

* **تایم‌اوت:** مقدار `relay_timeout` را حتماً به **60** تغییر دهید.
* **آیدی اسکریپت:** Deployment ID جدید را جایگزین کنید. (می‌توانید چند آیدی را با کاما `,` جدا کنید).

```json
{
  "relay_timeout": 60,
  "script_id": "ID1,ID2",
  "direct_google_exclude": [
    "console.cloud.google.com"
  ]
}
```

---

<a name="english"></a>
## 🇺🇸 English Guide

**mhr-vps-worker** is a specialized adaptation of the **mhr-cfw** engine that replaces Cloudflare Workers with a private VPS-based Node.js worker.

### 🌟 Key Advantages
* **Static IP:** Maintain a consistent IP address for all proxied requests.
* **AI Ready:** Seamlessly access Gemini, ChatGPT, and other AI platforms.
* **No Daily Limits:** Bypass Cloudflare's free tier request limits.
* **Private Infrastructure:** Runs exclusively on your own VPS.

### 🛠 Prerequisites
1. **Core Project:** This is a worker replacement. Ensure you have the [mhr-cfw](https://github.com/denuitt1/mhr-cfw) client installed first.
2. **Linux VPS:** A basic VPS (minimum specs) running Ubuntu/Debian.

---

### 🚀 Setup Instructions

#### 1. VPS Configuration
Connect to your VPS via SSH and install Node.js and PM2:

```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2
sudo npm install pm2 -g
```

Deploy the `server.js` file and ensure port **8081** is open in your firewall:

```bash
# Run the worker
pm2 start server.js --name mhr-relay --node-args="--max-http-header-size=65536"
pm2 save
```

#### 2. Update Google Apps Script
Open your `Code.gs` in the Google Apps Script editor and point it to your VPS:

```javascript
const VPS_IP = "YOUR_SERVER_IP"; 
const WORKER_URL = "http://" + VPS_IP + ":8081";
```
Re-**Deploy** the script and copy the new Deployment ID.

#### 3. Client Configuration (Local)
Edit your local `config.json` with the following adjustments:

* **Timeout:** Set `relay_timeout` to **60**.
* **Script IDs:** Update the `script_id`. You can use multiple IDs separated by commas.

```json
{
  "relay_timeout": 60,
  "script_id": "YOUR_DEPLOYMENT_ID",
  "direct_google_exclude": [
    "gemini.google.com",
    "chatgpt.com"
  ]
}
```

---
**Disclaimer:** This tool is for educational purposes only. Use it responsibly.
