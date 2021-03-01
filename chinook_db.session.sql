
-- 1 Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT LastName, FirstName, CustomerId, Country 
FROM Customer
WHERE Country NOT LIKE "USA";


-- 2 Provide a query only showing the Customers from Brazil.
SELECT LastName, FirstName, CustomerId, Country
FROM Customer
WHERE Country LIKE "Brazil";


-- 3 Provide a query showing the Invoices of customers who are from Brazil. 
--   The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT 
    FirstName || " "  || LastName AS FullName, 
    InvoiceId, 
    InvoiceDate, 
    Country
FROM Invoice AS I
JOIN Customer AS C 
ON C.CustomerId LIKE I.CustomerId
WHERE Country LIKE "Brazil"
ORDER BY InvoiceDate;


-- 4 Provide a query showing only the Employees who are Sales Agents.
SELECT *
FROM Employee
WHERE Title LIKE "%Sales%Agent%";


-- 5a Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry
FROM Invoice;


-- 5b
SELECT BillingCountry, COUNT (BillingCountry)
FROM Invoice;


-- 6 Provide a query that shows the invoices associated with each sales agent. 
--   The resultant table should include the Sales Agent's full name.
SELECT 
    E.FirstName || " " || E.LastName AS FullName,
    InvoiceId, InvoiceDate, BillingAddress,
    BillingCity, BillingState, BillingCountry,
    BillingPostalCode, Total
FROM Invoice AS I
JOIN Customer AS C ON C.CustomerId = I.CustomerId
JOIN Employee AS E ON E.EmployeeId = C.SupportRepId
WHERE E.Title LIKE "Sales Support Agent"
ORDER BY E.LastName;


-- 7 Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT 
    Total,
    C.FirstName || " " || C.LastName AS CustomerName,
    C.Country,
    E.FirstName || " " || E.LastName AS SaleAgent
FROM Invoice AS I
JOIN Customer AS C ON I.CustomerId = C.CustomerId
JOIN Employee AS E ON E.EmployeeId = C.SupportRepId
ORDER BY Total DESC;


-- 8 How many Invoices were there in 2009 and 2011?
SELECT
    COUNT(InvoiceDate) AS NumberOfInvoices,
    STRFTIME('%Y', InvoiceDate) AS InvoiceYear
FROM Invoice
WHERE InvoiceYear = "2011" OR InvoiceYear = "2009"
GROUP BY InvoiceYear;


-- 9 What are the respective total sales for each of those years?
SELECT
    "$" || printf("%.2f", SUM(Total)) AS AnnualSales,
    STRFTIME('%Y', InvoiceDate) AS InvoiceYear
FROM Invoice
WHERE InvoiceYear = "2011" OR InvoiceYear = "2009"
GROUP BY InvoiceYear;


-- 10 Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT
    I.InvoiceId AS InvoiceId,
    COUNT(IL.InvoiceLineId) AS NumberOfLines
FROM Invoice AS I
JOIN InvoiceLine AS IL
ON I.InvoiceId = IL.InvoiceId
WHERE I.InvoiceId = 37;


-- 11 Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
SELECT
    I.InvoiceId AS InvoiceId,
    COUNT(IL.InvoiceLineId) AS NumberOfLines
FROM Invoice AS I
JOIN InvoiceLine AS IL
ON I.InvoiceId = IL.InvoiceId
GROUP BY I.InvoiceId;


-- 12 Provide a query that includes the purchased track name with each invoice line item.
SELECT
    IL.InvoiceLineId AS InvoiceLineId,
    T.Name AS TrackName
FROM InvoiceLine AS IL
JOIN Track AS T ON T.TrackId = IL.TrackId
ORDER BY IL.InvoiceLineId;

-- 13 Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT
    IL.InvoiceLineid AS InvoiceLineId,
    T.Name AS TrackName,
    A.Name AS ArtistName
FROM InvoiceLine AS IL
JOIN Track AS T ON T.TrackId = IL.TrackId
JOIN Album AS Al ON Al.AlbumId = T.AlbumId
JOIN Artist AS A ON A.ArtistId = Al.ArtistId
ORDER BY IL.InvoiceLineid