#!/bin/bash
# This script explains how does the central dogma (dna) work using bash.
# Created by Daniil Gentili (http://daniil.it)

# Copyright (C) 2016 Daniil Gentili
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Changelog:
# v0.1 (and revisions): added dna engine and started to work on RNA transcription.
# v0.2 (and revisions): added rna transcription process and finished complementary engine.

clear
echo "BNA v0.2

Created by Daniil Gentili (http://daniil.it)
This script explains how does the central dogma (dna) work using bash.

Copyright (C) 2016 Daniil Gentili
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it under certain conditions; see https://github.com/danog/bna/raw/master/LICENSE.

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

opposite() {
 # If $2 is rna, opposite of A is U
 case $1 in # Generate chromosome complementary.
  "A")
   [ "$2" = "rna" ] && echo "U" || echo "T"
   ;;
  "T"|"U")
   echo "A"
   ;;
  "G")
   echo "C"
   ;;
  "C")
   echo "G"
   ;;
  "*")
   return
   ;;
 esac
}

# This function appends a dna couple to the dna variable and optionally prints out some ascii art.
mkdna() {
 # $1 is the index of the chromosome array and $2 enables ascii art
 opposite=$(opposite ${chromosome[$1]}) # Generate opposite chromosome
 # Store dna in array
 dna[0]+="${chromosome[$1]}"-
 dna[1]+="$opposite"-
 # Print random chromosome, its complementary, phosphorus (P), deoxyrybose (D), and some ascii art.
 echo -e " D-\e[44m${chromosome[$1]}\e[49m"---"\e[44m$opposite\e[49m-D"
 [ $n != 10 ] && echo \
'/         \
P          P
\         /
 |       |'
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


waitprint bio "The chromosomes of one strand are complementary to the chromosomes of the other: A always stays close to T, and G to C.
"
waitprint bash 'This is the equivalent function in bash that generates the opposite chromosome.
opposite() {
 # If $2 is rna, opposite of A is U
 case $1 in # Generate chromosome complementary.
  "A")
   [ "$2" = "rna" ] && echo "U" || echo "T"
   ;;
  "T"|"U")
   echo "A"
   ;;
  "G")
   echo "C"
   ;;
  "C")
   echo "G"
   ;;
  "*")
   return
   ;;
}

'

waitprint bio "The DNA is composed of (almost) endless combinations of these four chromosome, held together in a double helicoidal structure by phosphorus and a deoxyribose (a type of sugar)."
waitprint bash "Let's declare the dna variable as an array (with two indexes, one per strand):"
set -x
declare -A dna
dna[0]=""; dna[1]=""
set +x

waitprint bash 'This function generates the DNA.
mkdna() {
 # $1 is the index of the chromosome array and $2 enables ascii art
 opposite=$(opposite ${chromosome[$1]}) # Generate opposite chromosome
 # Store dna in array
 dna[0]+="${chromosome[$1]}"-
 dna[1]+="$opposite"-
}

'
waitprint bash 'This function is then called in a loop that also creates the TATAAA magic string (see part 2):

n=0 # Reset the counter
until [ $n = 10 ]; do # This loop makes ten more combinations after the TATAAA magic string
 n=$(($n+1)) # Increase counter
 until echo "${dna[*]}" | grep -q "T-A-T-A-A-A"; do # This loop creates random combinations until we get a TATAAA magic string in at least one of the strands
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
 until echo "${dna[*]}" | grep -q "T-A-T-A-A-A"; do # This loop creates random combinations until we get a TATAAA magic string in at least one of the strands
  random=$(shuf -i 0-3 -n 1) # Generate random chromosome
  mkdna $random
 done
 random=$(shuf -i 0-3 -n 1) # Generate random chromosome
 mkdna $random
done

waitprint "
The various combinations are like source code: a certain combination of chromosomes (alias words) that contain encoded instructions on how to build proteins (alias programs)."


waitprint "Part 2: Initiation of Transcription.
"

waitprint bio "Transcription begins when an enzyme called RNA polymerase attaches to the DNA template strand and begins assembling a new chain of nucleotides to produce a complementary RNA strand. There are multiple types of types of RNA. In eukaryotes, there are multiple types of RNA polymerase which make the various types of RNA. In prokaryotes, a single RNA polymerase makes all types of RNA. Generally speaking, polymerases are large enzymes that work together with a number of other specialized cell proteins. These cell proteins, called transcription factors, help determine which DNA sequences should be transcribed and precisely when the transcription process should occur."

