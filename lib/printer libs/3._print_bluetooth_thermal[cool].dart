// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
// import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
// import 'package:image/image.dart' as Imag;
// import 'package:waterworks/ETC/model.dart';



// class MyApp_Printer extends StatefulWidget {
//   @override
//   final ToInvoice invoideModel;
//   MyApp_Printer({Key? key, required this.invoideModel}) : super(key: key);

//   _MyApp_PrinterState createState() => _MyApp_PrinterState();
// }

// class _MyApp_PrinterState extends State<MyApp_Printer> {
//   String _info = "";
//   String _msj = '';
//   bool connected = false;

//   String _selectSize = "2";

//   @override
//   void initState() {
//     super.initState();
//     connect('F4:60:77:38:CC:8E');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('พิมพ์เอกสาร'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: disconnect,
//                     child: Text("กลับ"),
//                   ),
//                 ],
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: printNow,
//                   child: Text("พิมพ์เอกสาร"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> connect(String mac) async {
//     setState(() {});
//     final bool result =
//         await PrintBluetoothThermal.connect(macPrinterAddress: mac);
//     print("state conected $result");
//     if (result) connected = true;
//     setState(() {});
//   }

//   Future<void> disconnect() async {
//     final bool status = await PrintBluetoothThermal.disconnect;
//     setState(() {
//       connected = false;
//     });
//     print("status disconnect $status");
//     Navigator.pop(context);
//   }

//   Future<void> printNow() async {
//     String x = "กดเกดเกด ";
//     List<int> j = encodeTIS620(x);
//     bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
//     if (connectionStatus) {
//       String dnum = '78910';
//       String text = """
// ^XA
// ^MMT
// ^PW575
// ^LL1600
// ^LS0
// ^FO0,352^GFA,01792,01792,00028,:Z64:
// eJzt0L9Kw0AcB/BfvJJUCP2zaMSShhacRA4cXErpopMPcW2gk+DhFEFoIlgyFOcKvoRvcNoiDh0
// 6Op76AvUF1Etb8WwuoYiL4Hc5+H3u3+8H8GdjxUt4vuoptvpTw8lmpJhG4/aZFaIsR1Vm+Cqgxz5wllM
// eCjtMKzAF1YVRrrZ3DiEnWtHX+CJpjIP3TODVR3ET7208Edj19Vjv6M2BzRsCe6AwbQzrNoEdhUUzq4l7
// PYi/F4UD0Zj4lcpmQ0tKzJw8MwIjYDUdSB3Z0DiTNmOcH2QHvCWsY1ThtitZw7Jesvc4skFXGJLMNwtudji1
// 4LIKTDZjZLvGEJ8Ju7ouC/tCYm4XXRhhIuxigr6bVRL2gEkXyH5/wbA5taaw06nJPZg5Fx5x80DMrBczcGGMW+1ka2
// 8l29Fakk2wZ8eN1iLjmOaACivLFlbmpkMo7MRRGIksRHeO1HtkFWAz66Nz2WjJhFJkGaDGBAXyzJYJ6iVb5vD3DY1SPpNmXor9Z7l8A
// Ai+fzE=:4C53
// ^FO224,160^GFA,02304,02304,00036,:Z64:
// eJzt0TFLw0AUwPFES67Co4mdnhDTCDabcK0dMoRWKYhCvoDbNYtrxw4iUReHIuKUod/CL3CtS
// ydnx1hXh9C5qEmaAwtCFCch/+lx/Hg8OEkqKioSYT4hz/mmbOcbrZxvOtN8Y7byjQQ/MCvR75/XxaC9hLUGZwPC7

