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

data cars_avg;
	format mpg_mean 5.2;
	set sashelp.cars;
	mpg_mean = mean(mpg_city, mpg_highway);
run;

data storm_avg;
	set pg1.storm_range;
	windAvg = mean(of wind1-wind4);
run;

data storm_avg;
	set pg1.storm_range;
	windAvg = mean(of wind:);
/*	drop wind:;*/
	drop wind1-wind4;
run;

/*wyrazenia warunkowe*/
data cars_categories;
	set sashelp.cars;
	if MSRP <= 30000 then
		num_category=1;
	else if MSRP <= 60000 then
		num_category=2;
	else num_category=3;
run;


data cars2;
    set sashelp.cars;
	length car_category $12;
    if MSRP<=40000 then do;
		Cost_Group=1;
		car_category="Basic";
	end;
    else if MSRP<=60000 then do;
		Cost_Group=2;
		car_category="Luxury";
	end;
    else do;
		Cost_Group=3;
		car_category="Extra Luxury";
	end;
run;

data Basic Luxury Extra_Luxury;
    set sashelp.cars;
	length car_category $12;
    if MSRP<=40000 then do;
		Cost_Group=1;
		car_category="Basic";
		output Basic;
	end;
    else if MSRP<=60000 then do;
		Cost_Group=2;
		car_category="Luxury";
		output Luxury;
	end;
    else do;
		Cost_Group=3;
		car_category="Extra Luxury";
		output Extra_Luxury;
	end;
run;

/*zlaczenie danych w sql*/
proc sql;
	create table class_grades as
	select t.name, sex, age, teacher, grade
		from pg1.class_teachers as t 
			inner join pg1.class_update as c
		on t.name=c.name;
quit;

proc sql;
	select coalesce(t.name, c.name) as name, sex, age, teacher, grade
		from pg1.class_teachers as t 
			full join pg1.class_update as c
		on t.name=c.name;
quit;