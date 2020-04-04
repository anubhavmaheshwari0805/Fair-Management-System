/*01. - */use fairdb;
          show tables;
/*02. - */SELECT * FROM Customer;
/*03. - */SELECT * FROM Cust_family;
/*04. - */SELECT * FROM Area;
/*05. - */SELECT * FROM Healthcare_booths;
/*06. - */SELECT * FROM Police;
/*07. - */SELECT * FROM Shops;
/*08. - */SELECT * FROM Health_visit_to;
/*09. - */SELECT * FROM Security_visit_to;
/*10. - */SELECT * FROM Visits;
/*11. - */SELECT * FROM Managing_staff;
/*12. - */SELECT * FROM Manages;

/*13. - Registered customer name and customer id of a person with member id : 'm03'.*/
    SELECT c.cust_id, c.name FROM Customer c, Cust_family f WHERE f.cust_id=c.cust_id AND f.m_id='m03';

/*14. - Number of peoples visited in a shop with shop id : 's02'.*/
    SELECT COUNT(*) FROM Visits WHERE shop_id = 's02';

/*15. - List of members whose age is less than 19.*/
    SELECT * FROM Cust_family WHERE age<19;

/*16. - List of shops with their location name visited by a customer with customer id : 'c03'.*/
    SELECT shop_id, shop_type, name FROM Shops, Area WHERE Shops.area_id=Area.area_id AND shop_id IN (SELECT shop_id FROM Visits WHERE Cust_id='c03');

/*17. - List the managing staff details who is managing 'area07'.*/
    SELECT * FROM Managing_staff WHERE staff_id IN (SELECT staff_id FROM Manages WHERE area_id IN (SELECT area_id FROM Area WHERE name = 'area07'));

/*18. - List the areas where shops are not available.*/
    SELECT * FROM Area WHERE NOT EXISTS (SELECT * FROM Shops WHERE Area.area_id=Shops.area_id);

/*19. - List the name, id of registered person with no. of members.*/
    SELECT c.cust_id, c.name, COUNT(f.m_id)+1 FROM Customer c, Cust_family f WHERE c.cust_id=f.cust_id GROUP BY c.cust_id;

/*20. - List the area id visited by Customer with customer id : 'c01' with date and time details.*/
    (SELECT regdate, regtime, area_id FROM Health_visit_to v, Healthcare_booths h WHERE v.hb_id=h.hb_id AND v.cust_id='c01') UNION
(SELECT regdate, regtime, area_id FROM Security_visit_to v, Police p WHERE v.police_id=p.police_id AND v.cust_id='c01') UNION
(SELECT regdate, regtime, area_id FROM Visits v, Shops s WHERE v.shop_id=s.shop_id AND v.cust_id='c01')
ORDER BY regdate, regtime;

/*21. - List the Police name with their id who is working in 'area01'.*/
    SELECT p.police_id, p.name FROM Police p , Area a WHERE a.area_id=p.area_id AND a.name='area01';

/*22. - A child named 'Anish' is found injured to the Police nameed 'Mohit' . Find the details of registered customer of the child and also details of healbooth incharge and security incharge with area details where the child is now resting.*/
    SELECT c.Cust_id, c.name, c.ph_no, h.hb_id, h.incharge_name, p.police_id, p.name, a.area_id, a.name FROM Customer c, Healthcare_booths h, Police p, Area a Where a.area_id=h.area_id AND a.area_id=p.area_id AND c.cust_id IN (SELECT cust_id FROM Cust_family WHERE name='Anish') AND p.area_id IN (SELECT area_id FROM Police WHERE name='Mohit') AND p.role='healthbooth security';

/*23. - Total no. of police persons in 'area01'.*/
    SELECT COUNT(*) FROM Police WHERE area_id IN (SELECT area_id FROM Area WHERE name='area01');

/*24. - Details of Police Persons who is working the role of "Lost&Found".*/
    SELECT * FROM Police WHERE role='Lost&Found';
