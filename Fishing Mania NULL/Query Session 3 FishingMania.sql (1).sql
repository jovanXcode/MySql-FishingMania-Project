-- 1
SELECT * FROM TransactionDetail
BEGIN TRAN
INSERT INTO [TransactionDetail] (TransactionID, FishID, Quantity)
VALUES 
	('TR014', 'FI014', 27),
	('TR014', 'FI010', 2),
	('TR015', 'FI005', 26),
	('TR015', 'FI002', 21);
ROLLBACK

-- 2 RAND -> 0-1	53 -> -2 -> 100 CAST NUMBER(2,0) 
SELECT * FROM MsFish
BEGIN TRAN
INSERT INTO MsFish 
VALUES('FI017', 'FT003', 'Red Mackerel', ROUND(RAND()*(40-5)+5,1))
ROLLBACK

-- 3
SELECT * FROM MsFish 
BEGIN TRAN
DELETE FROM [MsFish]
WHERE FishTypeID IN ('FT003', 'FT005')
ROLLBACK

-- 4
SELECT * FROM MsCustomer
BEGIN TRAN
DELETE FROM MsCustomer 
WHERE MsCustomer.CustomerGender IN ('Female') AND CustomerAddress IS NULL
ROLLBACK

-- 5 
SELECT * FROM MsFish
BEGIN TRAN
UPDATE MsFish
SET FishPrice = FishPrice - 3
WHERE FishID IN (
	SELECT FishID FROM MsFish WHERE FishPrice BETWEEN 10 AND 12
	)
ROLLBACK

-- 6
SELECT * FROM MsFish
BEGIN TRAN
UPDATE MsFish
SET FishPrice = FishPrice + 2.5 
WHERE MsFish.FishTypeID IN ('FT001', 'FT002') AND FishPrice > 35
ROLLBACK

-- 7
SELECT * FROM MsCustomer
WHERE CustomerAddress IS NOT NULL
ORDER BY CustomerDOB ASC

-- 8
SELECT * FROM MsFisherman
SELECT FishermanName, CONCAT('Address: ',FishermanAddress) AS [Address]
FROM MsFisherman
WHERE FishermanGender LIKE 'Male'

-- 9
SELECT FishName, CONCAT('$', CAST(FishPrice AS VARCHAR)) AS Price
FROM MsFish
WHERE FishPrice <= 10

-- 10 CONVERT
SELECT FishName, CONCAT('$', CONVERT(VARCHAR, FLOOR(FishPrice))) AS DiscountPrice
FROM MsFish
WHERE FishName LIKE 'Red Grouper'