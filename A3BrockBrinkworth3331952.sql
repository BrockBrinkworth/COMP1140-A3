-- Removing database to allow creation of databse
drop database A3
create database A3;
go


-- Removing tables to allow reruns
drop table Reservation
drop table AcquisitionRequest
drop table Privilege
drop table CourseOffering
drop table Loan
drop table CourseEnrollment
drop table StaffMember
drop table StudentMember
drop table Member
drop table ImmovableResource
drop table MovableResource
drop table CourseDetails
drop table Course
drop table ResourceDetails
drop table Resource
drop table Location
drop table Category
go


create table Category (
	CategoryID    int identity(1,1) not null,
	Name      varchar(20),
    Descriptions  varchar(50),
	MaxPeriodInHrs   int   not null,
	primary key (CategoryID),
);
go

create table Location (
	LocationID     int identity(1,1) not null,
	Room      Varchar(20),
	Building  Varchar(20),
	Campus    Varchar(20),
	primary key (locationID),
);
go

create table Resource (
	ResourceID      varchar(10) not null, 
	ReStatus        varchar(20) default 'available' check (ReStatus IN ('available', 'occupied', 'damaged'))not null, 
	CategoryID      int,
	LocationID      int,
	primary key (ResourceID),
	foreign key (CategoryID) references Category(CategoryID) on update cascade on delete no action,
	foreign key (LocationID) references Location(LocationID) on update cascade on delete no action
);
go

create table ResourceDetails (
	ReDescription   varchar(50) not null,
	ResourceID varchar(10) not null references Resource(ResourceID)
);
go

create table Course (
	CourseID int,
	CourseName varchar(50),
	Avaliability varchar(20) default 'avaliable' check (Avaliability in ('avaliable', 'not avaliable'))not null,
	primary key (CourseID)
);
go

create table CourseDetails (
	CourseDetails varchar(200),
	CourseContent varchar(200),
	CourseID int,
	primary key (CourseDetails),
	foreign key (CourseID) references Course(CourseID) on update cascade on delete no action
);
go

create table MovableResource (
	ResourceID      varchar (10) not null,
	Name            varchar (50), 
	MoType          varchar(50), 
	MoManufacturer  varchar(30), 
	MoModel         varchar(30), 
    MoPrice         varchar(15),

	primary key (ResourceID),
	foreign key (ResourceID) references resource(ResourceID) on update cascade on delete no action
);
go

create table ImmovableResource (
	ResourceID      varchar (10) not null,
	Name            varchar (50), 
	MoType          varchar(50), 
	MoManufacturer  varchar(30), 
	MoModel         varchar(30), 
    MoPrice         varchar(15),

	primary key (ResourceID),
	foreign key (ResourceID) references resource(ResourceID) on update cascade on delete no action
);
go

create table Member (
	MemberID      varchar(15) not null, 
	Name          varchar(20) not null, 
	DOB           datetime2 not null, 
	TeleNum       int,
	Email         varchar(20) not null, 
	StartDate     date not null, 
	Status        varchar(8) default 'active' check (Status IN ('active', 'expire')) not null, 
	primary key (MemberID),
);
go

create table StudentMember (
	MemberID        varchar(15) not null, 
	Name varchar(20) not null,
	StuPoints        int,
	primary key (MemberID),
	foreign key (MemberID) references Member(MemberId) on update cascade on delete no action
);
go

create table StaffMember (
	MemberID        varchar(15) not null,
	Name varchar(20) not null,
	StaPoints        int,
	primary key (MemberID),
	foreign key (MemberID) references Member(MemberId) on update cascade on delete no action
);
go

create table CourseEnrollment (
	MemberID varchar(15),
	CourseID int,
	foreign key (MemberID) references StudentMember(MemberID),
	foreign key (CourseID) references Course(CourseID)
);
go

create table Loan (
	LoanID			 int identity(1,1),
    DateTimeBorrowed date not null, 
	DateTimeReturned date,
	DateTimeDue      date not null,
	Maximum			 int,
	ResourceID       varchar(10) not null,
	MemberID         varchar(15) not null,
	primary key (LoanID),
	foreign key (MemberID) references Member on update cascade on delete no action,
	foreign key (ResourceID) references MovableResource on update cascade on delete no action
);
go

create table CourseOffering (
	OfferID int identity(1,1) primary key,
	CourseID int not null,
	Semester int,
	Year int,
	Date date,
	foreign key (CourseID) references Course(CourseID) on update cascade on delete no action
);
go

create table AcquisitionRequest (
	RequestID int identity(1,1) primary key,
	LoanID int,
	AcquisitionRequests int
	foreign key (LoanID) references Loan(LoanID) on update cascade on delete no action
);
go

create table Reservation (
	ReservationID int identity(1,1) primary key,
	LoanID int,
	Reservations int,
	Date date,
	LocationID int not null references Location(LocationID),
	foreign key (LoanID) references Loan(LoanID) on update cascade on delete no action
);
go

create table Privilege (
	MemberID varchar(15) primary key,
	Privilege varchar(10) default 'student' check (Privilege in ('student', 'staff'))not null
);
go
 
