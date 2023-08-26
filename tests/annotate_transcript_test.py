import os
import json
import unittest
from transcript_processing import annotate_transcript
from flask import Request

class TestTranscriptProcessing(unittest.TestCase):
    def test_annotate_transcript(self):
        # Load test transcript from file
        with open(os.path.join(os.path.dirname(__file__), 'test_transcript.txt'), 'r') as f:
            transcript = f.read()

        # Create request body
        request_body = {
            'source': 'test',
            'participants': ['Ayn', 'Mike'],
            'clientid': '123e4567-e89b-12d3-a456-426655440000',
            'customerid': '123e4567-e89b-12d3-a456-426655440001',
            'transcript': transcript
        }

        # Create Flask request object
        request = Request.from_values(json=request_body)
        request.method = 'POST'

        # Call annotate_transcript function
        response, status_code = annotate_transcript(request)
        dict_obj = json.loads(response.data.decode('utf-8'))
        # Check response
        self.assertEqual(status_code, 200)
        self.assertIsInstance(dict_obj, dict)
        self.assertIn('source', dict_obj)
        self.assertIn('participants', dict_obj)
        self.assertIn('clientid', dict_obj)
        self.assertIn('customerid', dict_obj)
        self.assertIn('transcript', dict_obj)
        self.assertIn('token_count', dict_obj)

if __name__ == '__main__':
    unittest.main()