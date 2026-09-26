# Where do French residents report the highest wellbeing? (ESS 2002-2023)

My second SQL project. I cleaned and queried the European Social Survey to compare self-reported happiness and life satisfaction across residential areas in France, building on earlier writing about infrastructure, land use and mental health.

## Data
- Source: [European Social Survey](https://www.europeansocialsurvey.org/data-portal), rounds 1-11 (2002-2023)
- 530,711 respondents across Europe, filtered to 20,809 French respondents
- The data file is not included here because of its size. Download it from the ESS data portal.

## What I did
- Planned to use a transport satisfaction variable, found it covered under 10% of French respondents (2,010 of 20,809), and pivoted to residential area as a proxy
- Excluded refusals (77) and "don't know" answers (88) from the wellbeing variables before averaging
- Compared average happiness and life satisfaction (both 0-10 scales) across five residential categories
- Checked whether the pattern holds in both early (2002-2008) and recent (2018-2023) survey rounds

## Findings
| Residential area | n | Happiness | Life satisfaction |
|---|---|---|---|
| Suburbs or outskirts of big city | 2,560 | 7.33 | 6.64 |
| Country village | 6,209 | 7.29 | 6.51 |
| Farm or home in countryside | 1,287 | 7.21 | 6.58 |
| Big city | 3,797 | 7.18 | 6.43 |
| Town or small city | 6,857 | 7.14 | 6.36 |

Suburban residents reported the highest wellbeing on both measures and town residents the lowest, in both early and recent survey rounds.

## Limitations
- Residential area is a proxy, not a measure of transport quality
- Happiness and life satisfaction are subjective wellbeing scales, not clinical instruments
- Figures are unweighted
- Differences are modest and have not been tested for statistical significance

## Related reading
Conceição et al. (2023), The effect of transport infrastructure, congestion and reliability on mental wellbeing: a systematic review of empirical studies, *Transport Reviews*. [doi.org/10.1080/01441647.2022.2100943](https://doi.org/10.1080/01441647.2022.2100943)

## Tools
SQL · DB Browser for SQLite

## Files
- `ess_wellbeing_by_area.sql`: coverage check, main analysis and time-period check, with comments
