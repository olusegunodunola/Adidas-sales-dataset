-- Adidas Sales Analysis SQL Script
-- Author: Taiwo Goodnews Aayi
-- Dataset: [dbo].[Data Sales Adidas]
-- Purpose: Comprehensive analysis of 2021 Adidas sales data for business case presentation

-- Query 0: View Entire Dataset 
SELECT * FROM [dbo].[Data Sales Adidas];

-- Query 1: Total Sales Revenue by Foot Locker in Charleston
SELECT SUM([Total Sales]) AS Total_Revenue
FROM [dbo].[Data Sales Adidas]
WHERE Retailer = 'Foot Locker' AND City = 'Charleston';

-- Query 2: Units Sold in February 2021
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 2;

-- Query 3a: Product with Highest Total Sales in March 2021
SELECT Product, SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3
GROUP BY Product
ORDER BY Total_Sales DESC;

-- Query 3b: Top 1 Product with Highest Total Sales in March 2021
SELECT TOP 1 Product, SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3
GROUP BY Product
ORDER BY Total_Sales DESC;

-- Query 4: Average Price per Unit for Women's Athletic Footwear
SELECT AVG([Price per Unit]) AS Avg_Price
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Women''s Athletic Footwear';

-- Query 5: Total Operating Profit for Men's Street Footwear in April 2021
SELECT SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Street Footwear' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4;

-- Query 6: Product with Highest Average Operating Margin
SELECT TOP 1 Product, AVG([Operating Margin]) AS Avg_Operating_Margin
FROM [dbo].[Data Sales Adidas]
GROUP BY Product
ORDER BY Avg_Operating_Margin DESC;

-- Query 6b: Top Products with Highest Operating Margin
SELECT Product, AVG([Operating Margin]) AS Avg_Operating_Margin
FROM [dbo].[Data Sales Adidas]
GROUP BY Product
ORDER BY Avg_Operating_Margin DESC;

-- Query 7: Distinct Products Sold in May 2021
SELECT COUNT(DISTINCT Product) AS Distinct_Products
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5;

-- Query 8: Total Sales Revenue for Online Sales
SELECT 
    [Sales Method],
    SUM([Total Sales]) AS Total_Sales,
    (SUM([Total Sales]) * 100.0) / (SELECT SUM([Total Sales]) FROM [dbo].[Data Sales Adidas] WHERE YEAR([Invoice Date]) = 2021) AS Sales_Percentage
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY [Sales Method]
ORDER BY Total_Sales DESC;

-- Query 9: Month-over-Month Sales Growth from February to March 2021
WITH MonthlySales AS (
    SELECT 
        DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month,
        MONTH([Invoice Date]) AS Month_Number,
        SUM([Total Sales]) AS Total_Sales
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) IN (2, 3)
    GROUP BY MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
)
SELECT 
    Month,
    Total_Sales,
    (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Month_Number)) AS Sales_Growth,
    ((Total_Sales - LAG(Total_Sales) OVER (ORDER BY Month_Number)) * 100.0) / 
    LAG(Total_Sales) OVER (ORDER BY Month_Number) AS Growth_Percentage
FROM MonthlySales
WHERE Month_Number = 3;

-- Query 10: Product with Lowest Units Sold in April 2021
SELECT TOP 1 Product, SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4
GROUP BY Product
ORDER BY Total_Units_Sold ASC;

-- Query 11: Total Operating Profit for Apparel Products
SELECT SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE Product IN ('Men''s Apparel', 'Women''s Apparel');

-- Query 12: Average Total Sales per Transaction in March 2021
SELECT AVG([Total Sales]) AS Avg_Sales_Per_Transaction
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3;

-- Query 13: Transactions for Women's Street Footwear in 2021
SELECT COUNT(*) AS Transaction_Count
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Women''s Street Footwear' AND YEAR([Invoice Date]) = 2021;

-- Query 14: Total Sales Revenue for Products with Operating Margin > 0.4
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE [Operating Margin] > 0.4;

