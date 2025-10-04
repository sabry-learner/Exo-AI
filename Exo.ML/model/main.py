# /join =>
import os
import logging
from typing import Dict, List, Tuple, Any
from datetime import datetime
import numpy as np
import pandas as pd
from flask import Flask, request, jsonify, Response
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.metrics import (
    accuracy_score,
    f1_score,
    precision_score,
    recall_score,
    confusion_matrix,
    classification_report
)
import logging
import numpy as np
from flask import Flask, render_template, request, jsonify
from sklearn.linear_model import LogisticRegression
from xgboost import XGBClassifier
import joblib
from flasgger import Swagger
from werkzeug.utils import secure_filename


# ============================================================================
# CONFIGURATION
# ============================================================================
class Config:
    """Configuration management"""
    MODEL_DIR = "models"
    TARGET_ENCODER_PATH = os.path.join(MODEL_DIR, "target_encoder.joblib")
    LOGS_DIR = "logs"
    UPLOAD_FOLDER = "uploads"

    # Model paths
    XGB_PATH = os.path.join(MODEL_DIR, "xgb_final_model.joblib")
    LOG_PATH = os.path.join(MODEL_DIR, "log_reg_model.joblib")
    SCALER_PATH = os.path.join(MODEL_DIR, "scaler.joblib")
    ENCODER_PATH = os.path.join(MODEL_DIR, "label_encoder_kepoi.joblib")
    TARGET_ENCODER_PATH = os.path.join(MODEL_DIR, "target_encoder.joblib")
    METADATA_PATH = os.path.join(MODEL_DIR, "metadata.joblib")

    # Upload settings
    ALLOWED_EXTENSIONS = {'csv'}
    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50MB

    # Model settings
    TEST_SIZE = 0.2
    RANDOM_STATE = 42
    CV_FOLDS = 5

    # Feature configuration
    FEATURE_ORDER = [
        "koi_score",
        "koi_model_snr",
        "koi_max_mult_ev",
        "koi_count",
        "koi_prad",
        "koi_smet_err2",
        "koi_prad_err1",
        "kepoi_name",
        "koi_dicco_msky",
        "koi_dicco_msky_err"
    ]

    NUMERIC_FEATURES = [
        "koi_score",
        "koi_model_snr",
        "koi_max_mult_ev",
        "koi_count",
        "koi_prad",
        "koi_smet_err2",
        "koi_prad_err1",
        "koi_dicco_msky",
        "koi_dicco_msky_err"
    ]

    @classmethod
    def init_directories(cls):
        """Create necessary directories"""
        for directory in [cls.MODEL_DIR, cls.LOGS_DIR, cls.UPLOAD_FOLDER]:
            os.makedirs(directory, exist_ok=True)


# ============================================================================
# LOGGING SETUP
# ============================================================================
def setup_logging():
    """Configure logging with file and console handlers"""
    Config.init_directories()

    log_file = os.path.join(
        Config.LOGS_DIR,
        f"ml_service_{datetime.now().strftime('%Y%m%d')}.log"
    )

    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file),
            logging.StreamHandler()
        ]
    )
    return logging.getLogger("ml_service")


logger = setup_logging()

# ============================================================================
# FLASK APP INITIALIZATION
# ============================================================================
app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = Config.MAX_FILE_SIZE
app.config['UPLOAD_FOLDER'] = Config.UPLOAD_FOLDER

# Enable CORS
#CORS(app)

# Swagger configuration
swagger_config = {
    "headers": [],
    "specs": [
        {
            "endpoint": 'apispec',
            "route": '/apispec.json',
            "rule_filter": lambda rule: True,
            "model_filter": lambda tag: True,
        }
    ],
    "static_url_path": "/flasgger_static",
    "swagger_ui": True,
    "specs_route": "/docs"
}

swagger_template = {
    "swagger": "2.0",
    "info": {
        "title": "ML Model API",
        "description": "API for training and predicting with ML models",
        "version": "2.0.0"
    },
    "schemes": ["http", "https"],
}

swagger = Swagger(app, config=swagger_config, template=swagger_template)


# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================
def allowed_file(filename: str) -> bool:
    """Check if file extension is allowed"""
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in Config.ALLOWED_EXTENSIONS


