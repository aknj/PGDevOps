data np_summary_update;
	set pg1.np_summary;
	sqmiles = acres * 0.0015625;
	camping = sum(OtherCamping, BackcountryCampers, RVCampers, TentCampers);
	format sqmiles camping comma15.0;
	keep Reg ParkName DayVisits Acres sqmiles camping;
run;

data eu_occ_total;
	set pg1.eu_occ;
/*	konwersja z teskstu na liczbe: funkcja input*/
	year = input(substr(yearmon, 1,4), 4.);
	month = input(substr(yearmon, 6,2), 2.);
	reportDate = mdy(month, 1, year);
	total = sum(Camp, Hotel, ShortStay);
	format reportDate monyy7. hotel camp shortstay total comma15.;
	keep  Country Hotel ShortStay Camp ReportDate Total;
run;

data np_summary2;
	set pg1.np_summary;
	parkType = scan(parkName, -1);
run;