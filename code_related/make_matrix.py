import pprint
patient_files = []
for i in range(1,6):
    patient_files.append('lung'+str(i)+'.txt')
for j in range(1,6):
    patient_files.append('colon'+str(j)+'.txt')

cancer_gene_colon = 'mart_export_colon.txt'
cancer_gene_lung = 'mart_export_lung.txt'
cancer_gene_combined = 'cancer_genes_com.txt'
color = 'color.txt'

colon_file = open(cancer_gene_colon,'r')
lung_file = open(cancer_gene_lung,'r')
combined = open(cancer_gene_combined,'w')
truemodules = open(color,'w')

colon_data = colon_file.readlines()
lung_data = lung_file.readlines()
colon_data.pop(0)
lung_data.pop(0)

colon_file.close()
lung_file.close()

cancer_gene_union = []
gene_indexer = []
colors = []
for info in colon_data:
    info_split = info.split('\t')
    if info_split[0] not in cancer_gene_union:
        cancer_gene_union.append(info_split[0])
        gene_indexer.append(info_split[0])
        colors.append(info_split[0]+'\tturquoise')
for info in lung_data:
    info_split = info.split('\t')
    if info_split[0] not in gene_indexer:
        cancer_gene_union.append(info_split[0])
        gene_indexer.append(info_split[0])
        colors.append(info_split[0]+'\tblue')
    else:
        colors[gene_indexer.index(info_split[0])] = info_split[0]+'\tbrown'

cancer_gene_union.insert(0,'Gene_name\t')

for file in patient_files:
    cancer_gene_union[0] += file[:-4]+'\t'
    patient_file = open(file,'r')
    patient_data = patient_file.readlines()
    for gene in patient_data:
        if gene[:15] in gene_indexer:
            cancer_gene_union[gene_indexer.index(gene[:15])+1] += '\t'+gene.split('\t')[1][:-1]
        #else:
        #    cancer_gene_union[gene_indexer.index(gene[:15]) + 1] += '\tNA'


pprint.pprint(cancer_gene_union)
pprint.pprint(colors)
print(len(colon_data),len(lung_data),len(cancer_gene_union),len(colors))
truemodules.write('\n'.join(colors))
combined.write('\n'.join(cancer_gene_union))
combined.close()
truemodules.close()

