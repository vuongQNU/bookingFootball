CREATE DATABASE bookingFootball;
USE bookingFootball;

-- Bảng User: Lưu thông tin người dùng (User và Admin)
CREATE TABLE User (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL, -- Mã hóa bằng BCrypt
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Category: Lưu danh mục sản phẩm (giày, tất, bóng, quần áo, v.v.)
CREATE TABLE Category (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(255)
);

-- Bảng Product: Lưu thông tin sản phẩm (phụ kiện thể thao)
CREATE TABLE Product (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category_id BIGINT NOT NULL,
    image_url VARCHAR(255), -- Đường dẫn ảnh sản phẩm
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Category(id),
    CONSTRAINT check_stock CHECK (stock >= 0)
);

-- Bảng Stadium: Lưu thông tin sân bóng
CREATE TABLE Stadium (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    area ENUM(
        'Quy Nhơn', 
        'An Lão', 
        'Hoài Ân', 
        'Hoài Nhơn', 
        'Phù Cát', 
        'Phù Mỹ', 
        'Tây Sơn', 
        'Tuy Phước', 
        'Vân Canh', 
        'Vĩnh Thạnh', 
        'An Nhơn'
    ) NOT NULL,
    price_per_hour DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255),
    image_url VARCHAR(255),
    contact_phone VARCHAR(15),
    field_type ENUM('Sân 5', 'Sân 7', 'Sân 11') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Booking: Lưu thông tin đặt sân
CREATE TABLE Booking (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    stadium_id BIGINT NOT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (stadium_id) REFERENCES Stadium(id)
);

-- Bảng PurchaseOrder: Lưu thông tin đơn hàng
CREATE TABLE PurchaseOrder (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('PENDING', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    payment_status ENUM('UNPAID', 'PAID') DEFAULT 'UNPAID',
    shipping_address VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- Bảng OrderDetail: Lưu chi tiết đơn hàng (sản phẩm trong đơn hàng)
CREATE TABLE OrderDetail (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    purchase_order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (purchase_order_id) REFERENCES PurchaseOrder(id),
    FOREIGN KEY (product_id) REFERENCES Product(id),
    CONSTRAINT check_quantity CHECK (quantity > 0)
);

-- Thêm dữ liệu mẫu vào bảng Stadium
INSERT INTO Stadium (name, address, area, price_per_hour, description, image_url, contact_phone, field_type, created_at) VALUES
('Sân Lê Lợi', '123 Lê Lợi, TP. Quy Nhơn', 'Quy Nhơn', 150000.00, 'Sân bóng hiện đại, 5 người, có mái che', 'https://example.com/images/stadium-quynhon.jpg', '0901234567', 'Sân 5', '2025-05-23 14:54:00'),
('Sân Phù Cát', '456 Quốc lộ 1A, Huyện Phù Cát', 'Phù Cát', 200000.00, 'Sân bóng 7 người, gần trung tâm huyện', 'https://example.com/images/stadium-phucat.jpg', '0912345678', 'Sân 7', '2025-05-23 14:54:00'),
('Sân Tây Sơn', '789 Đường Nguyễn Huệ, Huyện Tây Sơn', 'Tây Sơn', 250000.00, 'Sân bóng 11 người, cỏ nhân tạo chất lượng cao', 'https://example.com/images/stadium-tayson.jpg', '0923456789', 'Sân 11', '2025-05-23 14:54:00'),
('Sân Hoài Nhơn', '321 Trần Phú, Thị xã Hoài Nhơn', 'Hoài Nhơn', 220000.00, 'Sân bóng 5 người, có đèn chiếu sáng', 'https://example.com/images/stadium-hoainhon.jpg', '0934567890', 'Sân 5', '2025-05-23 14:54:00'),
('Sân An Nhơn', '654 Hùng Vương, Thị xã An Nhơn', 'An Nhơn', 180000.00, 'Sân bóng 7 người, không gian thoáng mát', 'https://example.com/images/stadium-annhon.jpg', '0945678901', 'Sân 7', '2025-05-23 14:54:00');
