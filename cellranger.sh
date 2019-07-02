#!/bin/sh
#$ -S /bin/sh
#$ -l s_vmem=75G
#$ -l mem_req=75G
#-pe def_slot 8

<<COMMENT
usage: 
	qsub -l os7 -cwd cellranger.sh -i ID_NAME -r REFERENCE \
	-f FASTQS -e EXPECTCELLS
options:
	-i ... id name
	-r ... reference (GRCh38 or mm10)
	-f ... path to fastqs
	-e ... expected number of cells
description:
	analysis of fastqs by cellranger
COMMENT

ulimit -v unlimited
export PATH=~/10X_dir/tools/cellranger-3.0.2/:$PATH

while getopts i:r:f:e: OPT;do
        case $OPT in
                i )ID=$OPTARG #ID_NAME
                        ;;
                r )REF=$OPTARG #REFERENCE
                        ;;
                f )FASTQS=$OPTARG #path to fastqs
                        ;;
                e )EC=$OPTARG #expected number of cells
                        ;;
                *?)usage
                        ;;
        esac
done

cellranger count --id=${ID} \
		 --transcriptome=~/10X_dir/reference/${REF}/ \
		 --fastqs=~/10X_dir/${FASTQS} --expect-cells=${EC} \
		 --localcores=8 --localmem=90



