class MonthTH {
  String convertMonth(String numMonth) {
    if (numMonth == '01') {
      return 'มกราคม';
    } else if (numMonth == '02') {
      return 'กุมภาพันธ์';
    } else if (numMonth == '03') {
      return 'มีนาคม';
    } else if (numMonth == '04') {
      return 'เมษายน';
    } else if (numMonth == '05') {
      return 'พฤษภาคม';
    } else if (numMonth == '06') {
      return 'มิถุนายน';
    } else if (numMonth == '07') {
      return 'กรกฏาคม';
    } else if (numMonth == '08') {
      return 'สิงหาคม';
    } else if (numMonth == '09') {
      return 'กันยายน';
    } else if (numMonth == '10') {
      return 'ตุลาคม';
    } else if (numMonth == '11') {
      return 'พฤษจิกายน';
    }
    return 'ธันวาคม';
  }
}
