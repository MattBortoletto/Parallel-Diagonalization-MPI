set terminal pdf size 15, 5 font "Latin Modern Math, 25"
set encoding utf8
set output "times.pdf"
set multiplot layout 1,2
load 'timepalette.pal' 

scalapack_time = system("ls scalapack_timing | grep times")
slepc_time = system("ls slepc_timing | grep times")

set format y "10^{%T}"
set logscale xy
set key outside 
set xlabel "N"
set ylabel "time [s]"
set grid 

set rmargin at screen 0.425
set lmargin at screen 0.06
set bmargin at screen 0.25
set label 11 center at graph 0.5 ,char 1 "(a) Build time" font ",30"
unset key 
plot for [i = 1:words(scalapack_time)] sprintf("scalapack_timing/%s", word(scalapack_time,i)) u 1:3 w l ls i lw i==3 ? 3:2 dt i==3 ? 2:1 t sprintf("ScaLAPACK %d", (word(scalapack_time,i)[6:6]+0)*(word(scalapack_time,i)[8:8]+0)), \
     for [i = 1:words(slepc_time)] sprintf("slepc_timing/%s", word(slepc_time,i)) u 1:3 w l ls (i+5) lw i==3 ? 3:2 dt i==3 ? 2:1 t sprintf("SLEPc %s", (word(slepc_time,i)[6:6]))

set rmargin at screen 0.83
set lmargin at screen 0.485
set bmargin at screen 0.25
set label 11 "(b) Diagonalization time" font ",30"
set key at screen 1,screen 0.9
plot for [i = 1:words(scalapack_time)] sprintf("scalapack_timing/%s", word(scalapack_time,i)) u 1:2 w l ls i lw i==3 ? 3:2 dt i==3 ? 2:1 t sprintf("ScaLAPACK %d", (word(scalapack_time,i)[6:6]+0)*(word(scalapack_time,i)[8:8]+0)), \
     for [i = 1:words(slepc_time)] sprintf("slepc_timing/%s", word(slepc_time,i)) u 1:2 w l ls (i+5) lw i==3 ? 3:2 dt i==3 ? 2:1 t sprintf("SLEPc %s", (word(slepc_time,i)[6:6]))

#