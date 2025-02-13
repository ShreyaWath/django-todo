# Use an official Python image
FROM python:3

# Set the working directory inside the container
WORKDIR /data

# Install required system dependencies
RUN apt-get update && apt-get install -y python3-distutils python3-pip

# Upgrade pip and install Django dependencies
RUN pip install --upgrade pip
RUN pip install django==3.2

# Copy project files into the container
COPY . .

# Run migrations before starting the server
RUN python manage.py migrate || echo "Migration failed, but continuing..."

# Expose port 8000 for the Django application
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]



