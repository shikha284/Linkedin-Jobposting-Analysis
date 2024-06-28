# Linkedin-Jobposting-Analysis
+ If changing column order in either eda.ipynb or create_schema.sql, change it in other file as well.
+ Post any changes done in eda.ipynb file,
  - clear all output
  - restart and run all code
  - commit your changes
+ Steps to generate staging_data
  - Copy all the data from https://www.kaggle.com/datasets/arshkon/linkedin-job-postings?select=job_postings.csv into raw_data. Refer the README in raw_data for more information.
  - Run the eda.ipynb script
   * Dependencies - matplotlib, pandas, numpy, csv
  - This should generate the staging files in staging_data
+ How to upload these staging files to MySQL workbench
  - Go to MySQL workbench.
  - Do the following on your connection to the DB in MySQL workbench. There is an insert restriction and it can be removed from MySQL Workbench 8.0 in the following way. Edit the connection, on the Connection tab, 
 go to the 'Advanced' sub-tab, and in the 'Others:' box add the line 'OPT_LOCAL_INFILE=1'. This should allow a client using the Workbench to run LOAD DATA INFILE as usual.
  - https://stackoverflow.com/questions/63361962/error-2068-hy000-load-data-local-infile-file-request-rejected-due-to-restrict
  - Open your workbench MySQL connection.
  - Run the create_schema.sql file. This will create database and tables in your server.
  - Open the importdb.sql file and make changes to the file path. Give your source file path from staging data.
  - Run the importdb.sql. This will insert data in your tables from the staging data.
  - Your DB is ready.
