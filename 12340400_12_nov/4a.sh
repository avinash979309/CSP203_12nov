input_file="heart.csv"
output_data="4a_data.csv"
output_plot="4a.p"

echo "Gender,Target0,Target1" > $output_data

awk -F, '
{
  if ($2 == 1 && $14 == 1) male_with++;
  else if ($2 == 1 && $14 == 0) male_without++;
  else if ($2 == 0 && $14 == 1) female_with++;
  else if ($2 == 0 && $14 == 0) female_without++;
}
END {
  print "Female," female_without "," female_with >> "'"$output_data"'";
  print "Male," male_without "," male_with >>"'"$output_data"'";
}' $input_file

cat <<EOF > $output_plot
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

plot '$output_data' using 2:xtic(1) title 'No Heart Disease' linecolor rgb 'blue', \
     '' using 3:xtic(1) title 'Heart Disease' linecolor rgb 'orange'
EOF

echo "Modified data saved as $output_data. Gnuplot script generated as $output_plot."

gnuplot $output_plot
echo "generated graph is saved as 4a.png"

