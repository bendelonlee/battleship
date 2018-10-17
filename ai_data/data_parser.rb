x1 = "1	games	38	shots
1	games	44	shots
1	games	41	shots
1	games	39	shots
1	games	100	shots
2	games	47	shots
3	games	43	shots
4	games	49	shots
4	games	52	shots
4	games	42	shots
4	games	48	shots
4	games	45	shots
5	games	56	shots
5	games	54	shots
5	games	99	shots
5	games	46	shots
6	games	60	shots
7	games	51	shots
8	games	57	shots
8	games	58	shots
8	games	63	shots
9	games	50	shots
9	games	53	shots
10	games	64	shots
11	games	55	shots
11	games	62	shots
11	games	59	shots
12	games	68	shots
13	games	98	shots
14	games	61	shots
16	games	66	shots
18	games	97	shots
19	games	70	shots
19	games	72	shots
19	games	76	shots
20	games	96	shots
20	games	65	shots
21	games	67	shots
21	games	73	shots
21	games	69	shots
22	games	75	shots
23	games	89	shots
23	games	83	shots
24	games	71	shots
24	games	81	shots
25	games	95	shots
25	games	82	shots
26	games	94	shots
27	games	93	shots
28	games	86	shots
28	games	78	shots
29	games	77	shots
29	games	74	shots
29	games	88	shots
29	games	90	shots
29	games	92	shots
30	games	84	shots
30	games	87	shots
32	games	79	shots
34	games	91	shots
35	games	85	shots
38	games	80	shots"

y1 = x1.split("\n")
z1 = y1.map { |line| line.split("\t") }
f1 = z1.map { |line| [line[0].to_i, line[2].to_i]}
f1 = f1.sort_by { |line| line[1] }
y_val = f1.map { |line| line[0]}
x_val = f1.map { |line| line[1]}

require 'pry'; binding.pry

p "x values"
p x_val
p "y values"
p y_val

nil
