/*
Suppose we have the following schema with two tables: Ads and Events
Ads
||ad_id || campaign_id ||status   ||
| 1     |  1            | active  |
| 2     |  1            | inactive|
| 3     |  1            | active  |
| 4     |  2            | active  |
| 5     |  2            | inactive|
| 6     |  2            | inactive|

Events
||event_id || ad_id || source   || event_type || date       || hour  ||
| xAbcd3    |  1    |  iOS      |  impression | 01/12/2020  |  13
| bf3VEc    |  1    |  iOS      |  impression | 01/12/2020  |  15
| bfE4gc    |  1    |  Android  |  click      | 14/12/2020  |  07
| hTeGs5    |  3    |  Web      |  conversion | 01/12/2020  |  12
| g5ht7f    |  3    |  Android  |  click      | 07/12/2020  |  23
| if5s3v    |  4    |  Web      |  conversion | 14/12/2020  |  08

event_type could be impression, click, conversion
Source could be iOS, Android or Web

For each question, give the answer and the SQL query that would answer the question
*/

------------------------
------- LEVEL 1  -------
------------------------
---1) The number of active ads.

SELECT COUNT(ad_id) FROM Ads WHERE status = "active"

--2) All active campaigns. (A campaign is active if there’s at least one active ad.)

SELECT campaign_id FROM Ads WHERE status = "active" 

--3) The number of events per each ad — ad_id, event_type, by event type.

SELECT Ads.ad_id, event_type, COUNT(event_id) FROM Ads 
FULL JOIN Events
USING (ad_id)
GROUP BY Ads.ad_id, event_type,

--4) The number of events over the last week per each active ad — broken down by event type and date (most recent first).

SELECT Ads.ad_id, COUNT(event_id) FROM Ads 
FULL JOIN Events
USING (ad_id)
WHERE status = "active" AND date > DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY Ads.ad_id

------------------------
------- LEVEL 2  -------
------------------------

--5) CTR (click-through rate) and  CVR (conversion rate) for each ad. 

WITH click AS (SELECT ad_id, COUNT(event_type) AS click 
               FROM Events WHERE event_type = "click" GROUP BY ad_id), 
     conversion AS (SELECT ad_id, COUNT(event_type) AS click 
               FROM Events WHERE event_type = "conversion" GROUP BY ad_id), 
     impression AS (SELECT ad_id, COUNT(event_type) AS click 
               FROM Events WHERE event_type = "impression" GROUP BY ad_id)
SELECT impression.ad_id, click.click/impression.impression AS CTR, conversion.conversion/impression.impression AS CVR
FROM impression INNER JOIN conversion USING (ad_id) click JOIN conversion USING (ad_id)

-- 6) Which day of the week is the best by activate ad?
-- Justify how you define "best"

-- 7) What is the best and the worst ad by campaign 
-- We want to see their CTR and CVR and the KPIs of the campaign
