# 19BDS0042 SAMARTH GUPTA
# DATABASE MANAGEMENT SYSTEMS LAB
# LAB CYCLE SHEET-1
# SLOT : L43+L44

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Q-1 : CREATING ALL TABLES WITH APPROPRIATE CONSTRAINTS :-

a) Doctor
SQL> CREATE TABLE Doctor(
2 Doc_ID VARCHAR(5) PRIMARY KEY CHECK(Doc_ID LIKE ('D%')),
3 Doc_Name VARCHAR(20) NOT NULL,
4 Gender char(1) NOT NULL CHECK(Gender in ('M','F','T’)),
5 DOB date,
6 Specialist VARCHAR(20) NOT NULL,
7 Qualification VARCHAR(30) NOT NULL,
8 Contact NUMBER(10),
9 Address VARCHAR(50),
10 Dt_No VARCHAR(8) CHECK(Dt_No Like ('D%'))
11 )
12 ;
Table created.

b) Department
SQL> CREATE TABLE Department(
2 Dt_No VARCHAR(8) PRIMARY KEY,
3 Dt_Name VARCHAR(20),
4 Room_No NUMBER(3) NOT NULL,
5 Floor NUMBER(1),
6 HOD VARCHAR(5),
7 CONSTRAINT hod_fk FOREIGN KEY(hod) REFERENCES Doctor(Doc_ID) ON DELETE CASCADE,
8 Estd_Date DATE CHECK(Estd_Date>'01-JAN-2010')
9 );
Table created.

c) Staff
SQL> CREATE TABLE Staff(
2 Staff_ID VARCHAR(5) PRIMARY KEY CHECK(Staff_ID LIKE ('S%')),
3 Staff_Name VARCHAR(20) NOT NULL,
4 Category VARCHAR(20),
5 Designation VARCHAR(20) NOT NULL,
6 DOB DATE,
7 Contact NUMBER(10),
8 Address VARCHAR(50),
9 Dt_No VARCHAR(8),
10 constraint Dt_No_staff_fk FOREIGN KEY(Dt_No) REFERENCES Department(Dt_No) ON DELETE CASCADE
11 );
Table created.

d) Patient
SQL> CREATE TABLE Patient(
2 Pat_ID VARCHAR(7) PRIMARY KEY CHECK(Pat_ID LIKE('P%')),
3 Pat_Name VARCHAR(20) NOT NULL,
4 DOB DATE,
5 Gender CHAR(1) CHECK(Gender in ('M','F','T')),
6 Contact NUMBER(10) NOT NULL,
7 Address VARCHAR(50)
8 );
Table created.

e) In_Patient
SQL> CREATE TABLE In_Patient(
2 Pat_ID VARCHAR(7) CHECK(Pat_ID LIKE ('P%')),
3 Date_Of_Admission DATE,
4 Bed_No NUMBER(3) NOT NULL,
5 Start_Time DATE,
6 End_Time DATE,
7 CONSTRAINT patid_inpatient_fk FOREIGN KEY(Pat_ID) REFERENCES Patient(Pat_ID) ON DELETE CASCADE,
8 CONSTRAINT starttime_chk CHECK(Start_Time>Date_Of_Admission and Start_Time<End_Time),
9 PRIMARY KEY (Pat_ID,Date_Of_Admission)
10 );
Table created.

f) In_Patient_Prescription
SQL> CREATE TABLE In_Patient_Prescription(
2 Pat_ID VARCHAR(7) CHECK(Pat_ID LIKE('P%')),
3 CONSTRAINT patid_inpatientpres_fk FOREIGN KEY(Pat_ID) REFERENCES Patient(Pat_ID)
4 ON DELETE CASCADE,
5 Pres_ID VARCHAR(7) CHECK(Pres_ID LIKE('PR%'))
6 );
Table created.

g) Appointment
SQL> CREATE TABLE Appointment(
2 App_ID VARCHAR(8) PRIMARY KEY CHECK(App_ID LIKE('APP%')),
3 Pat_ID VARCHAR(7) NOT NULL CHECK (Pat_ID LIKE('P%')),
4 CONSTRAINT patid_appt_fk FOREIGN KEY(Pat_ID) REFERENCES Patient(Pat_ID)
5 ON DELETE CASCADE,
6 Doc_ID VARCHAR(5) NOT NULL CHECK(Doc_ID LIKE('D%')),
7 CONSTRAINT docid_appt_fk FOREIGN KEY(Doc_ID) REFERENCES Doctor(Doc_ID)
8 ON DELETE CASCADE,
9 Nurse_ID VARCHAR(5) NOT NULL CHECK(Nurse_ID LIKE ('S%')),
10 CONSTRAINT nurseid_appt_fk FOREIGN KEY(Nurse_ID) REFERENCES Staff(Staff_ID)
11 ON DELETE CASCADE,
12 Consult_Room_No NUMBER(3) NOT NULL,
13 Appt_Time timestamp
14 );
Table created.

