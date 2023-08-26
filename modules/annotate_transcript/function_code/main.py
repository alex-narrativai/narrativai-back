from flask import Flask, jsonify
import re
import time
import uuid

app = Flask(__name__)

def is_valid_uuid(val):
    try:
        uuid.UUID(str(val))
        return True
    except ValueError:
        return False

def create_interaction_uuid():
    return str(uuid.uuid4())

from datetime import datetime

def recombine_transcript(annotated_transcript):
    transcript = ""
    for line in annotated_transcript['transcript']:
        timestamp = datetime.fromtimestamp(line['timestamp']).strftime('%Y-%m-%d %H:%M:%S')
        transcript += f"{line['name']}: [{timestamp}] {line['message']}\n"
    return transcript

def annotate_transcript(request):
    if request.method != 'POST':
        return 'Only POST requests are accepted', 405

    content = request.get_json(silent=True)

    # Validate input
    if not content or 'source' not in content or 'participants' not in content or 'clientid' not in content or 'customerid' not in content or 'transcript' not in content:
        return 'Invalid input', 400

    source = content['source']
    participants = content['participants']
    clientid = content['clientid']
    customerid = content['customerid']
    transcript = content['transcript']

    # Check if clientid and customerid are valid UUID format
    if not is_valid_uuid(clientid) or not is_valid_uuid(customerid):
        return 'Invalid UUID format for clientid or customerid', 400

    # Initialize annotated transcript
    annotated_transcript = {
        'source': source,
        'participants': participants,
        'clientid': clientid,
        'customerid': customerid,
        'transcript': [],
        'interaction_uuid': create_interaction_uuid()
    }

    # Token count for GPT-4
    token_count = 0

    # Process transcript
    lines = transcript.split('\n')
    for line in lines:
        # Extract name and message
        match = re.match(r'([^:]+): (.+)', line)
        if match:
            name, message = match.groups()
            # Check if name or email matches with participants
            if name in participants or any(email in name for email in participants):
                timestamp = int(time.time())  # UNIX timestamp
                annotated_transcript['transcript'].append({
                    'timestamp': timestamp,
                    'name': name,
                    'message': message
                })
                token_count += len(message.split())
            else:
                timestamp = int(time.time())  # UNIX timestamp
                annotated_transcript['transcript'].append({
                    'timestamp': timestamp,
                    'name': 'Unassigned',
                    'message': line
                })
                token_count += len(line.split())
    annotated_transcript['token_count'] = token_count

    # Recombine transcript
    transcript = recombine_transcript(annotated_transcript)

    # Send to another Google Cloud Function
    #gpt4_url = 'https://example.com'  # Replace with actual function URL
    #response = requests.post(gpt4_url, json=annotated_transcript)
    #if response.status_code != 200:
    #    return 'Error sending data to GPT-4 function', 500

    with app.app_context():
        annotated_transcript['transcript'] = transcript
        return jsonify(annotated_transcript)
