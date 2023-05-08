import os
import asposepdfcloud
from asposepdfcloud.apis.pdf_api import PdfApi

# Prompt user for input of file name
file_name_input = input("Enter a start or text of the file name: ")

# Get a list of PDF files in the current directory matching the file name input
pdf_files = [f for f in os.listdir() if f.lower().endswith('.pdf') and file_name_input.lower() in f.lower()]

if not pdf_files:
    print("No PDF files found matching the file name input")
else:
    # Prompt user for input of search and replace text
    search_replace_list = []
    while True:
        search_text = input("Enter the search text (leave blank to exit): ")
        if not search_text:
            break
        replace_text = input("Enter the replace text: ")
        search_replace_list.append((search_text, replace_text))

    # Initialize PdfApi instance
    pdf_api_client = asposepdfcloud.api_client.ApiClient(
    app_key='ffbbf5c6c0ed61e84b80921d13715183',
    app_sid='be3b2dd2-5b49-4424-b347-1209e4dbaa04')
    pdf_api = PdfApi(pdf_api_client)
    
    for file_name in pdf_files:
        # Upload PDF file to cloud storage
        upload_result = pdf_api.upload_file(file_name)

        # Search and replace text in PDF file
        for search_text, replace_text in search_replace_list:
            response = pdf_api.post_document_text_replace(file_name, replacement=replace_text, text=search_text)

        # Download modified PDF file from cloud storage
        download_result = pdf_api.download_file(file_name)

        output_file_name = file_name[:-4] + '_modified.pdf'
        with open(output_file_name, 'wb') as f:
            f.write(download_result)
            print(f"Changes saved to {output_file_name}")