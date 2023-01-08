import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Data{
  final int id;
  final String name;
  final double y;
  final Color color;

  Data({
    required this.id,
    required this.name,
    required this.color,
    required this.y
});
}

class BarData{
  static int interval =5;
  static List<Data> barData =[
    Data(
        id: 0,
        name: 'Fats',
        color: Colors.yellowAccent,
        y: 45),
    Data(
        id: 1,
        name: 'Proteins',
        color: Colors.deepOrangeAccent[400]!,
        y: 23),
    Data(
        id: 3,
        name: 'Carbs',
        color: Colors.greenAccent[400]!,
        y: 32),
  ];
}

class BarTitles{
  static AxisTitles getSideTitles() => AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 22.0,
      getTitlesWidget: (value, meta) =>
          Text(value.toInt().toString(),
              style: TextStyle(color: Colors.white, fontSize: 15)),
      interval: 5.0,
    ),
  );
  static AxisTitles getTopBottomTitles() => AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) =>
          Text(BarData.barData
              .firstWhere((element) => element.id == value.toInt()).name,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      interval: 5.0,
    ),
  );

}