# 🔍 DIGITAL LOST & FOUND MANAGEMENT SYSTEM

> A centralized, database-driven web application for managing lost and found items on campus with intelligent matching algorithms and admin verification.

[![Database](https://img.shields.io/badge/Database-MySQL-orange)](https://www.mysql.com/)
[![Status](https://img.shields.io/badge/Status-Review%201%20Complete-success)](https://github.com)
[![DBMS](https://img.shields.io/badge/Course-DBMS%2018CS53-blue)](https://srm.edu)

---

## 📋 TABLE OF CONTENTS

- [Project Overview](#project-overview)
- [Problem Statement](#problem-statement)
- [Solution](#solution)
- [Current Progress](#current-progress)
- [Database Design](#database-design)
- [Installation & Setup](#installation--setup)
- [Usage Examples](#usage-examples)
- [Project Structure](#project-structure)
- [Review 1 Deliverables](#review-1-deliverables)
- [Next Steps](#next-steps)
- [Team Members](#team-members)
- [References](#references)

---

## 🎯 PROJECT OVERVIEW

**Project Name:** Digital Lost & Found Management System  
**Course:** Database Management Systems (18CS53)  
**Semester:** IV  
**Academic Year:** 2025-2026  
**Institution:** SRM Institute of Science and Technology, Chennai  
**Department:** Computer Science & Engineering

### Project Type
Academic DBMS Project - Database Design & Implementation

### Current Phase
✅ **Review 1 Complete** (Feb 10-16, 2026)  
🔄 Review 2 - Backend Development (Upcoming)  
⏳ Review 3 - Frontend & Integration (Upcoming)

---

## 🚨 PROBLEM STATEMENT

### Current Situation

Students and staff in educational institutions lose **200-300 items per semester**, but current methods for reporting and recovering lost items are highly inefficient:

- **WhatsApp Groups**: Messages get buried, no search functionality
- **Physical Notice Boards**: Limited visibility, no real-time updates
- **Verbal Announcements**: Temporary, no permanent record

### Key Statistics

| Metric | Current State | Target |
|--------|--------------|--------|
| **Recovery Rate** | 20% | 60%+ |
| **Search Time** | 3-5 hours | 15-30 minutes |
| **Privacy Issues** | Public contacts | Admin-gated |
| **Data Available** | None | Complete analytics |
| **Accountability** | Zero | Full audit trail |

### Impact

- Financial loss: ₹50,000 - ₹2,00,000 per semester
- Significant time and productivity loss
- Stress and anxiety from losing important items
- No way to identify problem areas on campus

---

## 💡 SOLUTION

### Proposed System

A **centralized database-driven web application** with:

1. **Intelligent Matching Algorithm**
   - Automatic confidence scoring (0-100%)
   - Multi-criteria matching:
     - Category match (40 points)
     - Location similarity (30 points)
     - Date proximity (20 points)
     - Name fuzzy matching (10 points)

2. **Admin Verification Workflow**
   - System creates matches automatically
   - Admin reviews and verifies
   - Calls both parties to confirm
   - Privacy-protected contact sharing

3. **Status Lifecycle Tracking**
   - Pending → Matched → Under Review → Verified → In Collection → Resolved

4. **Complete Audit Trail**
   - Every action logged with timestamp
   - Full history of reports, matches, and verifications

---

## ✅ CURRENT PROGRESS

### What We've Completed (Review 1)

#### Week 1: Problem Identification ✅
- [x] Team formed
- [x] Problem statement documented
- [x] Current system analysis
- [x] Proposed solution defined

#### Week 2: ER Model Design ✅
- [x] Four entities identified
- [x] Attributes defined for each entity
- [x] Relationships mapped (1:M, M:M)
- [x] Cardinality and participation constraints

#### Week 3: Database Implementation ✅
- [x] Database created in MySQL
- [x] All 4 tables implemented
- [x] Primary keys, foreign keys, constraints
- [x] Normalization to 3NF
- [x] Sample data inserted
- [x] Complex queries tested
- [x] Complete workflow demonstrated

### Deliverables Completed ✅

- [x] Chapter 1: Introduction (35KB)
- [x] Chapter 2: System Design (included in report)
- [x] ER Diagram (8 different formats)
- [x] Complete SQL Commands (23KB)
- [x] PowerPoint Presentation (20 slides)
- [x] Review 1 Preparation Guide
- [x] Working MySQL Database

---

## 🗄️ DATABASE DESIGN

### Architecture

```
┌─────────────────────────────────────────┐
│              USERS                      │
│  (Authentication & Contact)             │
└───────────┬────────────┬────────────────┘
            │            │
            │ 1:M        │ 1:M
            │            │
┌───────────▼────────┐   │   ┌────────────▼───────────┐
│   LOST_REPORTS     │   │   │    FOUND_REPORTS       │
│  (Lost Items)      │   │   │   (Found Items)        │
└──────────┬─────────┘   │   └──────────┬─────────────┘
           │             │              │
           │ M:M (via Matches)          │
           └─────────────┼──────────────┘
                         │
                    ┌────▼────────────────────────┐
                    │        MATCHES              │
                    │   (Bridge Table +           │
                    │    Verification)            │
                    └─────────────────────────────┘
```

### Tables Overview

| Table | Purpose | Rows | Key Relationships |
|-------|---------|------|-------------------|
| **Users** | Authentication & contact | 8 columns | → LostReports, FoundReports, Matches |
| **LostReports** | Track lost items | 12 columns | Users → LostReports (1:M) |
| **FoundReports** | Track found items | 12 columns | Users → FoundReports (1:M) |
| **Matches** | Connect & verify matches | 12 columns | LostReports ↔ FoundReports (M:M) |

### Normalization

**Third Normal Form (3NF)**
- ✅ 1NF: All attributes are atomic
- ✅ 2NF: No partial dependencies
- ✅ 3NF: No transitive dependencies

**Benefits:**
- Minimal data redundancy
- Data integrity ensured
- Consistent updates
- Easy maintenance

### Foreign Key Constraints

```sql
LostReports.user_id → Users.user_id (ON DELETE CASCADE)
FoundReports.user_id → Users.user_id (ON DELETE CASCADE)
Matches.lost_id → LostReports.lost_id (ON DELETE CASCADE)
Matches.found_id → FoundReports.found_id (ON DELETE CASCADE)
Matches.admin_id → Users.user_id (ON DELETE SET NULL)
```

---

## 🚀 INSTALLATION & SETUP

### Prerequisites

- MySQL 8.0 or higher
- MySQL Workbench (recommended)
- Basic SQL knowledge

### Step 1: Create Database

```sql
CREATE DATABASE lost_and_found;
USE lost_and_found;
```

### Step 2: Run Schema File

**Option A: MySQL Workbench**
1. Open MySQL Workbench
2. File → Open SQL Script
3. Select `lost_and_found_schema.sql`
4. Execute (⚡ button)

**Option B: Command Line**
```bash
mysql -u root -p lost_and_found < lost_and_found_schema.sql
```

### Step 3: Verify Installation

```sql
SHOW TABLES;
```

Expected output:
```
+---------------------------+
| Tables_in_lost_and_found  |
+---------------------------+
| FoundReports              |
| LostReports               |
| Matches                   |
| Users                     |
+---------------------------+
```

### Step 4: Insert Sample Data (Optional)

```sql
-- Insert test users
INSERT INTO Users (name, email, phone, password, role) VALUES
('Harish Kumar', 'harish@srm.edu', '9876543210', 'hashed_pass', 'student'),
('Admin User', 'admin@srm.edu', '9876543200', 'admin_pass', 'admin');

-- Insert lost item
INSERT INTO LostReports (user_id, item_name, category, description, location, lost_date, color) 
VALUES (1, 'Black Wallet', 'Wallet', 'Contains college ID', 'Library - 2nd Floor', '2024-02-05', 'Black');
```

---

## 💻 USAGE EXAMPLES

### Basic Queries

**View all users:**
```sql
SELECT user_id, name, email, role FROM Users;
```

**View pending lost items:**
```sql
SELECT * FROM LostReports WHERE status = 'Pending';
```

**Search by category:**
```sql
SELECT * FROM LostReports WHERE category = 'Phone';
```

### Advanced Queries

**View complete match details:**
```sql
SELECT 
    m.match_id,
    m.confidence_score,
    lr.item_name AS lost_item,
    u1.name AS lost_by,
    fr.item_name AS found_item,
    u2.name AS found_by
FROM Matches m
JOIN LostReports lr ON m.lost_id = lr.lost_id
JOIN FoundReports fr ON m.found_id = fr.found_id
JOIN Users u1 ON lr.user_id = u1.user_id
JOIN Users u2 ON fr.user_id = u2.user_id;
```

**Admin dashboard - pending matches:**
```sql
SELECT 
    m.match_id,
    lr.item_name AS lost_item,
    fr.item_name AS found_item,
    m.confidence_score,
    u1.phone AS lost_by_phone,
    u2.phone AS found_by_phone
FROM Matches m
JOIN LostReports lr ON m.lost_id = lr.lost_id
JOIN FoundReports fr ON m.found_id = fr.found_id
JOIN Users u1 ON lr.user_id = u1.user_id
JOIN Users u2 ON fr.user_id = u2.user_id
WHERE m.match_status = 'Pending'
ORDER BY m.confidence_score DESC;
```

**System statistics:**
```sql
SELECT 
    'Total Users' AS Metric, COUNT(*) AS Count FROM Users
UNION ALL
SELECT 'Lost Reports', COUNT(*) FROM LostReports
UNION ALL
SELECT 'Found Reports', COUNT(*) FROM FoundReports
UNION ALL
SELECT 'Matches Created', COUNT(*) FROM Matches
UNION ALL
SELECT 'Resolved Cases', COUNT(*) FROM Matches WHERE match_status = 'Resolved';
```

---

## 📁 PROJECT STRUCTURE

```
lost-and-found-system/
│
├── 📄 README.md                              # This file
├── 📄 lost_and_found_schema.sql              # Database creation script
│
├── 📂 documentation/
│   ├── Chapter1_and_Chapter2_Report.md       # Complete report (35KB)
│   ├── ER_Diagram_Visual_Representation.md   # 8 diagram formats (40KB)
│   ├── Complete_SQL_Commands.md              # All SQL queries (23KB)
│   ├── DATABASE_TABLES_SUMMARY.md            # Quick reference
│   └── Review_1_Checklist_and_Guide.md       # Preparation guide
│
├── 📂 presentation/
│   └── Review_1_Presentation.pptx            # 20-slide presentation
│
├── 📂 sql/
│   ├── DrawSQL_Import.sql                    # For ER diagram tools
│   └── DrawSQL_Import_Simplified.sql         # Simplified version
│
└── 📂 screenshots/
    └── er_diagram.png                        # ER diagram image
```

---

## 📊 REVIEW 1 DELIVERABLES

### Documentation ✅

| Document | Size | Status | Purpose |
|----------|------|--------|---------|
| Chapter 1 & 2 Report | 35KB | ✅ Complete | Full project documentation |
| ER Diagram (8 formats) | 40KB | ✅ Complete | Visual database design |
| SQL Commands | 23KB | ✅ Complete | Complete query reference |
| Database Schema | 6.6KB | ✅ Complete | DDL commands |
| Presentation | 20 slides | ✅ Complete | Review 1 presentation |
| Checklist & Guide | 14KB | ✅ Complete | Preparation guide |

### Database Implementation ✅

| Component | Details | Status |
|-----------|---------|--------|
| Tables | 4 tables (Users, LostReports, FoundReports, Matches) | ✅ Complete |
| Relationships | 5 foreign key relationships | ✅ Complete |
| Constraints | Primary keys, foreign keys, unique, not null, default | ✅ Complete |
| Indexes | 13 indexes for performance | ✅ Complete |
| Normalization | Third Normal Form (3NF) | ✅ Complete |
| Sample Data | 4 users, 3 lost, 3 found, 2 matches | ✅ Complete |
| Queries | Basic & complex (JOINs, aggregations) | ✅ Complete |

### DBMS Concepts Demonstrated ✅

- [x] Entity-Relationship Modeling
- [x] Normalization (1NF, 2NF, 3NF)
- [x] Primary & Foreign Keys
- [x] Referential Integrity (CASCADE, SET NULL)
- [x] SQL DDL (CREATE, ALTER, DROP)
- [x] SQL DML (INSERT, UPDATE, DELETE, SELECT)
- [x] Complex Queries (JOINs, Subqueries, Aggregations)
- [x] Indexing for Performance
- [x] ENUM Data Types
- [x] Timestamps & Auto-increment

---

## 🔮 NEXT STEPS

### Review 2: Backend Development (Upcoming)

**Timeline:** March 2026

**Tasks:**
- [ ] Set up Flask/Python environment
- [ ] Create RESTful API endpoints
- [ ] Implement matching algorithm
  - [ ] Calculate confidence scores
  - [ ] Fuzzy string matching
  - [ ] Date proximity calculation
- [ ] User authentication (login/register)
- [ ] Admin verification workflow
- [ ] Status update mechanisms
- [ ] Database connection and queries
- [ ] API testing with Postman

**Deliverables:**
- Working backend API
- Documentation (Chapter 3)
- API endpoint documentation
- Test results

### Review 3: Frontend & Integration (Future)

**Timeline:** April 2026

**Tasks:**
- [ ] HTML/CSS/Bootstrap UI
- [ ] Student dashboard
- [ ] Report submission forms
- [ ] Admin panel
- [ ] Match viewing interface
- [ ] Frontend-backend integration
- [ ] Testing and debugging
- [ ] Deployment preparation

**Deliverables:**
- Complete working application
- Final documentation
- Deployment guide
- Demo video

---

## 📈 TEST RESULTS

### Current System Statistics

| Metric | Value |
|--------|-------|
| Total Users | 4 (3 students + 1 admin) |
| Lost Reports | 3 items |
| Found Reports | 3 items |
| Matches Created | 2 automatic matches |
| Verified Matches | 1 (by admin) |
| Resolved Cases | 1 (successful return) |
| Match Confidence | 88.50% and 92.00% |
| Success Rate | 50% (1 out of 2 resolved) |

### Query Performance

All queries execute in **< 0.02 seconds** on current dataset.

---

## 🎓 LEARNING OUTCOMES

### Technical Skills Gained

- ✅ Database design from problem to implementation
- ✅ ER modeling and normalization
- ✅ SQL DDL and DML commands
- ✅ Complex query writing (JOINs, aggregations)
- ✅ Constraint implementation
- ✅ Index optimization
- ✅ Foreign key relationships

### DBMS Concepts Applied

- Entity-Relationship Model
- Relational Schema Design
- Normalization Theory (1NF, 2NF, 3NF)
- Primary and Foreign Keys
- Referential Integrity
- ACID Properties
- Database Transactions
- Query Optimization

---

## 👥 TEAM MEMBERS

| Name | USN | Role | Contribution |
|------|-----|------|--------------|
| [Your Name] | [Your USN] | Database Designer | ER Model, Schema Design |
| [Team Member 2] | [USN] | SQL Developer | DDL/DML Implementation |
| [Team Member 3] | [USN] | Documentation | Report Writing |
| [Team Member 4] | [USN] | Presentation | Slides & Demo |

**Project Guide:** [Professor Name]  
**Course Instructor:** [Professor Name]  
**Department:** Computer Science & Engineering  
**Institution:** SRM Institute of Science and Technology, Chennai

---

## 📚 REFERENCES

### Books
1. Elmasri, R., & Navathe, S. B. (2015). *Fundamentals of Database Systems* (7th ed.). Pearson.
2. Silberschatz, A., Korth, H. F., & Sudarshan, S. (2019). *Database System Concepts* (7th ed.). McGraw-Hill.

### Online Resources
3. MySQL Documentation. (2024). *MySQL 8.0 Reference Manual*. Oracle Corporation.
4. W3Schools. (2024). *SQL Tutorial*. https://www.w3schools.com/sql/

### Tools Used
5. MySQL Workbench 8.0 - Database Design & Implementation
6. MySQL Server 8.0 - Database Management System
7. DrawSQL - ER Diagram Visualization
8. Python-PPTX - Presentation Creation

---

## 📞 CONTACT

**For Questions or Issues:**
- **Email:** [your.email@srm.edu]
- **GitHub:** [Repository Link]
- **Project Status:** https://github.com/[username]/lost-and-found-system

---

## 📜 LICENSE

This project is created for academic purposes as part of the Database Management Systems course at SRM Institute of Science and Technology.

---

## 🏆 ACKNOWLEDGMENTS

Special thanks to:
- **Project Guide:** [Professor Name] for guidance and support
- **Course Instructor:** [Professor Name] for DBMS concepts
- **Department:** Computer Science & Engineering, SRM IST
- **Peers:** For valuable feedback during development

---

## 📊 PROJECT STATUS

```
Review 1: ████████████████████████ 100% Complete ✅
Review 2: ░░░░░░░░░░░░░░░░░░░░░░░░   0% Upcoming 🔄
Review 3: ░░░░░░░░░░░░░░░░░░░░░░░░   0% Future ⏳
```

**Current Phase:** Review 1 Complete  
**Last Updated:** February 07, 2026  
**Version:** 1.0.0  
**Status:** ✅ Database Implementation Complete

---

## 🎯 QUICK LINKS

- [View Documentation](./documentation/)
- [View SQL Schema](./lost_and_found_schema.sql)
- [View Presentation](./presentation/Review_1_Presentation.pptx)
- [View ER Diagram](./documentation/ER_Diagram_Visual_Representation.md)
- [View SQL Commands](./documentation/Complete_SQL_Commands.md)

---

**⭐ If this project helped you, please star the repository!**

---

**Built with ❤️ by [Your Team Name]**  
**SRM Institute of Science and Technology, Chennai**  
**Academic Year 2025-2026**

---

*Last Updated: February 07, 2026*  
*Version: 1.0.0*  
*Review 1: Complete ✅*
