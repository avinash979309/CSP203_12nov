awk -F',' '
$14==1 {
    if ($1 >= 40 && $1 < 50) ageGroup["40-50"]++
    else if ($1 >= 50 && $1 < 60) ageGroup["50-60"]++
    else if ($1 >= 60 && $1 < 70) ageGroup["60-70"]++
    else if ($1 >= 70 && $1 < 80) ageGroup["70-80"]++
    else if ($1 >= 80 && $1 < 90) ageGroup["80-90"]++
    else if ($1 >= 90 && $1 < 100) ageGroup["90-100"]++
}
END {
    for (group in ageGroup) print group "," ageGroup[group]
}' heart.csv > 4d_data.csv

total=$(awk -F',' '{sum += $2} END {print sum}' 4d_data.csv)

start_angle=0
color=("red" "orange" "yellow" "green" "blue" "purple")

cat <<EOF > 4d.p
set terminal png
set output '4d.png'
set title 'Age Groups with Heart Disease'
set key outside top box
set style fill solid 1.0 border -1

set angles degrees
set xrange [-1:1]
set yrange [-1:1]
set size square
EOF

i=0
while IFS=, read -r group count; do
    percent=$(awk "BEGIN {print ($count / $total) * 100}")
    end_angle=$(awk "BEGIN {print $start_angle + ($percent * 3.6)}")
    
    echo "set obj $(($i + 1)) circle at 0,0 size 1 front arc [$start_angle:$end_angle] fc rgb \"${color[$i]}\"" >> 4d.p

    start_angle=$end_angle
    i=$((i+1))
done < 4d_data.csv

cat <<EOF >> 4d.p
plot NaN title '40-50' with lines lc rgb "red", \
     NaN title '50-60' with lines lc rgb "orange", \
     NaN title '60-70' with lines lc rgb "yellow", \
     NaN title '70-80' with lines lc rgb "green", \
     NaN title '80-90' with lines lc rgb "blue", \
     NaN title '90-100' with lines lc rgb "purple"
EOF

echo 'generated data 4d_data.csv & gnu script 4d.p'
gnuplot 4d.p
echo 'generated pie chart as 4d.png'

