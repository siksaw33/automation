import os
import fitz

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

    for file_name in pdf_files:
        pdf_file = fitz.open(file_name)
        found = False
        for page in pdf_file:
            for search_text, replace_text in search_replace_list:
                draft = page.search_for(search_text.strip(), hit_max=16, quads=True, quads_tol=0.01)
                if draft:
                    found = True
                    for rect in draft:
                        annot = page.add_redact_annot(rect, text=replace_text)
                    page.apply_redactions()
                    page.apply_redactions(images=fitz.PDF_REDACT_IMAGE_NONE)

        if found:
            output_file_name = file_name[:-4] + '_modified.pdf'
            pdf_file.save(output_file_name, garbage=False, deflate=True, encryption=False)
            print(f"Changes saved to {output_file_name}")
        else:
            print(f"No search text found in {file_name}")

        pdf_file.close()
