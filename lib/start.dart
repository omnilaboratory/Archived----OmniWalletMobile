import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'create_account.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _showSwiper(),            
            _showContent(),
            _selectLanguage(),
          ],
        ),
      )
    );
  }

  // Swiper
  Widget _showSwiper() {
    return Container(
      height: 300,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 4,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  // Swiper
  Widget _showContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Button - Get Started
          RaisedButton(
            child: Text('     Get Started     '),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              // TODO: Show the create new wallet page.
              Navigator.push(context, new MaterialPageRoute( 
                builder: (context) => new CreateAccount()) );
            },
          ),

          // Button - Restore wallet
          SizedBox(height: 20),
          RaisedButton(
            child: Text('   Restore wallet   '),
            onPressed: () {
              // TODO: Show the restore wallet page.
            },
          ),
        ],
      ),
    ); 
  }

  // TODO: Select language.
  Widget _selectLanguage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: <Widget>[
          Icon(Icons.language),
          SizedBox(width: 20),
          Text('Language'),
          
          Expanded(
            child: Text(
              'English',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          SizedBox(width: 15),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

}