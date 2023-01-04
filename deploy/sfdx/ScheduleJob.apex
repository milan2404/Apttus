Datetime dateTimeNow = Datetime.now().addSeconds(1);
String hour = String.valueOf(dateTimeNow.hour());
String min = String.valueOf(dateTimeNow.minute());
String ss = String.valueOf(dateTimeNow.second());
String day = String.valueOf(dateTimeNow.day());
String month = String.valueOf(dateTimeNow.month());
String year = String.valueOf(dateTimeNow.year());

String cron = ss + ' ' + min + ' ' + hour + ' ' + day + ' ' + month+ ' ? ' + year;
String strTime = dateTimeNow.format('yyyy-MM-dd h:mm:ss a');
System.schedule('EvergreenScheduleGenerationScheduler at : ' + strTime, cron, new Apttus_Billing.EvergreenScheduleGenerationScheduler());

//System.schedule('AccountBillingSummaryScheduler at : ' + strTime, cron, new Apttus_Billing.AccountBillingSummaryScheduler());