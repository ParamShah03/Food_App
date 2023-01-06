import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Models/Cuisine_model.dart';
import '../Service/CusineApi.dart';

class CuisineDisplay extends StatefulWidget {
  final String name;
  const CuisineDisplay({Key? key,
    required this.name})
      : super(key: key);

  @override
  State<CuisineDisplay> createState() => _CuisineDisplayState();
}

class _CuisineDisplayState extends State<CuisineDisplay> {
  Future reFresh() async {
    setState(() {});
  }
  List<Results> _CuisineList = [];
  Future getCuisine() async {
    _CuisineList = await CuisineService().getCuisinesData(cuisine: widget.name);
    print(_CuisineList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.name),
            centerTitle: true,
            backgroundColor: Colors.brown,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
            elevation: 0,

        ),
        body: FutureBuilder(
            future: getCuisine(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if(snapshot.hasError){
                return
                  Center(
                    child: SnackBar(content: Text(snapshot.error.toString(),
                      style: TextStyle(letterSpacing: 1.5),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.redAccent,
                    ),
                  );

              }
              else {
                return RefreshIndicator(
                  onRefresh: reFresh,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _CuisineList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Results results = _CuisineList[index];
                      return CuisineInfo(
                        title: results.title,
                        image: results.image
                      );
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(height: 5,);
                    },
                  ),
                );
              }
            }
        )
    );
  }
}

class CuisineInfo extends StatefulWidget {
  final String title;
  final String image;
  const CuisineInfo({Key? key,
    required this.title,
    required this.image
  })
      : super(key: key);

  @override
  State<CuisineInfo> createState() => _CuisineInfoState();
}

class _CuisineInfoState extends State<CuisineInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    widget.title ,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

