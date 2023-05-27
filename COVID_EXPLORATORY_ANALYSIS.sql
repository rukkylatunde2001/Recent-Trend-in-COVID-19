
--Total cases and new cases in 2023
SELECT location , population, total_cases, new_cases,YEAR(date) AS year
FROM [COVID PROJECT].dbo.coviddata_Population
WHERE continent IS NOT NULL and YEAR(date) = '2023'
ORDER BY 1,2

--sum of new cases
SELECT location , population, MAX(total_cases) as totalcases, sum(new_cases) as newcases,YEAR(date) AS year
FROM [COVID PROJECT].dbo.coviddata_Population
WHERE continent IS NOT NULL and YEAR(date) = '2023'
GROUP BY location , population, YEAR(date) 
ORDER BY 1,2

--Total death and people vaccinated
SELECT pop.location,pop.population,
       SUM(CONVERT(int, pop.new_deaths)) AS totaldeaths,
       MAX(CONVERT(int, vac.people_fully_vaccinated)) AS peoplevaccinated, MAX(CONVERT(int, vac.people_fully_vaccinated))/pop.population*100 AS percentvaccinated,
	   YEAR(pop.date) AS year
FROM [COVID PROJECT].dbo.coviddata_Population pop
JOIN [COVID PROJECT].dbo.coviddata_vaccination vac
    ON pop.location = vac.location
    AND pop.date = vac.date
WHERE pop.continent IS NOT NULL and YEAR(POP.date) = '2023'
GROUP BY YEAR(pop.date), pop.location, pop.population
ORDER BY 1,2

--Total new cases and new deaths over the world
Select YEAR(date) AS year, SUM(new_cases) as newcases, SUM(cast(new_deaths as int)) as totaldeaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [COVID PROJECT].dbo.coviddata_Population
where continent is not null 
GROUP BY YEAR(date) 
order BY YEAR(date)

--Total death by continent
SELECT YEAR(date) AS year, continent, SUM(cast(new_deaths as int)) as totaldeaths, SUM(new_cases) as totalcases,SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [COVID PROJECT].dbo.coviddata_Population
WHERE continent IS NOT NULL
GROUP BY YEAR(date), continent
ORDER BY YEAR(date), totaldeaths desc


--Total new cases and new deaths over the world (2023)
Select YEAR(date) AS year, SUM(new_cases) as newcases, SUM(cast(new_deaths as int)) as totaldeaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [COVID PROJECT].dbo.coviddata_Population
where continent is not null and YEAR(date) = '2023'
GROUP BY YEAR(date) 
order BY YEAR(date)

SELECT location, MAX(total_cases) as totalcases, sum(new_cases) as newcases, date
FROM [COVID PROJECT].dbo.coviddata_Population
WHERE continent IS NOT NULL 
GROUP BY location, date 
ORDER BY 1,2

Select continent, location, date, SUM(new_cases) as newcases, SUM(new_deaths) as totaldeaths
FROM [COVID PROJECT].dbo.coviddata_Population
where continent is not null 
GROUP BY date, continent, location
order BY 1,2
