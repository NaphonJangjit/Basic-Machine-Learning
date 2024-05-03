#!bin/bash


readarray -t data < data.csv

n=${#data[@]}


sum_x=0
sum_y=0

for ((i=1; i<n; i++)); do
	x=$(echo ${data[i]} | cut -d',' -f1)
	y=$(echo ${data[i]} | cut -d',' -f2)
	sum_x=$(echo "$sum_x + $x" | bc)
	sum_y=$(echo "$sum_y + $y" | bc)
done

mean_x=$(echo "scale=2; $sum_x / $n" | bc)
mean_y=$(echo "scale=2; $sum_y / $n" | bc)

sum_xy=0
sum_xx=0
for ((i=1; i<n; i++)); do
	x=$(echo ${data[i]} | cut -d',' -f1)
	y=$(echo ${data[i]} | cut -d',' -f2)
	sum_xy=$(echo "$sum_xy + ($x - $mean_x) * ($y - $mean_y)" | bc)
	sum_xx=$(echo "$sum_xx + ($x - $mean_x) * ($x - $mean_x)" | bc)
done

slope=$(echo "scale=2; $sum_xy / $sum_xx" | bc)
intercept=$(echo "scale=2; $mean_y - ($slope * $mean_x)" | bc)

echo "Enter a Number: "
read num
res=$(echo "scale=2; $num * $slope + $intercept" | bc)
echo "Slope = $slope , Intercept = $intercept"
echo "$res"
