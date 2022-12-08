DECLARE @BulkColumn VARCHAR(max)
SELECT @BulkColumn = REPLACE(BulkColumn, NCHAR(10),'|') FROM OPENROWSET (BULK 'C:\Users\fredr\Documents\AOC22\07\input.txt', SINGLE_CLOB) I

;WITH BASE AS (
SELECT ROW_NUMBER() OVER( ORDER BY (SELECT 1)) RN, value Operation FROM STRING_SPLIT (@BulkColumn,'|'))

,STRUKTUR AS(
SELECT RN ,Operation,TRY_CAST(LEFT(Operation, CHARINDEX(' ',Operation)) AS INT) Verdi,CAST('root' AS VARCHAR(MAX)) Path
FROM BASE
WHERE RN=1
UNION ALL
SELECT B.RN ,B.Operation
,TRY_CAST(LEFT(B.Operation, CHARINDEX(' ',B.Operation)) AS INT) Verdi
,CASE WHEN B.Operation = '$ cd ..' THEN LEFT(S.Path, LEN(S.Path)-CHARINDEX('/',RIGHT(REVERSE(S.Path), LEN(S.Path))))
	  WHEN LEFT(B.Operation,4) = '$ cd' THEN S.Path + '/' + RIGHT(B.Operation,LEN(B.Operation)-5) 
	  ELSE S.Path END as Path
FROM BASE B
	INNER JOIN STRUKTUR S
		ON B.RN = S.RN+1)

,grpd AS (
SELECT SUM(Verdi) Verdi, Path FROM STRUKTUR GROUP BY Path)

,dirs AS (
SELECT 
k.Path, SUM(d.Verdi) Verdi
FROM grpd d
	LEFT JOIN grpd k 
		ON d.Path LIKE k.Path +'%'
GROUP BY K.Path)

SELECT TOP 1 Verdi pt2, x.value as pt1 FROM DIRS 
	CROSS JOIN
		(SELECT SUM(Verdi) value
		 FROM dirs d
		 WHERE d.Verdi <=100000) X 
WHERE Verdi > (SELECT 30000000-(70000000-Verdi) FROM DIRS WHERE Path = 'root') 
ORDER BY VERDI ASC

OPTION (MAXRECURSION 0)