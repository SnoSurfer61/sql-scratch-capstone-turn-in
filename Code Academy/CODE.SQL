

/*CAPSTONE:ATTRIBUTION*/


/*Question 1. Answers*/

/*Presentation Slide 3 Data*/
/* 1. utm_campaigns
*/
SELECT DISTINCT utm_campaign
FROM page_visits
GROUP BY utm_campaign
;

/*Presentation Slide 4 Data*/
/* 1. utm_sources
*/
SELECT DISTINCT utm_source
FROM page_visits
GROUP BY utm_source
;

/*Presentation Slide 5 Data*/
/* 1. Campaign and Source Relationship*/
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits
GROUP BY utm_campaign, utm_source
;

/*Question 2 Answer And Presentation Slide 6 Data*/

/* 2. pages*/
SELECT DISTINCT page_name
FROM page_visits
GROUP BY page_name
;

/*Question 3 Answer And Presentation Slide 8 Data*/

/*3.  First Touches*/
WITH first_touch AS 
(
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id
)
SELECT pv.utm_campaign,
     COUNT (ft.first_touch_at)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
;

/*Question 4 Answer And Presentation Slide 9 Data*/

/*4. Last Touches*/
WITH last_touch AS 
(
    SELECT user_id,
         MAX(timestamp) as last_touch_at   
    FROM page_visits
    GROUP BY user_id
)
SELECT pv.utm_campaign,
             pv.utm_source,
    COUNT (lt.last_touch_at)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign,
                    pv.utm_source
;

/*Question 5 Answer and Presentation Slide 11*/
/*5. Purchases made */

SELECT  COUNT (page_name)
   AS num_of_purchases
FROM page_visits
WHERE page_name = '4 - purchase'
;

/*Presentation Slide 11 Code*/

SELECT  COUNT(utm_source)
   AS num_of_checkouts
   FROM page_visits
 WHERE page_name = '2 - shopping_cart'
 order by utm_source
;

SELECT  COUNT(utm_source)
   AS num_of_landing_page
   FROM page_visits
 WHERE page_name = '1 - landing_page'
 ORDER BY  utm_source
;

SELECT  COUNT(utm_source)
   AS num_of_checkout
   FROM page_visits
 WHERE page_name = '3 - checkout' and 
 ORDER BY  utm_source
;

/*Question 6 Answer and Presentation Slide 10 Data*/

/*Purchase Page Last Touches*/
   WITH last_touch AS
(
   SELECT user_id,
       MAX(timestamp) as last_touch_at
   FROM page_visits
   GROUP BY user_id
)
SELECT pv.utm_campaign,
     COUNT(lt.last_touch_at)
FROM last_touch AS lt
JOIN page_visits AS pv
    ON  lt.user_id = pv.user_id
    AND lt.last_touch_as = pv.timestamp
WHERE page_name = ‘4 – purchase’
GROUP BY pv.utm_campaign
;
