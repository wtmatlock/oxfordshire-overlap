from Bio import SeqIO


file = open("/Users/willmatlock/Desktop/complete_assemblies.txt", 'r')
samples = file.readlines()
file.close()
samples = [s.strip() for s in samples]

for i in range(len(samples)):
    sample = samples[i]
    assembly = r"/Users/willmatlock/Desktop/to-upload/{}.fasta".format(sample)
    processed = r"/Users/willmatlock/Desktop/processed/{}.fasta".format(sample)
    with open(assembly) as a, open(processed, 'w') as p:
        records = SeqIO.parse(a, 'fasta')
        for record in records:
            record.description = ""
            if record.id=="1":
                print(record.id + " " + "[location=chromosome][topology=circular][completeness=complete]")
                record.id = record.id + " " + "[location=chromosome][topology=circular][completeness=complete]"
            else:
                name = str(int(record.id)-1)
                print(record.id + " " + "[plasmid-name=unnamed{}][topology=circular][completeness=complete]".format(name))
                record.id = record.id + " " + "[plasmid-name=unnamed{}][topology=circular][completeness=complete]".format(name)
            SeqIO.write(record, p, 'fasta')
    a.close()
    p.close()


