select avg(sum_paint) avg_paint   -- select cast(avg(sum_paint * 1.0) as numeric (6,2)) avg_paint <--this line for MS SQL  
from (select q.q_id,
        case when qc.b_q_id is not null then qc.sum_vol 
             else 0 end sum_paint
from utq q
left join (
    select b_q_id, sum(b_vol) sum_vol
    from utb
    group by b_q_id
) qc on qc.b_q_id = q.q_id) t