def validate_dataframe(df: pd.DataFrame) -> Tuple[bool, str]:
    """Validate dataframe has required columns and proper data"""
    required_cols = Config.FEATURE_ORDER + ["label"]
    missing = [col for col in required_cols if col not in df.columns]

    if missing:
        return False, f"Missing columns: {missing}"

    # Check for null values
    null_counts = df[required_cols].isnull().sum()
    if null_counts.any():
        return False, f"Null values found: {null_counts[null_counts > 0].to_dict()}"

    # Check numeric columns are numeric
    for col in Config.NUMERIC_FEATURES:
        if not pd.api.types.is_numeric_dtype(df[col]):
            return False, f"Column '{col}' must be numeric"

    return True, "Valid"


def preprocess_data(df: pd.DataFrame, is_training: bool = True) -> Tuple[np.ndarray, Any]:
    """Preprocess data with encoding and scaling"""
    df = df.copy()

    # Encode kepoi_name
    if is_training:
        le_kepoi = LabelEncoder()
        df["kepoi_name"] = le_kepoi.fit_transform(df["kepoi_name"])
        joblib.dump(le_kepoi, Config.ENCODER_PATH)
    else:
        le_kepoi = joblib.load(Config.ENCODER_PATH)
        try:
            df["kepoi_name"] = le_kepoi.transform(df["kepoi_name"])
        except ValueError as e:
            logger.warning(f"Unknown kepoi_name encountered: {e}")
            # Handle unknown categories by assigning a default value
            df["kepoi_name"] = 0

    # Scale numeric features
    if is_training:
        scaler = StandardScaler()
        df[Config.NUMERIC_FEATURES] = scaler.fit_transform(df[Config.NUMERIC_FEATURES])
        joblib.dump(scaler, Config.SCALER_PATH)
    else:
        scaler = joblib.load(Config.SCALER_PATH)
        df[Config.NUMERIC_FEATURES] = scaler.transform(df[Config.NUMERIC_FEATURES])

    X = df[Config.FEATURE_ORDER].values

    if is_training and "label" in df.columns:
        le_target = LabelEncoder()
        y = le_target.fit_transform(df["label"])
        joblib.dump(le_target, Config.TARGET_ENCODER_PATH)
        return X, y

    return X, None


def save_metadata(metadata: Dict):
    """Save training metadata"""
    joblib.dump(metadata, Config.METADATA_PATH)
    logger.info("Metadata saved successfully")


def load_metadata() -> Dict:
    """Load training metadata"""
    if os.path.exists(Config.METADATA_PATH):
        return joblib.load(Config.METADATA_PATH)
    return {}


def calculate_metrics(y_true: np.ndarray, y_pred: np.ndarray) -> Dict:
    """Calculate comprehensive metrics"""
    return {
        "accuracy": float(accuracy_score(y_true, y_pred)),
        "f1_score": float(f1_score(y_true, y_pred, average="macro")),
        "precision": float(precision_score(y_true, y_pred, average="macro")),
        "recall": float(recall_score(y_true, y_pred, average="macro")),
        "confusion_matrix": confusion_matrix(y_true, y_pred).tolist()
    }


# ============================================================================
# API ENDPOINTS
# ============================================================================

@app.route("/", methods=["GET"])
def home():
    """
    Home endpoint with API information
    ---
    responses:
      200:
        description: API information
    """
    return jsonify({
        "service": "ML Model API",
        "version": "2.0.0",
        "endpoints": {
            "docs": "/docs",
            "health": "/health",
            "train": "/train",
            "predict": "/predict/<model_type>",
            "models": "/models",
            "metadata": "/metadata"
        }
    })


@app.route("/health", methods=["GET"])
def health():
    """
    Health check endpoint
    ---
    responses:
      200:
        description: Service health status
    """
    models_status = {
        "xgb": os.path.exists(Config.XGB_PATH),
        "logistic": os.path.exists(Config.LOG_PATH),
        "encoders": os.path.exists(Config.ENCODER_PATH) and
                    os.path.exists(Config.TARGET_ENCODER_PATH),
        "scaler": os.path.exists(Config.SCALER_PATH)
    }

    return jsonify({
        "status": "healthy",
        "timestamp": datetime.now().isoformat(),
        "models_available": models_status
    })


