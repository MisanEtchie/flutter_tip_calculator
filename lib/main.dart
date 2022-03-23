import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.teal[700],
            ),
      ),
      //theme: ThemeData(primaryColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: Bills(),
    ),
  );
}

class Bills extends StatefulWidget {
  const Bills({Key? key}) : super(key: key);

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  Color? bttnColor = Colors.tealAccent[900];
  int tipPercent = 0;
  int people = 1;
  double bill = 0.0;
  double totalPerPerson = 0;

  @override
  Widget build(BuildContext context) {
    //assert(debugCheckHasMaterial(context));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          //margin:EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.5),
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.tealAccent[100],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Per Person",
                        style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                            "₦${calculateperperson(bill, people, tipPercent)}",
                            style: TextStyle(
                                color: Colors.teal[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 36.0)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(24.0)),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: Icon(Icons.credit_card),
                          hintText: "Bill Amount"),
                      style: TextStyle(
                          color: Colors.teal[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: (String value) {
                        try {
                          bill = double.parse(value);
                        } catch (exception) {
                          bill = 10.0;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Split",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: (() {
                                  setState(() {
                                    if (people > 1) {
                                      people--;
                                    } else {}
                                  });
                                }),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA7FFeB),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                          color: Colors.teal[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "$people",
                                    style: TextStyle(
                                        color: Colors.teal[800],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (() {
                                  setState(() {
                                    if (people < 99) {
                                      people++;
                                    } else {}
                                  });
                                }),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA7FFeB),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                          color: Colors.teal[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tip",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '₦${(calculatetotaltip(bill, people, tipPercent)).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.teal[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          child: Text(
                            "$tipPercent%",
                            style: TextStyle(
                                color: Colors.teal[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                              activeColor: Colors.teal[800],
                              inactiveColor: Colors.grey[700],
                              divisions: 20,
                              min: 0,
                              max: 100,
                              value: tipPercent.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  tipPercent = value.round();
                                });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
                //tip
              )
            ],
          ),
        ),
      ),
    );
  }

  calculateperperson(double bill, int people, int tipPercent) {
    var totalPerPerson =
        (calculatetotaltip(bill, people, tipPercent) + bill) / people;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculatetotaltip(double bill, int people, int tipPercent) {
    double totalTip = 0;

    if (bill < 0 || bill.toString().isEmpty || bill == null) {
    } else {
      totalTip = (bill * tipPercent) / 100;
    }
    return totalTip;
  }
}
