#include<stdio.h>
#include<string.h>

main(int argc, char *argv[])
{
  int j;
  float gpa, credits, points, total_credits;
  char usn[11], grades[8], temp, gr;


  if(argc < 3);
    //printf("Usage : $%s usn gradestring\n", argv[0]);

  else{
  strcpy(usn, argv[1]);

  points = 0.0;
  for(j = 0; j < 8; j++){
    credits = (j < 6) ? 4.0 : 1.5;
    gr = argv[2][j];
    if(gr >= 'A' && gr < 'Z'){
      if(gr < 'F'){
	points += ('Z' - 16 - gr) * credits; 
	total_credits += credits;
      }
      else if(gr == 'S'){
	total_credits += credits;
	points += 10 * credits;
      }
    }	
    
    gpa = points / total_credits;
  }
  
  printf("| %10s | %3.1f | %2.1f | ", usn, points, total_credits);
  
  if(gpa > 0.00)
    printf("%2.20f", gpa);
  else
    printf("--");
  }
}

