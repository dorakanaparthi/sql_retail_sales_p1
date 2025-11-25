-- SQL Reail Sales Analysis - p1
create database sql_project_p1;

-- create table
create table retail_sales(

						   transactions_id int primary key,
						   sale_date date,
						   sale_time time,
						   customer_id int,
						   gender varchar(15),
						   age  int,
						   category varchar(20),
						   quantity int,
						   price_per_unit  float,
						   cogs float,
						   total_sale float
						  );



select * from retail_sales limit 10;

select count(*) from retail_sales;

-- Data Cleaning

select * from retail_sales 
where 
	transactions_id is null
	or 
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantity is null
	or
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null ;

Delete from retail_sales
where 
		transactions_id is null
		or 
		sale_date is null
		or 
		sale_time is null
		or
		customer_id is null
		or
		gender is null
		or
		age is null
		or
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or 
		cogs is null
		or
		total_sale is null ;

-- Data Exploration

-- how many sales we have ?
select count(*) from retail_Sales;

-- how many customers we have?
select count(customer_id) from retail_Sales;

-- how many unique customers we have?
select count(distinct(customer_id)) from retail_sales;

-- what are the categories we have?
select distinct category from retail_sales;

--how many quantity per each category?
select category,count(*) from retail_sales  group by category;


-- Data Analysis & Business Key Problems & Answers\

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



--  Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

	select * from retail_sales
	where sale_date='2022-11-05';

--  Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

	select 
		   *
	from retail_sales
	where category='Clothing'
		  and 
		  sale_Date between '2022-11-01' and '2022-11-30'
		  and 
		  quantity >=4;

--  Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

    select category,sum(total_sale) as net_sale , count(*) as total_orders from retail_sales  group by category;


--  Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
    select category,round(avg(age),2) as avg_age from retail_sales where category='Beauty' group by category;


--  Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

    select * from retail_sales where total_sale>1000;

--  Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

   select 
   		category,
		gender,
		count(transactions_id) as total_trans 
   from retail_sales
   group
   		by
		gender,
		category
   order by category ;


--  Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


  select * from
       (select 
	   		extract(year from sale_date) as sale_year,
			extract(month from sale_date) as sale_month,
			avg(total_sale) as avg_sale,
			rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
	from 
		 retail_sales
    group by
		 sale_year,
		 sale_month)
	where rank=1;
		 
  

--  Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

      select 
		  customer_id,
		  sum(total_sale) as total_sale
	        from  retail_sales
	  group by customer_id
	  order by 2 desc limit 5;
	 

--   Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

      select category,count(distinct customer_id) from retail_sales group by category;

--   Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17,Evening >17)
   with hourly_sales
   as
   (
      select *,
	        case
			     when extract(hour from sale_time) <=12 Then 'morning'
				 when extract(hour from sale_time) between 12 and 17 Then 'Afternoon'
				 else 'Evening'
			end as shift		
			   from retail_Sales
   )
   select 
   		shift,
   		count(*) as total_orders
   from hourly_sales
   group by shift
   order by total_orders desc;

-- End of Project
      

 