h) Prescription
SQL> CREATE TABLE Prescription(
2 Pres_ID VARCHAR(7) PRIMARY KEY CHECK(Pres_ID LIKE('PR%')),
3 App_ID VARCHAR(8) NOT NULL CHECK(App_ID LIKE ('APP%')),
4 CONSTRAINT pres_appid_fk FOREIGN KEY(App_ID) REFERENCES Appointment(App_ID) ON DELETE CASCADE,
5 Pres_Time timestamp,
6 Diagnosis_Detail VARCHAR(50)
7 );
Table created.

i) Prescribed Medicines
SQL> CREATE TABLE Prescribed_Medicines(
2 Pres_ID VARCHAR(7) CHECK(Pres_ID LIKE('PR%')),
3 CONSTRAINT presmeds_presid_fk FOREIGN KEY(Pres_ID) REFERENCES Prescription(Pres_ID)
4 ON DELETE CASCADE,
5 Medicine_name VARCHAR(15),
6 Dosage VARCHAR(20),
7 Brand VARCHAR(20),
8 PRIMARY KEY(Pres_ID,Medicine_name)
9 );
Table created.

j) Hospital Bill
SQL> CREATE TABLE Hospital_Bill(
2 Inv_No NUMBER(4),
3 Inv_Date date,
4 PRIMARY KEY(Inv_No,Inv_Date),
5 Pat_ID VARCHAR(7) CHECK(Pat_ID LIKE ('P%')) NOT NULL,
6 CONSTRAINT hbill_patid_fk FOREIGN KEY(Pat_ID) REFERENCES Patient(Pat_ID) ON DELETE CASCADE,
7 Bill_Amount NUMBER(9,2) NOT NULL,
8 Payment_Type VARCHAR(10) NOT NULL,
9 Discount NUMBER(6,2) NOT NULL
10 );
Table created.

k) Lab Tests
SQL> CREATE TABLE Lab_Tests(
2 Test_ID VARCHAR(5) NOT NULL CHECK(Test_ID LIKE('T%')),
3 Pat_ID VARCHAR(7) CHECK(Pat_ID LIKE('P%')),
4 CONSTRAINT labtest_patid_fk FOREIGN KEY(Pat_ID) REFERENCES Patient(Pat_ID)
5 ON DELETE CASCADE,
6 Labtest_Time_Date timestamp,
7 PRIMARY KEY(Test_ID)
8 );
Table created.

l)Test_Results
SQL> CREATE TABLE Test_Results(
2 Test_ID VARCHAR(5) CHECK(Test_ID LIKE ('T%')),
3 CONSTRAINT testres_testid_fk FOREIGN KEY(Test_ID) REFERENCES Lab_Tests(Test_ID)
4 ON DELETE CASCADE,
5 TT_ID VARCHAR(7) CHECK(TT_ID LIKE ('TT%')),
6 PRIMARY KEY(Test_ID,TT_ID),
7 Result VARCHAR(30)
8 );
Table created.

m) Test Types
SQL> CREATE TABLE Test_Types(
2 TT_ID VARCHAR(7) PRIMARY KEY CHECK(TT_ID LIKE ('TT%')),
3 Description VARCHAR(20),
4 Low_Value NUMBER(3) NOT NULL,
5 High_Value NUMBER(3) NOT NULL,
6 Test_Method VARCHAR(25),
7 Technician VARCHAR(5),
8 CONSTRAINT tech_tt_fk FOREIGN KEY(Technician) REFERENCES Staff(Staff_ID) ON DELETE CASCADE
9 );
Table created.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

REQUIRED ALTERATION IN TABLES:

