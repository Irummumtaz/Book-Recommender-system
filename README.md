# 📚 Book Recommendation System with AWS Deployment

Predict personalized book recommendations for users using machine learning with a scalable, production-ready setup deployed on **AWS EC2**.

---

## 🔹 Project Overview

This project is a **Book Recommendation System** that predicts user preferences based on historical ratings using collaborative filtering. It involves:

- Data ingestion, validation, and transformation
- Model training and evaluation
- Containerized deployment using Docker
- Hosting on AWS EC2
- End-to-end MLOps workflow

The system is built to handle large datasets efficiently and can recommend similar books based on user ratings.

---

## 💡 Key Features

- **Collaborative Filtering:** User-based book recommendations using nearest neighbors.
- **Data Processing Pipeline:** Modular stages for ingestion, validation, transformation, and model training.
- **Sparse Matrix Computation:** Efficient handling of large datasets with `scipy.sparse`.
- **Interactive Queries:** Recommend books dynamically using trained model.
- **Deployment:** Hosted on **AWS EC2** with Docker containers.
- **MLOps Practices:** Clean project structure, reusable components, and scalable architecture.

---

## 🔹 Dataset

The project uses the **Book-Crossing Dataset**:

- `BX-Books.csv` – Book metadata including title, author, year, publisher, and image URLs.
- `BX-Users.csv` – User information including location and age.
- `BX-Book-Ratings.csv` – Ratings provided by users for books (scale 0–10).

After preprocessing:

- Only users with **>200 ratings** are considered.
- Only books with **>50 ratings** are included.
- Pivot table created with **703 books × 888 users**.

---

## 🔹 Exploratory Data Analysis (EDA)

EDA is performed in `research.ipynb`:

- **Missing values:** Users with missing age values are handled, and duplicates removed.
- **Rating distribution:** Analyzed to understand user engagement.
- **Top books & users:** Identified books with the highest number of ratings and users with the most activity.
- **Visualization:** Histograms, bar charts, and heatmaps show rating distributions and book popularity.
- **Insights:** Helps in filtering the dataset to improve model performance.

---
## 🔹 Model Workflow

1. **Data Ingestion** – Load CSV files and clean data (`stage_00_data_ingestion.py`).
2. **Data Validation** – Ensure consistency, handle missing values, and correct datatypes (`stage_01_data_validation.py`).
3. **Data Transformation** – 
   - Pivot table of books × users
   - Fill NaN ratings with 0
   - Convert pivot table to **sparse matrix** for memory efficiency (`stage_02_data_transformation.py`)
4. **Model Training** – Train a **Nearest Neighbors** model using `scikit-learn` with brute-force algorithm (`stage_03_model_trainer.py`).
5. **Recommendation Generation** – Query the model for similar books and return top-N recommendations.
6. **Deployment** – Containerized using **Docker** and deployed on **AWS EC2** (`Dockerfile` + `app.py`).

---


## 🛠 Technologies & Skills

- **Programming:** Python 3.8
- **Machine Learning:** Collaborative filtering, Nearest Neighbors
- **Data Processing:** Pandas, NumPy, Scipy
- **MLOps & CI/CD:** Docker, GitHub Actions
- **Cloud & DevOps:** AWS EC2, AWS ECR
- **Database:** MongoDB (for optional storage)
- **Version Control:** Git & GitHub
- **Environment Management:** Conda, pip

---

## 📂 Project Structure

book-recommender/
│
├── artifacts/ # Generated data, models, and outputs
├── components/ # Core processing modules
│ ├── stage_00_data_ingestion.py
│ ├── stage_01_data_validation.py
│ ├── stage_02_data_transformation.py
│ ├── stage_03_model_trainer.py
├── config/ # Configuration files
│ └── config.yaml
├── entity/ # Data and model entities
├── exception/ # Custom exceptions
├── logger/ # Logging modules
├── pipeline/ # Training pipeline
├── utils/ # Utility functions
├── main.py # Entry point
├── app.py # Optional API
├── Dockerfile # Docker configuration
├── requirements.txt # Dependencies
├── README.md # Project description
└── setup.py


---


---

## ⚙️ Setup & Installation

1. **Clone the repository:**

```bash
git clone <your-repo-url>
cd book-recommender

**Create and activate Conda environment:**

conda create -n books python=3.8 -y
conda activate books
pip install -r requirements.txt

## 🚀 Deployment on AWS EC2

sudo apt-get update -y
sudo apt-get upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
newgrp docker

docker build -t book-recommender .
docker run -p 5000:5000 book-recommender
