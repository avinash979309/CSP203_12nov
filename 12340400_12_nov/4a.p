set term png
set output '4a.png'
set title 'Gender vs. Number of People with and without Heart Disease'
set xlabel 'Gender'
set ylabel 'Count'
set style data histogram
set style fill solid
set datafile separator ','
set yrange[0:*]
set xrange[0:*]
set xtics 1
set key out box

plot '4a_data.csv' using 2:xtic(1) title 'No Heart Disease' linecolor rgb 'blue',      '' using 3:xtic(1) title 'Heart Disease' linecolor rgb 'orange'
