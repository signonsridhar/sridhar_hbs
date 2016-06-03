define(['can_fixture'], (can)->
    can.fixture('GET /bss/account?action=getAccountStatement',(req, res)->
        return {
            "response":{
                "service":"getAccountStatement",
                "response_code":100,
                "execution_time":2586,
                "timestamp":"2014-02-26T20:02:19+0000",
                "response_data": "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\u000a<html>\u000a<head>\u000a<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\u000a<title></title>\u000a\u000a<style media=\"all\" type=\"text/css\">\u000abody { font-family: Helvetica, Arial, sans-serif; font-size: 11px; margin:0; padding:0; }\u000atable.logo { border-bottom: 6px solid #A0A0A0; padding: 0px; padding: 0px; spacing: 0px; }\u000atable.box { border: 1px solid #A0A0A0; width: 100% ; background-color: #EEE }\u000atable.section { border-collapse:collapse; padding: 0px; padding: 0px; spacing: 0px; width:700px; border: 0px solid #A0A0A0; }\u000ath { text-align: left; vertical-align: bottom; padding: 5px; font-weight: bold; }\u000ath.branded { border-bottom: solid 1px #A0A0A0; border-top: solid 1px #A0A0A0; background-color: #F0F0F0; text-align:left; font-size: 16px;}\u000ath.branded2 { border-bottom: solid 1px #A0A0A0; border-top: solid 1px #A0A0A0; background-color: #F0F0F0 ; text-align:left; font-size: 14px;}\u000atd {vertical-align:top;}\u000atd.coname { font-weight: bold; font-size: 16px }\u000atd.grey { color:#505050; }\u000atd.branded { border-bottom: solid 1px #A0A0A0; border-top: solid 1px #A0A0A0; background-color: #F0F0F0 ; text-align:left}\u000atd.lineitem { border-bottom: solid 1px #A0A0A0; padding: 2px; }\u000atd.pbal { background-color: #FFF; color:#505050; font-weight: bold; padding: 5px; }\u000atd.pbalrt { background-color: #FFF; color:#505050; text-align: right; font-weight: bold; padding: 5px; }\u000atd.totals { border-top: solid 1px #A0A0A0; background-color: #FFF; font-weight: bold; padding: 5px; }\u000atd.totals-rightalign { border-top: solid 1px #A0A0A0; background-color: #FFF; text-align: right; font-weight: bold; padding: 5px; font-size: 12px; }\u000ath.usageh { border-bottom: solid 1px #A0A0A0; font-weight: bold; font-size: 14px; }    \u000a\u000a#logo {margin-bottom: 13px;}\u000a#content {width: 700px; margin: 0 auto; }\u000a#paged-section {page-break-inside :avoid;}\u000a</style>\u000a<style media=\"print\" type=\"text/css\">\u000a@page {\u000a@bottom-left {\u000afont-family: Arial, Helvetica, sans-serif; font-size: 10pt;\u000acolor: #000000;\u000acontent: \"Sample Footer\";\u000a}\u000a@bottom-right {\u000afont-family: Arial, Helvetica, sans-serif; font-size: 10pt;\u000atext-align:right;\u000acolor: #000000;\u000acontent: \"Page \" counter(page) \" of \" counter(pages);\u000a}\u000a@top-left {\u000afont-family: Arial, Helvetica, sans-serif; font-size: 10pt;\u000acolor: #000000;\u000acontent: \"Sample Header\" ;\u000a}\u000asize : 8.5in 11in; margin-top: 1.5in; margin-left: .5in; margin-right: .5in; margin-bottom: .75in;\u000a}\u000a</style>\u000a\u000a\u000a</head>\u000a\u000a<body>\u000a<!-- ************** HEADER ***************** -->\u000a<div id=\"content\">\u000a<table class=\"logo\" width=\"700\">\u000a<tr>\u000a<td width=\"450\" rowspan=3><img class=\"logo\" src=\"\" title=\"Deutsche Telekom HBS Test 2\" alt=\"Deutsche Telekom HBS Test 2 Logo\"  /></td>\u000a<td width=\"250\">\u000a<table style=\"spacing:0px; padding:0px; border-collapse:collapse\" width=\"100%\">\u000a<tr>\u000a<td style=\"background-color:#EEEEEE; color:magenta; font-weight:bold;\">Contact us</td><td  style=\"background-color:#EEEEEE\">: 1 (800) 286-0203</td>\u000a</tr>\u000a<tr>\u000a<td colspan=\"2\"  style=\"background-color:#EEEEEE\">customerservice@tmobilebiz.com</td>\u000a</tr>\u000a<tr>\u000a<td>Statement Date</td><td>: 2/26/2014</td>\u000a</tr>\u000a<tr>\u000a<td>Account Number</td><td>: 15148688</td>\u000a</tr>\u000a</table>\u000a</td>\u000a</tr>\u000a</table>\u000a\u000a<table width=\"700\">\u000a<tr>\u000a<td class=\"coname\" width=\"350\" height=\"30\">Monthly Billing &amp; Payment Statement</td>\u000a<td width=\"350\" style=\"text-align:right\">Billing Period : 2/26/2014 to 3/25/2014</td>\u000a</tr>\u000a<tr>\u000a<td><b>choochee</b><br />\u000asapna jkjlkj<br />\u000a1800 stokes street<br />\u000a<br />\u000asan jose, CA 95126</td>\u000a<td style=\"text-align:right\" class=\"coname\">Main phone number: <br />\u000a<img class=\"logo\" src=\"\" title=\"Deutsche Telekom HBS Test 2\" alt=\"Deutsche Telekom HBS Test 2 Logo\"  />\u000a</td>\u000a</tr>\u000a<tr>\u000a<td>&nbsp;</td>\u000a<td style=\"text-align:right\">&nbsp;</td>\u000a</tr>\u000a</table>\u000a\u000a<!-- *************** BODY ***************** -->\u000a<table class=\"section\">\u000a<tr>\u000a<td colspan=\"3\">&nbsp;</td>\u000a</tr>\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">Statement Summary</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;</th> \u000a</tr>\u000a<tr> \u000a<td class=\"pbal\">Previous Balance</td> \u000a<td class=\"pbal\">&nbsp;</td> \u000a<td class=\"pbalrt\">$0.00</td> \u000a</tr>\u000a<tr> \u000a<td class=\"pbal\">Recurring Charges</td> \u000a<td class=\"pbal\">&nbsp;</td> \u000a<td class=\"pbalrt\">$ 810.00</td> \u000a</tr>\u000a<tr> \u000a<td class=\"pbal\">Usage Charges</td> \u000a<td class=\"pbal\">&nbsp;</td> \u000a<td class=\"pbalrt\">$ 0.00</td> \u000a</tr>\u000a<tr> \u000a<td class=\"pbal\">Credits</td> \u000a<td class=\"pbal\">&nbsp;</td> \u000a<td class=\"pbalrt\">$ 0.00</td> \u000a</tr>\u000a<!--tr> \u000a<td class=\"pbal\">Refunds</td> \u000a<td class=\"pbal\">&nbsp;</td> \u000a<td class=\"pbalrt\">$ 0.00</td> \u000a</tr-->\u000a<tr> \u000a<td class=\"pbal\" style=\"border-bottom:1px solid black;\">Taxes, Surcharges &amp; Fees</td> \u000a<td class=\"pbal\" style=\"border-bottom:1px solid black;\">&nbsp;</td> \u000a<td class=\"pbalrt\" style=\"border-bottom:1px solid black;\">$ 0.00</td> \u000a</tr>\u000a<tr> \u000a<td class=\"pbal\">Subtotal</td> \u000a<td class=\"pbal\">&nbsp;</td> \u000a<td class=\"pbalrt\">$ 810.00</td> \u000a</tr>\u000a<tr> \u000d\u000a    <td class=\"pbal\">Electronic Payment (applied 2/26/2014)  </td>\u000d\u000a    <td class=\"pbal\">&nbsp;</td> \u000d\u000a    <td class=\"pbalrt\">$   -810.00</td> \u000d\u000a</tr>\u000a<tr> \u000a<td colspan=\"3\" class=\"pbalrt\" style=\"border-top:1px solid black;\"><b>Balance Due</b> $810.00</td> \u000a</tr>\u000a</table>\u000a<div id = \"paged-section\">\u000a<table class=\"section\">\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">Recurring Charges</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;</th> \u000a</tr>\u000a<!-- Line Items -->\u000a<tr> \u000a    <td class=\"pbal\"><!--itemPlanAnd__Comments-->Extension Service (2/26/2014       - 3/25/2014      )</td>\u000a    <td class=\"pbal\"> </td> \u000a    <td class=\"pbalrt\">$405.00</td> \u000a</tr>\u000a<tr> \u000a    <td class=\"pbal\"><!--itemPlanAnd__Comments-->service0 (2/26/2014       - 3/25/2014      )</td>\u000a    <td class=\"pbal\"> </td> \u000a    <td class=\"pbalrt\">$405.00</td> \u000a</tr>\u000a<tr>\u000a<td style=\"text-align:right\" colspan=\"3\"><b>Total:</b>&nbsp; $ 810.00</td>\u000a</tr>\u000a</table>\u000a</div>\u000a<!-- <div id = \"paged-section\">\u000a<table class=\"section\">\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">One-Time Fee</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;</th> \u000a</tr>\u000a< Line Items >\u000a<tr>\u000a<td style=\"text-align:right\" colspan=\"3\"><b>Total:</b>&nbsp; $ 0.00</td>\u000a</tr>\u000a</table>\u000a</div> -->\u000a<div id=\"paged-section\">\u000a<table class=\"section\">\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">Usage Charge Summary</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;<br/></th> \u000a</tr>\u000a</table>\u000a<table class=\"section\">\u000a<tr>\u000a<td style=\"text-align:right\" colspan=\"3\"><b>Total:</b>&nbsp; $ 0.00</td>\u000a</tr>\u000a</table>\u000a</div>\u000a\u000a<div id = \"paged-section\">\u000a<table class=\"section\">\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">Adjustments</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;<br/></th> \u000a</tr>\u000a</table>\u000a<table class=\"section\">\u000a<tr>\u000a<td style=\"text-align:right\" colspan=\"3\"><b>Total:</b>&nbsp; $ 0.00</td>\u000a</tr>\u000a</table>\u000a</div>\u000a\u000a<div id = \"paged-section\">\u000a<table class=\"section\">\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">Taxes, Surcharges &amp; Fees</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;</th> \u000a</tr>\u000a<!-- Taxes and Fees Loop -->\u000a<tr>\u000a<td style=\"text-align:right\" colspan=\"3\"><b>Total:</b>&nbsp; $ 0.00</td>\u000a</tr>\u000a</table>\u000a</div>\u000a\u000a<div id = \"paged-section\">\u000a<table class=\"section\">\u000a<tr> \u000a<th class=\"branded2\" width=\"500\">Usage Charges Detail</th> \u000a<th class=\"branded\" width=\"40\" style=\"text-align: right\">&nbsp;</th> \u000a<th class=\"branded\" width=\"160\" style=\"text-align: right\">&nbsp;</th> \u000a</tr>\u000a</table>\u000a<table class=\"section\">\u000a</table>\u000a</div>\u000a\u000a</div>\u000a\u000a<!-- CurrentStmtTotalPymts: 810.00  -->\u000a<!-- CurrentStmtTotalWOs: 0.00 -->\u000a<!-- CurrentStmtTotalRefunds: 0.00 -->\u000a<!-- CurrentStmtTotalCredits: 810.00 -->\u000a<!-- GLDebit: 810.00 -->\u000a<!-- GLBaseDebit: 810.00 -->\u000a<!-- GLTaxDebit: 0.00 -->\u000a<!-- GLOnlyBaseDebit:  810.00 -->\u000a<!-- GLOnlyDebit: 810.00 -->\u000a<!-- GLOnlyTaxDebit: 0.00 -->\u000a<!-- GLTotalDue: 810.00 -->\u000a<!-- GLBalDue: 0.00 -->\u000a<!-- AcctTotalOwed 0.00 -->\u000a<!-- AcctTotalNewCharges: 810.00  -->\u000a<!-- AcctTotalNewPayments: 810.00  -->\u000a<!-- AcctTotalNewEndBalance: 0.00  -->\u000a<!-- GLTotalCredits: 0.00  -->\u000a<!-- GLCredit: 810.00  -->\u000a<!-- GLTotalSvcCredits: 0.00  -->\u000a<!-- TotalCashandSvcCredits: 0.00  -->\u000a<!-- ExtendedAltRate:     -->\u000a<!-- UsageUnitsTotal: 0.00   -->\u000a<!-- UsageUnitsSubtotal: 0.00  -->\u000a<!-- UsageAltAmountSubtotal: 0.00  -->\u000a<!-- UsageAltAmountTotal: 0.00  -->\u000a<!-- UsageGrpAlt_Rate:  -->\u000a<!-- usageExtendedGrpAlt_Rate:  -->\u000a\u000a<!-- New Strings Per DEV-2905  -->\u000a<!-- XtaxSrvTaxTypeDesc: taxSrvTaxTypeDesc  -->\u000a<!-- XtaxSrvTaxAmount: taxSrvTaxAmount  -->\u000a\u000a<!-- New Strings Per DEV-2969  -->\u000a<!-- GLTotalRecurringCharges: 810.00  -->\u000a<!-- GLTotalUsageCharges: 0.00   -->\u000a<!-- GLTotalRecurAfterCredits: 810.00  -->\u000a<!-- GLTotalUsageAfterCredits: 0.00  -->\u000a<!-- GLRecurDiscountCredits: 0.00   -->\u000a<!-- GLUsageDiscountCredits: 0.00  -->\u000a<!-- GLTaxDiscountCredits: 0.00  -->\u000a<!-- GLTaxDiscountCredits: 0.00  -->\u000a\u000a</body>\u000a\u000a</html>\u000a",
                "version":"1.0"
            }
        }
    )
)