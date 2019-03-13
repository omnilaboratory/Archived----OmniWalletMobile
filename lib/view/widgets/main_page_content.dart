
import 'package:flutter/material.dart';


class BodyContentWidget extends StatefulWidget {
  BodyContentWidget({Key key, }) : super(key: key);
  @override
  _BodyContentWidgetState createState() => _BodyContentWidgetState();
}

class _BodyContentWidgetState extends State<BodyContentWidget> {

  List<String> dataIitems = List.generate(8, (index){return "addressaddress${index+1}";});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: dataIitems.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300])
            ),
            child: ExpansionTile(
              title: buildFirstLevelHeader(index),
              children: buildItemes(context,index),
            ),
          );
      }),
    );
  }

  Widget buildFirstLevelHeader(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8,top: 8),
          child: Icon(
            Icons.ac_unit,
            size: 28,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text('钱包地址：'),
                Text('备注信息')
              ],),
              SizedBox(height: 10,),
              Text(
                dataIitems[index],
                maxLines: 1,
                style: TextStyle(

                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment(1.3, 0),
                child: Text(
                   '\$0.00',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ) ,
            ],
          ),
        ),
      ],
    );
  }
  List<Widget> buildItemes(BuildContext context, int index) {
    List<Widget> list = List();
    list.add(Container(height: 1,color: Colors.red,));
    list.add(
        Align(
          alignment: Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(left: 60,top: 10,bottom: 10),
            child: Text(
              dataIitems[index]+"-资产",
              style: TextStyle(fontSize: 16),
            ),
          ),
        )
    );
    for (int i = 0; i < 4; i++) {
      list.add(
        Container(
          margin: EdgeInsets.only(left: 60,bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey)
          ),
          child: Container(
            margin: EdgeInsets.all(6),
            child: Row(
              children: <Widget>[
                Icon(Icons.add,size: 40,),
                Container(
                  margin: EdgeInsets.only(left: 16),
                    child: Text('Btc',style: TextStyle(fontSize: 18),)
                ),
                Expanded(child: Container(),),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('0',textAlign: TextAlign.right,style: TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('\$0.00',textAlign: TextAlign.right,),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      );
    }
    list.add(SizedBox(height: 30,));
    return list;
  }
}