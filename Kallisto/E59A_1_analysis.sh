kallisto quant -i /ddn/gs1/home/li11/refDB/mm10/kallistoIndex/kallistoMM10  -o /ddn/gs1/home/li11/project2021/RNAProj/results/Kallisto/E59A_1.kallisto  <(zcat -c /ddn/gs1/home/li11/project2021/RNAProj/rawData/usftp21.novogene.com/raw_data/E59A_1/E59A_1_1.fq.gz ) <(zcat -c /ddn/gs1/home/li11/project2021/RNAProj/rawData/usftp21.novogene.com/raw_data/E59A_1/E59A_1_2.fq.gz ) 





#salmon quant -i /ddn/gs1/home/li11/refDB/mm10/salmonIndex/mm10_salmon_index  -l MU -1 <(zcat -c /ddn/gs1/home/li11/project2021/RNAProj/rawData/usftp21.novogene.com/raw_data/E59A_1/E59A_1_1.fq.gz ) -2 <(zcat -c /ddn/gs1/home/li11/project2021/RNAProj/rawData/usftp21.novogene.com/raw_data/E59A_1/E59A_1_2.fq.gz ) -o /ddn/gs1/home/li11/project2021/RNAProj/results/Salmon/E59A_1.salmon 

