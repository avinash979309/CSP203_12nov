set term png
set output '4b.png'
set title 'Correlation between Age and Blood Pressure'
set xlabel 'Age'
set ylabel 'Blood Pressure (trestbps)'
set style data points
set datafile separator ','

plot 'heart.csv' using 1:4 title 'Age vs. Blood Pressure' with points pointtype 7 pointsize 0.5 linecolor rgb 'blue'
