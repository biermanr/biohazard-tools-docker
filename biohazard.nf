nextflow.enable.dsl=2

// Required inputs
params.sampleSheet = file_exists(param_set(params.sampleSheet,"--sampleSheet"))
params.outputDir = file(param_set(params.outputDir, "--outputDir"))


// Write info to stdout about the current run
log.info """\
         biohazard-tools 
         ==========================
         run as       : ${workflow.commandLine}
         started at   : ${workflow.start}
         container    : ${workflow.containerEngine}:${workflow.container}
         """
         .stripIndent()

//
//process bam-dir {
//    input:
//        ???
//    output:
//        ???
//    """
//    bam-dir \
//        $bam
//    """
//}
//
//process bam-fixpair {
//    input:
//        ???
//    output:
//        ???
//    """
//    bam-fixpair \
//        $bam
//    """
//}
//
//process bam-mangle {
//    input:
//        ???
//    output:
//        ???
//    """
//    bam-mangle \
//        $bam
//    """
//}
//
//process bam-meld {
//    input:
//        ???
//    output:
//        ???
//    """
//    bam-meld \
//        $bam
//    """
//}
//
//process bam-rewrap {
//    input:
//        ???
//    output:
//        ???
//    """
//    bam-rewrap \
//        $bam
//    """
//}
//
//process bam-rmdup {
//    input:
//        ???
//    output:
//        ???
//    """
//    bam-rmdup \
//        $bam
//    """
//}
//
//process expound {
//    input:
//        ???
//    output:
//        ???
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
    fastq2bam()
}