@app.route("/models", methods=["GET"])
def list_models():
    """
    List available trained models
    ---
    responses:
      200:
        description: List of available models with details
    """
    models = []

    for model_type, path in [("xgb", Config.XGB_PATH), ("logistic", Config.LOG_PATH)]:
        if os.path.exists(path):
            stat = os.stat(path)
            models.append({
                "type": model_type,
                "size_mb": round(stat.st_size / (1024 * 1024), 2),
                "last_modified": datetime.fromtimestamp(stat.st_mtime).isoformat()
            })

    return jsonify({
        "models": models,
        "metadata": load_metadata()
    })


@app.route("/metadata", methods=["GET"])
def get_metadata():
    """
    Get training metadata
    ---
    responses:
      200:
        description: Training metadata and model information
    """
    metadata = load_metadata()
    if not metadata:
        return jsonify({"message": "No training metadata available"}), 404

    return jsonify(metadata)


server_link = 'https://exo-ai.runasp.net/'


@app.route("/retrain", methods=["POST"])
def train():


    """
    Train Logistic Regression and XGBoost models
    ---
    consumes:
      - multipart/form-data
    parameters:
      - name: file
        in: formData
        type: file
        required: true
        description: CSV file containing training data
      - name: use_cv
        in: formData
        type: boolean
        required: false
        description: Whether to use cross-validation
    responses:
      200:
        description: Training results with comprehensive metrics
      400:
        description: Invalid input or missing data
      500:
        description: Training error
    """
    try:
        # Validate file upload
        if 'file' not in request.files:
            return jsonify({"error": "No file provided"}), 400

        file = request.files['file']
        if file.filename == '':
            return jsonify({"error": "No file selected"}), 400

        if not allowed_file(file.filename):
            return jsonify({"error": "Invalid file type. Only CSV allowed"}), 400

        # Read and validate data
        logger.info(f"Reading training data from {file.filename}")
        df = pd.read_csv(file)

        is_valid, message = validate_dataframe(df)
        if not is_valid:
            return jsonify({"error": message}), 400

        logger.info(f"Data loaded: {df.shape[0]} rows, {df.shape[1]} columns")

        # Preprocess data
        X, y = preprocess_data(df, is_training=True)

        # Get label distribution
        le_target = joblib.load(Config.TARGET_ENCODER_PATH)
        label_distribution = pd.Series(y).value_counts().to_dict()
        label_names = {int(k): le_target.inverse_transform([k])[0]
                       for k in label_distribution.keys()}

        # Split data
        if len(df) < 20:
            X_train, X_test, y_train, y_test = X, X, y, y
        else:
            X_train, X_test, y_train, y_test = train_test_split(
                X, y, test_size=Config.TEST_SIZE, random_state=Config.RANDOM_STATE,
                stratify=y
            )

        logger.info(f"Data split: Train={X_train.shape[0]}, Test={X_test.shape[0]}")

        # Training parameters
        use_cv = request.form.get('use_cv', 'false').lower() == 'true'

        results = {}
        training_time = {}

        # Train Logistic Regression
        logger.info("Training Logistic Regression...")
        start_time = datetime.now()
        log_model = LogisticRegression(
            max_iter=1000,
            random_state=Config.RANDOM_STATE,
            class_weight='balanced'
        )
        log_model.fit(X_train, y_train)
        training_time['logistic'] = (datetime.now() - start_time).total_seconds()

        # Train XGBoost
        logger.info("Training XGBoost...")
        start_time = datetime.now()
        xgb_model = XGBClassifier(
            n_estimators=300,
            learning_rate=0.05,
            max_depth=5,
            random_state=Config.RANDOM_STATE,
            eval_metric='mlogloss'
        )
        xgb_model.fit(X_train, y_train)
        training_time['xgb'] = (datetime.now() - start_time).total_seconds()

        # Evaluate models
        for name, model in [("logistic", log_model), ("xgb", xgb_model)]:
            logger.info(f"Evaluating {name} model...")

            y_train_pred = model.predict(X_train)
            y_test_pred = model.predict(X_test)

            train_metrics = calculate_metrics(y_train, y_train_pred)
            test_metrics = calculate_metrics(y_test, y_test_pred)

            # Cross-validation if requested
            cv_scores = None
            if use_cv:
                cv_scores = cross_val_score(
                    model, X_train, y_train,
                    cv=Config.CV_FOLDS,
                    scoring='f1_macro'
                )
                cv_scores = {
                    "mean": float(cv_scores.mean()),
                    "std": float(cv_scores.std()),
                    "scores": cv_scores.tolist()
                }

            results[name] = {
                "train_metrics": train_metrics,
                "test_metrics": test_metrics,
                "cv_scores": cv_scores,
                "training_time_seconds": training_time[name]
            }

        # Save models
        logger.info("Saving models...")
        joblib.dump(log_model, Config.LOG_PATH)
        joblib.dump(xgb_model, Config.XGB_PATH)

        # Save metadata
        metadata = {
            "training_date": datetime.now().isoformat(),
            "dataset_shape": df.shape,
            "label_distribution": {label_names[k]: int(v)
                                   for k, v in label_distribution.items()},
            "feature_names": Config.FEATURE_ORDER,
            "test_size": Config.TEST_SIZE,
            "results": results
        }
        save_metadata(metadata)

        logger.info("Training completed successfully")

        return jsonify({
            "message": "Both models trained and saved successfully!",
            "results": results,
            "metadata": metadata
        })

    except Exception as e:
        logger.error(f"Training error: {str(e)}", exc_info=True)
        return jsonify({"error": f"Training failed: {str(e)}"}), 500


