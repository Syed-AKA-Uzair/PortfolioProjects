select * from portfolioproject..CovidDeaths
order by 3,4

--select * from portfolioproject..CovidVaccinations
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population 
from portfolioproject..CovidDeaths
order by 1,2

-- Likelihood of death due to COVID in a country | (Deaths vs Cases)
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
from portfolioproject..CovidDeaths
where location like '%India%'
order by 1,2

-- Total Cases vs Population
select location, date, population, total_cases, (total_cases/population)*100 as InfectionRate 
from portfolioproject..CovidDeaths
--where location like '%India%'
order by 1,2

--Looking at Countries with highest Infection Rate in comparison to Population
select location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population)*100) as PercentPopulationInfected 
from portfolioproject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected Desc

-- Countries with Highest Death Count Per Population 
select location, Max(cast(total_deaths as bigint)) as TotalDeathCount from portfolioproject..CovidDeaths
Where continent is not NULL Group by Location
order by TotalDeathCount Desc

--Continents with Highest Death Count
select continent, Max(cast(total_deaths as bigint)) as TotalDeathCount from portfolioproject..CovidDeaths
Where continent is not NULL 
Group by continent
order by TotalDeathCount Desc

--Global Numbers
select date, Sum(cast(new_cases as bigint)) as TotalCasesPerDay, Sum(cast(new_deaths as bigint)) as TotalDeathPerDay,   
(Sum(cast(new_deaths as bigint))/Sum(new_cases)*100) as DailyDeathPercentage
from portfolioproject..CovidDeaths
Where continent is not NULL 
Group by date
order by 1,2

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as bigint)) Over (Partition by dea.location order by dea.location, dea.date) as TillDateVaccinated
From PortfolioProject..CovidDeaths Dea
Join PortfolioProject..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null
order by 2,3

--Use CTE
With PopvsVac (Continent, Location, Date, Population,new_vaccinations, TillDateVaccinated) as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as bigint)) Over (Partition by dea.location order by dea.location, dea.date) as TillDateVaccinated
From PortfolioProject..CovidDeaths Dea
Join PortfolioProject..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null
)
Select *, (TillDateVaccinated/population)*100 From PopvsVac 

--Temp Table

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
TillDateVaccinated numeric,
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as bigint)) Over (Partition by dea.location order by dea.location, dea.date) as TillDateVaccinated
From PortfolioProject..CovidDeaths Dea
Join PortfolioProject..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null

Select *, (TillDateVaccinated/population)*100 as VaccinatedPercentage From #PercentPopulationVaccinated

--Creating View to store data for future visualisation

Create View PercentVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as bigint)) Over (Partition by dea.location order by dea.location, dea.date) as TillDateVaccinated
From PortfolioProject..CovidDeaths Dea
Join PortfolioProject..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null

Select * from PercentVaccinated
