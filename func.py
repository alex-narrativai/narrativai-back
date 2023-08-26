import requests
import json

# Define the URL of the Google Cloud Function
url = "https://europe-west2-narrativai.cloudfunctions.net/annotate-transcript-function"
print(url)
# Create a sample payload
payload = {
    "source": "email",
    "participants": ["john.doe@example.com", "Jane Doe"],
    "clientid": "123e4567-e89b-12d3-a456-426614174000",
    "customerid": "123e4567-e89b-12d3-a456-426614174001",
    "transcript": "John: Hello\nJane: Hi\nJohn: How are you?"
}

# Send POST request
response = requests.post(url, json=payload)
print(response)

# Check the response
if response.status_code == 200:
    print("Success:", json.dumps(response.json(), indent=4))
else:
    print("Failed:", response.content)
