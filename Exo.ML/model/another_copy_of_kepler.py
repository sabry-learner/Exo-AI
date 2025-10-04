import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from xgboost import XGBClassifier
from sklearn.metrics import accuracy_score, classification_report, f1_score
import requests
import json

# Load the dataset
df = pd.read_csv(r"D:\nasa app challenge\data\cumulative_2025.09.30_05.08.18.csv")

# Drop columns with >50% missing values
missing_percentage = df.isnull().sum() / len(df) * 100
columns_to_drop = missing_percentage[missing_percentage > 50].index
df = df.drop(columns=columns_to_drop)

# Drop columns with <=1 unique value
columns_to_drop_unique = [col for col in df.columns if df[col].nunique() <= 1]
df = df.drop(columns=columns_to_drop_unique)

# Encode object columns
le = LabelEncoder()
df = df.apply(lambda col: le.fit_transform(col) if col.dtype == 'object' else col)

# Drop columns with correlation = 1
numeric_df_cleaned = df.select_dtypes(include=[np.number])
corr_matrix = numeric_df_cleaned.corr()
upper = corr_matrix.where(np.triu(np.ones(corr_matrix.shape), k=1).astype(bool))
to_drop_eq_one = [column for column in upper.columns if any(upper[column] == 1)]
df = df.drop(columns=to_drop_eq_one)

# Drop specific column
df = df.drop(['koi_pdisposition'], axis=1)

# Drop duplicate rows and nulls
df = df.dropna()

# -------------------------
# Commenting all plots
# -------------------------
# import seaborn as sns
# import matplotlib.pyplot as plt
# import plotly.express as px
# from plotly.subplots import make_subplots
# import plotly.graph_objects as go
# import math
#
# # Heatmap
# corr_matrix = df.corr()
# plt.figure(figsize=(90, 90))
# sns.heatmap(corr_matrix, annot=True, fmt='.2f', cmap='coolwarm', cbar=True)
# plt.show()
#
# # Boxplots
# num_cols = df.select_dtypes(include=['float64', 'int64']).columns.tolist()
# rows = math.ceil(len(num_cols) / 3)
# fig = make_subplots(rows=rows, cols=3, subplot_titles=num_cols)
# for i, col in enumerate(num_cols, 1):
#     row = math.ceil(i / 3)
#     col_pos = (i - 1) % 3 + 1
#     fig.add_trace(go.Box(y=df[col], name=col), row=row, col=col_pos)
# fig.show()
#
# # Histograms
# fig = make_subplots(rows=rows, cols=3, subplot_titles=num_cols)
# for i, col in enumerate(num_cols, 1):
#     row = math.ceil(i / 3)
#     col_pos = (i - 1) % 3 + 1
#     fig.add_trace(go.Histogram(x=df[col], name=col, nbinsx=50), row=row, col=col_pos)
# fig.show()

# Clip outliers using IQR
numerical_cols_to_clip = df.select_dtypes(include=np.number).columns
for col in numerical_cols_to_clip:
    Q1 = df[col].quantile(0.25)
    Q3 = df[col].quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    df[col] = df[col].clip(lower=lower_bound, upper=upper_bound)

# Features and target
X = df.drop(columns=['koi_disposition'])
y = df['koi_disposition']

# Scaling
scalar = StandardScaler()
X = scalar.fit_transform(X)

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Logistic Regression
lg = LogisticRegression(max_iter=1000, class_weight='balanced')
lg.fit(X_train, y_train)
lg_pred = lg.predict(X_test)

print(f"Logistic Regression Accuracy: {accuracy_score(y_test, lg_pred)}")
print(classification_report(y_test, lg_pred))

# XGBoost Classifier
xgb = XGBClassifier(use_label_encoder=False, eval_metric='mlogloss', class_weight='balanced')
xgb.fit(X_train, y_train)
xgb_pred = xgb.predict(X_test)

print(f"XGBoost Accuracy: {accuracy_score(y_test, xgb_pred)}")
print(classification_report(y_test, xgb_pred))
print(f"XGBoost F1-score (macro): {f1_score(y_test, xgb_pred, average='macro')}")

# print(X_train)





