class MonthTH {
  String convertMonth(String numMonth) {
    if (numMonth == 'ม.ค.') {
      return 'มกราคม';
    } else if (numMonth == 'ก.พ.') {
      return 'กุมภาพันธ์';
    } else if (numMonth == 'มี.ค.') {
      return 'มีนาคม';
    } else if (numMonth == 'เม.ย.') {
      return 'เมษายน';
    } else if (numMonth == 'พ.ค.') {
      return 'พฤษภาคม';
    } else if (numMonth == 'ม.ย.') {
      return 'มิถุนายน';
    } else if (numMonth == 'ก.ค.') {
      return 'กรกฏาคม';
    } else if (numMonth == 'ส.ค.') {
      return 'สิงหาคม';
    } else if (numMonth == 'ก.ย.') {
      return 'กันยายน';
    } else if (numMonth == 'ต.ค.') {
      return 'ตุลาคม';
    } else if (numMonth == 'พ.ย.') {
      return 'พฤษจิกายน';
    }
    return numMonth;
  }
}