@app.route("/predict/<model_type>", methods=["POST"])
def predict(model_type: str):
    """
    Predict using trained model
    ---
    parameters:
      - name: model_type
        in: path
        type: string
        enum: ["xgb", "logistic"]
        required: true
        description: Which model to use for prediction
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            koi_score: {type: number, example: 0.85}
            koi_model_snr: {type: number, example: 15.2}
            koi_max_mult_ev: {type: number, example: 3.5}
            koi_count: {type: number, example: 2}
            koi_prad: {type: number, example: 1.8}
            koi_smet_err2: {type: number, example: 0.15}
            koi_prad_err1: {type: number, example: 0.05}
            kepoi_name: {type: string, example: "K00001.01"}
            koi_dicco_msky: {type: number, example: 0.95}
            koi_dicco_msky_err: {type: number, example: 0.02}
    responses:
      200:
        description: Prediction result with probabilities and confidence
      400:
        description: Invalid input or model type
      404:
        description: Model not found
      500:
        description: Prediction error
    """
    try:
        # Validate model type
        if model_type not in ["xgb", "logistic"]:
            return jsonify({
                "error": "Invalid model type. Use 'xgb' or 'logistic'"
            }), 400

        # Load model
        model_path = Config.XGB_PATH if model_type == "xgb" else Config.LOG_PATH
        if not os.path.exists(model_path):
            return jsonify({
                "error": f"Model '{model_type}' not found. Please train first."
            }), 404

        model = joblib.load(model_path)
        le_target = joblib.load(Config.TARGET_ENCODER_PATH)

        # Get input data
        data = request.json
        if not data:
            return jsonify({"error": "No input data provided"}), 400

        # Validate features
        missing = [f for f in Config.FEATURE_ORDER if f not in data]
        if missing:
            return jsonify({"error": f"Missing features: {missing}"}), 400

        # Create dataframe for preprocessing
        df = pd.DataFrame([data])
        X, _ = preprocess_data(df, is_training=False)

        # Predict
        pred = model.predict(X)[0]
        proba = model.predict_proba(X)[0]

        # Get label names
        pred_label = le_target.inverse_transform([pred])[0]
        all_labels = le_target.classes_

        # Calculate confidence
        confidence = float(np.max(proba))

        # Create probability dictionary
        prob_dict = {
            label: float(prob)
            for label, prob in zip(all_labels, proba)
        }

        response = {
            "model": model_type,
            "prediction": int(pred),  # ✅ convert np.int64 to int
            "prediction_label": pred_label,
            "confidence": float(np.max(proba)),  # ✅ convert np.float64 to float
            "probabilities": {  # ✅ convert all np.float64 to float
                label: float(prob) for label, prob in zip(all_labels, proba)
            },
            "raw_probabilities": proba.tolist(),
            "timestamp": datetime.now().isoformat()
        }

        logger.info(f"Prediction made: {pred_label} (confidence: {confidence:.3f})")

        return jsonify(response)

    except Exception as e:
        logger.error(f"Prediction error: {str(e)}", exc_info=True)
        return jsonify({"error": f"Prediction failed: {str(e)}"}), 500