waitprint "The first step in transcription is initiation. During this step, RNA polymerase and its associated transcription factors bind to the DNA strand at a specific area that facilitates transcription. This area, known as a promoter region, often includes a specialized nucleotide sequence, TATAAA, which is also called the TATA box.
Once RNA polymerase and its related transcription factors are in place, the single-stranded DNA is exposed and ready for transcription. At this point, RNA polymerase begins moving down the DNA template strand in the 3' to 5' direction, and as it does so, it strings together complementary nucleotides. By virtue of complementary base- pairing, this action creates a new strand of mRNA that is organized in the 5' to 3' direction. As the RNA polymerase continues down the strand of DNA, more nucleotides are added to the mRNA, thereby forming a progressively longer chain of nucleotides. This process is called elongation."

waitprint bash "Here we must find where do we have to start copying the DNA to the mRNA, and then start copying it to the mRNA. As mentioned earlier, we can use the magic TATAAA string.
This is how we do it:"'

for strand in ${dna[*]}; do # Search for the TATAAA string in both strands.
 last6="ponies"
 for chromo in $(echo $strand | sed '"'"'s/-/ /'"'"');do # Loop trough every chromo until I find the combination
  if [ "$last6" != "TATAAA" ]; then # If the last 6 chromosomes aren'"'"'t the magic sequence, continue searching
   last6=${last6:1}$chromo # Remove first char of variable and append current chromo
  else 
   mRNA+=$(opposite $chromo rna) # Append the opposite chromosome to the mRNA. Note that in this complementary string there will be no T, since the mRNA uses U (Uracil) instead of T (Thymine).
  fi
 done
 [ "$mRNA" != "" ] && break
done
echo $mRNA
'

for strand in ${dna[*]}; do # Search for the TATAAA string in both strands.
 last6="ponies"
 for chromo in $(echo $strand | sed 's/-/ /g');do # Loop trough every chromo until I find the combination
  if [ "$last6" != "TATAAA" ]; then # If the last 6 chromosomes aren't the magic sequence, continue searching
   last6=${last6:1}$chromo # Remove first char of variable and append current chromo
  else 
   mRNA+=$(opposite $chromo rna)  # Append the opposite chromosome to the mRNA. Note that in this complementary string there will be no T, since the mRNA uses U (Uracil) instead of T (Thymine).
  fi
 done
 [ "$mRNA" != "" ] && break
done
echo $mRNA

waitprint "Part 3: Termination and editing"
waitprint bio "As previously mentioned, mRNA cannot perform its assigned function within a cell until elongation ends and the new mRNA separates from the DNA template. This process is referred to as termination. In eukaryotes, the process of termination can occur in several different ways, depending on the exact type of polymerase used during transcription. In some cases, termination occurs as soon as the polymerase reaches a specific series of nucleotides along the DNA template, known as the termination sequence. In other cases, the presence of a special protein known as a termination factor is also required for termination to occur."
waitprint bash "In bash, the termination sequence is the actual end of string that ends the second loop."
waitprint bio "Once termination is complete, the mRNA molecule falls off the DNA template. At this point, at least in eukaryotes, the newly synthesized mRNA undergoes a process in which noncoding nucleotide sequences, called introns, are clipped out of the mRNA strand. This process \"tidies up\" the molecule and removes nucleotides that are not involved in protein production (Figure 6). Then, a sequence of 200 adenine nucleotides called a poly-A tail is added to the 3' end of the mRNA molecule (Figure 7). This sequence signals to the cell that the mRNA molecule is ready to leave the nucleus and enter the cytoplasm.
"
waitprint bash "In bash, this can be done by editing the string and appending 200 A's to the end of the mRNA variable."'
mRNA=${mRNA/UA//} # delete UA from the mRNA (this is just an example).
n=0; until [ $n = 300 ]; do mRNA=$mRNA"A"; n=$(($n + 1));done # This loop appends 200 A'"'"'s to the mRNA
echo $mRNA

'
mRNA=${mRNA/UA//} # delete useless UA from the mRNA (this is just an example).
n=0; until [ $n = 300 ]; do mRNA=$mRNA"A"; n=$(($n + 1));done # This loop appends 200 A's to the mRNA
echo $mRNA

waitprint "Part 4: transcription."
waitprint bio "Once an mRNA molecule is complete, that molecule can go on to play a key role in the process known as translation. During translation, the information that is contained within the mRNA is used to direct the creation of a protein molecule. In order for this to occur, however, the mRNA itself must be read by a special, protein-synthesizing structure within the cell known as a ribosome. 
The ribosome uses around 50 different types of tRNA (transfer RNAs) to build the protein."

) 2>&1 | sed 's/.*set +x.*/\
/g;s/^\+ //g'


