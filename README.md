# Web Application: User Search & Money Transfers

## 📌 Overview
This web application allows users to:
- Search for other users by **username** or **unique ID**.
- Perform **secure money transfers** between accounts.
- View **detailed transaction history** (recorded and visible to both sender & receiver).
- Manage and update **user profiles**.
- Access profiles through **unique IDs or usernames**.

The backend is implemented in **PHP**, while the frontend uses **HTML, CSS, and JavaScript**.  
A **Bash script** automates account creation with:
- Random usernames  
- Secure passwords  
- Initial balance of **100 units**

---

## ⚙️ Core Functionalities
- 🔍 User search by username or ID  
- 💸 Money transfers between users  
- 🧾 Transaction history for both parties  
- 👤 Profile management & updates  
- 🔑 Unique user identification  

---

## 🔐 Security Mechanisms Implemented

1. **User Authentication & Session Management**  
   - Secure login, registration, and logout.  
   - Prevents unauthorized access.  

2. **SQL Transactions & Input Validation**  
   - Maintains **data integrity** during transfers.  
   - Protects against **SQL injection** attacks.  

3. **SSL Certificate**  
   - Encrypts data in transit.  
   - Guards against **Man-in-the-Middle (MITM)** attacks.  

4. **User Activity Logging**  
   - Logs user actions, accessed pages, IP addresses, and timestamps.  
   - Enables **security monitoring & audit trails**.  

5. **Access Control via Unique User IDs**  
   - Validates user IDs before fetching profile data.  
   - Prevents unauthorized profile access.  

6. **Dockerized Deployment**  
   - Runs application in **isolated containers**.  
   - Reduces risks from misconfigurations and external threats.  

7. **Secure Database**  
   - Database protected with a **strong password**.  

8. **Hashed User Passwords**  
   - Passwords are hashed using **bcrypt**.  
   - Prevents easy reversal of credentials.  

9. **Secure Backend with PDO Queries (PHP)**  
   - Uses **prepared statements** for safe query execution.  

---

## 🚀 Tech Stack
- **Frontend**: HTML, CSS, JavaScript  
- **Backend**: PHP (PDO-based queries)  
- **Database**: MySQL (secured with strong password)  
- **Automation**: Bash scripting for account creation  
- **Deployment**: Docker containers  

---

