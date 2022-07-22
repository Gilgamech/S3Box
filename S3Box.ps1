#Dropbox replacement
#Make it in PS, then compile into C#.

$bucketname = "gilgamech"
$listS3 = Get-S3Object -BucketName $bucketname
$installFolder = "C:\repos\website\"
$installFolder = $installFolder -replace "\\","\\"#The first pair is an escaped single slash, to clear regex. The second is an unescaped pair of slashes, as regex doesn't apply to the replacement pattern.

#Get list of files in each, recurse through directories.  
#Keep list from last time.
#- Format: 
	#Size: ls.Length -match s3.Size
	#LastModified: ls.LastWriteTime -match s3.LastModified 
	#Name: ls.Name -match s3.Key

#1. No files in this one, but files in other
#- Copy files to this one
#2. If a file in this one is newer than the other
#- Copy file to the other.
#3. If a file is in one but not the other
#- Copy to the other. 
#4. if a file is in this one's current list but not the old list
#- Delete it from other.
#5. if a file is in the other's current list but not the old list
#- Delete it from this one.
#At the end, they have to match, and then there's just one list to save for next time.

function Sync-Folder {
	#Run on each item in the folder, then iterate itself onto each folder.
	$listDir = ls -directory $installFolder
	$listFolder = ls -file $installFolder
	foreach ($file in $listFolder) {
		$key = $dir.FullName -replace $installFolder,""
		Write-S3Object -BucketName $bucketname -File $_.name -Key $key
		$s3file = $listS3 | where {$file.name -match $_.Key}
		$fileItem = get-item $file.name
		$fileItem.LastWriteTime = (get-date $s3file.LastModified)
		#$file.CreationTime = (get-date "7/10/2022 12:11 am")
	}
}

function test-iteration($int){
	write-host $int;$int++;
	if ($int -lt 3){
		$int = test-iteration $int
	}; 
	return $int
}


