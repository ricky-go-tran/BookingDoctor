# BookingDoctor
*"BookingDoctor - Connecting Patients and Clinics"*

## Introduction
BookingDoctor serves as a platform that bridges the gap between patients and individual clinics. Operating on a model akin to hotel or tour booking websites, its primary objective is to enhance the convenience for patients when selecting a suitable clinic. By enabling advance bookings and offering access to reviews and comments, patients can make informed decisions. Recognizing the financial constraints faced by individual clinics, which may hinder their ability to invest in dedicated management software, BookingDoctor steps in to provide essential functionalities such as inventory management, statistics, and medical records. This integrated approach empowers clinics to efficiently manage their resources without the burden of acquiring separate software solutions.

## Description
Below are some descriptions of this application. Within the system, there will be 3 roles:

- **System Administrator:** User management has lock/unlock users, create users with other system management roles. Feedback management from clinics and patients. Inventory management.
- **Clinic:** View the schedule of patient appointments (Real-time notifications when a patient makes a booking). Manage information such as service pricing, operating hours, general information (name, address, etc.). Create patient profiles has add patient personal information, add patient results and prescriptions schedule follow-up appointments. Print invoices and prescriptions. Inventory management. Generate revenue and inventory statistics (PDF, spreadsheets, charts).
- **Clinic:** View a list and search for clinics. View clinic information has appointment availability, service pricing, general information, queue status, book/cancel appointments. Access medical records has view appointment history at specific clinics, view results and prescriptions from specific clinics, receive appointment reminders (background job).
There are more analyses available, such as use case diagrams and database diagrams at the following link: <https://puffy-ceiling-4ab.notion.site/BookingDoctor-0e80dfb604dc40d3b09afec834e9207f?pvs=4>
## Technologies
To develop the BookingDoctor website, we utilize the following technologies:

  - Rails 7 (BE framework)
  - HTML, SCSS, JS, Slim (Frontend)
  - Devise, pundit, rolify (Authentication, Authorization)
  - Active Mailer (Send mail)
  - Background Job (Schedule)
  - Active Cable (Realtime notice)
  - pry-rails (Debug)
  - Rspec (Testing)
## Feature
  - [x] All actor: Authentication and Authorization
  - [x] All: homepage
  - [x] Clinic, Admin: Medical Resource and Inventory management 
  - [x] Clinic: Clinic profile
  - [x] Clinic: Patient management 
  - [x] Patient: Clinic management
  - [x] Patient: Patient management
  - [x] Patient: payment
  - [x] Patient: rate  
  - [x] Admin: Category management 
  - [x] Admin: User management
## How To Use? 
- **Step 1:** Download source


  ![image](https://github.com/ricky-go-tran/BookingDoctor/assets/136413699/a782fe31-928c-44c6-a2c4-66a8b409a8df)
  

- **Step 2:** Install ruby ​​and rails environment. (Tutorial: https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm)
- **Step 3:** Prepare a stripe account, webhook,key. (Stripe: https://stripe.com/)
- **Step 4:** Prepare postgresql
  
  - With local: [https://www.postgresql.org/](https://www.postgresql.org/download/)https://www.postgresql.org/download/
  - Or use host
- **Step 5:** Run `bundle install` to install all denpendencies
- **Step 6:**  With local database config can config in  config/database.yml

  
![image](https://github.com/ricky-go-tran/BookingDoctor/assets/136413699/34076b62-4334-4319-a147-23497d126bb2)

- **Step 7:** Delete old cretials and add new file with following content:
   `secret_key_base: ((value))
    postgres_host: ((value))
    database_name: ((value))
    postgres_user: ((value))
    postgres_password: ((value))
    stripe_publishable_key:((value))
    stripe_secret_key: ((value))
    email_password: ((value))`  
-  **Step 8:** Create database `rails db:create`
-  **Step 9:** Migrate database `rails db:migrate` but not following default. Use migrate up each file in order to avoid foreign key errors
![BookingDoctor (1)](https://github.com/ricky-go-tran/BookingDoctor/assets/136413699/a7ac1aa1-a487-4137-ab31-5e94bf055e9f)
 
- **Step 10:** Run seed file
- **Step 11:** Run `rails server`
