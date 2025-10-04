/* Table Creation and Data Importation */

DROP TABLE IF EXISTS zepto;

create table zepto (
	sku id SERIAL PRIMARY KEY,
	category VARCHAR(120),
	name VARCHAR(150) NOT NULL,
	mrp NUMERIC (8,2),
	discountPercent NUMERIC (5,2),
	availableQuantity INTEGER,
	discountedSelling Price NUMERIC (8,2),
	weightInGms INTEGER,
	outOfStock BOOLEAN,
	quantity INTEGER
);

COPY zepto(category, name, mrp, discountPercent, availableQuantity, 
		   discountedSellingPrice, weightInGms, outOfStock, quantity)
FROM 'E:\complete web bootcap\SQL\Zepto Real-time Database Analysis\Dataset\zepto_v2.csv' 
DELIMITER ',' 
CSV HEADER
ENCODING 'WIN1252';

SELECT * FROM zepto;

/* Data Exploration & Cleaning */

-- 1- Count of rows

SELECT COUNT(*) FROM zepto;

-- 2- Sample Data

SELECT * FROM zepto LIMIT 10;

-- 3- Null Values

SELECT * FROM zepto WHERE
name IS NULL
OR
category IS NULL 
OR 
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- 4- Different Product Categories

SELECT DISTINCT category FROM zepto 
ORDER BY category;

-- 5- Products in stock vs out of stock 

SELECT outOfStock, COUNT(sku_id) FROM zepto
GROUP BY outOfStock;

-- 6- Product names present multiple times

SELECT name, COUNT(sku_id) AS "Number of SKUs" FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1 
ORDER BY COUNT(sku_id) DESC;

-- 7- Products with price = 0

SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0;

-- 8- Convert paise to rupees

UPDATE zepto
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;
SELECT mrp, discountedSellingPrice FROM zepto;