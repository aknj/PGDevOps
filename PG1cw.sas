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

data parks monumets;
	set pg1.np_summary;
	if type="NP" then do;
		parkType="Park";
		output parks;
	end;
	else if type="NM" then do;
		parkType="Monument";
		output monumets;
	end;
run;

data parks monumets;
	set pg1.np_summary;
	select;
		when (type="NP") do;
			parkType="Park";
			output parks;
		end;
		when (type="NM") do;
			parkType="Monument";
		output monumets;
		end;
		otherwise;
	end;
run;

data parks monumets;
	set pg1.np_summary;
	select (type);
		when ("NP") do;
			parkType="Park";
			output parks;
		end;
		when ("NM") do;
			parkType="Monument";
		output monumets;
		end;
		otherwise;
	end;
run;

data car_type;
	length car_type $ 8;
    set sashelp.cars;
    if msrp>80000 then car_type="luxury";
    else car_type="regular";

run;