// ZLK9UNuXkgzojkVhbzqJTU1jUbEZqw3wr4LWr8zYez68l2NnjZvsW3Bvp+aJj3wGAMTXTDt7hXryRNdC5WdoalbI
// KeGzuloHDIggQNHyOTQo4/xTyl7QffNEKZJH3i8BwYAJ2hIzDvmEfGVegSOIkyLzhODCHCKss+8KQeJKfUA4YtZC
// NNOTC9KzfZwxTBhMDGMp0b+rbH/ZmqZsTNjICwQiX8Wcu7IYWx0sIZLs5uZLVTvETf88zvO3bV4z00VLDczVJhKNTF
// 9YYLYOEuDsRl/cKik9xApuceWuUIiAB2Xpqjon/QJv+mIDg==:FFA1
// ^FO0,256^GFA,03072,03072,00032,:Z64:

// eJzt0L1Kw1AUB/BzTc2NcO3H5BFDW4qjwx0zlOIg6CM4BvICHSsITQdLhT6Aj3OhGjp06Ngx4AtkzKTe9N7UJr

// bpIC6S/3I45wf34wCUKVPmH8bNtjzHeMAvf+ui2O0DfpzzfE78PeCq0syPe6r2tTt5H6o6kW7+PLXnzvwi/wx
// H2oVymnkfEeGzGgy017IO7pManGtHse3GR/tN+YW/08nyQfkZ7HK5X6K8q/vs/ckT1CDULYXdvjf7vF0TdERH
// gvgRsypGBBGNqBgQEil3Oa/NrFlIRsiQVZBgK0Z3apio/Rrx3Qq4cosRdOw6nxoVpt1ndc961V43CfIqSIfU6a

// LpUel+LJ2OIXZN4I+Jr29w2VXDg4X09fkB4K109u1oS59v+d0445zl/D51/T9W9WClnQZ1dPIOHiy1Q4DYMoucI

