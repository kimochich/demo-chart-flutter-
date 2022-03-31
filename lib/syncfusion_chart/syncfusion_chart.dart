import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DemoChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DemoChart({Key? key}) : super(key: key);

  @override
  _DemoChartState createState() => _DemoChartState();
}

class _DemoChartState extends State<DemoChart> {
  List<_SalesData> data = [
    _SalesData('Tháng 1/2022', 35),
    _SalesData('Tháng 2/2022', 28),
    _SalesData('Tháng 3/2022', 34),
  ];

  List<_SalesData> dataColumn = [
    _SalesData('Tháng 1/2022', 10),
    _SalesData('Tháng 2/2022', 20),
    _SalesData('Tháng 3/2022', 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demo chart'),
        ),
        body: Column(
          children: [
            Expanded(
              child: _LineMixBarChar(dataColumn: dataColumn, data: data),
            ),
            const _Note()
          ],
        ));
  }
}

class _Note extends StatelessWidget {
  const _Note({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 20,
                  color: Colors.orange,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Dư nợ cho vay",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 20,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Lãi đã thu",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LineMixBarChar extends StatelessWidget {
  const _LineMixBarChar({
    Key? key,
    required this.dataColumn,
    required this.data,
  }) : super(key: key);

  final List<_SalesData> dataColumn;
  final List<_SalesData> data;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        // thêm 1 cột
        axes: [
          CategoryAxis(
            // đảo vị trí
            opposedPosition: true,
            // gán name vào cột chú thích
            name: 'y2',
          )
        ],
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          isVisible: true,
        ),
        primaryYAxis: CategoryAxis(),
        title: ChartTitle(text: 'Biểu đồ cho vay'),
        // bật chú thích
        // legend: Legend(isVisible: true),
        // bật tooltip
        tooltipBehavior: TooltipBehavior(
            enable: true,
            color: Colors.white,
            textStyle: const TextStyle(color: Colors.black),
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              Color color = Colors.yellow;
              if (series is ColumnSeries<_SalesData, String>) {
                color = series.color ?? Colors.yellow;
              } else if (series is LineSeries<_SalesData, String>) {
                color = series.color ?? Colors.yellow;
              }
              _SalesData sale = data as _SalesData;
              return _TooltipCustom(color: color, sale: sale);
            }),
        series: <ChartSeries<_SalesData, String>>[
          ColumnSeries<_SalesData, String>(
              dataSource: dataColumn,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Dư nợ cho vay',
              // bật label
              dataLabelSettings: const DataLabelSettings(
                isVisible: false,
              ),
              color: Colors.green,
              animationDuration: 2000,
              // bind với cột name là
              yAxisName: 'y2'),
          LineSeries<_SalesData, String>(
            animationDuration: 2000,
            dataSource: data,
            xValueMapper: (_SalesData sales, _) => sales.year,
            yValueMapper: (_SalesData sales, _) => sales.sales,
            name: 'Số tiền giải ngân',
            // bật label
            dataLabelSettings: const DataLabelSettings(
              isVisible: false,
            ),
            color: Colors.orange,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              color: Colors.orange,
            ),
          ),
        ]);
  }
}

class _TooltipCustom extends StatelessWidget {
  const _TooltipCustom({
    Key? key,
    required this.color,
    required this.sale,
  }) : super(key: key);

  final Color color;
  final _SalesData sale;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: color)),
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Text(
              sale.year,
              style: const TextStyle(fontSize: 8),
            ),
            const Divider(
              height: 2,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  ),
                  Expanded(
                    child: Text(
                      "Số tiền giải ngân: ${sale.sales}",
                      style: const TextStyle(fontSize: 8),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
