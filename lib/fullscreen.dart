import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class fullscreen extends StatefulWidget{

  final String imageurl;

  const fullscreen({super.key, required this.imageurl});





  @override
  _fullscreenState createState() => _fullscreenState();
}

class _fullscreenState extends State<fullscreen> {

  Future<void>setwallpaper()async{
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
   bool result = await WallpaperManager.setWallpaperFromFile(file.path,location);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
          'Wallzy',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              fontFamily: 'Fontmain'),

      ),
        centerTitle: true,),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imageurl),
            )),
            InkWell(
              onTap: (){
                setwallpaper();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Set Wallpaper',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'Fontmain'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}