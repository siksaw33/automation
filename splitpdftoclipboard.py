import os
import fitz  # PyMuPDF library
import pyperclip  # Pyperclip module for copying text to clipboard

# Define the character limit
CHARACTER_LIMIT = 12000

# Open the PDF file
input_pdf = fitz.open('prenup.pdf')

# Get the total number of pages in the PDF
total_pages = input_pdf.page_count

# Initialize the page counter and PDF file counter
page_count = 0
pdf_count = 1

# Initialize the output text
output_text = ""

# Loop through each page in the PDF
for i in range(total_pages):
    # Get the current page
    current_page = input_pdf[i]

    # Extract the text from the current page
    page_text = current_page.get_text('text')

    # Check if adding the current page will exceed the character limit
    if (page_count + len(page_text)) > CHARACTER_LIMIT:
        # Format the output text as Markdown
        formatted_text = f"**PDF {pdf_count}:**\n\n{output_text}"

        # Copy the formatted output text to clipboard
        pyperclip.copy(formatted_text)

        # Prompt for user input to continue or exit
        print(
            f"File {pdf_count}: Copied {page_count} characters to clipboard. Press Enter to continue or 'q' to quit...")
        user_input = input().strip()

        # Check if the user wants to quit
        if user_input.lower() == 'q':
            break

        # Save the current PDF file
        output_filename = f'output_file_{pdf_count}.pdf'
        output_pdf = fitz.open()
        output_pdf.insert_pdf(input_pdf, from_page=i - page_count, to_page=i - 1)
        output_pdf.save(output_filename)

        # Increment the PDF file counter, reset the page counter, and reset the output text
        pdf_count += 1
        page_count = 0
        output_text = ""

    # Increment the page counter and append the page text to the output text
    page_count += len(page_text)
    output_text += page_text

# Format the last output text as Markdown
formatted_text = f"**PDF {pdf_count}:**\n\n{output_text}"

# Wait for 5 seconds before copying to clipboard
        time.sleep(5)

# Copy the last formatted output text to clipboard
pyperclip.copy(formatted_text)

# Save the last PDF file
output_filename = f'output_file_{pdf_count}.pdf'
output_pdf = fitz.open()
output_pdf.insert_pdf(input_pdf, from_page=total_pages - page_count, to_page=total_pages - 1)
output_pdf.save(output_filename)

# Print a message when the PDF is finished
print("Finished splitting the PDF!")
