import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:waterworks/blue_thermal_printer/print_setting.dart';
import 'package:waterworks/models/invoice_to_printer.dart';

class PrintHereFucker {
  printInvoice_Now(ToInvoice thisInvoice, String check) async {
    print('หน้าปริ้น ฟังชั่นปริ้น' + check);
    print(thisInvoice.inv_number);
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        String zplToPrinter = "";
        if (check == "1") {
          zplToPrinter = """
CT~~CD,~CC^~CT~
^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL1840
^LS0
^FO0,352^GFA,02304,02304,00024,:Z64:
eJzt0r9Kw0AcB/BLr5AMJUednJKCL6BbhUIULL6G+AKeuFxQmisOzSDtA/RlfqVKF8HBxc3DJY4ngmQIjWmTtuYfFXFQ6Hf8cPz+cQj91cg1XhPFvpXxkzWuQ7FjXtxfLZnr28H8GdHtHNPqQcjdQp8UuEWrh4/gNrMeSjweAqMZVkCi4yFo2asqnKLBEOoisxcOd9H0EkxAGk/7kxJcgMUzjpCPfQwOyrmGAQMrvBuGvOW9aXKz27uGFsEjoAxjkbgjrLE7EacEjwW9UdVkNzaSO557L18IvqWyT2p+7DZntue+zvyOij5BLHlPWNvr+TKI3IZO5Hrslt/2ur6UkTvciNyM/WrpE/urM7bvdaV8i+axIeXK3AcYbGGs6if+vnSU8o+HEj+bu5V2IQNn7tOld2L3rZmbg0Xfo/PEzUrDBlPjyZwLl2Tmxsr3GAqVyPVKI+QrbxoMtaJ/JWsKhMhQF/V/Gr1V7PVfclLiuMyDEveLfZNNNvln+QRRqtBg:32E2
^FO224,160^GFA,02304,02304,00036,:Z64:
eJzt0TFLw0AUwPFES67Co4mdnhDTCDabcK0dMoRWKYhCvoDbNYtrxw4iUReHIuKUod/CL3CtSydnx1hXh9C5qEmaAwtCFCch/+lx/Hg8OEkqKioSYT4hz/mmbOcbrZxvOtN8Y7byjQQ/MCvR75/XxaC9hLUGZwPC7ZLK9UNuXkgzojkVhbzqJTU1jUbEZqw3wr4LWr8zYez68l2NnjZvsW3Bvp+aJj3wGAMTXTDt7hXryRNdC5WdoalbIKeGzuloHDIggQNHyOTQo4/xTyl7QffNEKZJH3i8BwYAJ2hIzDvmEfGVegSOIkyLzhODCHCKss+8KQeJKfUA4YtZCNNOTC9KzfZwxTBhMDGMp0b+rbH/ZmqZsTNjICwQiX8Wcu7IYWx0sIZLs5uZLVTvETf88zvO3bV4z00VLDczVJhKNTF9YYLYOEuDsRl/cKik9xApuceWuUIiAB2Xpqjon/QJv+mIDg==:FFA1
^FO0,256^GFA,03072,03072,00032,:Z64:
eJzt0rFqwkAYB/BLU4iDGJ0rEewLtGRJaaiLTn2Jlr6AFoeTirnUwTxFnyWSokuhD1Aon1M6nuiQQUgvd9FijLF2K+Q/3HH8CPm+7w6hPHny/P/QI10n2X6b8Lsj/Rplewllp3rAj07AV6O4hzsrvjUjT5vlo5npje6L8Gq6h8tPvptGqktu7Kc43UlXeCGyO5ScjxzqwlWIvZ7wD1FfzU11Nh5N9EH2eEG4uT7v3I+2U/Tv3KiRmj0aupoqu9AeIBVZ6EaCokpit6DhOVPQakMXOiGpkJBYJxdV3gkLHtNz33mjWsUbw0JxK94Q3p8NUwfhPYJ7vvMlnMrMJVCYS7FjFbf8URB/PwZ1gqliB5G3uTeClm8zV5kv70GevFKF4Mj5k8L92OXIOyBPE47xlW/TLJc2vpjPZC9Ye3vH6Xw2ZGvsKMXBO+APwlfbDhvXuT8FGx9s+xn3waa+Zkd4hXnZmYPKvV9f95fu+McvMQol5kpolx3LVRJuaBiZkktLSoig3SCy8Or6/3ny5PljvgGzMCOw:1D8A
^FO192,0^GFA,09216,09216,00048,:Z64:
eJzt1c+K2kAcB/DfdEJmC9bZowXRPoK9eQiGti/istBrj80hrGML9VLoG7SvMrKgR19hYF8g0EsOYvqbaP5psjiwhx5+X0XHyUfzy+RnAkChUCiUF4520ty4eW/i6N+7euXk+V83D1/dOHxx42x/jRLVKO1EY9XmdadfmGIU517WtvWKAa/m1qXfXPjh5Z6ZSorR95qP89egUNWPsF7l+9WmQ6f3Cg/byrNtp39V+kVern/c1xXeD9x8P7rCw4/SvzGV33T6uPShrmY71wegXM9DbTK4whs4z7O+JS/jheF6AFokeNmxB/0Ae+zMB3wELH0HtuUlhJWXCddTpsd7EAnL8Lk8wJBlKoOAZ/agQi0h06UfpFxH+JUZ9CK+TvnqUaJcrX+pwB8bqeb3RrLHcjWS2yj38zHcTAXEPrfe52uhAg8r1fMPRnJ24bVUN9M+zCD3kHv8g03mBn1ttYt6RkJ50RBGKP/kHuuR1uv7ppdHHwol0sEMvc6s15kKeAKTOxU2PRzr+bRSEA0y6/N6NNaD1Q22aDv926ffDS+UPDznX6/PPU87fLhaQiQvPECHF6ulisTT6Hqv8O3g4uf2NDj4iaMftnjst07fb/HYb02fWh9zg14UXu5PfqGw3xqe/bR+40/Q8/Tko89Hz3boddN71n/zbuvefDx5XIM71e75DljhVeXP+83WIxTWY69XhYdjPRHbQd5vo/rx8gz7HT/jPaWxPmGW4BzeKmW2b7uaUSgUCoVCoVAoFAqFQqFQKBQK5X/JPxZtTiA=:A3F2
^FO0,32^GFA,07168,07168,00032,:Z64:
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:BD68
^FO224,192^GFA,04224,04224,00044,:Z64:
eJzt071q3EAQB/BZ6ZCVIPCQSsURHX4ChTQuTKI4JqQyeYS1OeLWD+Bi9EHsKtxT5B3S7X1wYJNGeYITGNxeeYUgmZEUu8udyoT9FztT/HbZ1a4AbGxsbGz+oSQ9rN4qhj3WffNIzFZ7QTyoAmBvK4VXYp0TgGfbbSCD83En68qg1gDejnbHtDbezbrX7iR6XcyveRo6MncAQNxByIUHGMEhaDmXO7gt1mf3i8UtBRR7sJ/XQ1DSwZgLXEWrFZy4dNnam0ta/GAbGhY484POLsV+wURD5jU35brlV/g+v5uXFCafngMs2Dok3YwLeCOxgaLmbGVqvpk7UxLqyQveKtsBSZdz4c2zXfqq/Q4l6Xvzk23cWuys6ixpGIfuo9209gwPopRtdJPiAVs/xTpgWx9G801jK9KabUXxOR5HuWE7yfCYLWZYvxR7FC/DJ1uKHWPGT3MUwKjgTuVcwFP8E5zGn4MnW4m9qH8RJGzfPnCnci7giF12lqp01VrUclti23vL5d4am+G5WCepsm7dMGls8sfOGuuIDd/7jZ2KNWZKvmGB1NkQPogtxM78d2IVTVPT2j1ZLYJk2NghHIndOLCCq/10/bcHOOjxsPtYv4fFHtbGxsbG5n/Pb6RPs0A=:BDBA
^FO0,416^GFA,01920,01920,00020,:Z64:
eJzt0EFKw0AUBuCXTjVdlA515UKSHkOhGF15j17AATcZBDPuupD2AL3MkypduvAAjj3BFEGyiMZ5qUlaE6oiuOq//Aj/+zMA2/xTXLXR2rpqe7kx2GgdrBqrO/fdxq85Qip6ArG/bs2TVA0rNluzN7LTRxwelptS6ptOMBTlJkbjzybYMoXtOmTjCXZ1sZknZO+X6CO0Pv+NpxrASS4wUIUBs8ZihhGUBj1ryDCsvEF2HTaYgyKAPme3KEJG3dkJEeGAs6kWN6673N0Ui6mec3YnzIi348x2xPM12b3QIw7h0iT2TWJN4hXZAVmkBsZYi5RHdkzvItWcbCZLYxLnZmHvSiwMpE7MYsxQai/vs2bMS2mQ2+tDjZ1nFqxaEmX2vmpxQOaPixtozW/0JPotlW+xXxhO5hWWqgBNp9FL1YqBr0zbwRQ8N+/7TTr9qnX/YLzGWJ0lNRZXbZttfpQP+u+wzA==:1018
^FO0,608^GFA,02304,02304,00024,:Z64:
eJzt0L9KxDAcwPGEFHKD3G9wORGaVxBcOgTrpK9xIjjf4JDh8HKk4CK6+igODnHyNQK3OmTsUK6maU/bRlHxnOx3aJLPkD9FaOhXiS35wZb8r0sQ9yPRXzlFBiH2EPhIOl/koS/d1IjQlZvqBE38Csu3/alEuLwPnJRuVb4EjovqOw+8Lvr4uT8IJMfqyYAGKYg7LG88NSckO7fMMn1Dybq+huvMntLsQszyQ3MLY1BHjcvKL8VUYOc7VMabA2xKVSGAY3MFeyv97kBlISaP2MSwv9v3xDvref6pp7xyWPWde6fqO842nnZ9gWzt65YTC8+ydnbX8mgG2XHjo+uOR85j93/ijk+9g+050UCkEdQ4p+37DA0N/e9eARTSjD4=:A08A
^FO0,736^GFA,01792,01792,00028,:Z64:
eJztzzFLw0AUB/ALR7wM5a46KZQLpZ+gWwqpWXRwcPIT+BG6XaEkl13a2cmvcsEP4gtFilvcKoTapE2bRr1QpYND/9vj9x5/HkL/IQ3Q29kfjSq9Yak3oqdfhNU02EpvnRq7Ab3dHsSqv/crZsndqVdjxt5W7asa2sccW9phCMkJljDCE8SbAuNi1QnAew7jc8oiWJAXGcADIcnaRJR0ZmHc4lYcP9E7NVVj1pivbSjFsDBgtB0rNGZIFHdMXM9CSFfWascp8kvz5rm5nOQ2gEDx0kaFGbl9AIYdE6JX2iMYVTO2xi/0Ruus+6P5+B0Yu8/N+2L91HwDlv2R2WJr/so8br5mFgEBe7Kxq0FuzctTc5pZCBbYlqyaWxovrSvQp5EZjr6ZwwVyEbjUUCo3IjnZ9B1zzEGyBEoZtnA=:34B1
^FO0,800^GFA,01536,01536,00024,:Z64:
eJzt0cFKwzAYB/DMDL8dRoueRyrbS+xQrIexvYTobl577Ekyd5iCWHwBT7LXMJsHX0JGZC/wFWFUlNU0tXW00YMHD+L/EMIv4Uu+hJBfDvCqNaXZd79xaqhtCbNTbnb44o4/CojWdjHnn2eHsm30a6PXXm+xbVUdkimyVtUtmOKWWxT9WFZPSqdYD0re4MR5uUFAg68f0ZZVV22hI8qtpsMBMmIMmjl3KrqMiH2Cw4BS6TKCvu4LZK9TE8kolpcA2PcIxtrrfq8znk3uL+SV3Yz7JzxquYXPqXYSDAY8OuxmHjhjkfqpcu+BR0e+PjeKIfVIMuW28uOs3+eu9lnhi6H2lbvpE44LXYe8aZ89Fc6yd461i8js1f3oQpjV98p+x7WvlcOmL4Wt3AnLPt/bSb3BUz9nfu5nypeSmXyUFO7J3EfCJolgQAILuO+V//0/fy7v1XS6Bg==:02A6
^FO0,832^GFA,02304,02304,00024,:Z64:
eJzt0b9uAiEcwPHfBSOLlbh1+MVLeAoGoosP0s3VqbnBpDadfIKOfRWuvsg9AjfJQLwiFGNPSartyHcA8hn4EwByuVyqZcLfb/TnhGPCRfJGf65ovhejMKm+hzsVFy79SO51f5BI+OIfHBL7x37pB1gT9ViCluQTgBFlwrM6OAyexPzVSGYByrfaeqe0/hisqmWNEiscT3a7mfchUcw5cS6AO1dT76O2YUR7n284nvxh2zBwrqxkhlcsOosuJaxLTa65pOrktD1z96zopL7DW3Pd9zo4jn+6DftY3nOzOHqBHHvnRq8u/cUUWGrabc5dONegqaIdTPsfmcvd2BfwPJHQ:76F3
^FO0,672^GFA,02304,02304,00024,:Z64:
eJzt0zFLw0AUwPEXbjinHqWToDkh+AGcrBDIYj+Lq24XKOmFA+NQ2lkc/CovBunXiHTIWuhSQRqTXiK2vYBiN/Mff8O9B48D+Lcdo9nPf+mn0uy0YW6ncaPDRfDnftsx+0OTnzS4C2BJw/vC7N7C7BzN/tf6XPIw/AD3zIYhBCBI5aPUS9QacnSsHHI5rg4n4oWTTVg4k45iKsIJ0+5L4WdjqiQ4iiry5YKJQfY4T1bA7wn6aVC7txpkTz3MJY2W+JratQ8Lf+4hxcLjby7EVekEqUq23cqmcyQvpb9ve6SQJKW/7XscmR1n2r1dv9G+rjzQzvBy43yq/fpOexe59iO577hEu/YLATktnalEjmTtfVuAWziDYn/wwG76OG1tbW2H7BMb+afj:5645
^FO0,896^GFA,01920,01920,00020,:Z64:
eJzt0TEOwiAUgOFHHViIrB0aOIRLh6a9ikfoyFQdnHsE7+ANOICJV8Ab1I2BVEHqUCEaTZzkJ2H4kkcgAKRSqUfVJ0ZlaM0QWlvOLHfbugjteozYGBrUkRtlEXsbl3QrGDqjYaHwzlujuDQMj9jggWtvSq9Uz5YVqYkupxdKgawVQBiI1hPaV864zCmIzWQHax3Dhp9AcD+LLtYYg9oZ6JkxamftujdGTPzGOmdIz6x3lpWvrTHWlk+mQVBiz1Pf/Erqb7oB1eBUsg==:2D17
^FO0,960^GFA,03072,03072,00032,:Z64:
eJzt0sFKwzAYB/DETOOhtEd7kE3wBeZtgmyP4BvIfAOPQcWlVuxBYUc9DK++gsfUijvuFSKiIniIeLCDsZi0dZ2ubkMYIvQPoQm/8n1fIADkyZNnONaMfWHG/hepxB/xSy9dpY4yfmqEqVu9Ueck9WVz1FnSv66WjUcYyvPUa28Z/jLkko422E8dWBleGD5keEZEXO2noBZg0aZEq4jZJqI90ABV6PMLRDmQgQHjPjXWKNQrNexKIGkDXq9dWL7ytpn4Nu8c7ZBV79hyXd5xr9e3Fu84VI6SOwkc+SkKIMcD98zkHTKBXaGc7t0StfW7kUPPNGLvC0wFKXmOvL1Rzva28B0HX71PsOc+tROHyhEy7NhVUSq1B7HvJt4qbwy8G3kQDjkQ5aeBh6F2n2s/qGpXw9eDtH6W+wH99HditT99v4pev7sgS5epzz9zYADoRA7D2M/ct4E/aEcw8rlK7E33RPvhivJ77Qs/eVG7rSaI5p8rc+xIYWEncVJEvnYDPGqHnCnnGIGov8NIETKm3AYbU73D6YKa472wOVtHnfEOJrmc4P0JnifP/8sHsVr9fA==:54E6
^FO0,1024^GFA,01536,01536,00016,:Z64:
eJzt0EEKwjAQBdDECcaVcwGxR4gHEFI3dukV9Ab1AlppwZ0ewatk12vkCANuxZqmdpGAO0GE/tU8EmaYYWzIr7IIySk0hOZNaHiEHrHIdfT/HvW7Rb5E89kH4wSLmYTS0JIXzpq0PSCcLa2h9d7uKENZ5ZTJ1pYVgZ+uU2ftrS0jjbIkQm93B0JX9mZfcHL1TnqrjffRH4aAlPKu23eRi1wlInWu0tDi7e0cxaqxncGAmY7h1Bj0+w8Z8jd5AeasaDQ=:663B
^FO0,1088^GFA,01920,01920,00020,:Z64:
eJzt0D8KwjAUBvCEFDLGzoIdPIJLh6IWB8cewgs4dmtKBUdv4B3cHASf7QG8QrxB3TpINf0TqSSDkyD0G97wg+TlC0J9fhTCQTNr/qX5upGM60uWBtvVU3xYWQ086BJ+6EYKg4Hhvi/jAOMMCXeKwrmymXDAjnM3wk+uTBQTYadueE12JG72IQixtOOabt/fgfceFiw9CbrNrUVzGh+kkfQMNH5aQVvtXll2AspZUnbtIs9yyot2b+nhGwEvr0y9JZSW6CYyg60MNmksUT0qG9bmbPyOMfDkW8abtseHBZ37KESyx1j1qI1AJLeOkOrRp0+fP8gLRzhxsg==:5B44
^FO0,1184^GFA,03456,03456,00036,:Z64:
eJzt1DFr20AUAOB3PddnaPG5eEmoiaL8grpeNIT4rzRTV403lPpSTFYPXdwpf+XUUNKCaSj9A09oyFLKFS8ahNR3klwKtrwkmEL9hgdP92HdvXcWwH8S3PxbhundmQcLvK8ZlzlFhs2sMJR4jtw2Gla4JZFj+0WzMdYZsc1wrSh3GbaHptFAQPkpoPhVmaN1I4oDyl72iie6fDDaZH44U4TwujL+pk1nJbVQQKOB0zLbym58F0CrzD2eQtOe/wTHLYv3jLOe1BIwZCjh4FTqIIS3QMUFKnhzXJkJjtG7wJDbkQ6+eibLWKG59SLM6S5Y1324MWhHEdq28k1wOcS7IyFMWz1L4is2u5g7wzTTyifTCnyjLofxR0mDbQXHSyM5sE7ojmoZ1GZk1K2fvJOPYzInhZYCWcfdGE6tV9W7PKMm54mWfE7FSQFS5OxD2a2xAUUbtDzlRsnzZCZFh4qXS5Aw0eUNdn1VnAxlMnFyNSMD6mxJHRGm+iew2ujavJ+JORUDZ1ZfkZUxpYmS7zNhqQA615rBysTXM6Gp2GjC2txJMuG6kTHaoDY/nQnWzZNvaAeK31qaZObMYGWqeUnkaf8L2q7imVqZbmW8qJwXHGJb9T/hZ6G4XZBJnRFk6OyjqJwX9Gg4/RucUp9xSsZKrumnS+P/ZZ5f45TRLGoTIVuZal6H5lFISwsgs5CMDKMhpYxmCqN6XkIzFECNLc/uDEzoKrCcjKy/XDsMWWyPfNcb2sc+9rGPfTxg/AbWKF/W:5204
^FO0,480^GFA,01536,01536,00016,:Z64:
eJzt0T8KwjAUBvA8A2YR3+BQB2lHLyF4HK/gZCMdsoi9UsGhY69Q6NBVcdBBWxuQ/JOCwa34QYYf4Xt5EEL+GXrQ02NP/xomD+81vdnG1vYCbc9ln+px66vjJ7dM0DHhxCfbFdyhzJQPO9rQi+FiGrGZ9jGdoOk4hVp0Lt+OUhqIKoOzMgtEYhg/XCcno49M7Cs9X1rem+76ymGPS9vqvRBpwXLT0NBWu/uPB7Rc9b8J5NzyaOlnqG2TjePYtcdyQ84LuGFK7A==:E9BB
^FO0,1248^GFA,02304,02304,00072,:Z64:
eJxjYBgFo2AUjIJRMAoIA8nn8yqpgOZQy5yBDo9RMLQBAEJcXt0=:7869
^FO288,608^GFA,00384,00384,00004,:Z64:
eJxjYBicgLEBgampdrABAG1yAwc=:8EF9
^FO288,672^GFA,00384,00384,00004,:Z64:
eJxjYBgcgLEBgampdrADAJ3SAwc=:D973
^FO288,832^GFA,00384,00384,00004,:Z64:
eJxjYBj+gLEBgamplhoAAIebAwc=:219C
^FO288,800^GFA,00256,00256,00004,:Z64:
eJxjYKA/YGxAYGqqJQcAAFa7Awc=:F61E
^FO288,1024^GFA,00384,00384,00004,:Z64:
eJxjYBicgLEBgampdrABAG1yAwc=:8EF9
^FO288,736^GFA,00256,00256,00004,:Z64:
eJxjYBgYwNiAwNRUSyoAAEqjAwc=:532D
^FO288,896^GFA,00384,00384,00004,:Z64:
eJxjYBh+gLEBgamplhYAALf7Awc=:A52A
^FO288,960^GFA,00384,00384,00004,:Z64:
eJxjYBgegLEBgampltYAANxDAwc=:4DB2
^FO480,1184^GFA,01152,01152,00012,:Z64:
eJxjYBgFdAfMB+SAiP0AiM3+QI79Qzr/AxCb54Mczw9niQ8gNkeBHEMFMjt9wgeoGoYK+w1gNjuIzQ5hM4DZH3CwH5DIPkAWm/n/HyC7Acr+AWcTA+T/g8E/YtWPgmEBAPUkSKQ=:F371
^FO448,800^GFA,01024,01024,00016,:Z64:
eJxjYBgRQI7KfB4K+aQAfoYHFcwMP5gPNkD48o0CPezM/9gfQ/mCBwX6+Nnk+dSR+Rz8SPwHdfwMCD7/8QdyQD7/cSif+QyEzw7j3/iAyv8A5rO3w/gPwHzm46h8hPyBD3L2yPqB/H+ofPl+BnsUPkeDO4p6EL8fhe/G/h+Jz85gw/yfpFAcBVgBAAcSOVo=:E35D
^FO480,832^GFA,00768,00768,00008,:Z64:
eJxjYBgFQwowH/hgx3zwAQP7gw/1LMkfGFgKPpxvSasA0ewtJRC6+U8FA/OHD+wNQJoBmf5BJP0BN834/wGUPsDe8KBioIODUgAAZUtCqw==:1A84
^FO480,896^GFA,00768,00768,00008,:Z64:
eJxjYBgFgwowH/hgx3zwAQP7gw/1LMkfGFgKPpxvSasA0ewtJRC6+U8FA/OHD+wNQJoBmf5BJP0BN834/wGUPsDe8KBioIOD1gAAuwNCqw==:9F0E
^FO480,1088^GFA,01152,01152,00012,:Z64:
eJxjYBi2QOYBYXYdgs34H8FmbkRiMyDY7P8SEOz/HxDmMCKxGQQIuYy54Q9DHUMFM5jd/J/hf0MPO9jIdv7m9gN9/GB2H/thZhh7DvOBygd1cPbRB3JQdvJBBPszEnvzwZ8wds/mgw9h7D5jJHYyiG0PZrc9BrH/QdxwGMiW7wexWdybQWyOBgj7wOcDcnB2fQOEzdzefMCeQY6dkJ9HwSjAAgAmqU0f:9B84
^FO224,64^GFA,05120,05120,00032,:Z64:
eJzt0jFv00AUwPF3PXP28GQckOBFstqIgYnh0jAYERWEok4dGOlmUdSJwaO3XpQKdagEI4iBzwDiA1xVBgY+hNkZMnaoVJ7PTWJKAmJhuv/g+PTLvZzlAPh8Pt9/Cv/V5a/L6KqLFCA0AGWzpN/8LqjICnPsVmF1ObVqeUxWjo/n49MEIJjPWdsBvGWleOlWSQZwh52itt9gvzf3Jz3+xOV+u/bHAI++tB2thG9u1X0LMOKngfvz8/HBhJk9WDTlvfXNfH5EbW/XHDFpe31zxXuUBcJMNQ1lIL9PDjegeA0noMsgcG7pBYpJltO+QnwYnu2Zi+54As+OMGgm0gjFIVW0rTBZj4qTcdxxTguX194Zva2olxKIU+iMX0FWknIvAvSQZPAB9JYi+WMd9Km9zk7UuAKN7O+NVorUUNhdmwl2vXAiKftGx0iYQr5rUE5UMvPYObAjErE/YJfsunGsPWQvaifIu84jrXVcewpFPalvckT+Jtiu4Z/DYOE56bb3natisb/UoRlAiZhp9gGwxzIfTN0rJPj6WUdmD46IRkMK2c+U6shq62na+NEn9ufON3VkB4LYRVW+oUv/yL7Pnu2wm02RqPgmVMXMi9yG4hyKg2mW6pAPVG2cx1DluW58Zb3Fn2RpeX05uFid+eN+4a7BSl/7i68Wn8/n8/l8Pp/Pt7SfIsOTRQ==:7FFB
^FO0,1280^GFA,13824,13824,00072,:Z64:
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:2DD1
^FO480,960^GFA,00768,00768,00008,:Z64:
eJxjYBgFAwKYD3ywYz74gIH9wYd6luQPDCwFH863pFWAaPaWEgjd/KeCgfnDB/YGIM2ATP8gkv6Am2b8/wBKH2BveFAx0MExUAAA+01Cqw==:F44E
^FO480,1024^GFA,00768,00768,00008,:Z64:
eJxjYBgFNAHMBz7YMR98wMD+4EM9S/IHBpaCD+db0ipANHtLCYRu/lPBwPzhA3sDkGZApn8QSX/ATTP+fwClD7A3PKgY6OAYrAAAURRCqw==:9A08
^FO288,1088^GFA,00384,00384,00004,:Z64:
eJxjYBgcgLEBgampdrADAJ3SAwc=:D973
^FO3,278^GB571,0,3^FS
^FO3,592^GB571,0,3^FS
^BY1,3,78^FT54,1801^BCN,,N,N
^FD>:${thisInvoice.inv_barcode}^FS
^FT310,1234^A@N,56,56,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.godTotal}^FS^CI0
^FO2,1^GB571,1836,6^FS
^FT264,325^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_number}^FS^CI0
^FT357,660^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_record_date}^FS^CI0
^FT193,397^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
^FT449,1301^A@N,39,37,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_dueDate}^FS^CI0
^FT357,720^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_previous_number}^FS^CI0
^FT357,783^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_number}^FS^CI0
^FT357,903^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_prapa_cost}^FS^CI0
^FT357,843^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_unit_use}^FS^CI0
^FT357,963^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_service}^FS^CI0
^FT357,1024^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_vat}^FS^CI0
^FT357,1076^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_total}^FS^CI0
^FT357,1136^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_notPay}^FS^CI0
^FT168,473^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
^FT104,549^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^FS^CI0
^FT183,1714^BQN,2,8
^FH\^FDLA,${thisInvoice.inv_barcode}^FS
^PQ1,0,1,Y^XZ
""";
        } else {
          zplToPrinter = """ 
          CT~~CD,~CC^~CT~
^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL0961
^LS0
^FO0,256^GFA,02688,02688,00028,:Z64:
eJzt0L9Kw0AcwPFfvJJUCP2zaMSShhacRA4cXErpopMPcW2gk2BwilBoIlgyFOcKvoRvcNoiDh06Op76AvUF1Etb8WwuUYpjvkvgPknu7geQlpa2YkZ0CS+eaoKtr2o43rQEU5yofbVGpMvhKtU8GTinHjCak34UdKlSoBKqc3OY3D4YBIwoRU9hy6RQBu4LgTcPRY3vt/VMYN9TI3dH7xZs3xI4AIkpE9g0CexJLJxZjf/Xheh+YQyIQvmpZDYfWlwRs/JU8zWf1lQgdWRCoyO8jHF+mB2yFreuVoW7nmANw3jNPuDQhj1uSDBPL9jZ0cz8qypQ0bSxaWsj3OF2fVPm9o1E3y3aMMaE2+UU/TSjxO0Rkx6Qw8GSYX1mTW7nMxPvoOdseMLNIz6zfsTAhgluteOtvRNvJxtxNsWuGTWnFhrDTg4cbmXRgsrCVAi4nVkSI6EF6N4S7h5aBejcBuhCNKekQym0DDjaFPnizP4S6sdb5vj/DY0TDpNkboKlpf3WJ0bRfzE=:C8A5
^FO224,96^GFA,03072,03072,00032,:Z64:
eJzt0jFLw0AUwPFrr7yk8EhCA3ItIW2xdHJ4waVDUVzEyd3tBMG13exSMolDca7f5gSpCMXPkIKjQ1wkW72UtoNILI5y/+GG+/F4NxxjJpPJZPoWFjN/L/ZKUOx2pdibb8XuNYqdwS++Tfx8XYr1YQ9Sd5pQnydB2UqcVuIdsyG/Cy3OP+7LViymGQ2JXrHXBbvXXBCdqKWVXdvP2PShrsSDaEVE4GEXvKD9SBQvHHvAvZnn+MCUGIlzmRLweQj7SCyNxGWMjO/N259u7nVxkeh56AN0Ji6jqCNvuOK1DEKee0OMpHZEgIMJUxRdSWDEa3OEtY833kTtlK3cmW2dNo4rlytnu3rwd3dvmQrW7iKMEbk6TKUMWardAf+UqdpmfmK9IFbU0ZmU3ZKef6qC39Uutl7NvbfxufaQKcx9mYC12s/jfH/AEs4zAEe/Z9c/YjKZ/l9fmAhsXw==:3CA5
^FO224,0^GFA,08448,08448,00044,:Z64:
eJzt1TFv00AUB/B3vcrXwcQpLK5k1S18gVRZrlLUlIKAAfEZoi5dvZEhai4MUYeKmSEfhPHCwlL1EzBciURXj0Gyal7O9sVgp6RIbPcfnPjyk/3u3dkBsLGxsbH5t/jr08YD7Pb/snx967XWtzRa326oe37slU8cYHJ9G4qVkqiy3XVgt2poXhZpGesJeOLko/nQlj6yODvb8I0NJeyP8yvlQ9m6uP2KPVDGsnwoWxc/Xx7KZWF7CtqXwETFPi7s3Ng3CrqX4MmKLZad/DT2pYJwAoGq2Obn/PRQFPZEAf0Euv4Vtv2b5XXWL+z7gsKpAhbVWa+w58YeoVV19bJiSyfGosIm1PSh+KCxsYA9g7r+GivKtrhZvS1HmW8PtX13aZkINkHg1o5wfiHwJigPbhSBAVEM1HHieoiktp4MXCKGEuY0haEYog3lTUzJHY0ZSZ5fu6Hgob4X31FBQAVeaOIw8UKmMaiD6XfOiOf0GU2nY78teVO3iTe1FRFxXSpH8qsC1bv5wtkG2+SMhqOxvy/5XrS0I+gT1yeKTAXa49kHzmBhHToac7QQlWoATiZYKZniJNTbzGINDMhV1DbW05ZzSLpSETlH++6WzNHSOcNHN8WpFha0HXAItA3RniSwuO7iMIChJH/Yj2gbWIOkEu0PYz3cGystQfv01tjFylXt3tIGs7/Y1tLCTNxnz7m/tm1w9wG2scL23aplK2xSY+mk1pLrGku+aevlNs1sl4x9Yztod6lEm2i7IyFGe5jbs7J9hfaZs9fAvaPttiQ+zKB7IbR9Tcbc2BO0+5sLOyjsFtzC0VZhr6Ky7aB1WrndyWxHWw/OcE8S2c/sKU3nbaeH/xudBmAXQkEu2B3wR2jTO3zNDSXDZzCbG1qcG7YK+yuwDwAxy/cv2g7uSWNtbGxsbGxsbGxsbGxsbGxsbGxsVuYXBuJIag==:142F
^FO0,0^GFA,07168,07168,00028,:Z64:
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:45B6
^FO224,160^GFA,04224,04224,00044,:Z64:
eJzt0zFP20AUB/B3sWuukhWHzQOCC63UjkeyMKFzurB3ZbATitLN6tQBpQ5iyNi1U7/Kc0CCjxGGSoyoLAwo6nu2ga22F6b7D3dv+Pn0Tu8MYGNjY2PTLKqF1bWi2+LcnWcS19oh8roEcLJaG7IVuwBuvfV4Ee8bWVGQB+qhlla2WUobNrPzi/l18GuZXGQik4K/7QAYqsCnjRbowRZovpc4O15+13/H42P0TOjARr6m8SBVMKANDoK7FHYF7pf2ct+MT8j6MQmZuF5lJ2w/SaUhcopJifntFRzd/Elu0Vcf3wCMyQrDVUIbOD22HmBxtymuPsdf4ilKffiWWiXbMVxFZ+aQmic7cSGrrP4WfyUbllY+2by0RsPAF8/2tLKLzQBResGlWWySPTeLmUd2thXcPBY2Ra3JphjuyX6Qr8heR7JPdhHJWcB2O5z4L3a6IjuQET3Nnge9EVf5z5Gk0WcaPoRD78WmbIfrHwiK7M49V/nv+zUItpPKYop3pZWap8W2nFuU0dwKG8m9wqo0r871VWHVk014xkLQjxj5/fPCxmwp6MYkpKmsD+/YjtgmrmILGOOqtA6SDTLVLWwXttmeCkjhYAMf/vcAO83fdSvrtrCyhbWxsbGxsXmF/ANy7pTl:4F31
^FO0,352^GFA,02304,02304,00024,:Z64:
eJzt0r9LAzEUB/CXS2mHnrTiYESpxcFJMKWgGY5e0Y7+EXFxvm4dIy4dhOLm7j/QUbdIpS6HODqei3PHTupLS9t4PwTBRex3eFw+cC/vHQfwL+LaBz1/ohmeu/yhX2f0z3C4TZ0SCE+QEUmtVyEvsYhDDYEsQNxbfgRdCUkXQdz9iQccuhpGln9EWLw2h44mlhNt3B31YUNTZjmYPisvfdhUttP3KtZij8M62O6QZ6wVXMwDu/901QAr3hNBIslPk+5kxHxVocC3SQ+qjcU8YyFlDd2/uFJyMPf8Flfc+OlgVclzNfOc2wZmvPmIThYeRoI10E+eSsbpzPdVi3H0ozGx3dnT6MfAd8IvTkPjA+De1OcDubLD+A3uNYy7ZLV6utfX0v2gmO5eKd1FAQR6L4o7hRb6Xdn2Jufc+AN5LS/2AlczOfGQ3Nvuq5LiDgg6xl/J8u9Chunu7P6Ok7eMi88y3MvwZZZZ5u/lEwJoc0c=:859E
^FO0,544^GFA,02304,02304,00024,:Z64:
eJzt0D1ugzAUwPHnPgoZHCDq8qa0R/ARchT3Q1WHDowMSJgl6sCh6JZjWJ06cgPyCEGCOJFSKUMH/wf0/EOyLQP4ror+mf81ddHlMOgZP55x2wCUreMiZbeZ6ysDYNx9xIMB0aXu/h3/M7+uF/3nVu/glphcYGMTGzW5gHI4jlO2xuC5JSJdo+iq7dE1L4NXepKpqhGrbzx6w8vghTYh9A52dKMKxB+K2QsMQY8OSiK80yrshyCb+9voX+f9/sQ/aX1wPPEPooOL9oKb6zx3XbSyhGzwcuJ3arkzgy931dSTBbuUwMPM44XRFBLwMHFh4wg0oWWPpvfx+Xy+W7QHauRJCg==:F432
^FO0,608^GFA,01792,01792,00028,:Z64:
eJztzr9Lw0AUB/AXLpAOR2O3N4QmpOAkkjFDlA6O/gGOV4pOIsGpQ4akOnRwcYv4z5wGdBH/hoDgnDFDBy8/Wi6FnOCofqd79+HxfQC/N0RhWT9pkx/avqLvU2GHCjtVWCG9Sd69hUuDUUBvqN9vA+zOgWxp1yLZzrr2IvcpzEj7DXZuiRTmKwy+N8fkRgI4hmmhmzFyc3VM+MCMK2OeZ2aAE3hC6vGj3C4znaHHa5sifrTmsPMQi+SWocNqi+nevDVgr74HmjBozHgbC7OBlxRmSwxAu8k3Rg9GwghwsTcDNGIt3u6hJdlQ/ErmUclGuzZUGGyN3SvsXWEXCrvsWBhUZhGbR8IWSHItnpeNrdzKXHLtPAoLURd7Vydde3Ye7oCx2haSucKWTrreWNhaaFGwRF/CQ78ywoX5jf3nD+YLr4dwvQ==:4DE8
^FO0,672^GFA,01536,01536,00024,:Z64:
eJzt0bFOwzAQBuBLLrIjYRoVBiLRAYkViY4dEC0C8RyW2FHHDhkMrVokMjAyMPQRGBmdvQ+RgQeoxNIBAWeHpA1Jh24g8Q+W9dmy72yAv5h2PQvjsuo7m7qs98Yad9N693TVTIJ8wsreMoOOgBceLhf1B/jjqkfJpOKowflMEPy47FwD3iS7wH+4kOBCsgXOU8X5+9k9OC8VZzh9A6dfrp+bfiWa+0tBZUdoQF2wVpc+4Kh9TLl7AmoRoEJnbsuI/ZEMRccfXzpD0ZxoxEWncAr5LWvGElmrXXhbGFeseSfRE7b+KMA0PBB77JQ8MD5LbZf7IEMQIWPkziP5se1DHFr3M3+Q6B7ZfsW5dT7OHWeZD62LbP8zvQ+9H2UbV8+fFt7Y0EXJ01W/WkBE3iXXElXh1xcQk7/2jHu9wgfkwuOj3Hvf3idnIffIlXGdewcGOOeojKPqqjVf+Z/fmi+7aWRZ:C951
^FO0,416^GFA,01536,01536,00016,:Z64:
eJxjYBgF9AbMNOYTAmzY+AcQxj1D5fP/Q+XL8KHyBdD02z9C5RvIovJJdi8aqJBh/MNQoADn99gxMzN0JCD4ySyMjch8Zw6Gg0j8GmfGAwcLEuCu4DnMpHCwAYnfzKRwAJ1fgdDP28x84MABJD7QeqB+ovn8aHw+gnzGxoYDDgj3MDMcZkhsQObXMNgTCFWLA6h8FxL5Nmh8HjQ+ewNe60fBIAUANsU0XQ==:74F6
^FO256,544^GFA,00384,00384,00004,:Z64:
eJxjYBhkgLEBgampdpACAIKcAwc=:D425
^FO256,608^GFA,00256,00256,00004,:Z64:
eJxjYBgAwNiAwNRUSwYAAFO1Awc=:11A8
^FO256,672^GFA,00256,00256,00004,:Z64:
eJxjYKAzYGxAYGqqJRMAAF/NAwc=:F6A2
^FO480,544^GFA,00768,00768,00008,:Z64:
eJxjYBjh4AMPf8MHCwZGCR6DgxI1IFohUeIYiGZIlGhjYPjBw5DwA0gD+QmSMJoNlZaG0lI4aDkoLYODlgDS9T8g9CigKwAAmg8UEw==:9BBD
^FO480,608^GFA,00512,00512,00008,:Z64:
eJxjYBjmgPmAgR3zgQcMLAkGh1kSP4DoxpZkCRDN2JIkwcD8wICx+ZEEAwOQ35AGpVPQ6BwonYGDroDSBTjoBAkGxv8PwPQgAwCt2SF4:6BDD
^FO480,672^GFA,00512,00512,00008,:Z64:
eJxjYBjigPmAgR3zgQcMLAkGh1kSP4DoxpZkCRDN2JIkwcD8wICx+ZEEAwOQ35AGpVPQ6BwonYGDroDSBTjoBAkGxv8PwPQQAwDc9SF4:282D
^FO0,768^GFA,11520,11520,00072,:Z64:
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:6590
^FO0,512^GFA,02304,02304,00072,:Z64:
eJxjYBgFo4B8IPl8XiUV0BxqmTPQ4TEKRsEoGAWjYGgAANp3Xt0=:5716
^FO0,224^GFA,04608,04608,00072,:Z64:
eJzt0EEJADAMBMHYqNR6CbVXG7WQRyAUZtj3PS4CAOAP657dUHbtTP8BAFD1AA52Xt0=:F586
^FO2,1^GB571,958,6^FS
^FT331,594^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_record_date}^FS^CI0
^FT206,324^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_number}^FS^CI0
^FT331,654^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_matr_number}^FS^CI0
^FT331,718^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_unit_use}^FS^CI0
^FT179,400^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_name}^FS^CI0
^FT111,477^A@N,45,45,angsana.fnt
^FH\
^FH\^CI17^F8^FD${thisInvoice.inv_user_address}^FS^CI0
^PQ1,0,1,Y^XZ
          """;
        }

        bluetooth.printCustom(
            zplToPrinter, Size.boldMedium.val, Align.center.val);

        bluetooth.paperCut();
      }
    });
  }
}



// ^XA
// ^MD20
// ^FO50,50^A0N,50,50^FDHello World!^FS
// ^XZ