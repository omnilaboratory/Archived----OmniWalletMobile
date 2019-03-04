import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'create_account.dart';
import 'select_language.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Omni Wallet'),
      ),

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
      height: 260,
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
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CreateAccount()
                ) 
              );
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

  // Select language bar.
  Widget _selectLanguage() {

    String currentLanguage = 'English';

    return InkWell(
      splashColor: Colors.blue[100],
      highlightColor: Colors.blue[100],

      onTap: () {
        // TODO: Show the select language page.
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => SelectLanguage(currentLanguage)
          ) 
        );
      },
          
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: <Widget>[
            Icon(Icons.language),
            SizedBox(width: 15),
            Text('Language'),
            
            Expanded(
              child: Text(
                currentLanguage,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(width: 15),
            Icon(
              Icons.chevron_right, 
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

}