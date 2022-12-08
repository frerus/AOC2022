--pt1
SELECT TOP 1
Nmbr+3
FROM (	SELECT 
		S.value Nmbr
		,SUBSTRING(SUBSTRING(I.BulkColumn, S.value, 4),A.Value,1) pt1
		FROM OPENROWSET (BULK 'C:\Users\fredr\Documents\AOC22\06\input.txt', SINGLE_CLOB) I
			CROSS APPLY (SELECT value FROM GENERATE_SERIES ( 1, CAST(LEN(I.BulkColumn) AS INT) )) S 
			CROSS APPLY (SELECT value FROM GENERATE_SERIES ( 1, 4 )) A
			) X
GROUP BY Nmbr
HAVING COUNT(DISTINCT pt1) > 3

--pt2
SELECT TOP 1
Nmbr+13
FROM (	SELECT 
		S.value Nmbr
		,SUBSTRING(SUBSTRING(I.BulkColumn, S.value, 14),A.Value,1) pt1
		FROM OPENROWSET (BULK 'C:\Users\fredr\Documents\AOC22\06\input.txt', SINGLE_CLOB) I
			CROSS APPLY (SELECT value FROM GENERATE_SERIES ( 1, CAST(LEN(I.BulkColumn) AS INT) )) S 
			CROSS APPLY (SELECT value FROM GENERATE_SERIES ( 1, 14 )) A
			) X
GROUP BY Nmbr
HAVING COUNT(DISTINCT pt1) > 13
