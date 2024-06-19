#World Life Expectancy - Exploratory Data Analysis

Select * from worldlifeexpectancy ;

Select country , Min(`Life Expectancy`), Max(`Life Expectancy`)
from worldlifeexpectancy
group by country
order by country desc;

# Now we have some 0's in our table for Min and Max and we might filter that below.

Select country , Min(`Life Expectancy`), Max(`Life Expectancy`)
from worldlifeexpectancy
group by country
Having Min(`Life Expectancy`) <> 0 
And max(`Life Expectancy`) <> 0
order by country desc;

##Now lets find out the countries which has made biggest thrives country wise.
#Largest Increase
Select country , 
Min(`Life Expectancy`),
Max(`Life Expectancy`),
Round( Max(`Life Expectancy`)- Min(`Life Expectancy`),2) AS Life_Increase
from worldlifeexpectancy
group by country
Having Min(`Life Expectancy`) <> 0 
And max(`Life Expectancy`) <> 0
order by Life_Increase desc;

#Least Life Increase
Select country , 
Min(`Life Expectancy`),
Max(`Life Expectancy`),
Round( Max(`Life Expectancy`)- Min(`Life Expectancy`),2) AS Life_Increase
from worldlifeexpectancy
group by country
Having Min(`Life Expectancy`) <> 0 
And max(`Life Expectancy`) <> 0
order by Life_Increase asc;

## Now lets find out the average year of life expectancy.alter

Select year, round(avg(`Life Expectancy`),2) AS Avg_Year
from worldlifeexpectancy
group by year
order by year ; 

# Now lets have a look at the co-relation between life expectancy and country's GDP resp.

Select country, `Life Expectancy` AS `LE`, GDP
from worldlifeexpectancy;

# It will be better if we take the avg of these and then compare.

Select country, Round(Avg (`Life Expectancy`),2) AS `LE`, Round(Avg (GDP),1)
from worldlifeexpectancy
group by country
order by `LE`;

# We now still have some 0's in the table.

Select country, Round(Avg (`Life Expectancy`),2) AS `LE`, Round(Avg (GDP),1) AS GDP
from worldlifeexpectancy
group by country
Having `LE` > 0
And GDP > 0
order by GDP desc;

## Now lets catogerize these gdp using case statements.

Select *
from worldlifeexpectancy
order by gdp desc;

Select 
Sum(Case When GDP >= 1500 Then 1 else 0 End) High_GDP_Count,
Avg (Case When GDP >= 1500 Then `Life Expectancy` else null End) High_GDP_Life_Expectancy,
Sum(Case When GDP <= 1500 Then 1 else 0 End) Low_GDP_Count,
Avg (Case When GDP <= 1500 Then `Life Expectancy` else null End) Low_GDP_Life_Expectancy
from worldlifeexpectancy;

#Hence we find out the correlation between high GDP and low GDP Countries as seen above

## Now lets play around the data with status and avg life expectancy

Select * from worldlifeexpectancy;

Select status, Round(avg(`Life Expectancy`),1)
from worldlifeexpectancy
group by status;

Select status, count(distinct country), Round(avg(`Life Expectancy`),1)
from worldlifeexpectancy
group by status;


# Now take a look at the correlation of Avg BMI and Life Expectancy below.

Select country, Round(Avg (`Life Expectancy`),2) AS `LE`, Round(Avg (BMI),1) AS BMI
from worldlifeexpectancy
group by country
Having `LE` > 0
And BMI > 0
order by BMI asc;

# Now lets compare adult mortality and let's see how many people are dying compared to life Expectancy by using rolling total

Select * from worldlifeexpectancy;

Select country, 
year,
`Life expectancy`,
`Adult Mortality`,
sum(`Adult Mortality`) over(Partition by country order by year) AS Rolling_total
from worldlifeexpectancy
where country like '%United%';

## Hence we have completed the 2nd part of the project which is the Exploratory Data Analysis.