SQL> alter TABLE Doctor add constraint Dtno_fk FOREIGN KEY(Dt_No) REFERENCES Department(Dt_No) ON DELETE CASCADE;
Table altered.
SQL> alter TABLE In_Patient_Prescription add constraint inpatient_presid_fk FOREIGN KEY(Pres_ID) REFERENCES Prescription(Pres_ID) ON DELETE CASCADE;
Table altered.
SQL> alter TABLE Test_Results add constraint ttid_testres_fk FOREIGN KEY
2 (TT_ID) REFERENCES Test_Types(TT_ID) ON DELETE CASCADE;
Table altered.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Q-2 : INSERTING VALUES in Table: -
a) Doctor
SQL> INSERT INTO Doctor VALUES('D0001','Raghavan','M','10-JAN-1980','Cardiology','MBBS',8999345622,'Panvel Plaza','D001');
1 row created.
SQL> INSERT INTO Doctor VALUES('D0002','Manimaran','M','15-DEC-1981','Neurology','MS',8932345624,'Andheri East','D012');
1 row created.
SQL> INSERT INTO Doctor VALUES('D0003','Meenakshi','F','19-APR-1980','Gynaecology','BDS',9932344625,'Bandra Extension','D002');
1 row created.
SQL> INSERT INTO Doctor VALUES('D0011','Saleem','M','30-MAR-1985','General Medicine','MD',7732344627,'Janaki Colony','D102');
1 row created.
SQL> INSERT INTO Doctor VALUES('D0065','Jayalakshmi','F','07-JUL-1989','Diabetes','MDS',8792345624,'Bharat Colony Main','D010');
1 row created.

b) Department
SQL> INSERT INTO Department VALUES('D001','Cardiology',121,3,'D0001','14-SEP-2011');
1 row created.
SQL> INSERT INTO Department VALUES('D012','Neurology',202,1,'D0002','25-JUN-2019');
1 row created.
SQL> INSERT INTO Department VALUES('D002','Gynaecology',205,2,'D0003','30-OCT-2017');
1 row created.
SQL> INSERT INTO Department VALUES('D102','Intensive Care Unit',402,4,'D0011','03-JAN-2020');
1 row created.
SQL> INSERT INTO Department VALUES('D010','Diabetes',114,1,'D0065','09-AUG-2014');
1 row created.

c) Staff
SQL> INSERT INTO Staff VALUES('S0012','Shyam','Lab Technician','Technician','10-FEB-1992','7767741058','Chandni Chowk','D010');
SQL> INSERT INTO Staff VALUES('S0005','Geetha','Nurse','Head Nurse','02-MAY-1993','9967741352','Civil Lines','D002');
1 row created.
SQL> INSERT INTO Staff VALUES('S0018','Muralidharan','Attender','Junior Attender','17-FEB-1994','6967741355','Shaniwar Waada','D001');
1 row created.
SQL> INSERT INTO Staff VALUES('S0009','Giriraj','Helper','ICU Helper','09-NOV-1990','9667731354','Mukti Mohan Parkside','D102');
1 row created.
SQL> INSERT INTO Staff VALUES('S0025','Vishwanath','Attender','Senior Attender','11-SEP-1988','7567761346','Gandhi Nagar','D012');
1 row created.
SQL> INSERT INTO Staff VALUES('S0045','Ranjan','Lab Technician','Technician','22-MAR-1991','8169989377','Bharhut Nagar','D002');
1 row created.

d) Patient
SQL> INSERT INTO Patient VALUES('P1001','Karthik','15-JAN-2000','M','9442897645','Gyan Ganga Colony');
1 row created.
SQL> INSERT INTO Patient VALUES('P1002','Seema','01-JUN-1995','F','9878987890','Gyan Ganga Colony');
1 row created.
SQL> INSERT INTO Patient VALUES('P1003','Ramakant','26-JAN-1990','M','8878687894','Bihari Chowk');
1 row created.
SQL> INSERT INTO Patient VALUES('P101','Mani','02-APR-2000','M','7878687791','Avinashi Road');
1 row created.
SQL> INSERT INTO Patient VALUES('P220','Gayle','12-AUG-1991','M','9898687999','Virat Nagar');
1 row created.
SQL> INSERT INTO Patient VALUES('P1005','Steve','31-OCT-1994','M','7894687921','Deeksha Colony');
1 row created.

e) In_Patient
SQL> INSERT INTO In_Patient VALUES('P1001','18-FEB-2018',204,'20-FEB-2018','27-FEB-2018');
1 row created.
SQL> INSERT INTO In_Patient VALUES('P1002','01-MAY-2017',100,'03-MAY-2017','07-MAY-2017');
1 row created.
SQL> INSERT INTO In_Patient VALUES('P1003','08-MAR-2017',100,'10-MAR-2017','10-APR-2017');
1 row created.
SQL> INSERT INTO In_Patient VALUES('P101','11-SEP-2017',111,'15-SEP-2017','21-SEP-2017');
1 row created.
SQL> INSERT INTO In_Patient VALUES('P220','18-JUL-2019',108,'19-JUL-2019','29-JUL-2019');
1 row created.
SQL> INSERT INTO In_Patient VALUES('P1005','25-DEC-2018',100,'26-DEC-2018','30-DEC-2018');
1 row created.

