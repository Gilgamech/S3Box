#Dropbox replacement

#This line copies a folder's files to S3. Doesn't do subfolders yet.
ls $d -file |%{Write-S3Object -BucketName gilgamech -File $_.name}

#This line compares an S3 bucket contents to a folder.

