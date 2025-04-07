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


process bam-dir {
    """
    bam-dir --help
    wget https://ftp.sra.ebi.ac.uk/vol1/analysis/ERZ004/ERZ004000/accepted_hits.bam

    bam-dir index accepted_hits.bam
    bam-dir lookup -f accepted_hits.bam VADER:27:C0A58ACXX:1:1102:1434:2091
    """
}

process bam-fixpair {
    """
    bam-fixpair --help
    wget https://ftp.sra.ebi.ac.uk/vol1/analysis/ERZ004/ERZ004000/accepted_hits.bam

    bam-fixpair --quiet --output fixed_accepted_hits.bam accepted_hits.bam
    """
}

//process bam-mangle {
//    """
//    bam-mangle \
//        $bam
//    """
//}

//process bam-meld {
//    """
//    bam-meld \
//        $bam
//    """
//}

//process bam-rewrap {
//    """
//    bam-rewrap \
//        $bam
//    """
//}

process bam-rmdup {
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

    wget https://ftp.sra.ebi.ac.uk/vol1/fastq/SRR325/008/SRR32596108/SRR32596108_1.fastq.gz
    wget https://ftp.sra.ebi.ac.uk/vol1/fastq/SRR325/008/SRR32596108/SRR32596108_2.fastq.gz

    fastq2bam \
        --read-one SRR32596108_1.fastq.gz \
        --read-two SRR32596108_2.fastq.gz \
        --output SRR32596108.ubam
    """
}

workflow {
    bam-dir()
    bam-fixpair()
    bam-rmdup()
    fastq2bam()
}