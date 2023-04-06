class MonthTH {
  String convertMonth(String monthInitial) {
    if (monthInitial == 'ม.ค.') {
      return 'มกราคม';
    } else if (monthInitial == 'ก.พ.') {
      return 'กุมภาพันธ์';
    } else if (monthInitial == 'มี.ค.') {
      return 'มีนาคม';
    } else if (monthInitial == 'เม.ย.') {
      return 'เมษายน';
    } else if (monthInitial == 'พ.ค.') {
      return 'พฤษภาคม';
    } else if (monthInitial == 'ม.ย.') {
      return 'มิถุนายน';
    } else if (monthInitial == 'ก.ค.') {
      return 'กรกฏาคม';
    } else if (monthInitial == 'ส.ค.') {
      return 'สิงหาคม';
    } else if (monthInitial == 'ก.ย.') {
      return 'กันยายน';
    } else if (monthInitial == 'ต.ค.') {
      return 'ตุลาคม';
    } else if (monthInitial == 'พ.ย.') {
      return 'พฤษจิกายน';
    }
    return monthInitial;
  }
}
