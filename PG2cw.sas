data camping(drop=LodgingOther) logging(drop=campTotal);
	set pg2.np_2017;
	campTotal=sum(of Camping:);
	if campTotal>0 then 
		output camping;
	if LodgingOther>0 then
		output logging;

	keep parkName Month DayVisits campTotal LodgingOther;
	format campTotal comma6.;
run;