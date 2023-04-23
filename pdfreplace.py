import os
import fitz

search_text = "SIKANDER SAWHNEY"
replace_text = "SURAJ"

for file_name in os.listdir():
    if file_name.startswith("ATTBill") and file_name.endswith(".pdf"):
        pdf_file = fitz.open(file_name)
        found = False
        for page in pdf_file:
            draft = page.search_for(search_text.strip())
            if draft:
                found = True
                for rect in draft:
                    annot = page.add_redact_annot(rect)
                page.apply_redactions()
                page.apply_redactions(images=fitz.PDF_REDACT_IMAGE_NONE)
            if found:
                output_file_name = file_name.replace('0604', '')
                pdf_file.save(output_file_name, garbage=4, deflate=True)
        print(found)
        pdf_file.close()

