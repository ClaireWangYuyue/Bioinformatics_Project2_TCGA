library(WGCNA)
datMicroarrays=read.table("cancer_genes_com.txt")
ArrayName= names(data.frame(datMicroarrays[,-1]))
GeneName= datMicroarrays$GeneName
datExpr=data.frame(t(datMicroarrays[,-1]))
names(datExpr)=datMicroarrays[,1]
dimnames(datExpr)[[1]]=names(data.frame(datMicroarrays[,-1]))
meanExpressionByArray=apply( datExpr,1,mean, na.rm=T)
NumberMissingByArray=apply( is.na(data.frame(datExpr)),1, sum)
sizeGrWindow(9, 5)
barplot(meanExpressionByArray,
        xlab = "Sample", ylab = "Mean expression",
        main ="Mean expression across samples",
        names.arg = c(1:10), cex.names = 0.7,ylim = c(0,50))
KeepArray= NumberMissingByArray<500
table(KeepArray)
datExpr=datExpr[KeepArray,]
ArrayName[KeepArray]
NumberMissingByGene =apply( is.na(data.frame(datExpr)),2, sum)
# One could do a barplot(NumberMissingByGene), but the barplot is empty in this case.
# It may be better to look at the numbers of missing samples using the summary method:
summary(NumberMissingByGene)
# Calculate the variances of the probes and the number of present entries
variancedatExpr=as.vector(apply(as.matrix(datExpr),2,var, na.rm=T))
no.presentdatExpr=as.vector(apply(!is.na(as.matrix(datExpr)),2, sum) )
# Another way of summarizing the number of pressent entries
table(no.presentdatExpr)
# Keep only genes whose variance is non-zero and have at least 4 present entries
KeepGenes= variancedatExpr>0 & no.presentdatExpr>=4
table(KeepGenes)
datExpr=datExpr[, KeepGenes]
GeneName=GeneName[KeepGenes]



library(cluster)
truemodule = read.table('color.txt')
truemodule=truemodule$V2
# here we define the adjacency matrix using soft thresholding with beta=6
ADJ1=abs(cor(datExpr,use="p"))^20
# When you have relatively few genes (<5000) use the following code
k=as.vector(apply(ADJ1,2,sum, na.rm=T))
# When you have a lot of genes use the following code
# k=softConnectivity(datE=datExpr,power=50)
# Plot a histogram of k and a scale free topology plot
sizeGrWindow(10,5)
par(mfrow=c(1,2))
hist(k)
scaleFreePlot(k, main="Check scale free topology\n")$

datExpr=datExpr[, rank(-k,ties.method="first" )<=3600]
# Turn adjacency into a measure of dissimilarity
dissADJ=1-ADJ1
dissTOM=TOMdist(ADJ1)
collectGarbage()

#============================staticADJ=======================

hierADJ=hclust(as.dist(dissADJ), method="average" )
# Plot the resulting clustering tree together with the true color assignment
sizeGrWindow(10,5);
plotDendroAndColors(hierADJ, colors = data.frame(truemodule), dendroLabels = FALSE, hang = 0.03,
                    main = "Gene hierarchical clustering dendrogram and simulated module colors" )


colorStaticADJ=as.character(cutreeStaticColor(hierADJ, cutHeight=.88, minSize=7))
# Plot the dendrogram with module colors
sizeGrWindow(10,5);
plotDendroAndColors(hierADJ, colors = data.frame(truemodule, colorStaticADJ),
                    dendroLabels = FALSE, abHeight = 0.88,
                    main = "Gene dendrogram and module colors")



#==========================DynamicADJ/DynamicHybridADJ==================


branch.number=cutreeDynamic(hierADJ,method="tree")
# This function transforms the branch numbers into colors
colorDynamicADJ=labels2colors(branch.number )
colorDynamicHybridADJ=labels2colors(cutreeDynamic(hierADJ,distM= dissADJ,
                                                  cutHeight = 0.9, deepSplit=2, pamRespectsDendro = FALSE))
# Plot results of all module detection methods together:
sizeGrWindow(10,5)
plotDendroAndColors(dendro = hierADJ,
                    colors=data.frame(truemodule, colorStaticADJ,
                                      colorDynamicADJ, colorDynamicHybridADJ),
                    dendroLabels = FALSE, marAll = c(0.2, 8, 2.7, 0.2),abHeight = 0.9,
                    main = "Gene dendrogram and module colors")


#===========================TOM================================



# Calculate the dendrogram
hierTOM = hclust(as.dist(dissTOM),method="average");
# The reader should vary the height cut-off parameter h1
# (related to the y-axis of dendrogram) in the following
colorStaticTOM = as.character(cutreeStaticColor(hierTOM, cutHeight=.88, minSize=7))
colorDynamicTOM = labels2colors (cutreeDynamic(hierTOM,method="tree"))
colorDynamicHybridTOM = labels2colors(cutreeDynamic(hierTOM, distM= dissTOM , cutHeight = 0.9,
                                                    deepSplit=2, pamRespectsDendro = FALSE))
# Now we plot the results
sizeGrWindow(10,5)
plotDendroAndColors(hierTOM,
                    colors=data.frame(truemodule, colorStaticTOM,
                                      colorDynamicTOM, colorDynamicHybridTOM),
                    dendroLabels = FALSE, marAll = c(1, 8, 3, 1),
                    main = "Gene dendrogram and module colors, TOM dissimilarity")



tabStaticADJ=table(colorStaticADJ,truemodule)
tabStaticTOM=table(colorStaticTOM,truemodule)
tabDynamicADJ=table(colorDynamicADJ, truemodule)
tabDynamicTOM=table(colorDynamicTOM,truemodule)
tabDynamicHybridADJ =table(colorDynamicHybridADJ,truemodule)
tabDynamicHybridTOM =table(colorDynamicHybridTOM,truemodule)
randIndex(tabStaticADJ,adjust=F)
randIndex(tabStaticTOM,adjust=F)
randIndex(tabDynamicADJ,adjust=F)
randIndex(tabDynamicTOM,adjust=F)
randIndex(tabDynamicHybridADJ ,adjust=F)
randIndex(tabDynamicHybridTOM ,adjust=F)


colorh1= colorStaticTOM
# remove the dissimilarities, adjacency matrices etc to free up space
rm(ADJ1); rm(dissADJ);
collectGarbage()
save.image("Simulated-NetworkConstruction.RData")