-----------------------------------
-- Data creation
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('Beaker', 'Glass container', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('TextBook', 'Mathematics textbook', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('Ball', 'Dodge Ball', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('Speaker', 'Speaker for sound', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('ChemicalCleaner', 'Cleans Chemicals on equipment', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('MountedProjector', 'Projector mounted on roof', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('BasketBallHoop', 'Mounted hoop for basket ball', 3);
insert into Category(Name, Descriptions, MaxPeriodInHrs) values ('Camera', 'photo or video camera', 3);

insert into Location(Room, Building, Campus) values ('SC101', 'Science', 'Callaghan');
insert into Location(Room, Building, Campus) values ('MT221', 'Mathematics', 'Callaghan');
insert into Location(Room, Building, Campus) values ('PE51', 'Sports Centre', 'Callaghan');
insert into Location(Room, Building, Campus) values ('LB1', 'Library', 'Callaghan');
insert into Location(Room, Building, Campus) values ('SC102', 'Science', 'Callaghan');
insert into Location(Room, Building, Campus) values ('MT222', 'Mathematics', 'Callaghan');
insert into Location(Room, Building, Campus) values ('PE50', 'Sports Centre', 'Callaghan');
insert into Location(Room, Building, Campus) values ('SC105', 'Science', 'Callaghan');

insert into Resource values ('BK36', 'occupied', '1', '1');
insert into Resource values ('TB12', 'occupied', '2', '2');
insert into Resource values ('BL121', 'occupied', '3', '3');
insert into Resource values ('SK32', 'occupied', '4', '4');
insert into Resource values ('CC01', 'occupied', '5', '5');
insert into Resource values ('MP12', 'occupied', '6', '6');
insert into Resource values ('BH02', 'occupied', '7', '7');
insert into Resource values ('CM09', 'occupied', '8', '8');

insert into ResourceDetails values ('Glass beaker used in science labratories','BK36');
insert into ResourceDetails values ('Mathematics TextBook','TB12');
insert into ResourceDetails values ('Ball used in dodge ball','BL121');

insert into Course values (2345101, 'BioChemistry', 'avaliable');
insert into Course values (4567211, 'Statistics', 'avaliable');
insert into Course values (1123120, 'Education', 'avaliable');

insert into CourseDetails values ('BioChemistry details', 'BioChemistry content', 2345101);
insert into CourseDetails values ('Statistics details', 'Statistics Content', 4567211);
insert into CourseDetails values ('Bachelor of Education details', 'Bachelor of Education Details', 1123120);

insert into MovableResource values ('BK36', 'Beaker', 'Science', 'Cosmic', '36', '$40');
insert into MovableResource values ('TB12', 'Mathematics textbook', 'Mathematics', 'Newton', '12', '$120');
insert into MovableResource values ('BL121', 'Ball', 'Sports', 'Nike', '121', '$30');
insert into MovableResource values ('SK32', 'Speaker', 'Library', 'Samsung', '32', '$85');
insert into MovableResource values ('CM09', 'Camera', 'Science', 'InstaCapture', '211', '$985');

insert into ImmovableResource values ('CC01', 'ChemicalCleaner', 'Science', 'Sleek', '01', '$672');
insert into ImmovableResource values ('MP12', 'MountedProjector', 'Mathematics', 'Beam', '124', '$143');
insert into ImmovableResource values ('BH02', 'BasketBallHoop', 'Sports', 'Addidas', '02', '$169');

insert into Member values ('c1112345', 'Sulayman Fry', '2020-02-29', 0423869544, 'c1112345@uon.edu.au', '', 'active');
insert into Member values ('c1112346', 'Viktoria Novak', '2020-02-29', 0482756632, 'c1112346@uon.edu.au', '', 'active');
insert into Member values ('c1112347', 'Xena Baxter', '2020-02-29', 0472839002, 'c1112347@uon.edu.au', '', 'active');
insert into Member values ('c0001234', 'Lorenzo Xiong', '2019-02-18', 0498286501, 'c0001234@uon.edu.au', '', 'active');
insert into Member values ('c0001235', 'Olli Devlin', '2019-02-18', 0498002101, 'c0001235@uon.edu.au', '', 'active');
insert into Member values ('c0001236', 'Izabel Noble', '2019-02-18', 0456788300, 'c0001236@uon.edu.au', '', 'active');

insert into StudentMember values ('c1112345', 'Sulayman Fry', 12);
insert into StudentMember values ('c1112346', 'Viktoria Novak', 12);
insert into StudentMember values ('c1112347', 'Xena Baxter', 12);

insert into StaffMember values ('c0001234', 'Lorenzo Xiong', 0);
insert into StaffMember values ('c0001235', 'Olli Devlin', 0);
insert into StaffMember values ('c0001236', 'Izabel Noble', 0);

insert into CourseEnrollment values ('c1112345', 2345101);
insert into CourseEnrollment values ('c1112346', 4567211);
insert into CourseEnrollment values ('c1112347', 1123120);

insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2020-05-01', '2020-05-09', '2020-05-11', 10, 'BK36', 'c1112345');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2020-06-05', '2020-06-12', '2020-06-15', 10, 'TB12', 'c1112346');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2020-09-19', '2020-09-21', '2020-09-29', 10, 'BL121', 'c1112347');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2019-10-01', '2019-10-07', '2019-10-11', 10, 'SK32', 'c1112345');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2019-05-21', '2019-05-23', '2019-06-01', 100, 'BK36', 'c0001234');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2019-04-30', '2019-05-03', '2019-05-09', 100, 'TB12', 'c0001235');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2019-07-11', '2019-07-15', '2019-07-21', 100, 'BL121', 'c0001236');
insert into Loan(DateTimeBorrowed, DateTimeReturned, DateTimeDue, Maximum, ResourceID, MemberID) values ('2020-04-13', '2020-04-17', '2020-04-23', 10, 'CM09', 'c1112346');

insert into CourseOffering(CourseID, Semester, Year, Date) values ( 2345101, 1, '2020', '2020-02-10');
insert into CourseOffering(CourseID, Semester, Year, Date) values ( 4567211, 1, '2020', '2020-02-10');
insert into CourseOffering(CourseID, Semester, Year, Date) values ( 1123120, 1, '2020', '2020-02-10');
insert into CourseOffering(CourseID, Semester, Year, Date) values ( 2345101, 1, '2021', '2021-02-10');
insert into CourseOffering(CourseID, Semester, Year, Date) values ( 4567211, 1, '2021', '2021-02-10');
insert into CourseOffering(CourseID, Semester, Year, Date) values ( 1123120, 1, '2021', '2021-02-10');

insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (1, 1);
insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (2, 1);
insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (3, 1);
insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (4, 1);
insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (5, 3);
insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (6, 5);
insert into AcquisitionRequest(LoanID, AcquisitionRequests) values (7, 2);

insert into Reservation(LoanID, Reservations, Date, LocationID) values (1, 1, '2020-05-01', 1);
insert into Reservation(LoanID, Reservations, Date, LocationID) values (2, 1, '2020-06-05', 2);
insert into Reservation(LoanID, Reservations, Date, LocationID) values (3, 1, '2020-09-19', 3);
insert into Reservation(LoanID, Reservations, Date, LocationID) values (4, 1, '2019-10-01', 4);
insert into Reservation(LoanID, Reservations, Date, LocationID) values (5, 2, '2019-05-21', 5);
insert into Reservation(LoanID, Reservations, Date, LocationID) values (6, 5, '2019-04-30', 6);
insert into Reservation(LoanID, Reservations, Date, LocationID) values (7, 3, '2019-07-11', 7);

insert into Privilege values ('c1112345', 'student');
insert into Privilege values ('c1112346', 'student');
insert into Privilege values ('c1112347', 'student');
insert into Privilege values ('c0001234', 'staff');
insert into Privilege values ('c0001235', 'staff');
insert into Privilege values ('c0001236', 'staff');

-----------------------------------
-- Output

--- Query 1 ---
select CourseEnrollment.CourseID, StudentMember.Name
from CourseEnrollment, StudentMember
where CourseID = '2345101';
---

--- Query 2 ---
select Loan.Maximum, StudentMember.Name
from Loan join Member on (Loan.MemberID = Member.MemberID) join StudentMember on (StudentMember.MemberID = Member.MemberID) join CourseEnrollment on (CourseEnrollment.MemberID = Member.MemberID)
where StudentMember.Name = 'Xena Baxter' and CourseEnrollment.CourseID = 1123120;
---

--- Query 3 ---
select StaffMember.Name , Member.TeleNum, AcquisitionRequest.AcquisitionRequests, Reservation.Reservations, YEAR('2019') as year
from StaffMember join Member on (StaffMember.MemberID = Member.MemberID) join Loan on (Loan.MemberID = Member.MemberID) join AcquisitionRequest on (AcquisitionRequest.LoanID = Loan.LoanID) join Reservation on (Reservation.LoanID = Loan.LoanID)
where StaffMember.MemberID = 'c0001235' and Reservation.Date > '2019-01-01' and Reservation.Date < '2019-12-30';
---

--- Query 4 ---
select StudentMember.Name
from StudentMember join Loan on (Loan.MemberID = StudentMember.MemberID) join MovableResource on (MovableResource.ResourceID = Loan.ResourceID)
where MovableResource.MoModel = '211';
---

--- Query 5 - I am making current month = September ---
select MovableResource.ResourceID, MovableResource.Name, MAX(Reservation.Reservations)
from MovableResource join Loan on (Loan.ResourceID = MovableResource.ResourceID) join Member on (Loan.MemberID = Member.MemberID) join Reservation on (Loan.LoanID = Reservation.LoanID)
where Reservation.Date > '2020-09-01' and Reservation.Date < '2020-09-30'
group by MovableResource.ResourceID, MovableResource.Name;
---

--- Query 6 ---
select Reservation.Date, Location.Room, Reservation.Reservations
from Reservation join Location on (Reservation.LocationID = Location.LocationID)
where Reservation.Date = '2020-05-01' or Reservation.Date = '2020-06-05' or Reservation.Date = '2020-09-19';
---

-----------------------------------