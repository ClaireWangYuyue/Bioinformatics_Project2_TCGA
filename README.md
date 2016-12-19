# Bioinformatics_Project2_TCGA
-In code_related folder:
1. COSMIC_filter.py: Python code that reads the tsv files downloaded from COSMIC and filtered for gene symbols of with the desired somatic type(lung/colon)
2. make_matrix.py: Python code that filters the cancer related genes expression levels for each patient from them total gene expression level data; and makes a matrix of gene versus patient and another matrix of gene versus truemodule colors.
3. R_try.R: all the R codes for pre-processing and clustering
4. colon.tsv/lung.tsv: 	the tsv files downloeaded from COSMIC for the two types of cancers(input of COSMIC_filter.py)
5. CRgene_colon.txt: colorectal cancer realted gene symbols (output of COSMIC_filter.py)
6. CRgene_lung.txt: lung cancer realted gene symbols (output of COSMIC_filter.py)
7. mart_export_colon.txt: the exported file from Biomart that reverse colon cancer related gene symbols to gene IDs.
8. mart_export_lung.txt: the exported file from Biomart that reverse lung cancer related gene symbols to gene IDs.
9. colon1-5.txt: gene expression level data of the 10 selected patients with colorectal cancer
10. lung1-5.txt: gene expression level data of the 10 selected patients with colorectal cancer
11. cancer_genes_com.txt: the matrix of cancer related gene versus patient(output of make_matrix.py)
12. color.txt: the matrix of gene versus truemodule colors(output of make_matrix.py)
-In plots folder:
All the figure plots cited in the report
-In Simulated Data folder:
All files need to run sample simulated codes
-In Sample_simulated folder:
All the simulated tutorial PDFs. (Using data from simulated data foler). To run the codes in tutorials, needs to set working directory to Simulated Data/

