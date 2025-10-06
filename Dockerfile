FROM python:3.11-slim-bookworm

# Set working directory
WORKDIR /app

# Copy all project files first
COPY . .

# Install system dependencies and Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        python3-dev \
        libffi-dev \
        libssl-dev \
        wget \
        curl \
        && pip install --upgrade pip \
        && pip install --no-cache-dir -r requirements.txt \
        && apt-get remove -y build-essential git python3-dev libffi-dev libssl-dev \
        && apt-get autoremove -y \
        && rm -rf /var/lib/apt/lists/*

# Expose Streamlit port
EXPOSE 8501

# Run Streamlit app
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