f) In_Patient_Prescription
SQL> INSERT INTO In_Patient_Prescription VALUES('P1001','PR00012');
1 row created.
SQL> INSERT INTO In_Patient_Prescription VALUES('P1002','PR00002');
1 row created.
SQL> INSERT INTO In_Patient_Prescription VALUES('P1003','PR00003');
1 row created.
SQL> INSERT INTO In_Patient_Prescription VALUES('P101','PR00101');
1 row created.
SQL> INSERT INTO In_Patient_Prescription VALUES('P220','PR00220');
1 row created.
SQL> INSERT INTO In_Patient_Prescription VALUES('P1005','PR00005');
1 row created.

g) Appointment
SQL> INSERT INTO Appointment VALUES('APP001','P1001','D0065','S0012',008,'17-FEB-2018 04:32:40');
1 row created.
SQL> INSERT INTO Appointment VALUES('APP002','P1002','D0011','S0009',123,'30-APR-2017 08:00:00');
1 row created.
SQL> INSERT INTO Appointment VALUES('APP003','P1003','D0001','S0018',111,'11-JAN-2020 10:00:00');
1 row created.
SQL> INSERT INTO Appointment VALUES('APP004','P101','D0002','S0025',324,'10-SEP-2017 12:00:00');
1 row created.
SQL> INSERT INTO Appointment VALUES('APP005','P220','D0003','S0005',102,'17-JUL-2019 09:00:00');
1 row created.
SQL> INSERT INTO Appointment VALUES('APP006','P1005','D0065','S0018',205,'24-DEC-2018 11:30:00');
1 row created.

h) Prescription
SQL> INSERT INTO Prescription VALUES('PR001','APP001','28-FEB-2018 07:00:00','High Cholestrol Level');
1 row created.
SQL> INSERT INTO Prescription VALUES('PR002','APP002','07-MAY-2017 08:20:23','Spine Fracture');
1 row created.
SQL> INSERT INTO Prescription VALUES('PR00012','APP003','12-MAR-2017 12:30:25','Pneumonia');
1 row created.
SQL> INSERT INTO Prescription VALUES('PR004','APP004','25-SEP-2017 07:55:59','Malaria With Fever');
1 row created.
SQL> INSERT INTO Prescription VALUES('PR005','APP005','01-AUG-2019 06:50:10','Asthama');
1 row created.
SQL> INSERT INTO Prescription VALUES('PR006','APP006','01-JAN-2019 02:44:12','Gastoenteritis');
1 row created.

i) Prescribed_Medicines
SQL> INSERT INTO Prescribed_Medicines VALUES('PR001','Cestrizine','Twice a day','Ranbaxy');
1 row created.
SQL> INSERT INTO Prescribed_Medicines VALUES('PR002','Cyra-D','Thrice a day','Sun Pharma');
1 row created.
SQL> INSERT INTO Prescribed_Medicines VALUES('PR00012','Rantidine','Once a day','Patanjali');
1 row created.
SQL> INSERT INTO Prescribed_Medicines VALUES('PR004','Supracal','Twice a Day','XYZ');
1 row created.
SQL> INSERT INTO Prescribed_Medicines VALUES('PR005','Calamine','Thrice a Day','Birla Care');
1 row created.
SQL> INSERT INTO Prescribed_Medicines VALUES('PR006','Juzgot','Once a Day','Ultramed');

j) Hospital Bill
SQL> INSERT INTO Hospital_Bill VALUES(001,'28-FEB-2018','P1001',90000,'Debit Card',100);
1 row created.
SQL> INSERT INTO Hospital_Bill VALUES(002,'08-MAY-2017','P1002',120000,'Cash',100);
1 row created.
SQL> INSERT INTO Hospital_Bill VALUES(003,'11-APR-2017','P1003',140500,'Debit Card',500);
1 row created.
SQL> INSERT INTO Hospital_Bill VALUES(004,'22-SEP-2017','P101',60000,'Debit Card',200);
1 row created.
SQL> INSERT INTO Hospital_Bill VALUES(005,'30-JUL-2019','P220',110000,'Debit Card',800);
1 row created.
SQL> INSERT INTO Hospital_Bill VALUES(006,'31-DEC-2018','P1005',20000,'Cash',350);
1 row created.

