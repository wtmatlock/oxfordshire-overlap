The repository accompanies *Matlock, W. and Lipworth, S. et al. Enterobacterales* plasmid sharing amongst human bloodstream infections, livestock, wastewater, and waterway niches in Oxfordshire, UK. eLife. 2023 12:e85302. doi: https://doi.org/10.7554/eLife.85302*

- Shell scripts (those ending in `.sh`) are formatted for a Slurm scheduler, but they also record the parameters used for any tools.
- If you want help/other materials (e.g., any plotting scripts), please don't hesitate to get in touch! 😊

| Script | Description | Dependencies |
| -------|-------------|--------------|
|`Coverage.sh`|Calculate the short-read coverage of genome assemblies for e.g. NCBI upload requirements. |bwa, samtools, bedtools|
|`Louvain.py`|Benchmarks Louvain clustering for a range of mash distance-weighted edge network thresholds.| Python: community_louvain, collections, networkx, numpy, pandas |
|`NetworkEvolution.py`|Records the largest connected component, number of connected components, and number of singletons, for a network over a range of network thresholds.| Python: networkx, numpy, pandas |
|`RunAbricateProkka.sh`|Annotates genomes with abricate (various databases), AMRFinder, and prokka. Parallelised for a list of genomes. | abricate, AMRFinder, prokka|
|`RunCopla.sh`|Runs COPLA in parallel on a list of genomes. |COPLA|
|`RunIqtree.sh`| Runs IQ-TREE in parallel for list of a plasmid clusters. |IQ-Tree|
|`RunMash.sh`|Calculate the mash edgelist for the plasmids | mash |
|`RunMobtyper.sh`|Runs MOB-typer in parallel for a list of plasmids. | MOB-typer
|`RunPanaroo.sh`| Runs panaroo in parallel for list of a plasmid clusters | panaroo |
|`UnicyclerNCBI.py`| Reformats assembly fasta headers for NCBI upload-compliant location/plasmid-name/topology/completeness | Python: Bio|