// Ra6udOjjRsvWe93Ew85EcjsKgRktfZh6pOO8qM2sk4DAogTP537hV6zfL2fxDsgUr+BQeLVjfdtBrZ0IoaxvN8BZ+003W+ZMmX+KF/pNYID:9404
// ^FO192,0^GFA,09216,09216,00048,:Z64:
// eJzt1c+K2kAcB/DfdEJmC9bZowXRPoK9eQiGti/istBrj80hrGML9VLoG7SvMrKgR19hYF8g
// 0EsOYvqbaP5psjiwhx5+X0XHyUfzy+RnAkChUCiUF4520ty4eW/i6N+7euXk+V83D1/dOHxx42x/jRLVKO1EY9XmdadfmGIU517WtvWKAa/m1qXfXPjh5Z6ZSorR95qP89egUNWPsF7l+9WmQ6f3Cg/byrNtp39V+kVern/c1xXeD9x8P7rCw4/SvzGV33T6uPShrmY71wegXM9DbTK4whs4z7O+JS/jheF6AFokeNmxB/0Ae+zMB3wELH0HtuUlhJWXCddTpsd7EAnL8Lk8wJBlKoOAZ/agQi0h06UfpFxH+JUZ9CK+TvnqUaJcrX+pwB8bqeb3RrLHcjWS2yj38zHcTAXEPrfe52uhAg8r1fMPRnJ24bVUN9M+zCD3kHv8g03mBn1ttYt6RkJ50RBGKP/kHuuR1uv7ppdHHwol0sEMvc6s15kKeAKTOxU2PRzr+bRSEA0y6/N6NNaD1Q22aDv926ffDS+UPDznX6/PPU87fLhaQiQvPECHF6ulisTT6Hqv8O3g4uf2NDj4iaMftnjst07fb/HYb02fWh9zg14UXu5PfqGw3xqe/bR+40/Q8/Tko89Hz3boddN71n/zbuvefDx5XIM71e75DljhVeXP+83WIxTWY69XhYdjPRHbQd5vo/rx8gz7HT/jPaWxPmGW4BzeKmW2b7uaUSgUCoVCoVAoFAqFQqFQKBQK5X/JPxZtTiA=:A3F2
// ^FO0,0^GFA,07168,07168,00028,:Z64:
// eJztWF1oHNcVPndmVjPRyjuztlwpzdo7dkhrnGJt2j4sktHOBgm1UMq62GkeGqz+0BZS6I
// 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:7BD9
// ^FO224,192^GFA,04224,04224,00044,:Z64:
// eJzt071q3EAQB/BZ6ZCVIPCQSsURHX4ChTQuTKI4JqQyeYS1OeLWD+Bi9EHsKtxT5B3S7X
// 1wYJNGeYITGNxeeYUgmZEUu8udyoT9FztT/HbZ1a4AbGxsbGz+oSQ9rN4qhj3WffNIzFZ7QTyoAmBvK4VXYp0TgGfbbSCD83En68qg1gDejnbHtDbezbrX7iR6XcyveRo6MncAQNxByIUHGMEhaDmXO7gt1mf3i8UtBRR7sJ/XQ1DSwZgLXEWrFZy4dNnam0ta/GAbGhY484POLsV+wURD5jU35brlV/g+v5uXFCafngMs2Dok3YwLeCOxgaLmbGVqvpk7UxLqyQveKtsBSZdz4c2zXfqq/Q4l6Xvzk23cWuys6ixpGIfuo9209gwPopRtdJPiAVs/xTpgWx9G801jK9KabUXxOR5HuWE7yfCYLWZYvxR7FC/DJ1uKHWPGT3MUwKjgTuVcwFP8E5zGn4MnW4m9qH8RJGzfPnCnci7giF12lqp01VrUclti23vL5d4am+G5WCepsm7dMGls8sfOGuuIDd/7jZ2KNWZKvmGB1NkQPogtxM78d2IVTVPT2j1ZLYJk2NghHIndOLCCq/10/bcHOOjxsPtYv4fFHtbGxsbG5n/Pb6RPs0A=:BDBA
// ^FO0,416^GFA,02304,02304,00024,:Z64:
// eJzt0r9LAzEUB/CXS2mHnrTiYESpxcFJMKWgGY5e0Y7+EXFxvm4dIy4dhOLm7j/QUbdIpS6HODqei3PHTupLS9t4PwTBRel3eFw+cC/vHQewzB+Oax/0/IlmeO7yh36d0T/D4TZ1SiA8QUYktV6FvMQiDjUEsgBxb/kRdCUkXQRx9ycecOhqGFn+EWHx2hw6mlhOtHF31IcNTZnlYPqsvPRhU9lO36tYiz0O62C7Q56xVnAxD+z+01UDrHhPBIkkP026kxHzVYUC3yY9qDYW84yFlDV0/+JKycHc81tcceOng1Ulz9XMc24bmPHmIzpZeBgJ1kA/eSoZpzPfVy3G0Y/GxHZnT6MfA98JvzgNjQ+Ae1OfD+TKDuM3uNcw7pLV6uleX0v3g2K6e6V0FwUQ6L0o7hRa6Hdl25ucc+MP5LW82AtczeTEQ3Jvu69Kijsg6Bh/Jcu/Cxmmu7P7O07eMi4+y3Avw5dZ5j/nE7mac0c=:8815
// ^FO0,608^GFA,02304,02304,00024,:Z64:
// eJzt0D1ugzAUwPHnPgoZHCDq8qamR/ARehT3Q1WHDowMSJilysCh6JZjWJ06cgP6CEGCmEit1Egd/B/Q8w/Jtgzgu0j0z/y3qbMuh0HPeLvgtgEoW8dFym4z1zcGwLj7iBsDokvd/Tv+Z75cL/rPX72DW2JygY1NbNTkAsrhOE7ZGoOHloh0jaKr3o+ueRk80Z1MVY1YfeDRG14Gj3QfQu9gRzeqQPykmL3AEPTooCTCC23CfgiyuT+Pvlv26xN/o9uD44m/Eh1ctGfc/Mxz10UrS8gGLyd+pdZ7M/h6X009WbFLCTzMPF4ZTSEBDxMXNo5AE1r2aHofn8/nW+obuGJJCg==:A0FF
// ^FO0,672^GFA,02688,02688,00028,:Z64:
// eJztzr9Lw0AUwPEXrpAOR2O3N4T2SMFJJGOGKB0c/QMcrxSdRIJThwxJdejg4hbxnzkN6CL+DQHBOWOHDl5+tFwKOaFzvtPdfXi8A+jaj2gsbSdjcqAda/b9auxUY5cay5UzyZp/EcrFzKE16rVbH5t3X7WkaaFqV037UPdpzEzaDfb+EmrM0xj8b8wSZgw4gmnesyIU1uqciL4VFcZd10oBJ/CG1BVn2Xid9ji6orQp4k9tjF8HmMePHBkvLaJH89qAf3ouGNKgMvNrJG0MYk1htkQfjIdsa/RkKI2AkHMzQDMyot0c2ooN5KtiLlVsuG8DjcHO+LPGvjV2o7HbhgV+YTYZi1DaAklmRPN1ZSunMIfcs1dpAfbk3N1F097ZyxNwXtpCMUfakiWbrQW1BTYFW+6LReAVRoQ0r7Kurq6urgP6A7GVcL0=:B18C
// ^FO0,736^GFA,02304,02304,00024,:Z64:
// eJzt0TFLw0AUwPGXvHAX8GyoDgbsILgKduwgtqL4OQ7cpWOHDKctrWAGRweHfgRHx8veD5HBDyC4dBD13dWkjUmHToLkPxzhl5DcuwD8p9rVLIzLsu9s6rLaG2vcTavd02UzBdkFK3rLLDoCnnu4vKk/wR+XPUomJUcNzleC4MdF5xrwJtkF/suFBBeSLXCeSs4/zu7BeSk5w+k7OP3i/rmZV6L5fiFUdoUGVIWVuvQBR+1jyt0TUPMAFTpvdhuxP5Kh6PjjS2comhONOO/kTpHfsmYskbXaubeFccWadxI9YfcfBZiGB2KPnZIHxmepnXIfZAgiZIzceSQ/tnOIQ+v+wh8kukd2XnFunY8zx9nCh9bF4vlnOh86P2obV98/zb2xoYuCp6t+NYeIvEuuJarcry8gJn/tGfd6uQ/IhcdHmfd+vE/OQu6RK+M68w4M8I2jMo6qq9b8yrq6urq/6xtvRWRZ:D83B
// ^FO0,800^GFA,01536,01536,00024,:Z64:
// eJztz01qwkAUB/A3TpkMNBjFTaASC73AdKcg6U70FukN7M7lSMCVtLj3Er1BSi8yR3CZlekkk5hE5i2K4Eb/q8ePx/sAuFISOwvE5//0hbT7BPFHxAd2hiniS4u5VWF29M6dGBdN9xAfIf4qL3dA5ufpIm67H3FPefLQoSogMpVAExEafzuIH5+54oWsMwkPkfg1vhw/v/uM+9q/HKZ9beZFQ9AO2mPgG+3lnsSFKNU+InHCt1RV/qk976dErvgeTv272pmT1v7dcKpq/2h4fkblIeLiAnfYmR8LD/mm7U+7wmd82/agX/q+7cPSm/8W3gXfy2BKFclU6ffcYP4AqflXPw==:B1C1
// ^FO0,832^GFA,01536,01536,00016,:Z64:
// eJztzjEKwkAQQNGRhZkUw5I0YQVJgl5gW8EiR/IIkYB4rLXyEhabxjo2kkqMI6LZzkZS5Hev+wBTU+OO/+yfcwORdx1VMXnoxGZd68hZY9RdXOR77F2wJnGpWfUukVX1dH2LFDmrLmYm5hQUOItp3IhjLWadJGKLYoOh54H5GrgZmo6Bd+INQg6nNkN6/SwRVnA+JIhfbgP7jxcIGfitfntqRD0AVj8v7Q==:245F
// ^FO0,896^GFA,01920,01920,00020,:Z64:
// eJzt0TEKwjAUgOFXU9IOwThmEOwRMnYo5io5Qt0cOhRcHIrgUbxBjhLEA2TsUNTYVBASheKaf/wI7yUEIBaLvSPfjCrfhPGtLn1TuW+PW2BvE9ie/rjtrKim7R6jKzJI06MzYbjqcHbPBsI3vbO6LGSHcZUvc8amF8o1WCOwyoDxaZ4iIBtMoUDAqslO1ghOtDgAy1pn59GAEXsOpLNLwHYB2waM/2/9y5D+tGQ8l8r5JgYwZGHnqZkfEos9ATrsMLc=:C871
// ^FO0,960^GFA,03072,03072,00032,:Z64:
// eJzt0z1Lw0AYB/DnejGX4dpmzFBpxC9wbhmKL7SoazfHE8HJQbcOYpNWfIG69+McOLj4AXSLFpwzCor1ckm9lGArgqCY//Qkv9w998AFoEiRIr8pyP97bs5eMvHPPsNPGT/Je/VNOxrn+9cq2nEgcm5n+puwnvO1R+1k7OacLWbOh8P8AXH2Ib/+O4nAn8VoiNLWIRENRHy37pOICLez1Bc2dB+sUuLVZ4dvYktwzuuy5IOVU86gO6KpOzWbKfeZJ0s+OIqdN6mRuF0B5bvgMFnyQTt2v0mtdFoT2ComgleHXJb8uN0PGcA1tRNfky9NDII7O1ux03tfrof+xOnEmbd9Fvul8sByMz6SLjfQjoLhRvjhJHEv9vKVcoiaTPuy8nrcv7yQOPRs7Vi5ox0DMh3t5xknsZem3HzRXk29lHpDzYdD3lF+WMFBxORNMlJvKTfueEv5RQX3DhgYYE37bcb3lZds7cS4CVOnqLcXAQUbJ/N7BrD6q/wrvKQ/RYEIwQIXhV+7iEk8MdtbP+yNOU7nOPFne5Ei/y/vxrd+KA==:602D
// ^FO0,1024^GFA,01536,01536,00016,:Z64:
// eJxjYBgFRAIeEvkyqFz+H6h8+QcOKHwDhgMofAULNL4NKl8PjW/fg8qX/IPK56hA5TMwEMmXF5Bn+MDCwc9w8AEL2KIPiQcleCQEGw4ZgL1s+OAACj+BsSERmV/ByJDwg0eCv+HgBzCfH6gEKM/YcAAiD7SHrnz2A8wPanhkgHzDP+CAOcCSMJtHCcg3V4LxZ/aA+DZw/ow/IL4FmM/ewHygwEKG/X+DBVoUj4JRMMQAAF0IS1M=:6115
// ^FO0,1088^GFA,01920,01920,00020,:Z64:
// eJztzz+KAjEYBfAvfOA0wZBqFf/gAYSd7UZY1KPEG4zdFBZRB9lCFvYo3iD2HmKOMNvZaTLG4JgBbSyEeUUgP0h4D6DOSyJ8iivs51lT+iBZyRJjWLa2sUZYso707QN8+wb/v+JGlF/ocVjGJCN5a0H+nU3yUPH1cbTBk7M4Ggi+6X4h9pvUmuiC4CmNsQH8aoqCYOkhw0DylrVfbST9lAg5j6z9GVsNFQJlubWdsfXBWHAdM6cwI5IKba7LWNvyzkL9dl9hswobXcztMNYrbMFvjRW2dTusTY1FNxZIqjtv3Q5jKCd6b+J21KlT501zBlONQLs=:191B
// ^FO0,1184^GFA,02816,02816,00044,:Z64:
// eJzt0zFr20AUAOB3OZOXhqBDUws1Uoj3EujiQdie4r9hCHStUzpc25CcYtNs8dou/R3dem4C3Wr6DyRSyJLhQhYNIuo7yY5lx4NL0ql5wwPd+xDv3pMA/p+Q97CrXUo/l7NPyLIXi+32PSx2KF0uZ5mmVF9s54MrSt3l7IMF051laX1l84Ft0yb/68pmVD6t0iCad2ymKR0mLNbl0y2ymZ6jTNv3RRJqsxbHlRmr7MR1HdrKPuY7sFaMK+XgGa2XZZ/gMH+stMb9ekVlzibWXsLNjBVpUZmL/GSfpTMWzaQyE2u5YcVFJv1OK/80ZGsfonqV64D1hlFVsgQCriLaCl0NlYADxwOdU5aFGTeyWuns8P6uaaT8BnZQxynSRNyBdsPspMYKywdcHNVlUOm2sf9Kvvni+NBei88bTuCg+zlyT3la6xUWoYK39q3cExsC2uux9qrgovsrcs9YcmsN5JabJvZSGQt2oZrr18rzteuIq0johvF7k34Bw0QGYOgiqTwf8KdKrGfgYeoG/CriOjM4tiAUKnlrL0ZI1rkGDxoisXZ4NbVYson8ndtV6gE8HvGYbHTHtgprRnjRF3CtydKQ4niR7RS2O8Ljj2XbW2C3C7s3wONeyUan8zaVwTMjfLIfBB6Hg5LdtXYwteF7GWwYcQhGNsmqUWEdpGZfWvtNFdZXfvhOBqtG/FBGNqx9ndsD19rnw8Tg+fi9NVULZbLFjei3jAysbYKd2YnrkBXDM4PfN+dtJbd8BBMbTOzR1FKfW2xi2Q34tHiytLdhhLpk7YW721XaG33hZCEF6z2QtLeQvgdpMNR//Qs9xmM8xnz8ASP6PyQ=:A1E9
// ^FO0,480^GFA,01536,01536,00016,:Z64:
// eJxjYBgFIw0w05hPCLBh4x9AGPcMlc//D5Uvw4fKF0DTb/8IlW8gi8on2b1ooEKG8Q9DgQKc32PHzMzQkYDgJ7MwNiLznTkYDiLxa5wZDxwsSIC7gucwk8LBBiR+M5PCAXR+BUI/bzPzgQMHkPhA64H6iebzo/H5CPIZGxsOOCDcw8xwmCGxAZlfw2BPIFQtDqDyXUjk26DxedD47A14rR8FOAAABz80XQ==:14EF
// ^FO0,1248^GFA,02304,02304,00072,:Z64:
// eJxjYBgFo2AUjIJRMAoIA8nn8yqpgOZQy5yBDo9RMLQBAEJcXt0=:7869
// ^FO288,608^GFA,00384,00384,00004,:Z64:
// eJxjYBicgLEBgampdrABAG1yAwc=:8EF9
// ^FO288,672^GFA,00384,00384,00004,:Z64:
// eJxjYBgcgLEBgampdrADAJ3SAwc=:D973
// ^FO288,832^GFA,00384,00384,00004,:Z64:
// eJxjYBj+gLEBgamplhoAAIebAwc=:219C
// ^FO288,800^GFA,00256,00256,00004,:Z64:
// eJxjYKA/YGxAYGqqJQcAAFa7Awc=:F61E
// ^FO288,1024^GFA,00384,00384,00004,:Z64:
// eJxjYBicgLEBgampdrABAG1yAwc=:8EF9
// ^FO288,736^GFA,00256,00256,00004,:Z64:
// eJxjYBgYwNiAwNRUSyoAAEqjAwc=:532D
// ^FO288,896^GFA,00384,00384,00004,:Z64:
// eJxjYBh+gLEBgamplhYAALf7Awc=:A52A
// ^FO288,960^GFA,00384,00384,00004,:Z64:
// eJxjYBgegLEBgampltYAANxDAwc=:4DB2
// ^FO448,1184^GFA,00768,00768,00012,:Z64:
// eJxjYBgFxAPGBxXyjA8+gNnMHyrsmwx/gNlMFhXph4xtYGzmQ1YI9sF/EDbjjwrmA3UQNkMFGruGAnYFCez/H5DYD5gPFNhQIVSGMgAAllgvSA==:2120
// ^FO480,608^GFA,00768,00768,00008,:Z64:
// eJxjYBgFKOADD3/DBwsGRgkeg4MSNSBaIVHiGIhmSJRoY2D4wcOQ8ANIA/kJkjCaDZWWhtJSOGg5KC2Dg5YA0vU/IPQooCkAAFjgFBM=:DA0A
// ^FO480,672^GFA,00768,00768,00008,:Z64:
// eJxjYBhhgPmAgR3zgQcMLAkGh1kSP4DoxpZkCRDN2JIkwcD8wICx+ZEEAwOQ35AGpVPQ6BwonYGDroDSBTjoBAkGxv8PwPQoGFAAABBJIXg=:80E8
// ^FO480,736^GFA,00512,00512,00008,:Z64:
// eJxjYBhmgPmAgR3zgQcMLAkGh1kSP4DoxpZkCRDN2JIkwcD8wICx+ZEEAwOQ35AGpVPQ6BwonYGDroDSBTjoBAkGxv8PwPQgBwDFZyF4:0E7C
// ^FO480,800^GFA,00512,00512,00008,:Z64:
// eJxjYBgmgPmAgR3zgQcMLAkGh1kSP4DoxpZkCRDN2JIkwcD8wICx+ZEEAwOQ35AGpVPQ6BwonYGDroDSBTjoBAkGxv8PwPQQAQDRLiF4:2FCF
// ^FO480,832^GFA,00768,00768,00008,:Z64:
// eJxjYBgFQwIwHzCwYz7wgIElweAwS+IHEN3YkiwBohlbkiQYmB8YMDY/kmBgAPIb0qB0ChqdA6UzcNAVULoAB50gwcD4/wGYHiYAAAFZIXg=:4805
// ^FO480,896^GFA,00768,00768,00008,:Z64:
// eJxjYBgFgwIwHzCwYz7wgIElweAwS+IHEN3YkiwBohlbkiQYmB8YMDY/kmBgAPIb0qB0ChqdA6UzcNAVULoAB50gwcD4/wGYHiEAADB1IXg=:8F47
// ^FO480,1088^GFA,01152,01152,00012,:Z64:
// eJztz7ENwjAQheHnHLJTmDACK3gERvEIKVNEJBGNC4ZglBMVYzBCBkAKODh2CiT3KH/1dfcO+Ns0531OFlMyDckFktXrFL2j2+qYza0p0KJDI7ylmMB8pdmKBthgKe4wwRpcm/brsmZndLD7be14XCwb5ug6mZ4rc7Si3rvzLi+faWb/6IOtPZSLDVezFYGPqFTu562tTG+ndTJ5:932F
// ^FO224,64^GFA,05120,05120,00032,:Z64:
// eJzt0rFu00AYwPHvfNXZiFPsbB+SBRYVbKCvyoCHqmRg5AEYD1KFjpaQUIYKToAgSF3YMvIKqC9wCAQMfYCOzhuYrRPlzm5tQ9MiNiTuP9i+/OzPtmIAn8/n+0fCv3Xx6zL53YMcILb7qlnSGb8Pcqg5awbHpvk1ND1PN3TIsR2fZwBRO2dtAXhLi+CwXmUFwD3rlPT9hvUHrb8a2z2u9tvONcDzed+vaMEW9Wpk7/vWHeycunsw3r7YsAR45g7a+Qn1vV/ziFnf+VkfUxFxViqaiSj8FEZbsLzKXoCqosgx0/QNuSgMHUjEp3H1lf0YcQEfEoyaiTRHHm0Y2pOYbSbLl0G6Xjt1Li6PQO1JGucE/DWscwlFRdK5ADUjcWkL1K6k8HATHr7R16wTNS5BofU7oKQkOeN6XxfcuuqcSIgJqBQJczD7gKGQ2amntYN1RCLrTwCFc9U4Oh9YL50TmFHtiVIqdZ5D6SZNwCDaM5kegb0dRp0bUn2f1C7L7vpKxTCFCrFQ1qfOU2Eel/VfSOzdjhrCF5YQzWcU6ymrpLwemt33eePDbeufa7dHehqQdW6+Z3Tij6wfWC8W7sztIJPpTWaWJw7lRz3gR1Ael0WuBpAzc/coZcYYBSs/m7Zx95GszLjN8QVdfH1Qb6Nzfe0Pfr74fD6fz+fz+Xz/aT8BkkOgEA==:CA0F
// ^FO0,1280^GFA,13824,13824,00072,:Z64:
// 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:4CBF
// ^FO480,960^GFA,00768,00768,00008,:Z64:
// eJxjYBgFdAXMBwzsmA88YGBJMDjMkvgBRDe2JEuAaMaWJAkG5gcGjM2PJBgYgPyGNCidgkbnQOkMHHQFlC7AQSdIMDD+fwCmRzgAAFPKIXg=:6A7E
// ^FO480,1024^GFA,00768,00768,00008,:Z64:
// eJxjYBgFVAXMBwzsmA88YGBJMDjMkvgBRDe2JEuAaMaWJAkG5gcGjM2PJBgYgPyGNCidgkbnQOkMHHQFlC7AQSdIMDD+fwCmRwFeAACC5iF4:83D1
// ^FO288,1088^GFA,00384,00384,00004,:Z64:
// eJxjYBgcgLEBgampdrADAJ3SAwc=:D973
// ^FO3,278^GB571,0,3^FS
// ^FO3,592^GB571,0,3^FS
// ^BY3,3,76^FT57,1552^BCN,,Y,N
// ^FD>:223|12|4700^FS
// ^FT365,1228^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD${widget.invoideModel.inv_user_name}^FS^CI0
// ^FO2,1^GB571,1595,6^FS
// ^FT285,325^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD1^FS^CI0
// ^FT357,660^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD3^FS^CI0
// ^FT206,397^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD2^FS^CI0
// ^FT462,1308^A@N,39,37,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD13^FS^CI0
// ^FT357,720^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD4^FS^CI0
// ^FT357,783^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD5^FS^CI0
// ^FT489,792^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD1^FS^CI0
// ^FT533,836^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD1^FS^CI0
// ^FT357,903^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD7^FS^CI0
// ^FT357,843^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD6^FS^CI0
// ^FT357,963^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD8^FS^CI0
// ^FT357,1024^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD9^FS^CI0
// ^FT357,1076^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD10^FS^CI0
// ^FT357,1136^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD11^FS^CI0
// ^FT179,473^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD555^FS^CI0
// ^FT111,549^A@N,45,45,angsana.fnt
// ^FH\
// ^FH\^CI17^F8^FD555^FS^CI0
// ^PQ1,0,1,Y^XZ
// """;

//       bool result = await PrintBluetoothThermal.writeString(
//           printText: PrintTextSize(
//               size: int.parse(_selectSize), text: text.toString()));
//       print("status print result: $result");
//       setState(() {
//         encodeTIS620('text');
//         _msj = "printed status: $result";
//       });
//     } else {
//       setState(() {
//         _msj = "no connected device";
//       });
//     }
//   }
// }

// encodeTIS620(String text) {
//   List<int> result = [];
//   for (int i = 0; i < text.length; i++) {
//     int codeUnit = text.codeUnitAt(i);
//     if (codeUnit >= 3584 && codeUnit <= 3711) {
//       // TIS-620 encoding for Thai characters
//       result.add(codeUnit - 3456);
//     } else {
//       // Other characters
//       result.add(codeUnit);
//     }
//   }
//   return result;
// }
