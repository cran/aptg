#' Tree from taxa
#'
#' Generates a tree and distance matrix from a list of species names. There are reference trees for mammals and angiosperms. The input species will be sorted by reference trees.
#' @param species a list of species that is to be included in the phylogenetic tree.
#' @import ape
#' @import brranching
#' @import phytools
#' @import taxize
#' @import xml2
#' @importFrom stats cophenetic
#' @importFrom graphics plot
#' @examples
#' \dontrun{
#' #Choose a list of string of species that you want to have in a phylogenetic tree.
#' taxa.tree(species = c("Canis lupus", "Canis latrans", "Acer saccharum", "Castor canadensis",
#' "Alces alces", "Acer rubrum",
#' "Vulpes vulpes", "Salix babylonica", "Odocoileus virginianus", "Betula alleghaniensis",
#' "Rangifer tarandus","Juniperus occidentalis"))}
#' @export

taxa.tree<- function(species){


  tax.name<-tax_name(sci=species ,get = c("class", "kingdom"), db = "ncbi", verbose = F)
  #subset  mammiferes
  subset.mamm<-tax.name[which(tax.name$class=="Mammalia"),]
  subset.mamm.sp<-subset.mamm$query
  try(tree.mamm<-phylomatic(taxa=subset.mamm.sp, storedtree ="binindaemonds2007", get='POST', clean = T, db="apg",verbose = F), silent=T)

  #representer l'arbre graphiquement
  try(plot(tree.mamm, no.margin=TRUE), silent=T)

  #subset plantes
  subset.plant<-tax.name[which(tax.name$kingdom=="Viridiplantae"),]
  subset.plant.sp<-subset.plant$query
  try(tree.plant<-phylomatic(taxa=subset.plant.sp, storedtree ="zanne2014", get='POST', clean = T, db="apg",verbose = F),silent=T)
  #graphique
  try(plot(tree.plant, no.margin=TRUE),silent=T)

  #cophenetic(matrice de distances)
  try(print(cophenetic(x=tree.mamm)), silent=T)
  try(print(cophenetic(x=tree.plant)), silent=T)

}
