
import 'package:flutter/material.dart';
import 'package:app_movies/src/pages/home_page.dart';

 Map<String, WidgetBuilder> getApplicationRoutes(){
   return  <String, WidgetBuilder>{
        '/' : ( BuildContext context) => HomePage(),
     

      };
 }