
concat(a, b, c) -- Объединение
length() -- длина строки
trim() -- обрезание пробелов
position() -- поиск подстроки
upper() -- верхний регистр
lower() -- нижний регистр


select upper(name) as upper_name, length(name) as len_name,
concat(gender, ' ', species) as type_gender, 
position('Smith' in name) from characters c;