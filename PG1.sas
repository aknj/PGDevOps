data suv_upto_30000;
	set sashelp.cars;
	where type = "SUV" and msrp <= 30000;
run;

/*Uzycie formatow*/
data class_bd;
	set pg1.class_birthdate;
	format Birthdate ddmmyyd10.;
	where Birthdate >= "01sep2005"d;
run;

/*Sortowanie danych*/
proc sort data=class_bd out=class_bd_srt;
	by Birthdate;
run;

/*sortowanie rosnaco po wieku i rosaco po wzroscie*/
proc sort data=class_bd out=class_bd_srt;
	by age Height;
run;

/*sortowanie rosnaco po wieku i malejaco po wzroscie*/
proc sort data=class_bd out=class_bd_srt;
	by age descending Height;
run;

/*usuwanie duplikatow*/
proc sort data=pg1.class_test3 out=class_test3_clean nodupkey dupout=class_test3_dups;
/*	by name Subject TestScore;*/
	by _all_;
run;

/*Przetwarzanie danych w data step*/
data class_bd;
	set pg1.class_birthdate;
	format Birthdate ddmmyyd10.;
	where Birthdate >= "01sep2005"d;
	drop age;
run;

/*Drop jako opcja zbioru*/
data class_bd;
	set pg1.class_birthdate(drop=age);
	format Birthdate ddmmyyd10.;
	where Birthdate >= "01sep2005"d;
run;