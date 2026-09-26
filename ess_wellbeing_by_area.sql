-- ============================================================
-- Where do French residents report the highest wellbeing?
-- European Social Survey (ESS), rounds 1-11, 2002-2023
-- 530,711 respondents across Europe; 20,809 in France
-- Shiloh Ayala · SQL · DB Browser for SQLite
-- Data: https://www.europeansocialsurvey.org/data-portal
-- Note: all figures are unweighted.
-- ============================================================
--
-- Variables used (table: ess)
--   cntry     country ('FR' = France)
--   essround  survey round (1 = 2002 ... 11 = 2023)
--   domicil   area where you live: 1 big city, 2 suburbs or
--             outskirts of big city, 3 town or small city,
--             4 country village, 5 farm or home in countryside
--   happy     how happy are you (0-10)
--   stflife   how satisfied with life as a whole (0-10)
--   poltran   transport satisfaction variable, dropped: under
--             10% coverage for French respondents
--
-- Codes excluded at analysis time: 77 = refusal,
-- 88 = don't know. domicil 7/8 (refusal/don't know) excluded
-- by keeping only codes 1-5.


-- ------------------------------------------------------------
-- 1. COVERAGE CHECK
-- Why the transport variable was dropped: share of French
-- respondents with an answer.
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS french_respondents,
    SUM(CASE WHEN poltran IS NOT NULL AND poltran <> '' THEN 1 ELSE 0 END) AS answered_poltran,
    SUM(CASE WHEN poltran IS NOT NULL AND poltran <> '' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pct_answered
FROM ess
WHERE cntry = 'FR';


-- ------------------------------------------------------------
-- 2. MAIN ANALYSIS
-- Average happiness and life satisfaction by residential area.
-- n added so group sizes are visible.
-- Result: suburbs highest on both (7.33 / 6.64),
-- town or small city lowest on both (7.14 / 6.36).
-- ------------------------------------------------------------

SELECT
    domicil,
    COUNT(*) AS n,
    AVG(CAST(happy AS FLOAT)) AS avg_happy,
    AVG(CAST(stflife AS FLOAT)) AS avg_stflife
FROM ess
WHERE cntry = 'FR'
  AND domicil IN ('1', '2', '3', '4', '5')
  AND happy NOT IN ('77', '88')
  AND stflife NOT IN ('77', '88')
GROUP BY domicil
ORDER BY avg_happy DESC;


-- ------------------------------------------------------------
-- 3. ROBUSTNESS CHECK: DOES POOLING 20 YEARS DRIVE THE RESULT?
-- Same averages, early rounds (1-4, 2002-2008) vs recent
-- rounds (9-11, 2018-2023). Added during portfolio review.
-- ------------------------------------------------------------

SELECT
    CASE WHEN CAST(essround AS INTEGER) <= 4 THEN '2002-2008'
         ELSE '2018-2023' END AS period,
    domicil,
    COUNT(*) AS n,
    AVG(CAST(happy AS FLOAT)) AS avg_happy,
    AVG(CAST(stflife AS FLOAT)) AS avg_stflife
FROM ess
WHERE cntry = 'FR'
  AND domicil IN ('1', '2', '3', '4', '5')
  AND happy NOT IN ('77', '88')
  AND stflife NOT IN ('77', '88')
  AND (CAST(essround AS INTEGER) <= 4 OR CAST(essround AS INTEGER) >= 9)
GROUP BY period, domicil
ORDER BY period, avg_happy DESC;
