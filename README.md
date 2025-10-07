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

## Tech Stack
**Python**, **scikit-learn**, **XGBoost**, **.NET 9**, **Entity Framework Core**, **Flutter**, **Docker**, **NASA Exoplanet Archive**

## Our Demo Project
ExoAI showcases its capabilities through the following screenshots:

![Dashboard](https://github.com/user-attachments/assets/e73ce1b1-4ac6-4467-93ba-b94737c824d0)
*Real-time analysis dashboard with Kepler data statistics.*

![Launch Screen](https://github.com/user-attachments/assets/8eb38581-db42-4e50-bc25-39aaa4a17a9d)
*Welcome screen with account creation and login options.*

![Menu](https://github.com/user-attachments/assets/28f2fb79-f6ad-460b-a15e-6406fdc8f7ff)
*Navigation menu for Home, Upload, Result, Settings, and Logout.*

![NASA Branding](https://github.com/user-attachments/assets/0a134ddb-3056-411d-aa6f-33ee2753b36e)
*ExoAI branding with NASA logo.*

![Settings](https://github.com/user-attachments/assets/b81f2a0a-995b-4253-99f9-76a76a54c478)
*Model configuration options for learning rate, dropout rate, batch size, and training epochs.*

![Upload Transit Data](https://github.com/user-attachments/assets/08e05f7b-2342-4e0f-9197-13934208320d)
*Interface for uploading CSV/TSV files for classification.*

![Sign Up](https://github.com/user-attachments/assets/d99b2bfd-55a0-4375-9f6e-b81eea14d8b2)
*Sign-up form for new users.*

---

## License
MIT License © 2025 ExoAI Team
