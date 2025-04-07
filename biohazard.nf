nextflow.enable.dsl=2

// Write info to stdout about the current run
log.info """\
         biohazard-tools 
         ==========================
         run as       : ${workflow.commandLine}
         started at   : ${workflow.start}
         container    : ${workflow.containerEngine}:${workflow.container}
         """
         .stripIndent()


process bamDir {
    """
    bam-dir --help
    wget https://ftp.sra.ebi.ac.uk/vol1/analysis/ERZ004/ERZ004000/accepted_hits.bam

    bam-dir index accepted_hits.bam
    bam-dir lookup -f accepted_hits.bam VADER:27:C0A58ACXX:1:1102:1434:2091
    """
}

process bamFixpair {
    """
    bam-fixpair --help
    wget https://ftp.sra.ebi.ac.uk/vol1/analysis/ERZ004/ERZ004000/accepted_hits.bam

    bam-fixpair --quiet --output fixed_accepted_hits.bam accepted_hits.bam
    """
}

//process bamMangle {
//    """
//    bam-mangle \
//        $bam
//    """
//}

//process bamMeld {
//    """
//    bam-meld \
//        $bam
//    """
//}

//process bamRewrap {
//    """
//    bam-rewrap \
//        $bam
//    """
//}

process bamRmdup {
    """
    bam-rmdup --help

    wget https://ftp.sra.ebi.ac.uk/vol1/analysis/ERZ004/ERZ004000/accepted_hits.bam

    bam-rmdup accepted_hits.bam
    """
}
//
//process expound {
//    """
//    expound \
//        $bam
//    """
//}

process fastq2bam {
    """
    fastq2bam --help
    wget https://ftp.sra.ebi.ac.uk/vol1/fastq/SRR781/000/SRR7810700/SRR7810700_1.fastq.gz
    wget https://ftp.sra.ebi.ac.uk/vol1/fastq/SRR781/000/SRR7810700/SRR7810700_2.fastq.gz

    fastq2bam \
        --read-one SRR7810700_1.fastq.gz \
        --read-two SRR7810700_2.fastq.gz \
        --output SRR7810700.ubam
    """
}

workflow {
    bamDir()
    bamFixpair()
    bamRmdup()
    fastq2bam()
}