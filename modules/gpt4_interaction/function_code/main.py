import os
import json
import openai
from pprint import pprint
from flask import Flask, request

# Initialize Flask app
app = Flask(__name__)

# Initialize GPT-4 API
openai.api_key = os.environ.get("OPENAI_KEY")

@app.route('/gpt4_summary', methods=['POST'])
def gpt4_summary(request):
    """
    This function generates a summary of a customer interaction in a structured JSON format using GPT-4 API.

    Args:
        request (flask.Request): The HTTP request object.

    Returns:
        str: The generated summary in a structured JSON format.
    """
    # Get JSON payload from request
    payload = request.get_json()
    
    # Extract relevant fields
    clientid = payload.get('clientid')
    customerid = payload.get('customerid')
    interaction_uuid = payload.get('interaction_uuid')
    participants = payload.get('participants')
    source = payload.get('source')
    token_count = payload.get('token_count')
    transcript = payload.get('transcript')

    # Update GPT-4 Prompt
    prompt = """Persona: Business Analyst
    As a Business Analyst, my role is to provide clear, factual, and structured summaries of customer interactions without a loss of important conversation points.
    I need to analyze the annotated transcript below and generate a summary in a structured JSON format.
    
    The summary should strictly adhere to the following sections:
    1. Participants Information
            3a. Sentiment Analysis
            3b. Participant Details
    2. Overall Interaction Summary - this should be a detailed summary of the entire interaction and can be up to 10 sentences.
    3. Overall Interaction Sentiment

--------
    Example JSON Format:
    Participants: {
        Partcipant 1 Name: {
            Sentiment: sentiment_analysis,
            Details: any_pertinent_business_or_personal_details
        }
    }
    Summary: overall_interaction_summary,
    Sentiment: overall_interaction_sentiment
---------------- 
    Annotated Transcript:


    """


    # Make GPT-4 API call
    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[{"role":"user", "content": prompt+transcript}],
        max_tokens=1000,
        n=1,
        stop=None,
        temperature=0.1
    )

    # Extract and parse GPT-4 output
    print(response.usage)
    tokens_used = response.usage['total_tokens']
    gpt4_output = response.choices[0]['message']['content']
    gpt4_dict = json.loads(gpt4_output)

    # Extract relevant fields
    participants_summary = gpt4_dict.get('Participants', {})
    interaction_summary = gpt4_dict.get('Summary', '')
    overall_sentiment = gpt4_dict.get('Sentiment', '')

    # Create a new dictionary with all the fields
    final_output = {
        'clientid': clientid,
        'customerid': customerid,
        'interaction_uuid': interaction_uuid,
        'participants': participants,
        'source': source,
        'token_count': token_count,
        'transcript': transcript,
        'ParticipantsSummary': participants_summary,
        'InteractionSummary': interaction_summary,
        'OverallSentiment': overall_sentiment,
        'TokensUsed': tokens_used
    }

    # Convert final_output to JSON if needed
    final_output_json = json.dumps(final_output, indent=4)
    return final_output_json
