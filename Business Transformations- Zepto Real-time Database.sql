/* Business Transformations */

-- 1- Find the top 10 best-value products on the discount percentage?

SELECT DISTINCT name, mrp, discountPercent FROM zepto
ORDER BY discountPercent desc
LIMIT 10;

-- 2- What are the products with high mrp but of stock

SELECT DISTINCT name, mrp FROM zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp desc;

-- 3- Calculate estimated revenue for each category?

SELECT category, 
SUM(discountedSellingPrice * availableQuantity) AS total_revenue FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- 4- Find all products where mrp is greater than Rs. 500 and discount is less than 10%?

SELECT distinct name, mrp, discountPercent FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp desc, discountPercent desc;

-- 5-  Identify the top 5 categories offering the highest average discount percentage?

SELECT category,
ROUND(AVG(discountPercent), 2) AS avg_discount FROM zepto
GROUP BY category
ORDER BY avg_discount desc
LIMIT 5;

-- 6- Find the price per gram for products above 100g and sort by best value?

SELECT DISTINCT name, weightInGms, discountedSellingPrice, 
ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- 7- Group the products into categories like low, medium, bulk?

SELECT DISTINCT name, weightInGms, 
CASE WHEN weightInGms < 1000 THEN 'Low'
	 WHEN weightInGms < 5000 THEN 'Medium'
	 ELSE 'Bulk'
	 END AS weight_category
FROM zepto;
 
-- 8- What is the total inventory weight per category?

SELECT category, 
SUM (weightInGms * availableQuantity) AS total_weight FROM zepto
GROUP BY category
ORDER BY total_weight;