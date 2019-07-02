#!/bin/sh
#$ -S /bin/sh
#$ -l s_vmem=48G
#$ -l mem_req=48G
#-pe def_slot 4

<<COMMENT
usage: qsub -l os7 -cwd preparation.sh
execute in your 10X directory
COMMENT

mkdir tools
cd tools
wget -O cellranger-3.0.2.tar.gz "http://cf.10xgenomics.com/releases/cell-exp/cellranger-3.0.2.tar.gz?Expires=1562030772&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9jZWxsLWV4cC9jZWxscmFuZ2VyLTMuMC4yLnRhci5neiIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTU2MjAzMDc3Mn19fV19&Signature=eotQfzfJo6ebf6Y~erxL9qxtpoMDiQn2tw3r4RRT2JspqS4lOuST9HCAf1OGAOfiVWxLuUxPXJJVzztthX0Wwh7k2~MNvhyGNBkLgkERXUjvtAP6PsQEzM8xV~aGbpllbI63Dz0vgA~hLArwVg62jKhU3Jiz-KEtxu3jxvJtgjIoAL6wQa-ZGb4Z-fB~YXDGRcEkuAlQJy70cHl0qK42RN0ARsIiTvY~-nMNYGucVof~4WD3RieBoV2kWPe78mGPqk0DQNOmvqwp18NlXrCcmMnJM2CiJgv3rUyELmEdkN-zvdwHbFZasVOi-7iZymVa6T-I7iUOWurLzrAZjiANUQ__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"
tar -xzvf cellranger-3.0.2.tar.gz
cd ../

mkdir reference
cd reference
wget http://cf.10xgenomics.com/supp/cell-exp/refdata-cellranger-GRCh38-3.0.0.tar.gz
tar -xzvf refdata-cellranger-GRCh38-3.0.0.tar.gz

wget ftp://ftp.ensembl.org/pub/release-93/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
gunzip Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz


wget ftp://ftp.ensembl.org/pub/release-93/gtf/homo_sapiens/Homo_sapiens.GRCh38.93.gtf.gz
gunzip Homo_sapiens.GRCh38.93.gtf.gz

export PATH=/home/tissei/tmp_10X/tools/cellranger-3.0.2:$PATH

cellranger mkgtf Homo_sapiens.GRCh38.93.gtf Homo_sapiens.GRCh38.93.filtered.gtf \
                 --attribute=gene_biotype:protein_coding \
                 --attribute=gene_biotype:lincRNA \
                 --attribute=gene_biotype:antisense \
                 --attribute=gene_biotype:IG_LV_gene \
                 --attribute=gene_biotype:IG_V_gene \
                 --attribute=gene_biotype:IG_V_pseudogene \
                 --attribute=gene_biotype:IG_D_gene \
                 --attribute=gene_biotype:IG_J_gene \
                 --attribute=gene_biotype:IG_J_pseudogene \
                 --attribute=gene_biotype:IG_C_gene \
                 --attribute=gene_biotype:IG_C_pseudogene \
                 --attribute=gene_biotype:TR_V_gene \
                 --attribute=gene_biotype:TR_V_pseudogene \
                 --attribute=gene_biotype:TR_D_gene \
                 --attribute=gene_biotype:TR_J_gene \
                 --attribute=gene_biotype:TR_J_pseudogene \
                 --attribute=gene_biotype:TR_C_gene


cellranger mkref --genome=GRCh38 \
                 --fasta=Homo_sapiens.GRCh38.dna.primary_assembly.fa \
                 --genes=Homo_sapiens.GRCh38.93.filtered.gtf \
                 --ref-version=3.0.0

wget ftp://ftp.ensembl.org/pub/release-93/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.primary_assembly.fa.gz
gunzip Mus_musculus.GRCm38.dna.primary_assembly.fa.gz


wget ftp://ftp.ensembl.org/pub/release-93/gtf/mus_musculus/Mus_musculus.GRCm38.93.gtf.gz
gunzip Mus_musculus.GRCm38.93.gtf.gz


cellranger mkgtf Mus_musculus.GRCm38.93.gtf Mus_musculus.GRCm38.93.filtered.gtf \
                 --attribute=gene_biotype:protein_coding \
                 --attribute=gene_biotype:lincRNA \
                 --attribute=gene_biotype:antisense \
                 --attribute=gene_biotype:IG_LV_gene \
                 --attribute=gene_biotype:IG_V_gene \
                 --attribute=gene_biotype:IG_V_pseudogene \
                 --attribute=gene_biotype:IG_D_gene \
                 --attribute=gene_biotype:IG_J_gene \
                 --attribute=gene_biotype:IG_J_pseudogene \
                 --attribute=gene_biotype:IG_C_gene \
                 --attribute=gene_biotype:IG_C_pseudogene \
                 --attribute=gene_biotype:TR_V_gene \
                 --attribute=gene_biotype:TR_V_pseudogene \
                 --attribute=gene_biotype:TR_D_gene \
                 --attribute=gene_biotype:TR_J_gene \
                 --attribute=gene_biotype:TR_J_pseudogene \
                 --attribute=gene_biotype:TR_C_gene


cellranger mkref --genome=mm10 \
                 --fasta=Mus_musculus.GRCm38.dna.primary_assembly.fa \
                 --genes=Mus_musculus.GRCm38.93.filtered.gtf \
                 --ref-version=3.0.0