@app.route("/predict/batch/<model_type>", methods=["POST"])
def predict_batch(model_type: str):
    """
    Batch prediction endpoint
    ---
    consumes:
      - multipart/form-data
    parameters:
      - name: model_type
        in: path
        type: string
        enum: ["xgb", "logistic"]
        required: true
        description: Which model to use for prediction
      - name: file
        in: formData
        type: file
        required: true
        description: CSV file containing features for prediction
    responses:
      200:
        description: Batch prediction results
      400:
        description: Invalid input
      404:
        description: Model not found
    """
    try:
        if model_type not in ["xgb", "logistic"]:
            return jsonify({"error": "Invalid model type"}), 400

        if 'file' not in request.files:
            return jsonify({"error": "No file provided"}), 400

        file = request.files['file']
        if not allowed_file(file.filename):
            return jsonify({"error": "Invalid file type"}), 400

        # Load model
        model_path = Config.XGB_PATH if model_type == "xgb" else Config.LOG_PATH
        if not os.path.exists(model_path):
            return jsonify({"error": f"Model not found"}), 404

        model = joblib.load(model_path)
        le_target = joblib.load(Config.TARGET_ENCODER_PATH)

        # Read data
        df = pd.read_csv(file)

        # Check features
        missing = [f for f in Config.FEATURE_ORDER if f not in df.columns]
        if missing:
            return jsonify({"error": f"Missing columns: {missing}"}), 400

        # Preprocess
        X, _ = preprocess_data(df, is_training=False)

        # Predict
        predictions = model.predict(X)
        probabilities = model.predict_proba(X)

        # Decode labels
        pred_labels = le_target.inverse_transform(predictions)

        # Prepare results
        # Load target encoder
        le_target = joblib.load(Config.TARGET_ENCODER_PATH)
        class_labels = le_target.classes_

        results = []
        for i, (pred, proba) in enumerate(zip(predictions, probabilities)):
            pred_label = le_target.inverse_transform([pred])[0]  # decode numeric → label

            # map probabilities to class names
            proba_dict = {
                class_labels[j]: float(proba[j])
                for j in range(len(class_labels))
            }

            results.append({
                "index": i,
                "prediction": pred_label,  # ✅ use decoded class name
                "confidence": float(np.max(proba)),
                "probabilities": proba_dict  # ✅ class-name → probability
            })

        return jsonify({
            "model": model_type,
            "total_predictions": len(results),
            "results": results,
            "timestamp": datetime.now().isoformat()
        })

    except Exception as e:
        logger.error(f"Batch prediction error: {str(e)}", exc_info=True)
        return jsonify({"error": str(e)}), 500


@app.errorhandler(413)
def too_large(e):
    """Handle file too large error"""
    return jsonify({
        "error": f"File too large. Maximum size is {Config.MAX_FILE_SIZE / (1024 * 1024)}MB"
    }), 413


@app.errorhandler(404)
def not_found(e):
    """Handle 404 errors"""
    return jsonify({"error": "Endpoint not found"}), 404


@app.errorhandler(500)
def internal_error(e):
    """Handle internal server errors"""
    logger.error(f"Internal error: {str(e)}", exc_info=True)
    return jsonify({"error": "Internal server error"}), 500


# @app.route("/predict", methods=["POST"])
# def predict():
#
#     """
#     Predict using XGBoost model
#     ---
#     consumes:
#       - application/json
#     parameters:
#       - in: body
#         name: input
#         required: true
#         schema:
#           type: object
#           properties:
#             koi_score: {type: number, example: 0.85}
#             koi_model_snr: {type: number, example: 15.2}
#             koi_max_mult_ev: {type: number, example: 3.5}
#             koi_count: {type: number, example: 2}
#             koi_prad: {type: number, example: 1.8}
#             koi_smet_err2: {type: number, example: 0.15}
#             koi_prad_err1: {type: number, example: 0.05}
#             kepoi_name: {type: string, example: "K00001.01"}
#             koi_dicco_msky: {type: number, example: 0.95}
#             koi_dicco_msky_err: {type: number, example: 0.02}
#     responses:
#       200:
#         description: Prediction result
#       400:
#         description: Invalid input
#       500:
#         description: Prediction error
#     """
#     try:
#         data = request.json
#         if not data:
#             return jsonify({"error": "No input data provided"}), 400
#
#         # Load encoders and model
#         le_kepoi = joblib.load(ENCODER_PATH)
#         le_target = joblib.load(TARGET_ENCODER_PATH)
#         model = joblib.load(XGB_PATH)
#
#         # Check required features
#         missing = [f for f in FEATURE_ORDER if f not in data]
#         if missing:
#             return jsonify({"error": f"Missing features: {missing}"}), 400
#
#         # Encode kepoi_name
#         features = dict(data)
#         features["kepoi_name"] = le_kepoi.transform([features["kepoi_name"]])[0]
#
#         # Build input array
#         X = np.array([features[f] for f in FEATURE_ORDER]).reshape(1, -1)
#
#         # Prediction
#         pred = model.predict(X)[0]
#         proba = model.predict_proba(X)[0]
#
#         # Decode prediction
#         pred_label = le_target.inverse_transform([pred])[0]
#
#         # Decode all probabilities using LabelEncoder
#         prob_dict = {}
#         for i, p in enumerate(proba):
#             label_name = le_target.inverse_transform([i])[0]
#             prob_dict[label_name] = float(p)
#
#         return jsonify({
#             "prediction": int(pred),
#             "prediction_label": pred_label,
#             "confidence": float(np.max(proba)),
#             "probabilities": prob_dict
#         })
#
#     except Exception as e:
#         logger.error(f"Prediction error: {e}")
#         return jsonify({"error": str(e)}), 500

