SELECT 
SUM(CASE WHEN (frstfrst>=scndfrst AND frstscnd <= scndscnd) OR (scndfrst >= frstfrst AND scndscnd <= frstscnd) THEN 1 ELSE 0 END) Pt1
,SUM(CASE WHEN (frstfrst <= scndscnd AND frstfrst >= scndfrst) OR (frstfrst <= scndscnd AND scndfrst <= frstscnd) THEN 1 ELSE 0 END) Pt2
FROM (SELECT 
	 CAST(SUBSTRING(X.frst,1,CHARINDEX('-' ,X.frst)-1) AS INT) frstfrst
	,CAST(SUBSTRING(X.frst,CHARINDEX('-' ,X.frst)+1,LEN(X.frst)) AS INT) frstscnd
	,CAST(SUBSTRING(X.scnd,1,CHARINDEX('-' ,X.scnd)-1) AS INT) scndfrst
	,CAST(SUBSTRING(X.scnd,CHARINDEX('-' ,X.scnd)+1,LEN(X.frst)) AS INT) scndscnd
	FROM (SELECT SUBSTRING(col1, 1,CHARINDEX(',', col1)-1) frst, SUBSTRING(col1, CHARINDEX(',', col1)+1, LEN(col1)) scnd  FROM DATA A) X
	) AOC


	 