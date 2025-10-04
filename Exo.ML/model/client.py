import requests

# عنوان السيرفر
url = "http://127.0.0.1:5000/train"

# فتح ملف CSV وإرساله
files = {"file": open("data.csv", "rb")}
response = requests.post(url, files=files)

print("Status Code:", response.status_code)
print("Raw Response:", response.text)   # ده هيوريك إيه اللي جالك من السيرفر

try:
    print("Response from server (JSON):", response.json())
except Exception as e:
    print("JSON decode error:", e)
