activate-pheweb-py3.6

### Creating a working instance with sample data
pheweb phenolist glob --simple-phenocode 'tests/input_files/assoc-files/*'
pheweb phenolist unique-phenocode
pheweb phenolist read-info-from-association-files
pheweb phenolist import-phenolist -f pheno-list-categories.json tests/input_files/categories.csv
pheweb phenolist merge-in-info pheno-list-categories.json
pheweb phenolist verify --required-columns category

pheweb process

pheweb serve --port 5002
