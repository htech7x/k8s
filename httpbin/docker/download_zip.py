import requests

def download_file(url, local_filename):
    # Make a GET request to the API endpoint
    response = requests.get(url)
    
    # Check if the request was successful
    if response.status_code == 200:
        # Open a file in binary write mode to write the downloaded content
        with open(local_filename, 'wb') as f:
            # Write the content of the response to the file
            f.write(response.content)
        print("File downloaded successfully.")
    else:
        print("Failed to download file. Status code:", response.status_code)

# Example usage:
api_url = "https://example.com/api/download/file"
local_filename = "downloaded_file.zip"

# Download the file from the API
download_file(api_url, local_filename)

