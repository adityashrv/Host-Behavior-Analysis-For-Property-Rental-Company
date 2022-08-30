use project
--toronto
sELECT * FROM toronto_availability
sELECT * FROM toronto_host
sELECT * FROM toronto_listing
sELECT * FROM toronto_review
update toronto_host set host_response_rate = 0 where host_response_rate is null
update toronto_listing set review_scores_value = 0 where review_scores_value is null
--vancouver
sELECT * FROM vancouver_availability
sELECT * FROM vancouver_host
sELECT * FROM vancouver_listing
sELECT * FROM vancouver_review
update vancouver_host set host_response_rate = 0 where host_response_rate is null
update vancouver_listing set review_scores_value = 0 where review_scores_value is null

----a. Analyze different metrics to draw the distinction between Super Host and Other Hosts:
----To achieve this, you can use the following metrics and explore a few yourself as well. 
----	Acceptance rate, response rate, instant booking, profile picture, identity verified, 
--review review scores, average no of bookings per month, etc.    

--TORONTO
select a.host_is_superhost,a.host_identity_verified , a.host_has_profile_pic, b.instant_bookable,
datepart(month,c.date)  as month_number,datepart(year,c.date) as year_number, 
count(c.id) total_booking, 
count(a.host_is_superhost) as count_true_false, 
avg(a.host_acceptance_rate)as avg_acceptance_rate,
avg(a.host_response_rate) as avg_response , avg(b.review_scores_value) as avg_review 
from toronto_host as a inner join toronto_listing as b on a.host_id=b.host_id 
join toronto_availability c on c.id = b.id
group by host_is_superhost, a.host_identity_verified,a.host_has_profile_pic,b.instant_bookable,
datepart(month,c.date), datepart(year,c.date)
having host_is_superhost = 'true' or host_is_superhost = 'false'
order by datepart(year,c.date) desc



select  a.host_is_superhost,count(a.host_is_superhost) as count_true_false,
count(a.host_identity_verified),
avg(a.host_acceptance_rate)as 
avg_acceptance_rate,
avg(a.host_response_rate) as avg_response , avg(b.review_scores_value) as avg_review 
from toronto_host as a inner join toronto_listing as b on a.host_id=b.host_id 
group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false'

--VANCOUVER

----1


select a.host_is_superhost,datepart(month,c.date)  as month_number,datepart(year,c.date) as year_number,  
count(c.id) total_booking, 
count(a.host_is_superhost) as count_true_false, 
avg(a.host_acceptance_rate)as avg_acceptance_rate,
avg(a.host_response_rate) as avg_response , avg(b.review_scores_value) as avg_review 
from vancouver_host as a inner join vancouver_listing as b on a.host_id=b.host_id 
join vancouver_availability c on c.id = b.id
group by host_is_superhost, datepart(month,c.date), datepart(year,c.date)
having host_is_superhost = 'true' or host_is_superhost = 'false'
order by datepart(year,c.date) desc

-----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////..................................
--STARTING FROM HERE

--TORONTO

select host_is_superhost, avg(host_acceptance_rate) as avg_acceptance from toronto_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false';

select host_is_superhost, avg(host_response_rate) as avg_response from toronto_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false'

select a.host_is_superhost , avg(b.review_scores_value) as avg_review 
from toronto_host as a left  join toronto_listing as b on a.host_id=b.host_id group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false'


select host_is_superhost, count(host_has_profile_pic) got_profile_pic
from toronto_host
where host_is_superhost = 'true' or host_is_superhost = 'false'
group by host_is_superhost



select host_is_superhost, count(host_identity_verified) got_identity_verified
from toronto_host
where host_is_superhost = 'true' or host_is_superhost = 'false'
group by host_is_superhost


select h.host_is_superhost,  count(L.instant_bookable) total_instant_book
from toronto_host h LEFT join toronto_listing L on h.host_id = L.host_id
where h.host_is_superhost = 'true' or host_is_superhost = 'false'
group by H.host_is_superhost

select top 10 a.host_is_superhost,datename(month,c.date)  as month_number,datename(year,c.date) as year_number,  
count(c.id) total_booking
from toronto_host as a inner join toronto_listing as b on a.host_id=b.host_id 
join toronto_availability c on c.id = b.id
group by host_is_superhost, datename(month,c.date), datename(year,c.date)
having host_is_superhost = 'true' or host_is_superhost = 'false'
order by datename(year,c.date) desc

--VANCOUVER
select host_is_superhost, avg(host_acceptance_rate) as avg_acceptance from VANCOUVER_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false';

select host_is_superhost, avg(host_response_rate) as avg_response from vancouver_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false'

select a.host_is_superhost , avg(b.review_scores_value) as avg_review 
from vancouver_host as a left  join vancouver_listing as b on a.host_id=b.host_id group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false'


select host_is_superhost, count(host_has_profile_pic) got_profile_pic
from vancouver_host
where host_is_superhost = 'true' or host_is_superhost = 'false'
group by host_is_superhost



