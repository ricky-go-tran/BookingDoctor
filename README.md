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
  - [ ] All actor: Authentication and Authorization
  - [ ] All: homepage
  - [ ] Clinic, Admin: Inventory management
  - [ ] Clinic: Clinic profile
  - [ ] Clinic: Patient management
  - [ ] Patient: Clinic management
  - [ ] Patient: Patient management
  - [ ] Admin: User management
  - [ ] Admin: Feedback management