-- Query 15: Month with Highest Total Units Sold in 2021
SELECT TOP 1 
    DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month, 
    SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
ORDER BY Total_Units_Sold DESC;

-- Query 15b: Sales by Month in 2021
SELECT 
    DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month,
    SUM([Units Sold]) AS Total_Units_Sold,
    SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
ORDER BY Total_Sales DESC;

-- Query 16: Profit Margin for Men's Athletic Footwear in May 2021
SELECT SUM([Operating Profit]) / SUM([Total Sales]) AS Profit_Margin
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Athletic Footwear' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5;

-- Query 17: Average Price per Unit in Charleston
SELECT AVG([Price per Unit]) AS Avg_Price
FROM [dbo].[Data Sales Adidas]
WHERE City = 'Charleston';

-- Query 18: Units Sold for Men's Street Footwear in Q2 2021
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Street Footwear' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) IN (4, 5, 6);

-- Query 19: Total Sales Revenue for Products Priced Above $40
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE [Price per Unit] > 40;

-- Query 20: Product with Highest Total Operating Profit in 2021
SELECT TOP 3 
    Product, 
    SUM([Operating Profit]) AS Total_Profit,
    SUM([Total Sales]) AS Total_Sales,
    SUM([Operating Profit]) / SUM([Total Sales]) * 100 AS Profit_Margin
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY Product
ORDER BY Total_Profit DESC;

-- Query 21: Percentage of Total Sales by Women's Apparel
SELECT 
    SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM [dbo].[Data Sales Adidas]) * 100 AS Sales_Percentage
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Women''s Apparel';

-- Query 22: Transactions with Total Sales Above $300,000
SELECT COUNT(*) AS Transaction_Count
FROM [dbo].[Data Sales Adidas]
WHERE [Total Sales] > 300000;

-- Query 23: Average Operating Profit per Unit Sold for Men's Apparel
SELECT SUM([Operating Profit]) / SUM([Units Sold]) AS Avg_Profit_Per_Unit
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Apparel';

-- Query 24: Product with Lowest Operating Profit in May 2021 (Corrected)
SELECT TOP 1 Product, SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5
GROUP BY Product
ORDER BY Total_Profit ASC;

-- Query 25: Total Sales Revenue for Foot Locker in Q1 2021
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE Retailer = 'Foot Locker' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) IN (1, 2, 3);

-- Query 26: Units Sold for Products with Operating Margin of 0.35
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE [Operating Margin] = 0.35;

-- Query 27: Average Units Sold per Transaction for Women's Street Footwear
SELECT AVG([Units Sold]) AS Avg_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Women''s Street Footwear';

-- Query 28: Total Operating Profit for Transactions in April 2021
SELECT SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4;

-- Query 29: Product with Highest Price per Unit in May 2021
SELECT TOP 1 Product, MAX([Price per Unit]) AS Max_Price
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5
GROUP BY Product
ORDER BY Max_Price DESC;

-- Query 30: Total Sales Revenue in South Carolina (Corrected)
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE State = 'South Carolina';

-- Query 31: Transactions in Southeast Region
SELECT COUNT(*) AS Transaction_Count
FROM [dbo].[Data Sales Adidas]
WHERE Region = 'Southeast';

-- Query 32: Average Operating Margin for Men's Street Footwear
SELECT AVG([Operating Margin]) AS Avg_Operating_Margin
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Street Footwear';

-- Query 33: Total Units Sold for Products with Total Sales Below $200,000
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE [Total Sales] < 200000;

-- Query 34: Month with Lowest Total Operating Profit in 2021
SELECT TOP 1 
    DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month, 
    SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
ORDER BY Total_Profit ASC;

-- Query 35: Total Sales Revenue for Products with Units Sold Above 800
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE [Units Sold] > 800;

-- Query 36: Distinct Invoice Dates in the Dataset
SELECT COUNT(DISTINCT [Invoice Date]) AS Distinct_Dates
FROM [dbo].[Data Sales Adidas];

