-- Числовые типы

select 10.0 / 7;
-- 1.4285714285714286

select mod(5, 2); -- mod - остаток от деления
select div(11, 3);  -- div - целечисленное деление
select round(1.54); -- round округление
select ceil(1.54); -- ceil ближайшее большее целое
select floor(1.54); -- ceil ближайшее меньшее целое
select power(3, 3); -- возведение в степень
select sqrt(4); -- sqrt - квадратный корень 


select  1 + 2 as simple_sum, 1 + 2.0 as second_sum, 4 - 8 as negative_diff, 5 * 6 as proizv, round(2.5) as o_round, ceil(2.5) as o_ceil,
FLOOR(2.5) as o_floor, power(2, 6) as o_power, sqrt(81) as o_sqrt;

