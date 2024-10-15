import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:waterworks/blue_thermal_printer/print_setting.dart';
import 'package:waterworks/models/invoice_bill_model_TOPRINTER.dart';

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
  printInvoice_Now(ToInvoice thisInvoice, String check, String debt, String b) async {
    print(thisInvoice.inv_number);
    // String billID = '${thisInvoice.inv_qr![0]}';
    // String area = '${thisInvoice.inv_qr![1]}';
    // String date = '${thisInvoice.inv_qr![2]}';
    // String price = '${thisInvoice.inv_qr![3]}';
    // print(billID + " " + area + " " + date + " " + price);
    // print('barcode2' + thisInvoice.inv_barcode2.toString());
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        String zplToPrinter = "";
        if (check == "1" && debt == "1") {
          //? ค้าง
          zplToPrinter = """
^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL1590
^LS0
^FT116,1190^A@N,39,37,angsana.fnt
^FH\
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
^FT42,292^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
^FT42,362^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^FS^CI0
^FT82,482^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_area}^FS^CI0
^FT248,482^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
^FT418,482^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.month}^FS^CI0
^FT47,585^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.meter_number}^FS^CI0
^FT248,585^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.meter_name}^FS^CI0
^FT403,585^A@N,39,37,angsana.fnt
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
^PQ1,0,1,Y^XZ
""";
        } else if (check == "1" && debt == "0") {
          //? ไม่ค้าง
          zplToPrinter = """
^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL1590
^LS0
^FT116,1190^A@N,39,37,angsana.fnt
^FH\
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
^FT42,292^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
^FT42,362^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^FS^CI0
^FT82,482^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_area}^FS^CI0
^FT248,482^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
^FT418,482^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.month}^FS^CI0
^FT47,585^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.meter_number}^FS^CI0
^FT248,585^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.meter_name}^FS^CI0
^FT403,585^A@N,39,37,angsana.fnt
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
^PQ1,0,1,Y^XZ
""";
        }

//? สำหรับเลขผิดปกติเท่านั้ัน
        else {
          zplToPrinter = """
^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL1120
^LS0
^FO0,256^GFA,02304,02304,00024,:Z64:
eJzt0r9Kw0AcB/BLr5AMJUednJKCL6BbhUIULL6G+AKeuFxQmisOzSDtA/RlfqVKF8HBxc3DJY4ngmQIjWmTtuYfFXFQ6Hf8cPz+cQhtssl/jlzjNVHsWxk/WeM6FDvmxf3Vkrm+HcyfEd3OMa0ehNwt9EmBW7R6+AhuM+uhxOMhMJphBSQ6HoKWvarCKRoMoS4ye+FwF00vwQSk8bQ/KcEFWDzjCPnYx+CgnGsYMLDCu2HIW96bJje7vWtoETwCyjAWiTvCGrsTcUrwWNAbVU12YyO547n38oXgWyr7pObHbnNme+7rzO+o6BPEkveEtb2eL4PIbehErsdu+W2v60sZucONyM3Yr5Y+sb86Y/teV8q3aB4bUq7MfYDBFsaqfuLvS0cp/3go8bO5W2kXMnDmPl16J3bfmrk5WPQ9Ok/crDRsMDWezLlwSWZurHyPoVCJXK80Qr7ypsFQK/pXsqZAiAx1Uf+n0VvFXv8lJyWOyzwocb/YN/lD+QTqdNBg:7CCA
^FO224,96^GFA,03456,03456,00036,:Z64:
eJztzr1Kw1AUwPF7e8K9CaRJtCBHKK2D4OJwwaVDoU6dfIhioa4ZMxRMSEktBgRdsvsC4hMUFFx8iAziHBykYAebL7GDRNHN+18OHH4cDiEymUwm+4tYNaGv1aZmVBulVm3Ml2qj1qsNgW+YtfQv9vNiKh2HP9rYoolBIeGWrbbdjndvguctHihkTD8aYyfCE9ZsgNI0kwh34lN/eTAZBubM1+PchBZGCCprgGpYcYSH9lTp0LOhyjWfDDLTDfeEg0CfTdgIkDgYijkj9HxkvfHS6OF+ggjQAtjscxfxUnRpTGdjMGlp6nr3ZmUYA9jqkwHirQCCdDZi8Mn0RGHMIDXjzEyHawZLw1hqRGbcnxrjd4bf5cYoDA+gxxiNtxdCmMRZGQ7adW608k4fngJWG7R3hWiQiLrHiq9dFUb/MJPUNEszWpmL3LDUnCYAQfoPnaf/GMSm3hKAs9zIZDLZP+gdQGNgBg==:61A9
^FO224,0^GFA,08448,08448,00044,:Z64:
eJzt1TFr20AUB/B3PmMFKiynXRx6xHYydDUYyhVEHNrSfokOpil0avFWDyY5Y4gXk73gD9ExQ4cTLs1S6Nqhw6UpaYdS1E0tIu6ddLItKw5uoNv9QUIn/dC9dxwSgImJiYnJtYJXp2i8us1t/yd7Z3WLzle38PIf7JOrHrbSw2B1i/3lEokFy7MGC23rrezDOGvJhaXnypW13czUUZaHo6axO8utE/dH5dFU05epfgflaSvfSeypbdfl6WZig7RF8p31wtRyVci6tuh32uKRXEWcWMTUFKVjPec9lrby4S6aWsjP20bWTk6ZtnhyqHpL7CvIWL4ztfBHrUti9xfsSJ0SC1CUh6V7gxBSQdHazmxuenXJXpmN6eIVZrAsGXtFrmktRvLAKgzajhrkoQudsgtVh7mYNUHelH3GO4s6nNiIHXAIHNa1uI0mENAdaDV5F7MJrzBqXYAbLQvdEIRgdirQaJ0/WxMED9g7+hhETXzBPU80OLUdeBHbUmRZG9nr/KG0BdyL7K60febXOC1b7OTtzPagM7XIiyxIO4C2tHXsDTbnapAd6BrsOXsIVNZQRV6uGPcWWUohdHjHEmQNeSFtKnuBh0ArnB70xhBbiGyXAkE8kANA3jG1lA3xkFAUWWfeHinrHUeW89iK/nBHWYLGG0eLdkwX7XNtS2lbJei9tt3Yno6HDy63dYI+aCtie7Z3lNjX83aflgn6lK7hbO9Q1+B9nLdFahPkx9bT9rwx0L15J8WULRIk0vbrrb6r7XnaWhn743a/E1v+M23xSN5O2e83+r62Ydqiz8qehbGtSBs4fa5tEFlX2k3MpQ2V/RZCRVn5ERW+NbV+ZB9Ju12oFuXeUfZiCxrK/ipFlmkrIntf2lpe2a6ywRbUuGhbnrQCZ60rbaEeW19Z37d6M9uZ2qd4EjQKLfnfcKN1uCu/mAfcQm+UlfvamvgEsdi60sreEFf7N1qzClRYvM9yiYXYmpiYmJiYmJiYmJiYmJiYmJiYmCzNX9XPd3U=:D35C
^FO224,160^GFA,03456,03456,00036,:Z64:
eJzt0jFLAzEUB/B3d+Ha4aAZHFIo9gYXF0lrhwjFnuDsZ7iqH6CjQodnKXZVJz9GP0Ls0MkPkYLg4lDEwU1f7lrawdpD1/w5wnH3I3l5CYCLi4vLn8MLGLHxT6nAPJW75ZvcaKrGjl0AT280UWrHewA/2WiCbHz41UC2RJ/Wwi1mSzITbTEz/VJ6nsmZhqQcgKEvDNDTAhCEyst9anbb4rrRaKaeVpWbOQRx5GFg+lSgOa1gbs5rceOQDGjBJwJCSYbJWw89HPCsFP1xgQe99/GHNfYJ+Y6PIEMfAxjk5epW2tsfN8etzGAZmNhjCJwx9GEKuDDiSLaWRkCUGUkmhMuVOV4aDzmZ0/LIxFF59DpXeWe1SoUgo6wJtDVDTmaXj95kO9BrpqfymmOIqixGSMIYI3EGa0YtTJKQ+eoYQL9jIjGFxBqj0qs1g7Qv22fwAZkY5OZOpY8rcwLUHzK+NSFfGmkNJevzoKZ9SYapIUE+4dm+Upn2ckPnVS99Gs+Qqcw/wR5a/cd7EBe4T0VMUsBgAePi4uLi8p98A07Lhec=:6FB7
^FO0,352^GFA,01920,01920,00020,:Z64:
eJzt0EFKw0AUBuCXTjVdlA515UKSHkOhGF15j17AATcZBDPuupD2AL3MkypduvAAjj3BFEGyiMZ5qUlaEyriSum//Aj/+zMAfzKu2mhtXbW93BhstA5WjdWd+27j1xwhFT2B2F+35kmqhhWbrdkb2ekjDg/LTSn1TScYinITo/FnE2yZwnYdsvEEu7rYzBOy90v0EVqf/8ZTDeAkFxiowoBZYzHDCEqDnjVkGFbeILsOG8xBEUCfs1sUIaPu7ISIcMDZVIsb113uborFVM85uxNmxNtxZjvi+ZrsXugRh3BpEvsmsSbxiuyALFIDY6xFyiM7pneRak42k6UxiXOzsHclFgZSJ2YxZii1l/dZM+alNMjt9aHGzjMLVi2JMntftTgg88fFDbTmN3oS/ZbKt9gvDCfzCktVgKbT6KVqxcBXpu1gCp6b9/0knX7Vur8wXmOszpIai6u2zTb/Nh9Q/rDM:64C0
^FO0,544^GFA,02304,02304,00024,:Z64:
eJzt0L9KxDAcwPGEFHKD+BtcToTmFQSXDsE66WucCM43OGQQL5KCi+jqozg4xMnXCNzqkLFDuZqmPW0bRQ/OLd+hST5D/hSh2CCxJT/ckv93GeJ+JPo3p8ggxJ4Dn0jnizL0Wzc1InTlpjpDU7/C8nN/KhGunwIntVvV74HjqvleB96WfP/cDQLJsXo1oEEK4g4rO8/NKSkuLLNM31Oyaq/hOrdntLgU8/LIPMAuqOPOZeNXYiaw8x0q0/UBNqeqEsCxuYH9pf5yoLIS0xdsUjjYG3vmnY28/NFz3jgsx869U/UXZ2vPh75AtvVVz4mFN9k6e+x5MofipPPJ3cAT56n7P+nAZ97BjpxoINIIapzT/n1isVhskz4AYciMPg==:5A05
^FO0,608^GFA,02688,02688,00028,:Z64:
eJztzz9Lw0AYx/EL15pOubpVCAmlr6BbCqlZ6uDg5BvQqatd5AqlvbwCR3HqW7ngC/EJRYpbOhkhVO/StCZqzj90M9/pgQ888EPofzZU2O0f7VphpsIchf00wsrN5uXWUdgplNvZniy/vf/BBrm7pzDtF+YoDH1vjs1s34foADOY4BtkNSeYt+yNzcC798OWQQJY6w9sBuvaheMxaTSIOks/NK1GGM6Nc74I5rUrOuTSxoyOMwNitEOOiDCcGiX0ZOlDkprZDhNEcLQ1L5bmWrq0Ecw4QTubZKZJewEMOaO09253oBVN25l1VG6Gyrpf2hSvgJDL1FZxwfpJ/QmI2CHtOcpsmppn1R+FBaALS7Kfg5G05vFhfSHMh4aweFAwN2/R1roUvWrCcPDJHIsiF4FraJxL05kwZ2NVVVVVVXvuDUCnydw=:B457
^FO0,672^GFA,02304,02304,00024,:Z64:
eJzt0TFLw0AYBuC7JngdlA8HoUNtiu5ScIkSWujS0b8gFFyTweHQ0CS0Qyd3F3+IU6S7/Qsngl2UZgwSopdLm5bk4uAiQt7peAjffW8Oof8aKrFnueOTH7wjmfNe4nqJW6Vb/iI29i/X562l9bjWlvlZS+ra40WtzYrufJr4xS86uzHRcearkryXf26igZvzKcJf90vkIIl/zFFcdF4LcIRySf6bCpjlXQSkunFD8diuwmCHuJ2u8sSAYLH/SO13mhBqd3XfctRhAOAJH6h93WjY+kOdBfPJFYX92cbbhnAyuaZwMBN9B8QLDcSdcB9H3Bfi3p7mUu69FubuJp72hVPhRuaHb6kP/S0PKeylc2AmvJU5Xoh7YSwcSrz4veLTSMx/zfttKHzJiBts+8hAEfcwyLl9hJvcg2nidW+1J5/PvdvFTOINLV77OM68iQKIMLOIyyhRCu9epUqVKn+fb+vnqFQ=:40E1
^FO0,416^GFA,01536,01536,00016,:Z64:
eJzt0T8KwjAUBvA8A2YR3+BQB2lHLyF4HK/gZCMdsoi9UsGhY69Q6NBVcdBBWxuQ/BPBIN36QYYf4Xt5EEKG9B309NjT/4bJw7+a3mxja3uBtueyT/W49dXxk1sm6Jhw4pPtCu5QZsqHHW3oxXAxjdhM+5hO0HScQi06l29HKQ1ElcFZmQUiMYwfrpOT0Ucm9pWeLy3vTXd95fCLS9vqvRBpwXLT0NBWu/uPB7Rc9X8J5NzyaOlnqG2TjePYtcdyQ/rLCzAbSuw=:4F54
^FO256,544^GFA,00384,00384,00004,:Z64:
eJxjYBhkgLEBgampdpACAIKcAwc=:D425
^FO256,608^GFA,00256,00256,00004,:Z64:
eJxjYBgAwNiAwNRUSwYAAFO1Awc=:11A8
^FO256,672^GFA,00256,00256,00004,:Z64:
eJxjYKAzYGxAYGqqJRMAAF/NAwc=:F6A2
^FO448,672^GFA,01024,01024,00016,:Z64:
eJxjYBiRgPEBdfkMByjkkwI+8LE3GPA32EhA3fJDkONAgf2DOgsoX0aQ48GHxA+PKpD5DUh8OfYHHxjgfIY/dYwg/h8Y3+YcmP8BxrftR+Xb84P5FTC+HYRvg8aHy9vwMz5G1g/kv3+Ayv/xgRmF/6GDpQCZ/wDI//EDhZ9Qj8wvYD5g/4HkkBwFAA37U9Y=:CFFC
^FO0,768^GFA,11520,11520,00072,:Z64:
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:C015
^FO0,512^GFA,02304,02304,00072,:Z64:
eJxjYBgFo4B8wOJCHcDRQR0w0OExCkbBKBgFo2BoAADDdTih:43C7
^FO0,224^GFA,04608,04608,00072,:Z64:
eJzt0LEJADAIADCHDh7mcZ7dFxyEUkhOSAQAwB9O7cje8foDAGDqAinlOKE=:06BB
^FO320,256^GFA,00768,00768,00008,:Z64:
eJxjYBgFgxEwN38wKHwApNt/FPz+wMDA3lLz8VQFkO63+XjEBkh37PncYsMOpvts+BtA9HwQ3W7zeTKIbrD5fBgk32Dz8TBIPZA+BqXfQOgPf6D0D6A6FgebDx+A+hC0/AMQzQw06QNQfrgCAB92Npw=:E11B
^FO0,928^GFA,06528,06528,00068,:Z64:
eJzt089rG0cUB/C3GnWk0pF2E0OYlkWS41an0j4lwd2CcZbGqAT8R4xcYxroQU0uOohmVZe1A6L0VNye+if4Txg5waRE7TnH7aXnPRWFFtyZ/WHL3rXJwQkl3S9oGO3M+2j2aRegSJEiRf7nIW+QUboE45WFzs/FRTsND+D0hrg5aPgvaSDAIXBxqqeJUeq+hDGLjWfwfo5h7qcGs9TQzDfIPyfG3xmD91PjqjZuB7kGpcdGbydjtNCYJobaAyLfYKXUsA+y9+JakBr6NtxWrmG+SA32xMgYD3+A58k+qYajX3INMFOjtvMis+h+CfvxrOKpwQvzjeTHn8E7ZeplVrkRzH+18o0kD6ARPWhnQ3KunRcCzvmLCHM+v8BIYwR92wjrdTIKqn3LsVZhiDb5Y/u7gV2xmrDKmxDgbejbZWjC1ySwHIoVyWUTiC6LjBLubpXshQY7QL6H3+Dj0Q622affro+vm2FPPt7rTRAfjvbaDBblUWWG07cHXHwQ9CShfKGRGqTMFm7ChjZ+74y2SdDmTaqMaiAno1AqYyKZMlz5PXOQXnnews+FlKSqy1KjSheWYsPvwKEh21jXhgXeFxB4PUQv0IbXA86QWuMW/ww9EZdF/QhDYvrmEvRCPsA/sf9kVTYW/3prPFypg7PRFI4IOyBYg8FMBJYyWqzLPXQEuaLLonT2CaVkCQRyjj/iU3kgKb1WYuwrQ26KntgU2JkJRhkIYTfHSBfHd7mPm4Jc7ZLEuInauHNijCQt140pm4KqdwNloEgMStU5rq/f5Y8S405s3Jg3tvDpxJOUUcLYWBtS5Bj3YuO9Y+PWvEExnHgTZVBWU0UDZQzOGjfWP+G/4kCQ2mFqOKcNqc7ha6Oui5Qhzhrvjpf5lrpEav5pY3ve6F5o2GOb39dGRZfFb0fW2NIGO8+oMZvfOsfozIaREchlMzJIIEQYGUPBmtpYrfw2o3XGuaMNP2ssr/0cGZZsVH1tlFX9bmRsCNZWf5Po0o/X1Io6sDJK3ayxsvaTNkaRUYoNVxlubKxHxkfHhpsxCAhnbS8stXrKqFd9wrWBcld9YmMlMj5MDZTaICdGWRvo9IUhGxBIWqEQqn5IE/rChKPAdlUfQbgrZOokhgmGf2y87gwuwRi/QcbwEgz2HzGKFClSpEiRIkWKnORfDbcy5w==:637E
^FO0,960^GFA,06528,06528,00068,:Z64:
eJzt1DFv00AYBuA7rqoZIl8jFiOdYuSIFRl1uUqmB1IFCyorA0Noh27IbB6ixpErkiF12FgifoujoIah6gzblQxdGNwJD1HD+Rw3bhVKQqiokN/hHc76nnzyWQEgT548efLkyfOfB7YWN249vxkG/LK4AcLFCRgsbtyAmFc/hm7chWs38HSDplNIGuRKg8lbhUHl4vHGPIZtx33rXtbgwtDmMAIzMYLJEVyZ0xi9n2pQew4DRHKs5140GJ/HoHJslD0S8zjdaybjtuzdXz2eyfhN/tBgxCGwHiKOwSlG9W8AOKS0TEog6te7XHd5QQnwStLWE24R3XcKJYAVIj5qNzFqnaEBvaES6fWzIvKGRGsSphoMjT7XeyE7XinooZ40r3nhLmFHLcKA3jCgi8ZG7+vHMnpXKlirvU7Ra1BDa5Edv7zawM3ugVM51ojprHVlByfLzgF9/d0nO+5Dv4xcnBgQhmoZtVSNwD4oej4wzBZBfrnsK81uQIO3GqlYNkw6APSD6UY+Qe79Q2Gke6xzVUftvu7Dfoi9NjfsqjD07f2ThjB0OyIvSA3IhkNhcN3ejY1Inxg1riqJEQyRV490ToShbO/rdWHQkJKXHRwkzeI9WKjKPZSJcRobDUVVYaAizyXYlcagfSc2bJsSpwN40silP0xHGo+yBr9kiM8jNnqN6caOOIqNu0ezGIPUYCQ24haGMjbgLIbnpQaVBv27BptmMGViEE0aXmqsRfF00mPjQUcaDKRGJIxBsse6MKpGbLRToyp+lBLEk8axUbU3X0ljcL7HJ2HsPZPGU2G0DFMYzcbY2LItg5KlStJFYZhb9mZVGIfK3uOssZQ17IsGldM0a7yxpLF0bmxIY1ktCEMZgZbOWZQY3silxmUDh4ZtiXeKhhnDkfciDUs5Aw52WSjuCcUGoETeCwqSxoBibtlEE0Yk7gXzef+trjVotEiG/3r9PHny5MmT5+bnJ6Zar5g=:09E8
^FO32,1024^GFA,00768,00768,00008,:Z64:
eJxjYBgugC0BOy0Ppe0fQOgEKO2gAKH/L4DQDR+gBglgM71Chl1AHkj3KPF/SDwAojkeHADTAgwNQBtqbPgYLIA0Tw7jgRQQfYYhAUz3QGheHoaECiDNB6QTkGgeOM38AEKzJMBpBwhtcAAsf4CfjFAZBfgBAJ+YIlU=:C822
^FO64,1024^GFA,03456,03456,00036,:Z64:
eJzt07Fu2zAQBuCjGZgdDDFbNDCS2yWrsmkIYmfKa/AR2M1DixBdnCEgOmbKsyh70Ge4wkNWZfNgWLmj7BRpWkhbMugfCAj4pCN5J4AhQ4a8c7CbiKbbjLJuM+4mIHsYUfVAtocpepjyoxm3UNcABzBVnr0DS3fmZEXrWPrYhvJ6o2sAA6irLT3fshEbhWTKiZ1Fc/PLIMA3iTkbcQOoyGhawRp31ZrAJeg7n3/n1JsgUMPo/LDWNDfGLT2b72HmCzZUbW8gA6epT8bJaI6DwkU0VTQjPGJjj8hkLva8zAO4aIRP2BzgCZeuTkD+zO24NcnOyGpvNBpB62qj+dM7E/ejcAKgwie81JjK+lKv7lSV+72J55KtOcQlGVEv9SPtVL82gCnXIsMT45bkJ3V7ruyPKdjMnhpPk/e18SqkrTnLElG392OnL2YOp42XIXWCzZcsGRXt/dgLKGTgXsAPKBT58m9TzBtY7Pq1TadsUncPr0x5/2Lk1liSD8au2BiTCNrslVzP6L9ewLo1uaeKa11t3k5c2mMq/2lk0xF888q0R615DzNkyJAhQ/6bZ51Gu9s=:2DF2
^FO0,0^GFA,08192,08192,00032,:Z64:
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:9B0E
^FT331,594^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_now_month}^FS^CI0
^FT206,324^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
^FT331,654^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_now_number}^FS^CI0
^FT331,718^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_unit_use}^FS^CI0
^FT179,400^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
^FT111,477^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^FS^CI0
^FT414,324^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_area}^FS^CI0
^FO3,770^GB571,0,2^FS
^FT372,877^A@N,37,30,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.wrong_water}^FS^CI0
^FO371,893^GB180,0,2^FS
^FO3,923^GB571,0,2^FS
^PQ1,0,1,Y^XZ
""";
        }

        bluetooth.printCustom(zplToPrinter, Size.boldMedium.val, Align.center.val);
        bluetooth.printCustom(zplToPrinter, Size.boldMedium.val, Align.center.val);

        bluetooth.paperCut();
      }
    });
  }
}
