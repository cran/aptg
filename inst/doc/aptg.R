## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----include=FALSE------------------------------------------------------------
library(aptg)


## ----taxa.tree, echo=TRUE, message=FALSE, results="hide"----------------------
taxa.tree(species = c("Canis lupus", "Canis latrans", "Acer saccharum", "Castor canadensis", "Alces alces", "Acer rubrum", "Vulpes vulpes", "Salix babylonica", "Odocoileus virginianus", "Betula alleghaniensis", "Rangifer tarandus","Juniperus occidentalis"))

## ----downto.tree, echo=-1,message=FALSE, results='hide', fig.height=6, fig.width=6----
Sys.setenv(ENTREZ_KEY="2a3e497f3b180829c87cafafac7a122d9f09") #API key for NCBI
downto.tree("Cervidae", "species")

