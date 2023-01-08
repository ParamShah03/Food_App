import 'package:app/Models/Nutrients_model.dart';
import 'package:app/Screens/home.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Models/BarData.dart';

class BarCard extends StatelessWidget {
  const BarCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Graph'),
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, PageTransition(
                  type: PageTransitionType.rotate,
                  alignment: Alignment.bottomCenter,
                  child: Home()),);
            },
            icon: Icon(Icons.arrow_back_outlined)),
        backgroundColor: Colors.brown,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 2, right: 2),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          color: Color(0xff020227),
          child: Padding(
            padding: EdgeInsets.only(top: 5,bottom: 8),
            child: BarChartWidget(),
          ),
        ),
      ),
    );
  }
}


class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 60,
          minY: 0,
          groupsSpace: 45,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: BarTitles.getSideTitles(),
            rightTitles: BarTitles.getSideTitles(),
            bottomTitles: BarTitles.getTopBottomTitles(),
            topTitles: BarTitles.getTopBottomTitles()
          ),
          gridData: FlGridData(
            checkToShowHorizontalLine: (value)=> value % BarData.interval == 0.0 ,
            getDrawingVerticalLine: (value){
              return FlLine(
                strokeWidth: 0.0
              );
            },
            getDrawingHorizontalLine: (value){
              if(value==0) {
                return FlLine(
                  color: Colors.blueAccent[100],
                  strokeWidth: 1,
                );
              } else {
                return FlLine(
                  color: Colors.blueAccent[100],
                  strokeWidth: 0.5,
                );
              }
            }
          ),
          barGroups: BarData.barData
              .map((data) => BarChartGroupData(
            x: data.id,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: data.y,
                width: 45,
                color: data.color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9)),
              ),
            ],
          )
          ).toList(),
        )
    );
  }
}
