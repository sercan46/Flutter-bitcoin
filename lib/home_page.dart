import 'dart:convert';

import 'package:bitcoin/models/bitcoin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BitcoinVM _bitcoinVM = BitcoinVM();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBitCoin().then((value) {
      _bitcoinVM = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFED5460),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bitcoin.png',
              width: 200,
            ),
            Text(
              _bitcoinVM.chartName.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _bitcoinVM.disclaimer.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_rounded),
                Text(
                  _bitcoinVM.time!.updated.toString(),
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.brown[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // s
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _bitcoinVM.bpi!.uSD!.code.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _bitcoinVM.bpi!.uSD!.description.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(_bitcoinVM.bpi!.uSD!.rate.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.purple[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0), // s
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                _bitcoinVM.bpi!.eUR!.code.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _bitcoinVM.bpi!.eUR!.description.toString(),
                                textAlign: TextAlign.center,
                              ),
                              Text(_bitcoinVM.bpi!.eUR!.rate.toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0), // s
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _bitcoinVM.bpi!.gBP!.code.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _bitcoinVM.bpi!.gBP!.description.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(_bitcoinVM.bpi!.gBP!.rate.toString()),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<BitcoinVM> getBitCoin() async {
    var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json');
    var response = await http.get(url);
    print(response.body);
    return BitcoinVM.fromJson(json.decode(response.body.toString()));
  }
}
