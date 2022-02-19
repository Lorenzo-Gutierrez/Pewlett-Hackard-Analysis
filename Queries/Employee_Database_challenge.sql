-- Join employee names with employee titles for employees born between 1952 and 1955
SELECT em.emp_no, em.first_name, em.last_name, tt.title, tt.from_date, tt.to_date
INTO retirement_titles
FROM employees as em
LEFT JOIN titles as tt
ON (em.emp_no = tt.emp_no)
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Create count of retiring employees by title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Find employees eligible for mentorship
SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, dp.from_date, dp.to_date, tt.title
INTO mentorship_eligibility
FROM employees as em
LEFT JOIN dept_emp as dp
ON (em.emp_no = dp.emp_no)
LEFT JOIN titles as tt
ON (em.emp_no = tt.emp_no)
WHERE dp.to_date = '9999-01-01'
AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;