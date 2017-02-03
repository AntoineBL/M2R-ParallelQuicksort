j=0
v=c()
set.seed(42)
w = sample(0:59,60)
for (i in w) {
  if(i<10){v[j]=100}
  else if(i<20){v[j]=1000}
  else if(i<30){v[j]=10000}
  else if(i<40){v[j]=100000}
  else if(i<50){v[j]=350000}
  else{v[j]=500000}
  j=j+1
}
sink("sample.txt")
v

