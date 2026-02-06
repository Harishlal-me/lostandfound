-- ================================================================
-- LOST & FOUND SYSTEM - COMPLETE SQL COMMANDS IN ORDER
-- Execute these commands sequentially from top to bottom
-- ================================================================

-- ================================================================
-- PART 1: DATABASE & TABLE CREATION
-- ================================================================

-- Step 1: Create and Use Database
CREATE DATABASE lost_and_found;
USE lost_and_found;

-- Step 2: Create Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('student', 'admin') DEFAULT 'student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 3: Create LostReports Table
CREATE TABLE LostReports (
    lost_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_name VARCHAR(200) NOT NULL,
    category ENUM(
        'Wallet', 'Phone', 'Keys', 'ID Card', 'Laptop', 
        'Tablet', 'Earphones', 'Bag', 'Water Bottle', 
        'Books', 'Umbrella', 'Charger', 'Watch', 'Jewelry', 'Other'
    ) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    lost_date DATE NOT NULL,
    color VARCHAR(50),
    status ENUM(
        'Pending', 'Matched', 'Under Review', 'Verified', 
        'In Collection', 'Resolved', 'Cancelled'
    ) DEFAULT 'Pending',
    photo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_category (category),
    INDEX idx_lost_date (lost_date),
    INDEX idx_user_id (user_id),
    INDEX idx_item_name (item_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 4: Create FoundReports Table
CREATE TABLE FoundReports (
    found_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_name VARCHAR(200) NOT NULL,
    category ENUM(
        'Wallet', 'Phone', 'Keys', 'ID Card', 'Laptop', 
        'Tablet', 'Earphones', 'Bag', 'Water Bottle', 
        'Books', 'Umbrella', 'Charger', 'Watch', 'Jewelry', 'Other'
    ) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    found_date DATE NOT NULL,
    color VARCHAR(50),
    status ENUM(
        'Pending', 'Matched', 'Under Review', 'Verified', 
        'In Collection', 'Resolved', 'Cancelled'
    ) DEFAULT 'Pending',
    photo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_category (category),
    INDEX idx_found_date (found_date),
    INDEX idx_user_id (user_id),
    INDEX idx_item_name (item_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 5: Create Matches Table
CREATE TABLE Matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    lost_id INT NOT NULL,
    found_id INT NOT NULL,
    confidence_score DECIMAL(5,2) NOT NULL,
    admin_verified BOOLEAN DEFAULT FALSE,
    admin_id INT,
    verification_notes TEXT,
    contact_shared BOOLEAN DEFAULT FALSE,
    match_status ENUM(
        'Pending', 'Under Review', 'Verified', 
        'Rejected', 'Resolved'
    ) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verified_at TIMESTAMP NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (lost_id) REFERENCES LostReports(lost_id) ON DELETE CASCADE,
    FOREIGN KEY (found_id) REFERENCES FoundReports(found_id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    INDEX idx_lost_id (lost_id),
    INDEX idx_found_id (found_id),
    INDEX idx_match_status (match_status),
    INDEX idx_admin_verified (admin_verified),
    INDEX idx_confidence_score (confidence_score)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 6: Verify Tables Created
SHOW TABLES;

-- Step 7: View Table Structures
DESCRIBE Users;
DESCRIBE LostReports;
DESCRIBE FoundReports;
DESCRIBE Matches;


-- ================================================================
-- PART 2: INSERT SAMPLE DATA
-- ================================================================

-- Step 8: Insert Users (3 Students + 1 Admin)
INSERT INTO Users (name, email, phone, password, role) VALUES
('Harish Kumar', 'harish@srm.edu', '9876543210', 'hashed_password_123', 'student'),
('Priya Sharma', 'priya@srm.edu', '9876543211', 'hashed_password_456', 'student'),
('Rahul Verma', 'rahul@srm.edu', '9876543212', 'hashed_password_789', 'student'),
('Admin User', 'admin@srm.edu', '9876543200', 'admin_password_secure', 'admin');

-- Step 9: Verify Users Inserted
SELECT * FROM Users;

-- Step 10: Insert Lost Reports
INSERT INTO LostReports (user_id, item_name, category, description, location, lost_date, color, status) VALUES
(1, 'Black Wallet', 'Wallet', 'Contains college ID, ATM card, and some cash', 'Library - 2nd Floor', '2024-02-05', 'Black', 'Pending'),
(2, 'iPhone 13', 'Phone', 'Blue iPhone 13 with cracked screen protector', 'Cafeteria', '2024-02-06', 'Blue', 'Pending'),
(3, 'HP Laptop', 'Laptop', 'HP Pavilion 15 with "CS Dept" sticker on back', 'Computer Lab - Block A', '2024-02-04', 'Silver', 'Pending');

-- Step 11: Verify Lost Reports Inserted
SELECT * FROM LostReports;

-- Step 12: Insert Found Reports
INSERT INTO FoundReports (user_id, item_name, category, description, location, found_date, color, status) VALUES
(2, 'Black Leather Wallet', 'Wallet', 'Found black wallet with college ID inside', 'Library - 2nd Floor', '2024-02-05', 'Black', 'Pending'),
(3, 'Blue iPhone', 'Phone', 'Found blue iPhone near table 5', 'Cafeteria', '2024-02-06', 'Blue', 'Pending'),
(1, 'Realme Buds 2', 'Earphones', 'White wireless earbuds in charging case', 'Basketball Court', '2024-02-07', 'White', 'Pending');

-- Step 13: Verify Found Reports Inserted
SELECT * FROM FoundReports;

-- Step 14: Insert Matches (System-generated matches)
INSERT INTO Matches (lost_id, found_id, confidence_score, admin_verified, match_status) VALUES
(1, 1, 88.50, FALSE, 'Pending'),  -- Black Wallet match
(2, 2, 92.00, FALSE, 'Pending');  -- iPhone match

-- Step 15: Verify Matches Inserted
SELECT * FROM Matches;


-- ================================================================
-- PART 3: VIEW ALL DATA (BASIC QUERIES)
-- ================================================================

-- Step 16: View All Users
SELECT user_id, name, email, phone, role FROM Users;

-- Step 17: View All Lost Reports with Reporter Names
SELECT 
    lost_id, 
    item_name, 
    category, 
    location, 
    lost_date, 
    status, 
    (SELECT name FROM Users WHERE user_id = LostReports.user_id) AS reported_by
FROM LostReports;

-- Step 18: View All Found Reports with Reporter Names
SELECT 
    found_id,
    item_name,
    category,
    location,
    found_date,
    status,
    (SELECT name FROM Users WHERE user_id = FoundReports.user_id) AS reported_by
FROM FoundReports;

-- Step 19: View Complete Match Details (JOIN Query)
SELECT 
    m.match_id AS 'Match#',
    m.confidence_score AS 'Confidence%',
    m.match_status AS 'Status',
    lr.item_name AS 'Lost Item',
    lr.location AS 'Lost At',
    lr.lost_date AS 'Lost Date',
    u1.name AS 'Lost By',
    u1.phone AS 'Lost Phone',
    fr.item_name AS 'Found Item',
    fr.location AS 'Found At',
    fr.found_date AS 'Found Date',
    u2.name AS 'Found By',
    u2.phone AS 'Found Phone'
FROM Matches m
JOIN LostReports lr ON m.lost_id = lr.lost_id
JOIN FoundReports fr ON m.found_id = fr.found_id
JOIN Users u1 ON lr.user_id = u1.user_id
JOIN Users u2 ON fr.user_id = u2.user_id;


-- ================================================================
-- PART 4: ADMIN WORKFLOW - VERIFY MATCH
-- ================================================================

-- Step 20: Admin Views Pending Matches
SELECT 
    m.match_id,
    lr.item_name AS lost_item,
    fr.item_name AS found_item,
    m.confidence_score,
    u1.name AS lost_by,
    u1.phone AS lost_by_phone,
    u2.name AS found_by,
    u2.phone AS found_by_phone
FROM Matches m
JOIN LostReports lr ON m.lost_id = lr.lost_id
JOIN FoundReports fr ON m.found_id = fr.found_id
JOIN Users u1 ON lr.user_id = u1.user_id
JOIN Users u2 ON fr.user_id = u2.user_id
WHERE m.match_status = 'Pending';

-- Step 21: Admin Verifies Match #1 (Wallet Match)
UPDATE Matches 
SET 
    admin_verified = TRUE,
    admin_id = 4,
    match_status = 'Verified',
    verification_notes = 'Called both parties. Harish confirmed wallet has SRM ID card. Priya confirmed same. Match verified. Coordinating exchange at admin office.',
    verified_at = NOW()
WHERE match_id = 1;

-- Step 22: View Updated Match
SELECT * FROM Matches WHERE match_id = 1;

-- Step 23: View Verified Match with Full Details
SELECT 
    m.match_id,
    m.confidence_score,
    m.match_status,
    m.admin_verified,
    a.name AS verified_by_admin,
    m.verification_notes,
    m.verified_at,
    lr.item_name AS lost_item,
    u1.name AS lost_by,
    u1.phone AS lost_phone,
    fr.item_name AS found_item,
    u2.name AS found_by,
    u2.phone AS found_phone
FROM Matches m
JOIN LostReports lr ON m.lost_id = lr.lost_id
JOIN FoundReports fr ON m.found_id = fr.found_id
JOIN Users u1 ON lr.user_id = u1.user_id
JOIN Users u2 ON fr.user_id = u2.user_id
LEFT JOIN Users a ON m.admin_id = a.user_id
WHERE m.match_id = 1;


-- ================================================================
-- PART 5: COMPLETE THE WORKFLOW - RESOLVE MATCH
-- ================================================================

-- Step 24: Admin Shares Contacts and Marks as Resolved
UPDATE Matches 
SET 
    contact_shared = TRUE,
    match_status = 'Resolved'
WHERE match_id = 1;

-- Step 25: Update Lost Report Status
UPDATE LostReports 
SET status = 'Resolved' 
WHERE lost_id = 1;

-- Step 26: Update Found Report Status
UPDATE FoundReports 
SET status = 'Resolved' 
WHERE found_id = 1;

-- Step 27: View Final Status of All Three Records
SELECT 
    'Match Status' AS Type,
    match_status AS Status,
    contact_shared AS Contacts_Shared
FROM Matches WHERE match_id = 1
UNION ALL
SELECT 
    'Lost Report Status' AS Type,
    status AS Status,
    '-' AS Contacts_Shared
FROM LostReports WHERE lost_id = 1
UNION ALL
SELECT 
    'Found Report Status' AS Type,
    status AS Status,
    '-' AS Contacts_Shared
FROM FoundReports WHERE found_id = 1;


-- ================================================================
-- PART 6: SYSTEM STATISTICS & ANALYTICS
-- ================================================================

-- Step 28: Complete System Dashboard
SELECT 'Total Users' AS Metric, COUNT(*) AS Count FROM Users
UNION ALL
SELECT 'Total Lost Reports', COUNT(*) FROM LostReports
UNION ALL
SELECT 'Total Found Reports', COUNT(*) FROM FoundReports
UNION ALL
SELECT 'Total Matches Created', COUNT(*) FROM Matches
UNION ALL
SELECT 'Verified Matches', COUNT(*) FROM Matches WHERE admin_verified = TRUE
UNION ALL
SELECT 'Resolved Cases', COUNT(*) FROM Matches WHERE match_status = 'Resolved'
UNION ALL
SELECT 'Pending Reviews', COUNT(*) FROM Matches WHERE match_status = 'Pending'
UNION ALL
SELECT 'Success Rate %', 
    ROUND((COUNT(CASE WHEN match_status = 'Resolved' THEN 1 END) * 100.0 / COUNT(*)), 2)
FROM Matches;


-- ================================================================
-- PART 7: ADDITIONAL SAMPLE DATA (OPTIONAL)
-- ================================================================

-- Step 29: Add More Users
INSERT INTO Users (name, email, phone, password, role) VALUES
('Sneha Patel', 'sneha@srm.edu', '9112233445', 'pass123', 'student'),
('Vikram Singh', 'vikram@srm.edu', '9223344556', 'pass456', 'student');

-- Step 30: Add More Lost Items
INSERT INTO LostReports (user_id, item_name, category, description, location, lost_date, color) VALUES
(5, 'Apple Watch Series 7', 'Watch', 'Black watch with sports band', 'Gym', '2024-02-07', 'Black'),
(6, 'Red Umbrella', 'Umbrella', 'Large red umbrella with wooden handle', 'Main Gate', '2024-02-06', 'Red');

-- Step 31: Add More Found Items
INSERT INTO FoundReports (user_id, item_name, category, description, location, found_date, color) VALUES
(1, 'Smart Watch', 'Watch', 'Black sports watch found near lockers', 'Gym', '2024-02-08', 'Black');

-- Step 32: Create New Match for Watch
INSERT INTO Matches (lost_id, found_id, confidence_score, match_status) 
VALUES (4, 4, 95.50, 'Pending');

-- Step 33: View Updated System Statistics
SELECT COUNT(*) AS total_users FROM Users;
SELECT COUNT(*) AS total_lost FROM LostReports;
SELECT COUNT(*) AS total_found FROM FoundReports;
SELECT COUNT(*) AS total_matches FROM Matches;


-- ================================================================
-- PART 8: USEFUL SEARCH QUERIES
-- ================================================================

-- Step 34: Search Lost Items by Category
SELECT * FROM LostReports WHERE category = 'Phone';

-- Step 35: Search by Location
SELECT * FROM LostReports WHERE location LIKE '%Library%';

-- Step 36: Search by Date Range
SELECT * FROM LostReports WHERE lost_date BETWEEN '2024-02-01' AND '2024-02-07';

-- Step 37: Find High Confidence Matches (>90%)
SELECT * FROM Matches 
WHERE confidence_score > 90 
ORDER BY confidence_score DESC;

-- Step 38: Top 5 Locations with Most Lost Items
SELECT location, COUNT(*) AS total 
FROM LostReports 
GROUP BY location 
ORDER BY total DESC 
LIMIT 5;

-- Step 39: Match Statistics by Status
SELECT 
    match_status,
    COUNT(*) AS total
FROM Matches
GROUP BY match_status;

-- Step 40: Items Lost in Last 7 Days
SELECT * FROM LostReports 
WHERE lost_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);


-- ================================================================
-- PART 9: COMMON UPDATE OPERATIONS
-- ================================================================

-- Step 41: Update User Phone Number
-- UPDATE Users SET phone = '9999888877' WHERE user_id = 1;

-- Step 42: Update Lost Item Status
-- UPDATE LostReports SET status = 'Matched' WHERE lost_id = 2;

-- Step 43: Add Photo to Lost Report
-- UPDATE LostReports SET photo_url = 'https://example.com/photo.jpg' WHERE lost_id = 2;

-- Step 44: Admin Verifies Another Match
-- UPDATE Matches 
-- SET admin_verified = TRUE, admin_id = 4, match_status = 'Verified' 
-- WHERE match_id = 2;


-- ================================================================
-- PART 10: COMMON DELETE OPERATIONS (USE WITH CAUTION)
-- ================================================================

-- Step 45: Delete a Lost Report (if user found item elsewhere)
-- DELETE FROM LostReports WHERE lost_id = 3;

-- Step 46: Delete a Match
-- DELETE FROM Matches WHERE match_id = 3;

-- Step 47: Delete a User (will cascade delete their reports)
-- DELETE FROM Users WHERE user_id = 5;


-- ================================================================
-- CONGRATULATIONS! SYSTEM IS FULLY OPERATIONAL
-- ================================================================
-- You can now:
-- ✅ Create new users, lost reports, found reports
-- ✅ Generate matches with confidence scores
-- ✅ Admin can verify and resolve matches
-- ✅ Track complete lifecycle: Pending → Matched → Verified → Resolved
-- ✅ Run analytics and generate reports
-- ================================================================
