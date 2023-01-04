import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';

class Details extends StatefulWidget {
  final String title;
  final String image;
  final String time;
  final String info;
 // final String cuisine;
  final String servings;
  final bool isVeg;

  const Details({Key? key,
    required this.title,
    required this.info,
    required this.image,
    //required this.cuisine,
    required this.servings,
    required this.time,
    required this.isVeg
  })
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  _parseHtmlString(String htmlString){
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        minHeight: (size.height / 2),
        maxHeight: size.height / 1.0,
        panel: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.title,
                style: _textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (widget.isVeg == true? "Veg":"Non-Veg"),
                style: _textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "198",
                    // style: _textTheme.caption,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.timer_outlined,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.time + '\'',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    (widget.servings==null? "1": widget.servings)
                         + ' Servings',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.restaurant),
                        SizedBox(width: 5,),
                        Text("Delicious!"),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      color: Colors.black.withOpacity(0.5),
                      height: 5,
                    ),
                    Text("Instructions",
                    style: _textTheme.headline5
                    ),
                    Flexible(
                        child: Text(_parseHtmlString(widget.info))
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: (size.height / 2) + 20,
            child: Image(
              fit: BoxFit.fill,
              image: NetworkImage(widget.image),
            ),
          ),
        ),
      ),
    );
  }
}
