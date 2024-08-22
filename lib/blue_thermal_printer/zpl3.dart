import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:waterworks/blue_thermal_printer/print_setting.dart';
import 'package:waterworks/models/invoice_bill_model_TOPRINTER.dart';

//         zplToPrinter1_Invoice = """
// ^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
// ^XA
// ^MMT
// ^PW575
// ^LL1590
// ^LS0
// ^FT116,1190^A@N,39,37,angsana.fnt
// ^FH\

// ^FH\^CI17^F8^FDm1^FS^CI0
// ^FT126,1242^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDsu1^FS^CI0
// ^FT225,1242^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDsu2^FS^CI0
// ^FT313,1242^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDsu3^FS^CI0
// ^FT415,1242^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDsu4^FS^CI0
// ^FT507,1242^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDsu5^FS^CI0
// ^FT42,248^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
// ^FT42,305^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^^FS^CI0
// ^FT82,476^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.inv_user_area}^FS^CI0
// ^FT248,476^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
// ^FT417,476^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.month}^FS^CI0
// ^FT46,578^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.meter_number}^FS^CI0
// ^FT247,578^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD8^FS^CI0
// ^FT402,578^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD9^FS^CI0
// ^FT57,1080^A@N,34,30,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD20^FS^CI0
// ^FT203,1190^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDm2^FS^CI0
// ^FT299,1190^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDm3^FS^CI0
// ^FT399,1190^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDm4^FS^CI0
// ^FT489,1190^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDm5^FS^CI0
// ^FT34,708^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD10^FS^CI0
// ^FT139,708^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD11^FS^CI0
// ^FT234,708^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD12^FS^CI0
// ^FT454,708^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD13^FS^CI0
// ^FT454,765^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD14^FS^CI0
// ^FT454,814^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD15^FS^CI0
// ^FT454,859^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD16^FS^CI0
// ^FT454,914^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD17^FS^CI0
// ^FT454,1033^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD19^FS^CI0
// ^FT454,976^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD18^FS^CI0
// ^FT296,82^A@N,47,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDใบแจ้งค่าน้ำประปา^FS^CI0
// ^FT38,765^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebt1^FS^CI0
// ^FT38,814^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebt2^FS^CI0
// ^FT38,859^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebt3^FS^CI0
// ^FT38,914^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebt4^FS^CI0
// ^FT152,765^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebttotal1^FS^CI0
// ^FT152,814^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebttotal2^FS^CI0
// ^FT152,859^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebttotal3^FS^CI0
// ^FT150,914^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDdebttotal4^FS^CI0
// ^FT38,1334^A@N,39,37,angsana.fnt
// ^FH\
// ^FB93,1,0,C^FH\^CI17^F8^FDชำระเงิน^FS^CI0
// ^FT239,1447^A@N,39,33,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD(ชื่อ-สกุล)^FS^CI0
// ^FT99,1493^A@N,39,33,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDผู้อำนวยการส่วนบริหารธุรกิจการประปา^FS^CI0
// ^FT197,1541^A@N,39,30,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FDวันที่ชำระเงิน^FS^CI0
// ^FT42,357^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${thisInvoice.inv_tax}^FS^CI0
// ^PQ1,0,1,Y^XZ
// """;
// ^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
// ^XA
// ^MMT

//${thisInvoice}
// ${thisInvoice.fiveMonths_Back_Model?[0].month}
// ${thisInvoice.fiveMonths_Back_Model?[0].sum_unit}
// ${thisInvoice.debtmonths_step?[0].name}
// ${thisInvoice.debtmonths_step?[0].total}

