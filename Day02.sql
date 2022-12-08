WITH YAS AS (
SELECT 'A' as col1, 'X' as col2, 1+3 as res1, 3+0 as res2  UNION ALL 
SELECT 'A' as col1, 'Y' as col2, 2+6 as res1, 1+3 as res2  UNION ALL 
SELECT 'A' as col1, 'Z' as col2, 3+0 as res1, 2+6 as res2  UNION ALL 
SELECT 'B' as col1, 'X' as col2, 1+0 as res1, 1+0 as res2  UNION ALL 
SELECT 'B' as col1, 'Y' as col2, 2+3 as res1, 2+3 as res2  UNION ALL 
SELECT 'B' as col1, 'Z' as col2, 3+6 as res1, 3+6 as res2  UNION ALL 
SELECT 'C' as col1, 'X' as col2, 1+6 as res1, 2+0 as res2  UNION ALL 
SELECT 'C' as col1, 'Y' as col2, 2+0 as res1, 3+3 as res2  UNION ALL 
SELECT 'C' as col1, 'Z' as col2, 3+3 as res1, 1+6 as res2 			 
)

SELECT SUM(res1) res1, SUM(res2) res2
FROM #DATA D
	INNER JOIN YAS Y
		ON D.col1 = Y.col1
		AND D.col2 = Y.col2
