tocelldb - Customize your specific organism cellchatdb!
========
While you might feel confused when you have no idea about dealing with cell communication analysis, it is because you do not possess a specific cellchat database of your own organism. Normally, this can only be done in humans or mice, or by matching homologous genes in your species. Now we provide a method that utilizes STRINGdb to predict interactions of your specific species as long as it has a reference genome. Alternatively, if you input a DGE list, we could assist you in predicting interactions and determining the reasons behind differential gene expression!
## Installation
    devtools::install_github(install_github("HallDaveNineteenNintysix/tocelldb"))
## Usage
### Get a nodes file from STRINGdb
If you have a list of genes that you interested in, such as a DGE list, you can use 'get_nodes' function to get predicted interactions from STRINGdb.
```
# Do not run
get_nodes(identifiers, # A character vector of genes, such as c("CDC42","CDK1",
                       # "KIF23","PLK1","RAC2","RACGAP1","RHOA","RHOB").
  species = 9606, # NCBI taxon identifiers (e.g. Human is 9606, see: STRING organisms at
                  # https://string-db.org/cgi/input.pl?input_page_active_form=organisms/).
  required_score = 400, # threshold of significance to include a interaction,
                        # a number between 0 and 1000 (default depends on the network).
  network_type = "functional", # network type: functional (default), physical.
  show_query_node_labels = 0, # when available use submitted names in the preferredName
                              # column when (0 or 1) (default:0)
  add_nodes = 10, # adds a number of proteins with to the network based on their confidence score,
                  # larger number will return more interactions.
  caller_identity = "Anonymous" # your identifier for STRINGdb.
  )
```
Let's have a try with _Rhinolophus ferrumequinum_ (greater horseshoe bat).
```
library(tocelldb)
rfq_nodes <- get_nodes(c("PPAT","GPR143","GAD1","ALDH5A1","GOT2","NAT8L","ASPA","FOLH1"), 
  species = 59479,
  required_score = 400,
  network_type = "functional",
  show_query_node_labels = 0,
  add_nodes = 10,
  caller_identity = "Dave"
)
```
Then, we use 'rfq_nodes' as input with make to build a cellchatdb which can be used in CellChat analysis.
```
# Usage of make_cellchatdb()
# Do not run!
make_cellchatdb(interaction_nodes, # nodes file generated from get_nodes().
    enrich = NULL, # A given pathway type, such as "KEGG：rfq00250", or "GO", as you wish, but better follow the CellChat db format.
    annotation = NULL # A given interaction type, one of "Secreted Signaling", "ECM-Recptor", "Cell-Cell Contact", "Non-protein Signaling".)
# Start here
rfq_cellchatdb <- make_cellchatdb(rfq_nodes, enrich = "KEGG：rfq00250", annotation = "Secreted Signaling")
```
