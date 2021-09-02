#################################################### ordre #########################################

SELECT fullvisitorid, SUM(totals.visits) #selection
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX = '20161201' #conditions
GROUP BY fullvisitorid #aggregation
HAVING SUM(totals.visits) > 0 #filtre
UNION ALL #concatenation / jointure
SELECT fullvisitorid, SUM(totals.visits)
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX = '20161202'
GROUP BY fullvisitorid
ORDER BY fullvisitorid

########################################### selection ########################################

SELECT DISTINCT fullvisitorid, device.deviceCategory
CASE 
    WHEN device.deviceCategory = "desktop" THEN 1 
    WHEN device.deviceCategory = "tablet" THEN 2 ELSE 3 END, 
10 AS dix
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201` 

##################################### conditions ###############################################

SELECT DISTINCT fullvisitorid, device.deviceCategory
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201` 
WHERE device.deviceCategory = "desktop" #egale

SELECT DISTINCT fullvisitorid, device.deviceCategory
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201` 
WHERE device.deviceCategory <> "desktop" #different

SELECT DISTINCT fullvisitorid, device.deviceCategory
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201` 
WHERE device.deviceCategory != "desktop" #different

SELECT DISTINCT fullvisitorid, device.deviceCategory
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201` 
WHERE device.deviceCategory IN ("mobile", "tablet") #parmis

SELECT DISTINCT fullvisitorid, device.deviceCategory
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201` 
WHERE ( device.deviceCategory LIKE "le%" OR device.deviceCategory LIKE "%le" #commence par ... ou fini par ...
OR device.deviceCategory LIKE "%le%" ) AND device.deviceCategory NOT LIKE "d%k" #ou contient ... et ne commence et fini par ...

SELECT DISTINCT fullvisitorid, date
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX > '20161201' ORDER BY date #superieur à

SELECT DISTINCT fullvisitorid, date
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX >= '20161201' ORDER BY date #superieur ou egal à

SELECT DISTINCT fullvisitorid, date
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX < '20161201' ORDER BY date DESC #inferieur à

SELECT DISTINCT fullvisitorid, date
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX <= '20161201' ORDER BY date DESC #inferieur à

SELECT DISTINCT fullvisitorid, date
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE _TABLE_SUFFIX BETWEEN '20161201' AND '20161203' ORDER BY date #entre

SELECT DISTINCT fullvisitorid
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201`AS ga, 
UNNEST(ga.hits) AS hits 
WHERE hits.transaction.transactionId IS NULL #est vide

SELECT DISTINCT fullvisitorid
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201`AS ga, 
UNNEST(ga.hits) AS hits 
WHERE hits.transaction.transactionId IS NOT NULL #n'est pas vide

################################# aggregation ############################################

SELECT fullvisitorid, 
SUM(totals.visits) #somme
ROUND(AVG(totals.visits),2) #moyenne arrondie
COUNT(DISTINCT device.deviceCategory) #compte
MIN(date), #minimum
MAX(date), #maximum
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201612*` 
GROUP BY fullvisitorid

###################################### filtre ################################################

SELECT fullvisitorid, SUM(totals.visits) AS visits
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201612*` 
GROUP BY fullvisitorid
HAVING SUM(totals.visits) >= 2
ORDER BY visits DESC

############################################ concatenation #######################################

SELECT DISTINCT fullvisitorid, 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161224` 
UNION ALL
SELECT DISTINCT fullvisitorid, 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161225`

SELECT DISTINCT fullvisitorid, 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161224` 
INTERSECT DISTINCT
SELECT DISTINCT fullvisitorid, 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161225` 

SELECT DISTINCT fullvisitorid, 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161224` 
EXCEPT DISTINCT
SELECT DISTINCT fullvisitorid, 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161225` 

######################################## jointure ############################################

WITH visits AS (
SELECT fullvisitorid, SUM(totals.visits) AS visits
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`
GROUP BY fullvisitorid),
transactions AS (
SELECT fullvisitorid, COUNT(DISTINCT hits.transaction.transactionId) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`AS ga, 
UNNEST(ga.hits) AS hits WHERE  hits.transaction.transactionId IS NOT NULL
GROUP BY fullvisitorid)
SELECT visits.fullvisitorid, visits.visits, transactions.transactions  FROM visits
INNER JOIN  transactions
USING (fullvisitorid) # ON visits.fullvisitorid = transactions.fullvisitorid

WITH visits AS (
SELECT fullvisitorid, SUM(totals.visits) AS visits
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`
GROUP BY fullvisitorid),
transactions AS (
SELECT fullvisitorid, COUNT(DISTINCT hits.transaction.transactionId) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`AS ga, 
UNNEST(ga.hits) AS hits WHERE  hits.transaction.transactionId IS NOT NULL
GROUP BY fullvisitorid)
SELECT visits.fullvisitorid, visits.visits, transactions.transactions  FROM visits
LEFT JOIN  transactions #LEFT OUTER JOIN
USING (fullvisitorid)

WITH visits AS (
SELECT fullvisitorid, SUM(totals.visits) AS visits
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`
GROUP BY fullvisitorid),
transactions AS (
SELECT fullvisitorid, COUNT(DISTINCT hits.transaction.transactionId) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`AS ga, 
UNNEST(ga.hits) AS hits WHERE  hits.transaction.transactionId IS NOT NULL
GROUP BY fullvisitorid)
SELECT visits.fullvisitorid, visits.visits, transactions.transactions  FROM visits
RIGHT JOIN  transactions #RIGHT OUTER JOIN
USING (fullvisitorid) 

WITH visits AS (
SELECT fullvisitorid, SUM(totals.visits) AS visits
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`
GROUP BY fullvisitorid),
transactions AS (
SELECT fullvisitorid, COUNT(DISTINCT hits.transaction.transactionId) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2016*`AS ga, 
UNNEST(ga.hits) AS hits WHERE  hits.transaction.transactionId IS NOT NULL
GROUP BY fullvisitorid)
SELECT visits.fullvisitorid, visits.visits, transactions.transactions  FROM visits
FULL JOIN  transactions #FULL OUTER JOIN
USING (fullvisitorid)

WITH 
visitors AS (SELECT DISTINCT fullvisitorid FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201`),
products AS (SELECT DISTINCT hp.v2ProductName AS product FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
             AS ga, UNNEST(ga.hits) AS hits, UNNEST(hits.product) AS hp )

SELECT fullvisitorid, product FROM visitors CROSS JOIN products #FROM visitors, products 

#############################################################################################

SELECT DISTINCT CONCAT("ID",fullvisitorid) AS fullvisitorid, device.deviceCategory,
LENGTH(device.deviceCategory),
LEFT(device.deviceCategory,1), 
RIGHT(device.deviceCategory,1),
UPPER(device.deviceCategory),
LOWER(UPPER(device.deviceCategory)),
LPAD(device.deviceCategory,10,"0"),
RPAD(device.deviceCategory,10,"0"),
LTRIM(LPAD(device.deviceCategory,10,"0"),"0"),
RTRIM(RPAD(device.deviceCategory,10,"0"),"0"),
TRIM(device.deviceCategory,"e"),
REPLACE(device.deviceCategory,"e","o"),
REVERSE(device.deviceCategory),
SUBSTR(device.deviceCategory,1, 2),
SUBSTR(device.deviceCategory,3),
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20161201`