-- Query 37: Average Total Sales for Men's Athletic Footwear
SELECT AVG([Total Sales]) AS Avg_Sales
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Athletic Footwear';

-- Query 38: Total Operating Profit in February Permenantly2021
SELECT SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 2;

-- Query 39: Product with Highest Units Sold in March 2021
SELECT TOP 1 
    Product, 
    SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3
GROUP BY Product
ORDER BY Total_Units_Sold DESC;

-- Query 40: Percentage of Operating Profit by Women's Athletic Footwear
SELECT 
    SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM [dbo].[Data Sales Adidas]) * 100 AS Profit_Percentage
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Women''s Athletic Footwear';

-- Query 41: Transactions with Operating Margin Below 0.3
SELECT COUNT(*) AS Transaction_Count
FROM [dbo].[Data Sales Adidas]
WHERE [Operating Margin] < 0.3;

-- Query 42: Total Sales Revenue for Men's Apparel in April 2021
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Men''s Apparel' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4;

-- Query 43: Average Units Sold for Transactions with Total Sales Above $250,000
SELECT AVG([Units Sold]) AS Avg_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE [Total Sales] > 250000;

-- Query 44: Product with Lowest Price per Unit in February 2021
SELECT TOP 1 Product, MIN([Price per Unit]) AS Min_Price
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 2
GROUP BY Product
ORDER BY Min_Price ASC;

-- Query 45: Total Operating Profit for Products with Units Sold Below 700
SELECT SUM([Operating Profit]) AS Total_Profit
FROM [dbo].[Data Sales Adidas]
WHERE [Units Sold] < 700;

-- Query 46: Transactions for Products Priced at $35
SELECT COUNT(*) AS Transaction_Count
FROM [dbo].[Data Sales Adidas]
WHERE [Price per Unit] = 35;

-- Query 47: Average Operating Profit for Women's Street Footwear
SELECT AVG([Operating Profit]) AS Avg_Profit
FROM [dbo].[Data Sales Adidas]
WHERE Product = 'Women''s Street Footwear';

-- Query 48: Total Sales Revenue for First Week of March 2021
SELECT SUM([Total Sales]) AS Total_Sales
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3 
AND DAY([Invoice Date]) BETWEEN 1 AND 7;

-- Query 49: Product with Highest Operating Margin in April 2021
SELECT TOP 1 Product, MAX([Operating Margin]) AS Max_Margin
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4
GROUP BY Product
ORDER BY Max_Margin DESC;

-- Query 50: Total Units Sold for Products with Operating Profit Above $100,000
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM [dbo].[Data Sales Adidas]
WHERE [Operating Profit] > 100000;

-- Query 51: Categorize Products by Operating Margin and Rank Within Each Month
SELECT 
    Product,
    [Invoice Date],
    [Operating Margin],
    CASE 
        WHEN [Operating Margin] >= 0.4 THEN 'High'
        WHEN [Operating Margin] >= 0.3 THEN 'Medium'
        ELSE 'Low'
    END AS Profit_Category,
    ROW_NUMBER() OVER (
        PARTITION BY MONTH([Invoice Date]) 
        ORDER BY [Operating Margin] DESC
    ) AS Profit_Rank
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 51b: Pivoting Profit_Category into Separate Columns
SELECT 
    Product,
    [Invoice Date],
    [Operating Margin],
    CASE WHEN [Operating Margin] >= 0.4 THEN 1 ELSE 0 END AS High,
    CASE WHEN [Operating Margin] >= 0.3 AND [Operating Margin] < 0.4 THEN 1 ELSE 0 END AS Medium,
    CASE WHEN [Operating Margin] < 0.3 THEN 1 ELSE 0 END AS Low
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 52: Cumulative Total Sales for Each Product Over Time
SELECT 
    Product,
    [Invoice Date],
    [Total Sales],
    SUM([Total Sales]) OVER (
        PARTITION BY Product 
        ORDER BY [Invoice Date]
    ) AS Cumulative_Sales
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
ORDER BY Product, [Invoice Date];

