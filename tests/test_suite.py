import os
import sys

# Get the absolute path to the directory containing the modules being tested
module_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '../modules/annotate_transcript/function_code'))

# Add the module directory to the sys.path list
sys.path.insert(0, module_dir)

# Print sys.path for debugging
print("sys.path:", sys.path)

import unittest
from tests.annotate_transcript_test import TestAnnotateTranscript

def suite():
    test_suite = unittest.TestSuite()
    test_suite.addTest(unittest.makeSuite(TestAnnotateTranscript))
    return test_suite