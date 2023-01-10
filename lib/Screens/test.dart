import 'package:flutter/material.dart';

class IncreaseDecreaseButton extends StatefulWidget {
  @override
  _IncreaseDecreaseButtonState createState() => _IncreaseDecreaseButtonState();
}

class _IncreaseDecreaseButtonState extends State<IncreaseDecreaseButton> {
  List<int> itemList = [0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Increase/Decrease Button'),
        ),
        body: GridView.builder(
          itemCount: itemList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Column(children: [
              Text('${itemList[index]}'),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: (() {
                        setState((() {
                          if (itemList[index] > 0) {
                            itemList[index]--;
                          }
                        }));
                      })),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: (() {
                      
                      setState((() {
                        // if (itemList[index] < 10) {
                        itemList[index]++;
                        // }
                      }));
                    }),
                  ),
                ],
              )
            ]);
          },
        ));
  }
}