k) Lab Tests
SQL> INSERT INTO Lab_Tests VALUES('T0001','P1001','25-FEB-2018 07:00:00');
1 row created.
SQL> INSERT INTO Lab_Tests VALUES('T0002','P1002','05-MAY-2017 11:30:00');
1 row created.
SQL> INSERT INTO Lab_Tests VALUES('T0003','P1003','09-APR-2017 12:30:40');
1 row created.
SQL> INSERT INTO Lab_Tests VALUES('T0004','P101','20-SEP-2017 05:50:00');
1 row created.
SQL> INSERT INTO Lab_Tests VALUES('T0005','P220','25-JUL-2019 06:00:20');
1 row created.
SQL> INSERT INTO Lab_Tests VALUES('T0006','P1005','29-DEC-2018 02:40:45');
1 row created.

l) Test Results
SQL> INSERT INTO Test_Results VALUES('T0001','TT001','Positive');
1 row created.
SQL> INSERT INTO Test_Results VALUES('T0002','TT002','Negative');
1 row created.
SQL> INSERT INTO Test_Results VALUES('T0003','TT003','Negative');
1 row created.
SQL> INSERT INTO Test_Results VALUES('T0004','TT004','Positive');
1 row created.
SQL> INSERT INTO Test_Results VALUES('T0005','TT005','Positive');
1 row created.
SQL> INSERT INTO Test_Results VALUES('T0006','TT001','Negative');
1 row created.

m) Test Types
SQL> INSERT INTO Test_Types VALUES('TT001','Blood Test',40,96,'Blood Glucose Level','S0045');
1 row created.
SQL> INSERT INTO Test_Types VALUES('TT002','Urine Test',20,80,'Urine Sample','S0012');
1 row created.
SQL> INSERT INTO Test_Types VALUES('TT003','Blood Test',24,76,'Blood Sample','S0045');
1 row created.
SQL> INSERT INTO Test_Types VALUES('TT004','Urine Test',45,85,'Urine Sample','S0012');
1 row created.
SQL> INSERT INTO Test_Types VALUES('TT005','Blood Test',21,83,'Blood Glucose Level','S0045');
1 row created.
SQL> INSERT INTO Test_Types VALUES('TT006','Urine Test',33,53,'Urine Sample','S0012');
1 row created.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Q-3 : Adding some attributes and justifying the additions:

1. Doctor – The experience of a Doctor is very important for severe operations.
SQL> alter TABLE Doctor add Doc_Exp_Yr NUMBER(2);
Table altered.

2. Staff – The staff experience is necessary for handling critical situations.
SQL> alter TABLE Staff add Staff_Exp_Yr NUMBER(2);
Table altered.

3. In_Patient – The brief description of patient’s symptoms and problems must be recorded.
SQL> alter TABLE In_Patient add Patient_Problem VARCHAR(50);
Table altered.

4. Prescribed_Medicines – The rate of each medicine should be provided for patient.
SQL> alter TABLE Prescribed_Medicines add value NUMBER(5);
Table altered.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Q-4 : DML Queries for the following questions:

a) Find the details of all doctors.
SQL> SELECT *FROM Doctor;
DOC_I DOC_NAME G DOB SPECIALIST
----- -------------------- - --------- --------------------
QUALIFICATION CONTACT
------------------------------ ----------
ADDRESS DT_NO
-------------------------------------------------- --------
D0001 Raghavan M 10-JAN-80 Cardiology
MBBS 8999345622
Panvel Plaza D001
D0002 Manimaran M 15-DEC-81 Neurology
MS 8932345624
Andheri East D012
D0003 Meenakshi F 19-APR-80 Gynaecology
BDS 9932344625
Bandra Extension D002
D0011 Saleem M 30-MAR-85 General Medicine
MD 7732344627
Janaki Colony D102
D0065 Jayalakshmi F 07-JUL-89 Diabetes
19BDS0042 SAMARTH GUPTA
MDS 8792345624
Bharat Colony Main D010


b) Display all the hospital bill details.
SQL> SELECT*FROM Hospital_Bill;
INV_NO INV_DATE PAT_ID BILL_AMOUNT PAYMENT_TY DISCOUNT
---------- --------- ------- ----------- ---------- ----------
1 28-FEB-18 P1001 90000 Debit Card 100
2 08-MAY-17 P1002 120000 Cash 100
3 11-APR-17 P1003 140500 Debit Card 500
4 22-SEP-17 P101 60000 Debit Card 200
5 30-JUL-19 P220 110000 Debit Card 800
6 31-DEC-18 P1005 20000 Cash 350
6 rows Selected.


