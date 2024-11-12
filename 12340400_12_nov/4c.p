set term png size 700,700
set output '4c.png'
set title 'Age vs Cholesterol for Individuals Without Heart Disease'
set xlabel 'Age'
set ylabel 'Cholesterol'
set datafile separator ','
set key below

plot '4c_data.csv' using 1:2 with linespoints title 'Age vs Cholesterol'
