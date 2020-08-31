/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

SELECT name FROM `Facilities` WHERE membercost<>0;



/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT(name) FROM `Facilities` WHERE membercost=0;



/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance  
FROM `Facilities` 
WHERE (membercost>0) AND (membercost<=monthlymaintenance*20/100);



/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

SELECT *  
FROM `Facilities` 
WHERE facid IN (1,5);



/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

SELECT name,`monthlymaintenance` ,
CASE
	WHEN `monthlymaintenance`>=100 THEN 'expensive'
	ELSE 'cheap'
END AS remark_on_maintenance
FROM `Facilities



/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

SELECT firstname,surname,joindate
FROM `Members`
ORDER BY joindate DESC;



/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT firstname, surname,f.name
FROM `Members` AS m
LEFT JOIN `Bookings` AS b
ON m.memid=b.memid
LEFT JOIN `Facilities` AS f
ON b.facid=f.facid
WHERE f.name IN('Tennis Court 1','Tennis Court 2')
ORDER BY firstname,surname;



/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

# For question 8 and 9, I imported the DB in PostgreSQL 

SELECT
	CONCAT(firstname,' ',surname) AS fullname,
	CASE 
		WHEN (b.memid=0) AND (f.guestcost*b.slots>30.0) THEN (f.guestcost*b.slots)
		WHEN (b.memid>0) AND (f.membercost*b.slots>30.0) THEN (f.membercost*b.slots)
		ELSE 0
	END AS cost,
	f.name	
FROM members as m
LEFT JOIN bookings as b
ON m.memid=b.memid
LEFT JOIN facilities as f
ON b.facid=f.facid 
WHERE date(starttime)='2012-09-14' 
        AND  CASE 
                WHEN (b.memid=0) AND (f.guestcost*b.slots>30.0) THEN TRUE
				WHEN (b.memid>0) AND (f.membercost*b.slots>30.0) THEN TRUE
            END 
ORDER BY cost DESC;


/* Q9: This time, produce the same result as in Q8, but using a subquery. */

# still using PostgreSQL

SELECT
	CONCAT(firstname,' ',surname) AS fullname,
	CASE 
		WHEN (bf.memid=0) AND (bf.guestcost*bf.slots>30.0) THEN (bf.guestcost*bf.slots)
		WHEN (bf.memid>0) AND (bf.membercost*bf.slots>30.0) THEN (bf.membercost*bf.slots)
		ELSE 0
	END AS cost,
	bf.name	
FROM members as m
LEFT JOIN (SELECT b.memid,b.slots,b.facid,f.guestcost,f.membercost,f.name
		   FROM bookings as b
		   LEFT JOIN facilities AS f
		   ON b.facid=f.facid 
		   WHERE date(starttime)='2012-09-14' ) AS bf
ON m.memid=bf.memid
WHERE CASE 
        WHEN (bf.memid=0) AND (bf.guestcost*bf.slots>30.0) THEN TRUE
		WHEN (bf.memid>0) AND (bf.membercost*bf.slots>30.0) THEN TRUE
		END
ORDER BY cost DESC;



/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  
---- for question 10 to 13, I will be using PostgreSQL in which I imported the country club data into PostgreSQL. I was not able to connect to a "local instance of SQLite3 on my machine" despite hours of googling,installing,updating... and requesting help on slack. It took me ten minutes to connect to a local instance of PostgreSQL in Python. The code to establish the ocnnection can be found below:

# I am using the module psycopg2 to connect the CountryClub database which has been uploaded in my local instance of PostgreSQL
# I am suing the Error class of psycopg2 because I like to know why a code failed as opposed to googling for hours to find out what is the meaning behind a cryptic error

import psycopg2
try:
    connection = psycopg2.connect(user = "postgres",
                                  password = "Bunny",
                                  host = "127.0.0.1",
                                  port = "5432",
                                  database = "CountryCLub")

    cursor = connection.cursor()
    # Print PostgreSQL Connection properties
    print ( connection.get_dsn_parameters(),"\n")

    # Print PostgreSQL version
    cursor.execute("SELECT version();")
    record = cursor.fetchone()
    print("You are connected to - ", record,"\n")

except (Exception, psycopg2.Error) as error :
    print ("Error while connecting to PostgreSQL", error)

I'll close my connection once done with work with the following
  
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

cursor.execute("""
SELECT
	sub.paid,
	sub.facility_name
FROM
	(SELECT 
	SUM(CASE 	WHEN b.memid=0 THEN (f.guestcost*b.slots)
				WHEN b.memid>0 THEN (f.membercost*b.slots)
				ELSE 0
				END ) AS paid,
	name AS facility_name
FROM facilities as f
LEFT JOIN bookings as b
ON f.facid=b.facid
GROUP BY f.name
ORDER BY facility_name) AS sub
WHERE sub.paid<1000
ORDER BY sub.paid;""")
cursor.fetchall()


/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */


cursor.execute("""
SELECT
	m.firstname AS member_firstname,
	m.surname AS member_surname,
	referral.who_referred as referred_by
	
FROM members as m
LEFT JOIN (
	SELECT 
		CONCAT(memb.firstname,' ',memb.surname) AS who_referred,
		memb.recommendedby AS id
 	FROM members as memb
	WHERE CAST(memb.memid as int) IN(
		SELECT
			DISTINCT CAST(msub.recommendedby AS int)
		FROM members AS msub
		WHERE (msub.recommendedby NOTNULL))) AS referral
ON CAST(m.memid AS int)=CAST(referral.id AS int)
ORDER BY member_surname,member_firstname;""")
cursor.fetchall()



/* Q12: Find the facilities with their usage by member, but not guests */

 
cursor.execute("""
SELECT
	mem_only.name AS facility_name,
	CONCAT(m.firstname,' ',m.surname) AS member_name,
	mem_only.used AS usage
FROM members as m
LEFT JOIN (
	SELECT 
		SUM(CASE 	WHEN b.memid>0 THEN b.slots
		   			ELSE 0 END) as used,
		f.name,
		b.memid
	FROM facilities AS f
	LEFT JOIN bookings AS b
	ON f.facid=b.facid
	WHERE b.memid>0
    GROUP BY f.name,b.memid) AS mem_only
ON m.memid=mem_only.memid
GROUP BY member_name,facility_name,usage
ORDER BY member_name;""")
cursor.fetchall()


/* Q13: Find the facilities usage by month, but not guests */

## As all the data was recorded in 2012, I did not have to discriminate years to clarify the month column

cursor.execute("""
SELECT
	mem_only.name AS facility_name,
	CONCAT(m.firstname,' ',m.surname) AS member_name,
	mem_only.used AS usage,
	mem_only.mth AS month
FROM members as m
LEFT JOIN (
	SELECT 
		SUM(CASE 	WHEN b.memid>0 THEN b.slots
		   			ELSE 0 END) as used,
		f.name,
		b.memid,
		EXTRACT(MONTH FROM b.starttime) AS mth
	FROM facilities AS f
	LEFT JOIN bookings AS b
	ON f.facid=b.facid
	WHERE b.memid>0
GROUP BY f.name,b.memid,mth) AS mem_only
ON m.memid=mem_only.memid
GROUP BY member_name,facility_name,usage,month
ORDER BY facility_name,month,member_name;""")
cursor.fetchall()
