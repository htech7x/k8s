# Use a base image with Python installed
FROM python:3.9

# Install any necessary dependencies
RUN pip install requests

# Set the working directory inside the container
WORKDIR /app

# Copy the Python script that downloads the ZIP file
COPY download_zip.py .

# Run the Python script when the container starts
CMD ["python", "download_zip.py"]

