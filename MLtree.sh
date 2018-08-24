sed s/"\."/\-/g final.fasta > final.tree.fasta 

raxml -f d -n MLtree -m GTRCAT -s final.tree.fasta -p 235