# Configuration
# ======================
MODEL_DIR = "models"
XGB_PATH = os.path.join(MODEL_DIR, "xgb_final_model.joblib")
ENCODER_PATH = os.path.join(MODEL_DIR, "label_encoder_kepoi.joblib")   # for kepoi_name
TARGET_ENCODER_PATH = os.path.join(MODEL_DIR, "target_encoder.joblib")  # for target label
os.makedirs(MODEL_DIR, exist_ok=True)
FEATURE_ORDER = [
    "koi_score",
    "koi_model_snr",
    "koi_max_mult_ev",
    "koi_count",
    "koi_prad",
    "koi_smet_err2",
    "koi_prad_err1",
    "kepoi_name",
    "koi_dicco_msky",
    "koi_dicco_msky_err"
]
@app.route("/predict-real", methods=["POST"])
def predict_real():

    """
    Predict using XGBoost model
    ---
    consumes:
      - application/json
    parameters:
      - in: body
        name: input
        required: true
        schema:
          type: object
          properties:
            koi_score: {type: number, example: 0.85}
            koi_model_snr: {type: number, example: 15.2}
            koi_max_mult_ev: {type: number, example: 3.5}
            koi_count: {type: number, example: 2}
            koi_prad: {type: number, example: 1.8}
            koi_smet_err2: {type: number, example: 0.15}
            koi_prad_err1: {type: number, example: 0.05}
            kepoi_name: {type: string, example: "K00001.01"}
            koi_dicco_msky: {type: number, example: 0.95}
            koi_dicco_msky_err: {type: number, example: 0.02}
    responses:
      200:
        description: Prediction result
      400:
        description: Invalid input
      500:
        description: Prediction error
    """
    try:
        data = request.json
        if not data:
            return jsonify({"error": "No input data provided"}), 400

        # Load encoders and model
        le_kepoi = joblib.load(ENCODER_PATH)
        le_target = joblib.load(TARGET_ENCODER_PATH)
        model = joblib.load(XGB_PATH)

        # Check required features
        missing = [f for f in FEATURE_ORDER if f not in data]
        if missing:
            return jsonify({"error": f"Missing features: {missing}"}), 400

        # Encode kepoi_name
        features = dict(data)
        features["kepoi_name"] = le_kepoi.transform([features["kepoi_name"]])[0]

        # Build input array
        X = np.array([features[f] for f in FEATURE_ORDER]).reshape(1, -1)

        # Prediction
        pred = model.predict(X)[0]
        proba = model.predict_proba(X)[0]

        # Decode prediction
        pred_label = le_target.inverse_transform([pred])[0]

        # Decode all probabilities using LabelEncoder
        prob_dict = {}
        for i, p in enumerate(proba):
            label_name = le_target.inverse_transform([i])[0]
            prob_dict[label_name] = float(p)

        return jsonify({
            "prediction": int(pred),
            "prediction_label": pred_label,
            "confidence": float(np.max(proba)),
            "probabilities": prob_dict
        })

    except Exception as e:
        logger.error(f"Prediction error: {e}")
        return jsonify({"error": str(e)}), 500

# ============================================================================
# MAIN
# ============================================================================
if __name__ == "__main__":
    logger.info("Starting ML Model API Service...")
    logger.info(f"Swagger documentation available at: http://localhost:5000/docs")
    app.run(debug=True, host='0.0.0.0', port=5000)

