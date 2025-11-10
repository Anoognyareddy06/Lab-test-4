DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Supplier;

-- Create Supplier table
CREATE TABLE IF NOT EXISTS Supplier (
    SupplierID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100),
    UNIQUE KEY (SupplierName)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create Products table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT,
    Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_products_supplier FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create Stock table
CREATE TABLE IF NOT EXISTS Stock (
    StockID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_stock_product FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample data into Supplier
INSERT INTO Supplier (SupplierName, ContactEmail) VALUES
('Supplier A', 'contact@supplierA.com'),
('Supplier B', 'contact@supplierB.com'),
('Supplier C', 'contact@supplierC.com');

-- Insert sample data into Products
INSERT INTO Products (ProductName, SupplierID, Price) VALUES
('Product 1', 1, 19.99),
('Product 2', 2, 29.99),
('Product 3', 3, 39.99);

-- Insert sample data into Stock
INSERT INTO Stock (ProductID, Quantity) VALUES
(1, 5),
(2, 15),
(3, 8);

-- Query to find products with stock quantity less than 10
SELECT p.ProductName, s.Quantity
FROM Products p
JOIN Stock s ON p.ProductID = s.ProductID
WHERE s.Quantity < 10;