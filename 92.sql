--Oracle
select q_name
from utq
where q_id in (
select b.b_q_id
from utb b
join utv v on v.v_id = b.b_v_id
where b.b_q_id in (              
select b_q_id from (
select b.b_q_id, v.v_color
from utb b
join utv v on v.v_id = b.b_v_id
and b.b_v_id in (select b_v_id       
                 from utb
                 group by b_v_id
                 having sum(b_vol) = 255
                 )
group by b.b_q_id, v.v_color
having sum(b_vol) = 255) t
group by b_q_id
having count(v_color) = 3
)
group by b.b_q_id
having count(distinct v.v_color) = 3
) 
 --from forum
 select max(squares.Q_NAME)
from utb painting
join utV cans on painting.B_V_ID = cans.V_ID
join utQ squares on painting.B_Q_ID = squares.Q_ID
join ( 	select painting.B_V_ID 
		from utb painting
		group by painting.B_V_ID
		having sum(painting.B_VOL) = 255
	) emptyCans on painting.B_V_ID = emptyCans.B_V_ID
group by painting.B_Q_ID
having 
	sum(case when cans.V_COLOR = 'R' THEN painting.B_VOL else 0 end) = 255 and
	sum(case when cans.V_COLOR = 'G' THEN painting.B_VOL else 0 end) = 255 and
	sum(case when cans.V_COLOR = 'B' THEN painting.B_VOL else 0 end) = 255 