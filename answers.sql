-- Create the database
-- group 541

CREATE DATABASE e_commerce;
USE e_commerce;

-- 1. brand
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



-- 2. product_category
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 3. product
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- 4. color
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7) -- e.g. #FFFFFF
);

-- 5. product_image
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url TEXT NOT NULL,
    alt_text VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 6. size_category
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 7. size_option
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    label VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- 8. product_item (specific purchasable item)
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_option_id INT,
    sku VARCHAR(100) UNIQUE NOT NULL,
    quantity_in_stock INT DEFAULT 0,
    price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- 9. product_variation
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    variation_name VARCHAR(100),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 10. attribute_category
CREATE TABLE attribute_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 11. attribute_type
CREATE TABLE attribute_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL -- e.g., text, number, boolean
);

-- 12. product_attribute
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(100) NOT NULL,
    value TEXT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(type_id)
);


-- INSERTING DATA

INSERT INTO brand (name) VALUES 
('Nike'), 
('Apple'), 
('Samsung');

INSERT INTO product_category (name) VALUES 
('Clothing'), 
('Electronics');

INSERT INTO product (name, brand_id, category_id, base_price) VALUES 
('Nike Running Shoes', 1, 1, 120.00),
('iPhone 15', 2, 2, 999.00);

INSERT INTO color (name, hex_code) VALUES 
('Black', '#000000'), 
('White', '#FFFFFF');

INSERT INTO product_image (product_id, image_url, alt_text) VALUES 
(1, 'https://example.com/nike-shoes.jpg', 'Nike Running Shoes'),
(2, 'https://example.com/iphone15.jpg', 'iPhone 15');

INSERT INTO size_category (name) VALUES 
('Shoe Size'), 
('Storage Capacity');

INSERT INTO size_option (size_category_id, label) VALUES 
(1, '42'), 
(1, '43'), 
(2, '256GB');

INSERT INTO product_item (product_id, color_id, size_option_id, sku, quantity_in_stock, price) VALUES 
(1, 1, 1, 'NIKE-RUN-BLK-42', 25, 120.00),
(1, 2, 2, 'NIKE-RUN-WHT-43', 30, 120.00),
(2, 1, 3, 'IPHONE15-BLK-256', 50, 999.00);


INSERT INTO product_variation (product_id, variation_name) VALUES 
(1, 'Size and Color'), 
(2, 'Storage and Color');

INSERT INTO attribute_category (name) VALUES 
('Physical'), 
('Technical');

INSERT INTO attribute_type (name) VALUES 
('Text'), 
('Number'), 
('Boolean');

INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES 
(1, 1, 1, 'Material', 'Mesh'),
(1, 1, 1, 'Sole Type', 'Rubber'),
(2, 2, 1, 'Battery Life', '20 hours'),
(2, 2, 1, 'Camera', '48MP');