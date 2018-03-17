##This code was obtained here : http://biom-format.org
#To install the latest release of the biom-format Python package:
pip install numpy
pip install biom-format

#To work with BIOM 2.0+ files:
pip install h5py

#To see a list of all biom commands, run:
biom

#To enable Bash tab completion of biom commands, add the following line to $HOME/.bashrc (if on Linux) or $HOME/.bash_profile (if on Mac OS X):
eval "$(_BIOM_COMPLETE=source biom)"

##This code was obtained here : http://phinchconversion.pitchinteractive.com
#convert qiime biom file to biom file in json format
biom convert -i otu_table.biom -o otu_table_json.biom --table-type="OTU table" --to-json