# ExoAI — Automated Exoplanet Classification System

## Overview
**ExoAI** is an AI-powered platform developed for the **NASA Space Apps Challenge** to automate the classification of exoplanet candidates using open-source data from **Kepler**, **K2**, and **TESS** missions.  
The system integrates **machine learning**, a **.NET 9 backend**, and a **Flutter-based interface** to deliver accurate, real-time predictions and improve the efficiency of exoplanet discovery.

---

## What We Built
### Machine Learning Engine (Python)
Developed an ML model trained on NASA’s Kepler, K2, and TESS datasets using **XGBoost** and **Logistic Regression**.  
The model classifies signals as confirmed planets, candidates, or false positives with an accuracy exceeding **95%**.

### Backend API (.NET 9)
Built a secure and scalable REST API for predictions, data management, and model retraining.  
Implemented with **Entity Framework Core**, **JWT authentication**, and **Docker** for deployment.

### User Interface (Flutter)
Created a responsive web dashboard that enables users to upload datasets, visualize predictions, view confidence scores, and retrain the model interactively.

---

## Impact
Automates exoplanet identification, reducing manual analysis time by **approximately 80%**.  
It provides researchers and students with direct access to NASA’s datasets through an accessible, user-friendly interface, accelerating the pace of exoplanet discovery and promoting open scientific collaboration.

---

## Screenshots & Description

### 🚀 Launch Screen
![Launch](/Images/lanuch.png)  
*Initial splash screen displaying ExoAI’s logo and entry point to the system.*

---

### 🧾 Sign-Up Screen
![Sign-Up](/Images/sign-up.png)  
*Allows new users to create an account securely before accessing the platform.*

---

### 🔐 Login Screen
![Login](/Images/login.png)  
*Secure login screen for registered users to access their dashboards.*

---

### 📊 Dashboard
![Dashboard](/Images/home.png)  
*Main dashboard showing real-time Kepler data insights, statistics, and prediction summaries.*

---

### 📤 Upload Screen
![Upload](/Images/upload.png)  
*Upload interface for users to submit new datasets in CSV/JSON format for prediction.*

---

### 📈 Result Screen
![Result](/Images/result.png)  
*Displays prediction results with confidence scores and visual data insights.*

---

## Navigation
Includes sections for:
- **Home:** Overview and statistics  
- **Upload:** Dataset input and model execution  
- **Result:** Prediction outputs and analytics  
- **Settings:** Model configuration (learning rate, dropout rate, etc.)  
- **Logout:** Secure session termination

## Tech Stack
**Python**, **scikit-learn**, **XGBoost**, **.NET 9**, **Entity Framework Core**, **Flutter**, **Docker**, **NASA Exoplanet Archive**




*Navigation menu for Home, Upload, Result, Settings, and Logout.*

*Model configuration options for learning rate, dropout rate, batch size, and training epochs.*

## Repository Structure
```
Exo-AI/
├── Exo.API/                # .NET 9 Web API
│   ├── Controllers/        # API endpoints
│   ├── Entities/          # Data models
│   ├── DTOs/              # Data transfer objects
│   ├── Data/              # EF Core DbContext, Migrations
│   ├── Services/          # Business logic, ML integration
│   ├── Program.cs
│   ├── appsettings.json
│   └── Dockerfile
├── Exo.ML/                # Machine learning code & models
│   ├── data/              # raw/, processed/
│   ├── preprocessing/     # Data preprocessing scripts
│   ├── training/          # Training scripts
│   │   └── train.py
│   ├── inference/         # Inference scripts
│   │   └── predict.py
│   ├── models/            # Exported models (pkl/json)
│   └── requirements.txt
├── Exo.Flutter/           # Flutter web dashboard
│   ├── lib/               # Flutter source code
│   │   ├── screens/       # UI screens
│   │   ├── widgets/       # Reusable components
│   │   └── services/      # API client
│   ├── pubspec.yaml
│   └── web/
├── Images/                # README screenshots
├── docker-compose.yml     # Multi-container setup
├── .env.example           # Environment variable template
├── .gitignore             # Git ignore rules
├── LICENSE                # MIT License
└── README.md              # This file
```

## Quickstart

### 1. Backend (.NET API)
```bash
cd Exo.API
dotnet restore
dotnet build
dotnet run --urls "http://localhost:5000"
# or with Docker
docker build -t exo-api .
docker run -e ASPNETCORE_ENVIRONMENT=Production -p 5000:80 exo-api
```

**Environment Variables** (see `.env.example`):
```
ASPNETCORE_ENVIRONMENT=Development
ConnectionStrings__DefaultConnection=Server=.;Database=ExoAiDb;Trusted_Connection=True;
Jwt__Key=your_super_secret_key_here
```

### 2. ML Module (Python)
```bash
cd Exo.ML
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
pip install -r requirements.txt
python training/train.py   # Trains and saves model to models/
```

**train.py**:
- Loads raw CSV(s) from `data/`.
- Performs preprocessing and feature engineering.
- Trains XGBoost/LogisticRegression.
- Exports model to `models/` with `metadata.json` (metrics, hyperparameters).

### 3. Frontend (Flutter Web)
```bash
cd Exo.Flutter
flutter pub get
flutter run -d chrome
```

Configure API URL in `lib/services/api_client.dart`.

### 4. Docker Compose (Optional)
```bash
docker-compose up --build
```

## Usage Workflow
1. Register/login via Flutter dashboard.
2. Upload dataset (CSV/JSON) → sent to API.
3. API processes data via ML module, returns predictions + confidence.
4. View results, inspect feature importance, retrain with new hyperparameters.
5. Save retrained model for future inference.

## Configuration & Best Practices
- Store large datasets/models externally (e.g., Git LFS).
- Use CI (e.g., GitHub Actions) for tests and validation.
- Version models semantically (e.g., v1.0.0) with `metadata.json`.
- Secure secrets with environment variables or secret manager.

## Contributing
1. Fork the repository.
2. Create a feature branch: `git checkout -b feat/your-feature`.
3. Add tests and update documentation.
4. Submit a Pull Request with change details.


---

## License
MIT License © 2025 ExoAI Team
