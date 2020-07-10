import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:app_movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> data;

  CardSwiper({@required this.data});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {

          data[index].uniqueId = '${data[index].id}-tarjeta';

          return Hero(
            tag: data[index].uniqueId ,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'detail',arguments:data[index]);
                  },
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'), 
                    image: NetworkImage(data[index].getImgApi()),
                    fit: BoxFit.cover, 
                  ),
                ),
               
            ),
          );
        },
         itemCount: this.data.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
