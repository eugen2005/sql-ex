with t as (select v.v_name, v.v_id,
       sum(case v.v_color when 'R' then 1 else 0 end) over(partition by v.v_id) qty_r,
       sum(case v.v_color when 'B' then 1 else 0 end) over(partition by b.b_q_id) qty_b
from utb b
join utv v on v.v_id = b.b_v_id)
select v_name
from t
where qty_r > 1
and qty_b > 0
group by v_name
--from forum
select V_NAME
  from utV q
 where V_COLOR = 'R'
   and (select count(*) from utB where B_V_ID = q.V_ID) > 1
   and exists
 (select B_Q_ID
          from utB
         where B_V_ID = q.V_ID
           and B_Q_ID in
               (select B_Q_ID
                  from utB
                 where B_V_ID in (select V_ID from utV where V_COLOR = 'B')
                )
  )