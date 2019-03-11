select * from survey limit 10;
 
SELECT question, 
COUNT(DISTINCT user_id) AS 'answers' 
FROM survey 
GROUP BY 1 
ORDER BY 2 DESC;

SELECT COUNT(DISTINCT user_id) 
FROM survey;

SELECT question, 
1.0 *  COUNT(DISTINCT user_id)/500 
	AS 'percentage answers' 
FROM survey 
GROUP BY 1;

SELECT * FROM quiz LIMIT 5;
SELECT * FROM home_try_on LIMIT 5;
SELECT * FROM purchase LIMIT 5;

SELECT 	
	DISTINCT q.user_id, 
	h.user_id IS NOT NULL AS 'is_home_try_on',
	h.number_of_pairs,
	p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q 
	LEFT JOIN home_try_on h 
		ON q.user_id = h.user_id 
	LEFT JOIN purchase p 
    		ON q.user_id = p.user_id 
LIMIT 10;




WITH funnel AS (
	SELECT 	
	  DISTINCT q.user_id, 
	  h.user_id IS NOT NULL AS 'is_home_try_on',
  	  h.number_of_pairs,
  	  p.user_id IS NOT NULL AS 'is_purchase'
	FROM quiz q 
	LEFT JOIN home_try_on h
	 ON q.user_id = h.user_id 
 	LEFT JOIN purchase p 
   	  ON q.user_id = p.user_id)
SELECT COUNT(DISTINCT user_id) as 'total users',
	  SUM(is_home_try_on) as 'total home tried', 
	  SUM(is_purchase) as 'total purchased'
FROM funnel;





WITH funnel AS (
  SELECT  
    DISTINCT q.user_id, 
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q 
    LEFT JOIN home_try_on h 
      ON q.user_id = h.user_id 
    LEFT JOIN purchase p 
      ON q.user_id = p.user_id)
SELECT	
  1.0 * COUNT(DISTINCT user_id)/
    1000 AS 'total users',
  1.0 * SUM(is_home_try_on)/
    1000 AS 'total home tried',
  1.0 * SUM(is_purchase)/
    1000 AS 'total purchased' 
FROM funnel;



with funnel as(select
q.user_id,
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs,
p.user_id is not null as 'is_purchase' 
from quiz as 'q' left join home_try_on as 'h' on q.user_id = h.user_id left join purchase as 'p' on q.user_id = p.user_id)
select sum(is_home_try_on) as 'Tryed_on', sum(is_purchase) as 'purchased', 1.0 *
sum(is_purchase)/sum(is_home_try_on) as 'pairs_purchased' from funnel ;



WITH funnel AS (
	SELECT  DISTINCT q.user_id, 
		h.user_id IS NOT NULL AS 'is_home_try_on',
		h.number_of_pairs,
    		p.user_id IS NOT NULL AS 'is_purchase'
	FROM quiz q 
		LEFT JOIN home_try_on h 
		ON q.user_id = h.user_id 
		LEFT JOIN purchase p 
		ON q.user_id = p.user_id)
SELECT  	
	COUNT(user_id)AS 'number of users',	
	number_of_pairs AS 'number of pairs', 
	SUM(is_purchase) AS 'sum of purchases', 
	1.0 *SUM(is_purchase) / COUNT(user_id) AS 'percent bought' 
FROM funnel 
WHERE number_of_pairs IS NOT NULL 
GROUP BY number_of_pairs;

WITH funnel AS (
  SELECT 
    DISTINCT q.user_id, 
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase',
    q.style
  FROM quiz q LEFT JOIN home_try_on h 
    ON q.user_id = h.user_id 
  LEFT JOIN purchase p 
    ON q.user_id = p.user_id)
SELECT  
	COUNT(user_id) AS 'number of user',	
	number_of_pairs, 
	SUM(is_purchase) AS 'sum of purchase', 
	1.0 *SUM(is_purchase) / COUNT(user_id) AS 'percent bought',
	style 
FROM funnel 
WHERE number_of_pairs IS NOT NULL 
AND (style LIKE "Men's Styles" 
  OR style LIKE "Women's Styles")
GROUP BY number_of_pairs, style 
ORDER BY 3 DESC;

SELECT 	
	style, 
	count(*) 
FROM quiz 
GROUP BY 1 
ORDER BY 2 DESC;

SELECT 
	style, 
	model_name, 
	color, 
	COUNT(*) AS 'number bought' 
FROM purchase 
GROUP BY 1,2,3 
ORDER BY 4 DESC 
LIMIT 3;

