#!/bin/bash
# This script explains how does the central dogma (dna) work using bash.
# Created by Daniil Gentili (http://daniil.it)
# Licensed under GPLv3.
clear
echo "BNA v0.1
This script explains how does the central dogma (dna) work using bash.
Created by Daniil Gentili (http://daniil.it)
Licensed under GPLv3.
I created this script using http://employees.csbsju.edu/hjakubowski/classes/chem%20and%20society/cent_dogma/olcentdogma.html, https://www.youtube.com/watch?v=J3HVVi2k2No and http://misc.flogisoft.com/bash/tip_colors_and_formatting, feel free to check these sites out.
"
sleep 1

# Print output and wait until user presses enter
waitprint() {
 [ "$1" = "bio" ] && { echo -e "\e[32mIn biology\e[39m" && shift; }
 [ "$1" = "bash" ] && { echo -e "\e[32mIn bash\e[39m" && shift; }
 echo "$*
"
 read
}
# This function appends a dna couple to the dna variable and optionally prints out some ascii art.
mkdna() {
 # $1 is the index of the chromosome array and $2 enables ascii art
 case ${chromosome[$1]} in # Generate chromosome complementary.
  "A")
   opposite="T"
   ;;
  "T")
    opposite="A"
   ;;
  "G")
   opposite="C"
   ;;
  "C")
   opposite="G"
   ;;
  "*")
   continue
   ;;
 esac
 # Store dna in array
 dna[0]+="${chromosome[$1]}"
 dna[1]+="$opposite" 
 [ "$2" = "y" ] && {
  # Print random chromosome, its complementary, phosphorus (P), rybose (R), and some ascii art.
  echo -e " R-\e[44m${chromosome[$1]}\e[49m"---"\e[44m$opposite\e[49m-R"
  [ $n != 10 ] && echo \
'/         \
P          P
\         /
 |       |'
 }
}

(
waitprint "Introduction.
The 'Central Dogma' of molecular biology is that 'DNA makes RNA makes protein'. This script shows how molecular commands transcribe the genes in the DNA of every cell into portable RNA messages, how those messenger RNA are modified and exported from the nucleus, and finally how the RNA code is read to build proteins.
"


waitprint "Part 1: the DNA.
"


waitprint bio "Everything starts with a organic molecule called Deoxyribonucleic acid (DNA).
This molecule has an intresting structure that can be trimmed down to a simple variable containing the four bases (called chromosomes) of the DNA: A, T, C and G.
"

waitprint bash "Let's declare an array and assign values to it."
set -x
declare -A chromosome
chromosome[0]="A"; chromosome[1]="T"; chromosome[2]="C"; chromosome[3]="G"
set +x

waitprint bio "The DNA is composed of (almost) endless combinations of these four chromosome, held together in a double helicoidal structure by phosphorus and a deoxyribose (a type of sugar).
The chromosomes of one strand are complementary to the chromosomes of the other: A always stays close to T, and G to C.
"
waitprint bash "First let's declare the dna variable as an array (with two indexes, one per strand):"
set -x
declare -A dna
dna[0]=""; dna[1]=""
set +x
waitprint bash 'This is the equivalent function in bash that generates a chromsome couple.
mkdna() {
 # $1 is the index of the chromosome array
 case ${chromosome[$1]} in # Generate complementary of chromosome.
  "A")
   opposite="T"
   ;;
  "T")
    opposite="A"
   ;;
  "G")
   opposite="C"
   ;;
  "C")
   opposite="G"
   ;;
 esac
 # Store dna in array
 dna[0]+="${chromosome[$1]}"
 dna[1]+="$opposite"
}
'
waitprint bash 'This function is then called in a loop that also creates the TATAAA magic string (see part 2):

n=0 # Reset the counter
until [ $n = 10 ]; do # This loop makes ten more combinations after the TATAAA magic string
 n=$(($n+1)) # Increase counter
 until echo "${dna[*]}" | grep -q "TATAAA"; do # This loop creates random combinations until we get a TATAAA magic string in at least one of the strands
  random=$(shuf -i 0-3 -n 1) # Generate random chromosome
  mkdna $random
 done
 random=$(shuf -i 0-3 -n 1) # Generate random chromosome
 mkdna $random
done
'

n=0 # Reset the counter
until [ $n = 10 ]; do # This loop makes nine more combinations after the TATAAA magic string
 n=$(($n+1)) # Increase counter
 until echo "${dna[*]}" | grep -q "TATAAA"; do # This loop creates random combinations until we get a TATAAA magic string in at least one of the strands
  random=$(shuf -i 0-3 -n 1) # Generate random chromosome
  mkdna $random
 done
 random=$(shuf -i 0-3 -n 1) # Generate random chromosome
 mkdna $random y
done

waitprint "
The various combinations are like source code: a certain combination of chromosomes (alias words) that contain encoded instructions on how to build proteins (alias programs)."


waitprint "Part 2: Initiation of Transcription.
"

waitprint bio "Transcription begins when an enzyme called RNA polymerase attaches to the DNA template strand and begins assembling a new chain of nucleotides to produce a complementary RNA strand. There are multiple types of types of RNA. In eukaryotes, there are multiple types of RNA polymerase which make the various types of RNA. In prokaryotes, a single RNA polymerase makes all types of RNA. Generally speaking, polymerases are large enzymes that work together with a number of other specialized cell proteins. These cell proteins, called transcription factors, help determine which DNA sequences should be transcribed and precisely when the transcription process should occur."

waitprint bio "The first step in transcription is initiation. During this step, RNA polymerase and its associated transcription factors bind to the DNA strand at a specific area that facilitates transcription. This area, known as a promoter region, often includes a specialized nucleotide sequence, TATAAA, which is also called the TATA box"

waitprint bash ""
) 2>&1 | sed 's/.*set +x.*/\
/g;s/^\+ //g'


