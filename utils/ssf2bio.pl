#! /usr/bin/perl


# This program takes argument as file name which contains data in SSF format and outputs in BIO format.

<< '#';
 Example of SSF and BIO format:

 SSF FORMAT:

<Sentence id="1">
0       ((      SSF
1       ((      NP
2       ikanuMci        NN
3       ))
4       ((      NP
5       nenu    PRP
6       ))
7       ((      NP
8       saBalU  NN
9       ,       SYM
10      ))
11      ((      NP
12      saMxarBalU      NN
13      ))
14      ((      VG
15      mAnukoVni       VRB
16      ))
17      ((      NP
18      iMtipattuna     NN
19      ))
20      ((      VG
21      uMdamanI        VRB
22      ))
23      ((      NP
24      xIni    PRP
25      BAvaM   NN
26      .       SYM
27      ))
</Sentence>

 BIO FORMAT:
 
ikanuMci_NN      B-NP
nenu_PRP     B-NP
saBalU_NN      B-NP
,_SYM     I-NP
saMxarBalU_NN      B-NP
mAnukoVni_VRB     B-VG
iMtipattuna_NN      B-NP
uMdamanI_VRB     B-VG
xIni_PRP     B-NP
BAvaM_NN      I-NP
._SYM     I-NP
  
 
Given below are SSF format and its corresponding BIO-format
i.e., TNT format contains two fields first is word and second is POS tag.

 psedo code:
Just read each line and if the line has all space charcters then print OUT \n and continue else split the line with space(or tab ) and if the first word starts with < (sometimes in SSF format sentence ID is represented by "<Sentence Id=1>" so we have to ignore it)or second word is (( or )) (as seen above (( and )) have no information so we can ignore it)then it is unwanted line so ignore it and else print OUT 2nd word and 3rd word.

#

&ssftobio();
sub ssftobio
{

	my $line;
	$flag=0;
	while ($line = <>)
	{
		chomp($line);
		if($line =~ /^\s*$/)  # if the line has all space charcters 
		{
			$flag=0;
			print "\n";
			next;
		}
		if($line =~/^</)
		{
			next;
		}
		my ($att1,$att2,$att3,$att4) = split (/\t+/, $line); #spliting the line using tabs..
		if($att2 eq "((" and $att1!~/[0-9]+\.[0-9]+/) #unwanted lines
		{
			$flag=1;
			$chunk=$att3;
		}
		elsif($att2 eq "))" and  $att1!~/[0-9]+\.[0-9]+/)  #unwanted lines
		{
			$flag=0;
			next;
		}
		else #print OUTing the wanted lines.
		{
			if($att4 =~/[A-Za-z][0-9]/)
			{
				my @array=split(/\,/,$att4);
				my ($garb,$root)=split(/\=/,$array[0]);
				if($flag){print $att2,"\t",$att3,"\tB-",$chunk;}
				else{print $att2,"\t",$att3,"\tI-",$chunk;}
			}
			else
			{
				if($flag){print $att2,"\t",$att3,"\tB-",$chunk;}
				else{print $att2,"\t",$att3,"\tI-",$chunk;}
			}
			print "\n";
			$flag=0;
		}
	}
}
