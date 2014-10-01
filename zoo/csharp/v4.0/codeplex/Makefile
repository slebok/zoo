extract:

fetch:
	rm -rf fetched/*
	curl 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=antlrcsharp&DownloadId=128258&FileTime=129215632402130000&Build=20941' > fetched.zip
	unzip fetched.zip
	mv UnitTest/cs.g fetched/
	rm -rf UnitTest browse fetched.zip
