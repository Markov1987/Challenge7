-- Challenge 7
-- Marco Antonio Salazar Pérez 

-- Creating titles Table
-- Note there are values repeated both for title and emp_no, thus, we can't define a primary key. 

CREATE TABLE titles (
emp_no INT NOT NULL,
title VARCHAR(30) NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


-- Deliverable 1
-- Eliminate previous table
drop table retirement_titles;
-- Selection using nicknames
SELECT 
    em.emp_no, 
    em.first_name, 
    em.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
-- Create new table
INTO retirement_titles

-- Define nicknames
FROM employees as em
INNER JOIN titles AS ti
-- Define link
ON (em.emp_no = ti.emp_no)
-- Filter
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- Order
ORDER BY emp_no ASC;

-- Retrieve data from recently created retirement_titles table (nickname =rt)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

-- Create new table with unique values
INTO unique_retirement_titles
-- Define Nickname
FROM retirement_titles AS rt
-- Gruou By and Order
ORDER BY emp_no ASC, to_date DESC;

--Count to review output
SELECT COUNT(urt.emp_no),urt.title

FROM unique_retirement_titles as urt
GROUP BY title 
ORDER BY COUNT(title) DESC;
-- Export CSV --\Challenge 7\Queries\unique_retirement_titles.csv




-- Deliverable 2

-- Selection using nicknames
SELECT DISTINCT ON(em.emp_no) 
    em.emp_no,
    em.first_name,
    em.last_name,
    em.birth_date,
    de.from_date,
    de.to_date,
    ti.title

-- Create New Table
INTO eligibility

-- Define nicknames
FROM employees AS em

-- Join
INNER JOIN dept_emp AS de
ON (em.emp_no = de.emp_no)

-- Next Join
INNER JOIN titles AS ti
ON (em.emp_no = ti.emp_no)

-- Filter 
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

-- Show new table
SELECT * FROM eligibility;

-- Export CSV --\Challenge 7\Queries\mentorship_eligibilty.csv
