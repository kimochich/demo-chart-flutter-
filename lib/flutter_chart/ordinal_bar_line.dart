// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of an ordinal combo chart with two series rendered as bars, and a
/// third rendered as a line.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_common/src/common/text_measurement.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart' as element;
import 'package:test_project/flutter_chart/text_custom_symbol.dart';

class OrdinalComboBarLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  OrdinalComboBarLineChart(this.seriesList, {this.animate = false});

  factory OrdinalComboBarLineChart.withSampleData() {
    return OrdinalComboBarLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory OrdinalComboBarLineChart.withRandomData() {
    return OrdinalComboBarLineChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      OrdinalSales('2014', random.nextInt(100)),
      OrdinalSales('2015', random.nextInt(100)),
      OrdinalSales('2016', random.nextInt(100)),
      OrdinalSales('2017', random.nextInt(100)),
    ];

    final tableSalesData = [
      OrdinalSales('2014', random.nextInt(100)),
      OrdinalSales('2015', random.nextInt(100)),
      OrdinalSales('2016', random.nextInt(100)),
      OrdinalSales('2017', random.nextInt(100)),
    ];

    final mobileSalesData = [
      OrdinalSales('2014', random.nextInt(100)),
      OrdinalSales('2015', random.nextInt(100)),
      OrdinalSales('2016', random.nextInt(100)),
      OrdinalSales('2017', random.nextInt(100)),
    ];

    return [
      // charts.Series<OrdinalSales, String>(
      //     id: 'Desktop',
      //     colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //     domainFn: (OrdinalSales sales, _) => sales.year,
      //     measureFn: (OrdinalSales sales, _) => sales.sales,
      //     data: desktopSalesData),
      // charts.Series<OrdinalSales, String>(
      //     id: 'Tablet',
      //     colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      //     domainFn: (OrdinalSales sales, _) => sales.year,
      //     measureFn: (OrdinalSales sales, _) => sales.sales,
      //     data: tableSalesData),
      charts.Series<OrdinalSales, String>(
          id: 'Mobile',
          colorFn: (_, __) => charts.Color.black,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }

  // EXCLUDE_FROM_GALLERY_DOCS_EN
  TextSymbolRenderer textSymbolRenderer = TextSymbolRenderer();

  @override
  Widget build(BuildContext context) {
    return charts.OrdinalComboChart(
      seriesList, animate: true,
      // Configure the default renderer as a bar renderer.
      // defaultRenderer: charts.BarRendererConfig(
      //     customRendererId: "customBar"
      //     ),
      // Custom renderer configuration for the line series. This will be used for
      // any series that does not define a rendererIdKey.
      customSeriesRenderers: [
        charts.LineRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customLine',
            includePoints: true),
        charts.BarRendererConfig(
          // ID used to link series to this renderer.
          customRendererId: 'customBar',
          // includePoints: false
        )
      ],
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.top,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
        ),
        charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
        charts.LinePointHighlighter(
          symbolRenderer: textSymbolRenderer,
          showVerticalFollowLine:
          charts.LinePointHighlighterFollowLineType.none,
        ),
      ],
      selectionModels: [
        charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            final value = model.selectedSeries[0].measureFn(model.selectedDatum[0].index);
            final value2 = model.selectedSeries[0].measureFn(model.selectedDatum[1].index);
            print(">>>>>> value = ${model.selectedSeries.length}");
            textSymbolRenderer.text = value.toString();
            textSymbolRenderer.text2 = value2.toString();
          }
        })
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    final mobileSalesData = [
      OrdinalSales('2014', 10),
      OrdinalSales('2015', 50),
      OrdinalSales('2016', 200),
      OrdinalSales('2017', 150),
    ];

    return [
      // charts.Series<OrdinalSales, String>(
      //     id: 'Desktop',
      //     colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //     domainFn: (OrdinalSales sales, _) => sales.year,
      //     measureFn: (OrdinalSales sales, _) => sales.sales,
      //     data: desktopSalesData),
      charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tableSalesData)
        ..setAttribute(charts.rendererIdKey, 'customBar'),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile ',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      )
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
