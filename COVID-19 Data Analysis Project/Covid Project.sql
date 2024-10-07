
--Select *
--From PortfolioProject..CovidVaccinations$
-- order by 3,4

-- Select Data that we are going to be using 
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
order by 1,2 -- based off location and date

-- Looking at Total Cases vs Total Deaths 
-- (total_deaths / total_cases) * 100 as DeathPercentage - gets death rate 
-- Shows likelhood of dying if you contarct covid in your country 

Select Location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 as DeathPercentage
From PortfolioProject..CovidDeaths$
--where location like '%states%'
order by 1,2

-- Looking at Total cases vs Population
-- Shows what percentage of population got Covid

Select Location, date, total_cases, Population,(total_cases / population) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--where location like '%states%'
order by 1,2


-- Looking for Countries with Highest Infection Rate Compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,MAX((total_cases / population)) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--where location like '%states%'
where continent is not null 
Group by Location
order by TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT 

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--where location like '%states%'
where continent is not null 
Group by continent
order by TotalDeathCount desc

-- Showing contintents with the highest death count per populaiton
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--where location like '%states%'
where continent is not null 
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS 
-- Global Cases, Deaths and Death Rates per day 

select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(New_cases) as DeathPercentage
From PortfolioProject..CovidDeaths$
where continent is not null
Group By date
order by 1,2 


-- Global Cases, Deaths and Death Rate per year

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(New_cases) as DeathPercentage
From PortfolioProject..CovidDeaths$
where continent is not null
order by 1,2 


-- Looking at Total Population vs Vaccinations
-- Looking at Countries Vacciantion Rate per day 

-- with CTE
with PopvsVac (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)

Select *, (RollingPeopleVaccinated/Population)* 100
From PopvsVac


-- ANOTHER WAY: Looking at Countries Vacciantion Rate per day with TEMP TABLE 

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated 
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime, 
Population numeric, 
New_vacciantions numeric,
RollingpeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3


Select *, (RollingPeopleVaccinated/Population)* 100
From #PercentPopulationVaccinated

-- Creating view to store data for later visualizations

Create View PercentPopulationVaccinated as  
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *
From PercentPopulationVaccinated