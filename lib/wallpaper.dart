import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'fullscreen.dart';

class wallpaper extends StatefulWidget {
  @override
  _wallpaperState createState() => _wallpaperState();
}

class _wallpaperState extends State<wallpaper> {
  List images = [];
  int page = 1;

  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
          'QpUlvNWG9ZNznDhh6IbZkKkZWAnLnXHR24qVXaWfTRMpq1wwwCBAeWNR'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  loadmore()async{
    setState(() {
      page++;
    });

    String url = 'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();
    await http.get(Uri.parse(url),
        headers: {
          'Authorization':
          'QpUlvNWG9ZNznDhh6IbZkKkZWAnLnXHR24qVXaWfTRMpq1wwwCBAeWNR'
        }).then((value){
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });

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
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>fullscreen(imageurl: images[index]['src']['large2x'],)));
                        },

                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: images.length,
                  ),
                )),
            InkWell(
              onTap: (){
                loadmore();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Load More',
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
        ));
  }
}
