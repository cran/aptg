#' Hierarchical Tree Generator
#'
#' Generates a phylogenetic tree from a taxon down to a chosen lower taxon.
#'
#' @param taxon The higher taxon from which the tree will start. (i.e. Family, Genus)
#' @param downto The lowest level of taxonomy wanted. Must be lower than the one in taxon argument. Only species can be outputed from the Mammals tree.
#' @param key API key. To create one use taxize::use_entrez().
#' @param db Database used. Default is "ncbi". For possible datbases see ?taxize::downstream
#' @import ape
#' @import brranching
#' @import phytools
#' @import taxize
#' @import xml2
#' @examples
#' \dontrun{
#' #Choose a certain taxon and the level you want the tree to stop
#' downto.tree("Cervidae", "species")
#' }
#' @export
downto.tree<- function(taxon, downto, key=NULL, db="ncbi"){

  ##Query liste de taxon
  taxon_downto<-downstream(sci_id = taxon, downto=downto, db=db)
  ##Extraire le vector des noms de taxons de la matrice
  taxon_list<-taxon_downto[[taxon]]
  #définir le vecteur comme taxon de reference
  taxa<-taxon_list$childtaxa_name

  find.tree<-function(x){
    #Obtenir le id de l'espece
    id.sp<-function(x){
        get_uid(sci_com = x, verbose = T,key = key)
    }

    #trouver sa classification

    hier.sp<-classification(id.sp(x), db="ncbi") #hiérarchie espece
    class.query<-hier.sp[[id.sp(x)]] #isoler le terme de la classe

    #tree.select
    tree.select<-function(x){
      if ("Mammalia" %in% class.query$name) {
        return("binindaemonds2007")
      }
      else if ("Euphyllophyta" %in% class.query$name) {
        return("zanne2014")
      }
      else {
        stop("There is no stored tree for your taxon")
      }
    }
    tree.select(x)
  }


  #creer l'arbre
  tree <- phylomatic(taxa=taxa,taxnames = T, storedtree =find.tree(x=sample(taxa, size=1)), get='POST', clean = T, db="ncbi")
  #representer l'arbre graphiquement
  plot(tree, no.margin=TRUE)

}