-- Query 53: Assign Sales Tier and Rank Transactions Within Each Product
SELECT 
    Product,
    [Invoice Date],
    [Total Sales],
    CASE 
        WHEN [Total Sales] > 400000 THEN 'Tier 1'
        WHEN [Total Sales] > 200000 THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS Sales_Tier,
    RANK() OVER (
        PARTITION BY Product 
        ORDER BY [Total Sales] DESC
    ) AS Sales_Rank
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 54: Compare Product-Level Operating Profit to Overall Average

SELECT 
    Product,
    DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Sales_Month,
    SUM([Operating Profit]) AS Total_Profit,
    AVG(SUM([Operating Profit])) OVER (PARTITION BY Product) AS Avg_Product_Profit,
    AVG(SUM([Operating Profit])) OVER () AS Total_Avg_Profit,
    CASE 
        WHEN AVG(SUM([Operating Profit])) OVER (PARTITION BY Product) > AVG(SUM([Operating Profit])) OVER () 
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS Profit_Status
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
GROUP BY Product, MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1));

-- Query 55: Top 3 Products by Total Sales Within Each Month
WITH MonthlySales AS (
    SELECT 
        Product,
        DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month,
        MONTH([Invoice Date]) AS Month_Number,
        SUM([Total Sales]) AS Total_Sales,
        DENSE_RANK() OVER (
            PARTITION BY MONTH([Invoice Date]) 
            ORDER BY SUM([Total Sales]) DESC
        ) AS Sales_Rank
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021
    GROUP BY Product, MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
)
SELECT Product, Month, Total_Sales, Sales_Rank
FROM MonthlySales
WHERE Sales_Rank <= 3
ORDER BY Month_Number, Sales_Rank;

-- Query 56. Percentage Contribution of Product Sales to Monthly Total
WITH ProductMonthlySales AS (
    SELECT 
        Product,
        DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month,
        MONTH([Invoice Date]) AS Month_Number,
        SUM([Total Sales]) AS Product_Sales
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021
    GROUP BY Product, MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
)
SELECT 
    Product,
    Month,
    Product_Sales,
    SUM(Product_Sales) OVER (PARTITION BY Month) AS Total_Monthly_Sales,
    (Product_Sales * 100.0) / SUM(Product_Sales) OVER (PARTITION BY Month) AS Sales_Percentage
FROM ProductMonthlySales
ORDER BY Month_Number, Sales_Percentage DESC;

-- Query 57: Flag Transactions with Above-Average Operating Profit
SELECT 
    Product,
    [Invoice Date],
    [Operating Profit],
    AVG([Operating Profit]) OVER (PARTITION BY Product) AS Avg_Product_Profit,
    CASE 
        WHEN [Operating Profit] > AVG([Operating Profit]) OVER (PARTITION BY Product) THEN 'High Profit'
        ELSE 'Normal Profit'
    END AS Profit_Flag
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 58: Month-over-Month Sales Growth Percentage for Each Product
WITH MonthlySales AS (
    SELECT 
        Product,
        DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month,
        MONTH([Invoice Date]) AS Month_Number,
        SUM([Total Sales]) AS Monthly_Sales
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021
    GROUP BY Product, MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
)
SELECT 
    Product,
    Month,
    Monthly_Sales,
    LAG(Monthly_Sales) OVER (PARTITION BY Product ORDER BY Month_Number) AS Previous_Month_Sales,
    CASE 
        WHEN LAG(Monthly_Sales) OVER (PARTITION BY Product ORDER BY Month_Number) IS NULL THEN NULL
        ELSE ((Monthly_Sales - LAG(Monthly_Sales) OVER (PARTITION BY Product ORDER BY Month_Number)) * 100.0) / 
             LAG(Monthly_Sales) OVER (PARTITION BY Product ORDER BY Month_Number)
    END AS Sales_Growth_Percentage
FROM MonthlySales
ORDER BY Product, Month_Number;