c) List the doctors who are specialized in ‘Cardiology’ and ‘Neurology’
SQL> SELECT* FROM Doctor WHERE Specialist in('Cardiology','Neurology');
DOC_I DOC_NAME G DOB SPECIALIST
----- -------------------- - --------- --------------------
QUALIFICATION CONTACT
------------------------------ ----------
ADDRESS DT_NO
-------------------------------------------------- --------
D0001 Raghavan M 10-JAN-80 Cardiology
MBBS 8999345622
Panvel Plaza D001
D0002 Manimaran M 15-DEC-81 Neurology
MS 8932345624
Andheri East D012


d) List all the appointments made for consultation room number 111 , on ’11-Jan-2020’.
SQL> SELECT*FROM Appointment WHERE Consult_Room_No=111 and Appt_Time='11-JAN-2020 10:00:00';
APP_ID PAT_ID DOC_I NURSE CONSULT_ROOM_NO
-------- ------- ----- ----- ---------------
APPT_TIME
---------------------------------------------------------------------------
19BDS0042 SAMARTH GUPTA
APP003 P1003 D0001 S0018 111
11-JAN-20 10.00.00.000000 AM


e) Display all the test types that have the VALUES in the range of 25 and 75.
SQL> SELECT *FROM Test_Types
2 WHERE Low_Value > 25 and High_Value<75;
TT_ID DESCRIPTION LOW_VALUE HIGH_VALUE TEST_METHOD
------- -------------------- ---------- ---------- -------------------------
TECHN
-----
TT006 Urine Test 33 53 Urine Sample
S0012


g) Display the name of the patients whose gender is female or the contact NUMBER is 9878987890.
SQL> SELECT Pat_Name FROM Patient WHERE Gender='F' OR Contact=9878987890;
PAT_NAME
--------------------
Seema


h) Find the staff name and staff id who are not working in the Department ‘D102’
SQL> SELECT Staff_Name,Staff_ID FROM Staff WHERE Dt_No != 'D102';
STAFF_NAME STAFF_ID
-------------------- -----
Shyam S0012
Geetha S0005
Muralidharan S0018
Vishwanath S0025
Ranjan S0045


i) Find the patients who are admitted on ’01-May-2020’ in the bed 100.
SQL> SELECT Patient.Pat_Name
2 FROM Patient join In_Patient
3 on Patient.Pat_ID = In_Patient.Pat_ID
4 WHERE In_Patient.Date_Of_Admission='01-MAY-2020' and In_Patient.Bed_No=100;
no rows Selected
SQL> SELECT Patient.Pat_Name
2 FROM Patient join In_Patient
3 on Patient.Pat_ID = In_Patient.Pat_ID
4 WHERE In_Patient.Date_Of_Admission='01-MAY-2017' and In_Patient.Bed_No=100;
PAT_NAME
--------------------
Seema


j) Delete the test results that are ‘Positive’
SQL> DELETE FROM Test_Results WHERE Result='Positive';
3 rows deleted.


k) Increase the discount with 5% more for all the patients whose bill amount is greater than 100000.
SQL> UPDATE Hospital_Bill SET Discount=Discount+(0.05*Discount) WHERE Bill_Amount>100000;
3 rows updated.


l) Change the HOD of cardiology Department with doctor ‘D0003’
SQL> UPDATE Department SET HOD='D0003' WHERE Dt_Name='Cardiology';
1 row updated.


m) Delete the prescribed medicines records that have the brand name ‘XYZ’
SQL> delete FROM Prescribed_Medicines WHERE Brand='XYZ';
1 row deleted.


n) Modify the low value and high value to 10 and 30 respectively for the clinical test ‘urine’
SQL> update Test_Types set Low_Value=10,High_Value=30 WHERE Description='Urine Test';
3 rows updated.


o) Update the contact NUMBER of all staffs who are in the category ‘Nurse’
SQL> update Staff set Contact=9876543210 WHERE Category='Nurse';
1 row updated.


p) Delete the staff records that have designations ‘junior attender’ or ‘technician’ and belongs to the Department ‘D190’.
SQL> DELETE FROM Staff WHERE Dt_No='D190'
2 AND Category IN('Junior Attender','Technician');
0 rows deleted.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
