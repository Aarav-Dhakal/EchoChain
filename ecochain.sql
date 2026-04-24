create database ecochain;

use ecochain;

CREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    role        ENUM('admin', 'donor', 'organization') NOT NULL,
    status      ENUM('pending', 'active', 'suspended') DEFAULT 'pending',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE donors (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    business_name   VARCHAR(150) NOT NULL,
    address         VARCHAR(255) NOT NULL,
    license_number  VARCHAR(100) NOT NULL,
    phone           VARCHAR(20) NOT NULL,
    reputation_score DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE organizations (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    user_id             INT NOT NULL,
    org_name            VARCHAR(150) NOT NULL,
    address             VARCHAR(255) NOT NULL,
    phone               VARCHAR(20) NOT NULL,
    area_of_service     VARCHAR(150) NOT NULL,
    reg_certificate     VARCHAR(255) NOT NULL,
    total_food_received DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE listings (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    donor_id        INT NOT NULL,
    category_id     INT NOT NULL,
    food_name       VARCHAR(150) NOT NULL,
    quantity        DECIMAL(10,2) NOT NULL,
    unit            VARCHAR(50) NOT NULL,
    expiry_date     DATE NOT NULL,
    storage_notes   TEXT,
    allergens       VARCHAR(255),
    status          ENUM('available', 'requested', 'picked_up', 'expired') DEFAULT 'available',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (donor_id) REFERENCES donors(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE pickups (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    listing_id      INT NOT NULL,
    org_id          INT NOT NULL,
    quantity        DECIMAL(10,2) NOT NULL,
    pickup_time     DATETIME NOT NULL,
    status          ENUM('pending', 'approved', 'rejected', 'completed', 'cancelled') DEFAULT 'pending',
    notes           TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    FOREIGN KEY (org_id) REFERENCES organizations(id) ON DELETE CASCADE
);

CREATE TABLE feedback (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    pickup_id   INT NOT NULL,
    org_id      INT NOT NULL,
    donor_id    INT NOT NULL,
    rating      INT CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pickup_id) REFERENCES pickups(id) ON DELETE CASCADE,
    FOREIGN KEY (org_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (donor_id) REFERENCES donors(id) ON DELETE CASCADE
);

CREATE TABLE wishlist (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    org_id      INT NOT NULL,
    listing_id  INT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE
);

INSERT INTO users (full_name, email, password, role, status)
VALUES ('Admin', 'admin@ecochain.com', 'admin123', 'admin', 'active');

INSERT INTO categories (name) VALUES
('Dairy'),
('Produce'),
('Baked Goods'),
('Canned Goods'),
('Beverages'),
('Frozen Food'),
('Cooked Meals');