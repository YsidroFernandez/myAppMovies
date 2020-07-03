import 'package:flutter/material.dart';
import 'package:app_movies/src/widgets/card_swiper.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title : Text('Home Page'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){})
        ],
        ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards(),
          ],
        )
      ),
    );
  }

  Widget _swiperCards() {

    return CardSwiper(data: [1,2,3,4,5,6]);

  }
}