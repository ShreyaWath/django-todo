# Use a stable Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies and update pip
RUN apt-get update && \
    apt-get install -y python3-distutils python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip

# Install Django and project dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy project files into the container
COPY . .

# Expose port 8000 for Django application
EXPOSE 8000

# Run migrations before starting the server
ENTRYPOINT ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
