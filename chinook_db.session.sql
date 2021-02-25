-- 1
SELECT LastName, FirstName, CustomerId, Country 
FROM Customer
WHERE Country NOT LIKE "USA";

-- 2
SELECT LastName, FirstName, CustomerId, Country
FROM Customer
WHERE Country NOT LIKE "Brazil";

-- 3
SELECT FirstName, LastName, InvoiceId, InvoiceDate, Country
FROM Invoice AS I
JOIN Customer AS C 
ON C.CustomerId LIKE I.CustomerId;

-- 4
SELECT *
FROM Employee
WHERE Title LIKE "%Sales%Agent%";

-- 5a
SELECT DISTINCT BillingCountry
FROM Invoice;

-- 5b
SELECT BillingCountry
FROM Invoice
WHERE COUNT BillingCountry 1;