-- Query 59: Rank Products by Operating Margin Within Each Invoice Date
SELECT 
    Product,
    [Invoice Date],
    [Operating Margin],
    ROW_NUMBER() OVER (PARTITION BY [Invoice Date] ORDER BY [Operating Margin] DESC) AS Margin_Rank,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY [Invoice Date] ORDER BY [Operating Margin] DESC) = 1 THEN 'Top Performer'
        ELSE 'Other'
    END AS Performance_Flag
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 60: Moving Average of Total Sales Over Last 3 Transactions
SELECT 
    Product,
    [Invoice Date],
    [Total Sales],
    AVG([Total Sales]) OVER (
        PARTITION BY Product 
        ORDER BY [Invoice Date] 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Moving_Avg_Sales
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
ORDER BY Product, [Invoice Date];

-- Query 61: Categorize Transactions by Operating Profit and Rank
SELECT 
    Product,
    [Invoice Date],
    [Operating Profit],
    CASE 
        WHEN [Operating Profit] > 0 THEN 'Profitable'
        ELSE 'Loss-Making'
    END AS Profit_Status,
    RANK() OVER (PARTITION BY Product ORDER BY [Operating Profit] DESC) AS Profit_Rank
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 62: Cumulative Operating Profit vs. Product Average
SELECT 
    Product,
    [Invoice Date],
    [Operating Profit],
    SUM([Operating Profit]) OVER (PARTITION BY Product ORDER BY [Invoice Date]) AS Cumulative_Profit,
    AVG([Operating Profit]) OVER (PARTITION BY Product) AS Avg_Product_Profit,
    CASE 
        WHEN SUM([Operating Profit]) OVER (PARTITION BY Product ORDER BY [Invoice Date]) > 
             AVG([Operating Profit]) OVER (PARTITION BY Product) THEN 'Above Average'
             ELSE 'Below Average'
    END AS Profit_Comparison
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 63: First and Last Transaction for Each Product
WITH RankedTransactions AS (
    SELECT 
        Product,
        [Invoice Date],
        [Total Sales],
        ROW_NUMBER() OVER (PARTITION BY Product ORDER BY [Invoice Date] ASC) AS First_Transaction,
        ROW_NUMBER() OVER (PARTITION BY Product ORDER BY [Invoice Date] DESC) AS Last_Transaction
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021
)
SELECT 
    Product,
    [Invoice Date],
    [Total Sales],
    CASE 
        WHEN First_Transaction = 1 THEN 'First Transaction'
        WHEN Last_Transaction = 1 THEN 'Last Transaction'
    END AS Transaction_Type
FROM RankedTransactions
WHERE First_Transaction = 1 OR Last_Transaction = 1
ORDER BY Product, [Invoice Date];

-- Query 64: First and Last Month Transactions per Product by Year
WITH TransactionData AS (
    SELECT 
        Product,
        [Invoice Date],
        [Total Sales] AS [Transaction],
        YEAR([Invoice Date]) AS Sales_Year,
        MONTH([Invoice Date]) AS Sales_Month
    FROM [dbo].[Data Sales Adidas]
),
FirstLastMonths AS (
    SELECT 
        Sales_Year,
        MIN(Sales_Month) AS First_Month,
        MAX(Sales_Month) AS Last_Month
    FROM TransactionData
    GROUP BY Sales_Year
)
SELECT 
    td.[Invoice Date] AS [Date],
    td.Product,
    td.[Transaction],
    CASE 
        WHEN td.Sales_Month = flm.First_Month THEN 'First Month Transaction'
        WHEN td.Sales_Month = flm.Last_Month THEN 'Last Month Transaction'
        ELSE NULL
    END AS Transaction_Type,
    td.Sales_Year AS [Year]
FROM TransactionData td
JOIN FirstLastMonths flm
    ON td.Sales_Year = flm.Sales_Year
WHERE td.Sales_Month = flm.First_Month OR td.Sales_Month = flm.Last_Month
ORDER BY td.Sales_Year, td.[Invoice Date], td.Product;

-- Query 65: Percentage of Units Sold by Each Transaction
SELECT 
    Product,
    [Invoice Date],
    [Units Sold],
    SUM([Units Sold]) OVER (PARTITION BY Product) AS Total_Product_Units,
    ([Units Sold] * 100.0) / SUM([Units Sold]) OVER (PARTITION BY Product) AS Units_Percentage,
    CASE 
        WHEN ([Units Sold] * 100.0) / SUM([Units Sold]) OVER (PARTITION BY Product) > 20 THEN 'High Contribution'
        ELSE 'Low Contribution'
    END AS Contribution_Level
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021;

-- Query 66: Rank Transactions by Top 10% Sales Within Each Month by Region, State, and City
SELECT 
    Region,
    State,
    City,
    Product,
    [Invoice Date],
    [Total Sales],
    NTILE(10) OVER (PARTITION BY MONTH([Invoice Date]) ORDER BY [Total Sales] DESC) AS Sales_Decile,
    CASE 
        WHEN NTILE(10) OVER (PARTITION BY MONTH([Invoice Date]) ORDER BY [Total Sales] DESC) = 1 THEN 'Top 10%'
        ELSE 'Other'
    END AS Sales_Category,
    RANK() OVER (PARTITION BY MONTH([Invoice Date]), Region, State, City ORDER BY [Total Sales] DESC) AS Sales_Rank
FROM [dbo].[Data Sales Adidas]
WHERE YEAR([Invoice Date]) = 2021
ORDER BY Region, State, City, MONTH([Invoice Date]), [Total Sales] DESC;

-- Query 67: Rank Transactions by Top 10% Sales Within Each Month by Region, State, and City (Only Top 10%)
SELECT 
    Region,
    State,
    City,
    Product,
    [Invoice Date],
    [Total Sales],
    Sales_Decile,
    Sales_Category,
    Sales_Rank
FROM (
    SELECT 
        Region,
        State,
        City,
        Product,
        [Invoice Date],
        [Total Sales],
        NTILE(10) OVER (PARTITION BY MONTH([Invoice Date]) ORDER BY [Total Sales] DESC) AS Sales_Decile,
        CASE 
            WHEN NTILE(10) OVER (PARTITION BY MONTH([Invoice Date]) ORDER BY [Total Sales] DESC) = 1 THEN 'Top 10%'
            ELSE 'Other'
        END AS Sales_Category,
        RANK() OVER (PARTITION BY MONTH([Invoice Date]), Region, State, City ORDER BY [Total Sales] DESC) AS Sales_Rank
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021
) AS Subquery
WHERE Sales_Category = 'Top 10%'
ORDER BY Region, State, City, MONTH([Invoice Date]), [Total Sales] DESC;

-- Query 68: Top 10% Sales Performance by Region, State, City, and Product for 2021
WITH SalesData AS (
    SELECT 
        Region,
        State,
        City,
        Product,
        MONTH([Invoice Date]) AS Sales_Month,
        [Total Sales],
        NTILE(10) OVER (PARTITION BY MONTH([Invoice Date]) ORDER BY [Total Sales] DESC) AS Sales_Decile
    FROM [dbo].[Data Sales Adidas]
    WHERE YEAR([Invoice Date]) = 2021
)
SELECT 
    Region,
    State,
    City,
    Product,
    DATENAME(MONTH, DATEFROMPARTS(2021, Sales_Month, 1)) AS Sales_Month,
    SUM([Total Sales]) AS Total_Sales,
    COUNT(*) AS Number_of_Transactions,
    (SUM([Total Sales]) * 100.0) / SUM(SUM([Total Sales])) OVER (PARTITION BY Sales_Month) AS Percent_of_Monthly_Sales
FROM SalesData
WHERE Sales_Decile = 1
GROUP BY Region, State, City, Product, Sales_Month, DATENAME(MONTH, DATEFROMPARTS(2021, Sales_Month, 1))
ORDER BY Region, State, City, Sales_Month, Total_Sales DESC;