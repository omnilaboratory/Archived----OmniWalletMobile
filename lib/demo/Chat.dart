
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const String defaultUserName='John Doe';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat>  with TickerProviderStateMixin {

  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = TextEditingController();
  bool _isWriting= false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Application'),
        elevation: Theme.of(context).platform==TargetPlatform.iOS?0.0:6.0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                  itemBuilder: (_,int index)=>_messages[index],
                itemCount: _messages.length,
                reverse: true,
                padding: EdgeInsets.all(6.0),
              ),
          ),
          Divider(height: 1.0,),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: buildComposer(),
          )
        ],
      ),
    );
  }

  Widget buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Enter some text to send a message"),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                      child: new Text("Submit"),
                      onPressed: _isWriting ? () => _submitMsg(_textController.text)
                          : null
                  )
                      : new IconButton(
                    icon: new Icon(Icons.message),
                    onPressed: _isWriting
                        ? () => _submitMsg(_textController.text)
                        : null,
                  )
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border:
              new Border(top: new BorderSide(color: Colors.brown))) :
          null
      ),
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 500)
      ),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }

}

class Msg extends StatelessWidget {
  final String txt;
  final AnimationController animationController;

  Msg({this.txt,this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: -1.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 8),
                child: CircleAvatar(child: Text(defaultUserName[0]))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(defaultUserName,style: Theme.of(context).textTheme.subhead,),
                  Container(
                    margin: EdgeInsets.only(top: 6.0),
                      child: Text(txt))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

