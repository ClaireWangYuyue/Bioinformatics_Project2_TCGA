
cancer1 = 'colon.tsv'
cancer2 = 'lung.tsv'

f1 = open( cancer1 , 'r')
f2 = open( cancer2 , 'r')

rawdata1= f1.readlines()
rawdata2= f2.readlines()
f1.close()
f2.close()

# create a new txt file to store the genes
g1 = open( "CRgene_colon.txt", 'w')
g2 = open( "CRgene_lung.txt", 'w')


for x in range(1,len(rawdata1)):
    # only looking for those in somatic cells
    if rawdata1[x].split("\t")[5] == "yes":
        g1.write(rawdata1[x].split("\t")[0] + "\n")

g1.close()


for x in range(1,len(rawdata2)):
    # only looking for those in somatic cells
    if rawdata2[x].split("\t")[5] == "yes":
        g2.write(rawdata2[x].split("\t")[0] + "\n")

g2.close()