// ^FH\\^FDLA,${billID}\\0D\\0A${area}\\0D\\0A${date}\\0D\\0A${price}^FS
// ^FD>:${thisInvoice.inv_barcode2}^FS
class PrintHereFucker {
  printInvoice_Now(ToInvoice thisInvoice, ToInvoice_Bill thisBill) async {
    // print(thisInvoice.inv_number);
    // String billID = '${thisInvoice.inv_qr![0]}';
    // String area = '${thisInvoice.inv_qr![1]}';
    // String date = '${thisInvoice.inv_qr![2]}';
    // String price = '${thisInvoice.inv_qr![3]}';
    // print(billID + " " + area + " " + date + " " + price);
    // print('barcode2' + thisInvoice.inv_barcode2.toString());

    // print('---------------');
    // print('----------------' + thisBill.inv_bill_id.toString());
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        String zplToPrinter1_Invoice = "";
        String zplToPrinter2_Bill = "";

        zplToPrinter1_Invoice = """
^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL1590
^LS0
^FO192,1312^GFA,02688,02688,00028,:Z64:
^FT260,1420^FD
^GFA,1425,1425,19,,:::::gT03C,gS07C3,gR078,gQ078,gP0F,gO0F,gN0F,gM07,gL078,gK03C,gJ01E,gJ0E,gI0F,gH038,gG01C,gG0F,g078,Y01C,Y0E,X07,W01C,W07,V01C,V0E,U038,U0E,T038,T0E,S038,S0E,R018,R06,Q018,Q06,P01C,003CL03,003FL0C,0039CJ038,0018EJ0E,00107I038,00101800E,00180C038,0018071E,I0807E,I0C02,I0403,I0601,I0201,I0301,I01818,I01808,J0C08,J0608,J0308,J01C8,K0F8,K07,K01838,L038,,:::::::::
^FS
^FT116,1190^A@N,39,37,angsana.fnt
^FH\0
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[0].month}^FS^CI0
^FT126,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[0].sum_unit}^FS^CI0
^FT225,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[1].sum_unit}^FS^CI0
^FT313,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[2].sum_unit}^FS^CI0
^FT415,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[3].sum_unit}^FS^CI0
^FT507,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[4].sum_unit}^FS^CI0
^FT42,248^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
^FT42,305^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^^FS^CI0
^FT82,476^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_area}^FS^CI0
^FT248,476^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
^FT417,476^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.month}^FS^CI0
^FT46,578^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.meter_number}^FS^CI0
^FT247,578^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.meter_name}^FS^CI0
^FT402,578^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_number}^FS^CI0
^FT57,1080^A@N,34,30,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.sum_total_text}^FS^CI0
^FT203,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[1].month}^FS^CI0
^FT299,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[2].month}^FS^CI0
^FT399,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[3].month}^FS^CI0
^FT489,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.fiveMonths_Back_Model?[4].month}^FS^CI0
^FT34,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_now_number}^FS^CI0
^FT139,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_previous_number}^FS^CI0
^FT234,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_unit_use}^FS^CI0
^FT454,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_prapa_cost}^FS^CI0
^FT454,765^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_service}^FS^CI0
^FT454,814^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD-^FS^CI0
^FT454,859^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_vat}^FS^CI0
^FT454,914^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.total_format}^FS^CI0
^FT454,1033^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.sum_total}^FS^CI0
^FT454,976^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_sum_invoice}^FS^CI0
^FT296,82^A@N,47,45,angsana.fnt
^FH\
^FH\^CI17^F8^FDใบแจ้งค่าน้ำประปา^FS^CI0
^FT38,765^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[0].name}^FS^CI0
^FT38,814^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[1].name}^FS^CI0
^FT38,859^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[2].name}^FS^CI0
^FT38,914^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[3].name}^FS^CI0
^FT152,765^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[0].total}^FS^CI0
^FT152,814^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[1].total}^FS^CI0
^FT152,859^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[2].total}^FS^CI0
^FT150,914^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.debtmonths_step?[3].total}^FS^CI0
^FT38,1334^A@N,39,37,angsana.fnt
^FH\
^FB93,1,0,C^FH\^CI17^F8^FDชำระเงิน^FS^CI0
^FT239,1447^A@N,39,33,angsana.fnt
^FH\
^FH\^CI17^F8^FD(ชื่อ-สกุล)^FS^CI0
^FT99,1493^A@N,39,33,angsana.fnt
^FH\
^FH\^CI17^F8^FDผู้อำนวยการส่วนบริหารธุรกิจการประปา^FS^CI0
^FT197,1541^A@N,39,30,angsana.fnt
^FH\
^FH\^CI17^F8^FDวันที่ชำระเงิน^FS^CI0
^FT42,357^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_tax}^FS^CI0
^PQ1,0,1,Y^XZโ
""";

        zplToPrinter2_Bill = """
^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL1590
^LS0
^FO192,1312^GFA,02688,02688,00028,:Z64:
^FT260,1420^FD
^GFA,1425,1425,19,,:::::gT03C,gS07C3,gR078,gQ078,gP0F,gO0F,gN0F,gM07,gL078,gK03C,gJ01E,gJ0E,gI0F,gH038,gG01C,gG0F,g078,Y01C,Y0E,X07,W01C,W07,V01C,V0E,U038,U0E,T038,T0E,S038,S0E,R018,R06,Q018,Q06,P01C,003CL03,003FL0C,0039CJ038,0018EJ0E,00107I038,00101800E,00180C038,0018071E,I0807E,I0C02,I0403,I0601,I0201,I0301,I01818,I01808,J0C08,J0608,J0308,J01C8,K0F8,K07,K01838,L038,,:::::::::
^FS
^FT116,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[0].month}^FS^CI0
^FT126,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[0].sum_unit}^FS^CI0
^FT225,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[1].sum_unit}^FS^CI0
^FT313,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[2].sum_unit}^FS^CI0
^FT415,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[3].sum_unit}^FS^CI0
^FT507,1242^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[4].sum_unit}^FS^CI0
^FT42,248^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD2^FS^CI0
^FT82,476^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD4^FS^CI0
^FT248,476^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD5^FS^CI0
^FT417,476^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD6^FS^CI0
^FT46,578^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD7^FS^CI0
^FT247,578^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD8^FS^CI0
^FT402,578^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD9^FS^CI0
^FT57,1080^A@N,34,30,angsana.fnt
^FH\
^FH\^CI17^F8^FD20^FS^CI0
^FT203,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[1].month}^FS^CI0
^FT299,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[2].month}^FS^CI0
^FT399,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[3].month}^FS^CI0
^FT489,1190^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisBill.fiveMonths_Back_Model?[4].month}^FS^CI0
^FT34,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD10^FS^CI0
^FT139,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD11^FS^CI0
^FT234,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD12^FS^CI0
^FT454,708^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD13^FS^CI0
^FT454,765^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD14^FS^CI0
^FT454,814^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD15^FS^CI0
^FT454,859^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD16^FS^CI0
^FT454,914^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD17^FS^CI0
^FT454,1033^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD19^FS^CI0
^FT454,976^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD18^FS^CI0
^FT296,82^A@N,47,45,angsana.fnt
^FH\
^FH\^CI17^F8^FDใบเสร็จรับเงิน^FS^CI0
^FT38,765^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebt1^FS^CI0
^FT38,814^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebt2^FS^CI0
^FT38,859^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebt3^FS^CI0
^FT38,914^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebt4^FS^CI0
^FT152,765^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebttotal1^FS^CI0
^FT152,814^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebttotal2^FS^CI0
^FT152,859^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebttotal3^FS^CI0
^FT150,914^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FDdebttotal4^FS^CI0
^FT38,1334^A@N,39,37,angsana.fnt
^FH\
^FB93,1,0,C^FH\^CI17^F8^FDชำระเงิน^FS^CI0
^FT239,1447^A@N,39,33,angsana.fnt
^FH\
^FH\^CI17^F8^FD(ชื่อ-สกุล)^FS^CI0
^FT99,1493^A@N,39,33,angsana.fnt
^FH\
^FH\^CI17^F8^FDผู้อำนวยการส่วนบริหารธุรกิจการประปา^FS^CI0
^FT197,1541^A@N,39,30,angsana.fnt
^FH\
^FH\^CI17^F8^FDวันที่ชำระเงิน^FS^CI0
^FT42,357^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD3^FS^CI0
^PQ1,0,1,Y^XZ
""";

         bluetooth.printCustom(
             zplToPrinter1_Invoice, Size.boldMedium.val, Align.center.val);
        bluetooth.printCustom(
            zplToPrinter2_Bill, Size.boldMedium.val, Align.center.val);

        bluetooth.paperCut();
      }
    });
  }
}
