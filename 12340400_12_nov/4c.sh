
awk -F',' 'NR==1 || $14==0 {print $1","$5","$14}' heart.csv > 4c_data.csv

cat <<EOF > 4c.p
set term png size 700,700
set output '4c.png'
set title 'Age vs Cholesterol for Individuals Without Heart Disease'
set xlabel 'Age'
set ylabel 'Cholesterol'
set datafile separator ','
set key below

plot '4c_data.csv' using 1:2 with linespoints title 'Age vs Cholesterol'
EOF

echo 'generated data as 4c_data.csv and plot script as 4c.p'
gnuplot  4c.p
echo 'graph generated as 4c.png'