select host_is_superhost, count(host_identity_verified) got_identity_verified
from vancouver_host
where host_is_superhost = 'true' or host_is_superhost = 'false'
group by host_is_superhost


select h.host_is_superhost,  count(L.instant_bookable) total_instant_book
from vancouver_host h LEFT join vancouver_listing L on h.host_id = L.host_id
where h.host_is_superhost = 'true' or host_is_superhost = 'false'
group by H.host_is_superhost

select top 10 a.host_is_superhost,datename(month,c.date)  as month_number,datename(year,c.date) as year_number,  
count(c.id) total_booking
from vancouver_host as a inner join vancouver_listing as b on a.host_id=b.host_id 
join vancouver_availability c on c.id = b.id
group by host_is_superhost, datename(month,c.date), datename(year,c.date)
having host_is_superhost = 'true' or host_is_superhost = 'false'
order by datename(year,c.date) desc

--b. Using the above analysis, identify top 3 crucial metrics one needs to maintain to become a Super Host and also,
--find their average values.

--TORONTO
select a.host_is_superhost,a.avg_acceptance,b.avg_response,c.avg_review 
from (select host_is_superhost, avg(host_acceptance_rate) as avg_acceptance from toronto_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false') a left join (select host_is_superhost, avg(host_response_rate) as avg_response 
from toronto_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false') b on a.host_is_superhost = b.host_is_superhost
left join (select a.host_is_superhost , avg(b.review_scores_value) as avg_review 
from toronto_host as a left  join toronto_listing as b on a.host_id=b.host_id group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false') c on b.host_is_superhost =c.host_is_superhost;

--VANCOUVER
select a.host_is_superhost,a.avg_acceptance,b.avg_response,c.avg_review 
from (select host_is_superhost, avg(host_acceptance_rate) as avg_acceptance from toronto_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false') a left join (select host_is_superhost, avg(host_response_rate) as avg_response 
from vancouver_host group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false') b on a.host_is_superhost = b.host_is_superhost
left join (select a.host_is_superhost , avg(b.review_scores_value) as avg_review 
from vancouver_host as a left  join vancouver_listing as b on a.host_id=b.host_id group by host_is_superhost
having host_is_superhost = 'true' or host_is_superhost = 'false') c on b.host_is_superhost =c.host_is_superhost;



--c. Analyze how does the comments of reviewers vary for listings of Super Hosts vs Other Hosts
--(Extract words from the comments provided by the reviewers)
sELECT * FROM vancouver_host
sELECT * FROM vancouver_review
sELECT * FROM vancouver_listing

--TORONTO
select top 10 h.host_id, H.host_is_superhost ,R.reviewer_name, R.comments
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_review R on L.id = R.listing_id
where H.host_is_superhost = 'true' and R.comments like '%good%' and R.comments like '%excellent%'

select h.host_id, H.host_is_superhost ,R.reviewer_name, R.comments
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_review R on L.id = R.listing_id
where H.host_is_superhost = 'false' and R.comments like '%bad%'

--VANCOUVER
select h.host_id, H.host_is_superhost ,R.reviewer_name, R.comments
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_review R on L.id = R.listing_id
where H.host_is_superhost = 'true' and R.comments like '%good%'

select top 10 h.host_id, H.host_is_superhost ,R.reviewer_name, R.comments
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_review R on L.id = R.listing_id
where H.host_is_superhost = 'false' and R.comments like '%bad%' and R.comments like '%poor%'




--d. Analyze do Super Hosts tend to have large property types as compared to Other Hosts

sELECT * FROM vancouver_availability
sELECT * FROM vancouver_host
sELECT * FROM vancouver_listing
sELECT * FROM vancouver_review

select l.property_type,l.accommodates , count(l.property_type) as count_property,h.host_is_superhost,
  case when  l.accommodates > 7 then 'L' else 's' end property_size,l.host_id
  from toronto_listing as l inner join toronto_host as h on l.host_id=h.host_id
  group by l.property_type,l.accommodates ,h.host_is_superhost,l.host_id
  order by accommodates desc,count(property_type) desc;
  --TORONTO
  select host_is_superhost,property_size,count(property_size) as count_property 
  from (select l.property_type,l.accommodates , count(l.property_type) as count_property,h.host_is_superhost,
  case when  l.accommodates > 7 then 'L' else 's' end property_size,l.host_id
  from toronto_listing as l inner join toronto_host as h on l.host_id=h.host_id
  group by l.property_type,l.accommodates ,h.host_is_superhost,l.host_id) b 
  group by host_is_superhost,property_size
  order by  host_is_superhost;


  --VANCOUVER

  select l.property_type,l.accommodates , count(l.property_type) as count_property,h.host_is_superhost,
  case when  l.accommodates > 7 then 'L' else 's' end property_size,l.host_id
  from vancouver_listing as l inner join vancouver_host as h on l.host_id=h.host_id
  group by l.property_type,l.accommodates ,h.host_is_superhost,l.host_id
  order by accommodates desc,count(property_type) desc;

  --VANCOUVER
  select host_is_superhost,property_size,count(property_size) as count_property 
  from (select l.property_type,l.accommodates , count(l.property_type) as count_property,h.host_is_superhost,
  case when  l.accommodates > 7 then 'L' else 's' end property_size,l.host_id
  from vancouver_listing as l inner join vancouver_host as h on l.host_id=h.host_id
  group by l.property_type,l.accommodates ,h.host_is_superhost,l.host_id
  ) b group by host_is_superhost,property_size
  order by  host_is_superhost;


--e. Analyze the average price and availability of the listings for the upcoming year between Super Hosts and Other Hosts

sELECT * FROM vancouver_availability
sELECT * FROM vancouver_host
sELECT * FROM vancouver_listing
sELECT * FROM vancouver_review

--TORONTO

select H.host_is_superhost, datepart(year, A.date) upcoming_year, avg(A.price) avg_price
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_availability A on L.id = A.id
where H.host_is_superhost = 'true' or H.host_is_superhost = 'false'
group by H.host_is_superhost, datepart(year, A.date)
having datepart(year, A.date) = '2023'


--VANCOUVER
select H.host_is_superhost, datepart(year, A.date) upcoming_year, avg(A.price) avg_price
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_is_superhost = 'true' or H.host_is_superhost = 'false'
group by H.host_is_superhost, datepart(year, A.date)
having datepart(year, A.date) = '2023'


--f. Analyze if there is some difference in above mentioned trends between Local Hosts or Hosts residing in other locations

sELECT * FROM vancouver_availability
sELECT * FROM vancouver_host
sELECT * FROM vancouver_listing
sELECT * FROM vancouver_review

--TORONTO

select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_availability A on L.id = A.id
where H.host_location like '%toronto%'
group by H.host_location, datepart(year, A.date)

select avg(avg_price) as avg_price_local_host, avg(avg_acceptance) as local_avg_acceptance,avg(avg_response) as local_avg_response
from(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_availability A on L.id = A.id
where H.host_location like '%toronto%'
group by H.host_location, datepart(year, A.date) )a

select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price,
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_availability A on L.id = A.id
where H.host_location not like '%toronto%'
group by H.host_location, datepart(year, A.date)

select avg(avg_price) as avg_price_other_location, 
avg(avg_acceptance) as other_location_avg_acceptance,avg(avg_response) as other_location_avg_response
from(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from toronto_host H join toronto_listing L on H.host_id = L.host_id
join toronto_availability A on L.id = A.id
where H.host_location not like '%toronto%'
group by H.host_location, datepart(year, A.date) )a

create view table3 as 
(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location like '%vancouver%'
group by H.host_location, datepart(year, A.date))

select avg(avg_price) as avg_price_local_host, avg(avg_acceptance) as local_avg_acceptance,avg(avg_response) as local_avg_response
from table3;

create view table4 as 
(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location like '%vancouver%'
group by H.host_location, datepart(year, A.date))

select avg(avg_price) as avg_price_local_host, avg(avg_acceptance) as local_avg_acceptance,avg(avg_response) as local_avg_response
from table4;

--VANCOUVER

select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location like '%vancouver%'
group by H.host_location, datepart(year, A.date)

select avg(avg_price) as avg_price_local_host, avg(avg_acceptance) as local_avg_acceptance,avg(avg_response) as local_avg_response
from(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location like '%vancouver%'
group by H.host_location, datepart(year, A.date) )a


select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price,
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location not like '%vancouver%'
group by H.host_location, datepart(year, A.date)

select avg(avg_price) as avg_price_other_location, 
avg(avg_acceptance) as other_location_avg_acceptance,avg(avg_response) as other_location_avg_response
from(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location not like '%vancouver%'
group by H.host_location, datepart(year, A.date) )a

create view table1 as 
(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location like '%vancouver%'
group by H.host_location, datepart(year, A.date))

select avg(avg_price) as avg_price_local_host, avg(avg_acceptance) as local_avg_acceptance,avg(avg_response) as local_avg_response
from table1;

create view table2 as 
(select H.host_location, datepart(year, A.date) upcoming_year, avg(A.price) avg_price, 
avg(H.host_acceptance_rate) avg_acceptance, avg(host_response_rate) avg_response
from vancouver_host H join vancouver_listing L on H.host_id = L.host_id
join vancouver_availability A on L.id = A.id
where H.host_location not like '%vancouver%'
group by H.host_location, datepart(year, A.date))

select avg(avg_price) as avg_price_local_host, avg(avg_acceptance) as local_avg_acceptance,avg(avg_response) as local_avg_response
from table2;



--g. Analyze the above trends for the two cities for which data has been provided and provide insights on comparison


