input_file="heart.csv"
output_file="table.tex"

echo "\documentclass{article}" > $output_file
echo "\usepackage{geometry}" >> $output_file
echo "\usepackage{longtable}" >> $output_file
echo "\title{Heart Dataset}" >> $output_file

echo "\begin{document}" >> $output_file
echo "\maketitle" >> $output_file
echo "\begin{longtable}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}" >> $output_file
echo "\hline" >> $output_file


header=$(head -n 1 $input_file)
echo $header | awk -F',' '{for(i=1;i<=NF;i++) printf "%s%s", $i, (i==NF ? "\\\\ \\hline\n" : " & ")}' >> $output_file

tail -n +2 $input_file | while IFS=',' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14
do
  echo "$col1 & $col2 & $col3 & $col4 & $col5 & $col6 & $col7 & $col8 & $col9 & $col10 & $col11 & $col12 & $col13 & $col14 \\\\ \\hline" >> $output_file
done

echo "\end{longtable}" >> $output_file
echo "\end{document}" >> $output_file

echo "LaTeX file generated: $output_file"

