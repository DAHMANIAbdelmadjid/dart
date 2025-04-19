import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    ),
    home: const GraphPlotterPage(),
  );
}

class GraphPlotterPage extends StatefulWidget {
  const GraphPlotterPage({super.key});
  @override
  State<GraphPlotterPage> createState() => _GraphPlotterPageState();
}

class _GraphPlotterPageState extends State<GraphPlotterPage> with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  final List<PlottedFunction> _functions = [];
  String? _errorMessage;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  
  double _zoomLevel = 1.0;
  double get _minX => -10 * _zoomLevel;
  double get _maxX => 10 * _zoomLevel;
  double get _minY => -10 * _zoomLevel;
  double get _maxY => 10 * _zoomLevel;
  
  static const _colors = [
    Colors.blue, Colors.red, Colors.green, Colors.purple,
    Colors.orange, Colors.teal, Colors.pink, Colors.indigo,
  ];
  
  static const _examples = [
    'x^2', 'sin(x)', 'cos(x)'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _plotGraph(String expression, {bool replot = false}) {
    if (expression.isEmpty) {
      setState(() => _errorMessage = 'Please enter a function');
      return;
    }

    try {
      final parser = Parser();
      final exp = parser.parse(expression);
      List<FlSpot> points = [];
      double? lastY;
      
      for (double x = _minX; x <= _maxX; x += (_maxX - _minX) / 500) {
        try {
          final y = exp.evaluate(EvaluationType.REAL, 
            ContextModel()..bindVariable(Variable('x'), Number(x))
          ).toDouble();
          
          if (y.isFinite && y.abs() < 1e6) {
            if (lastY != null && (y - lastY).abs() > (_maxY - _minY)) {
              points.add(FlSpot(x, double.nan));
            } else {
              points.add(FlSpot(x, y));
            }
            lastY = y;
          } else {
            points.add(FlSpot(x, y.isFinite ? y.sign * 1e6 : double.nan));
            lastY = null;
          }
        } catch (_) {
          points.add(FlSpot(x, double.nan));
          lastY = null;
        }
      }

      setState(() {
        if (!replot) {
          _functions.add(PlottedFunction(
            expression: expression,
            points: points,
            color: _colors[_functions.length % _colors.length],
          ));
          _controller.clear();
        } else if (_functions.isNotEmpty) {
          _functions.last = PlottedFunction(
            expression: _functions.last.expression,
            points: points,
            color: _functions.last.color,
          );
        }
        _errorMessage = null;
      });
      
      if (!replot) {
        _animationController.forward(from: 0);
      }
    } catch (_) {
      setState(() => _errorMessage = 'Invalid expression');
    }
  }

  void _handleZoom(bool zoomIn) {
    setState(() {
      _zoomLevel = (_zoomLevel * (zoomIn ? 1/1.5 : 1.5))
        .clamp(0.5, 5.0);
      if (_functions.isNotEmpty) {
        _plotGraph(_functions.last.expression, replot: true);
      }
    });
  }

  Widget _buildFunctionChip(int index) => Chip(
    label: Text('y = ${_functions[index].expression}',
      style: const TextStyle(fontSize: 12),
    ),
    backgroundColor: _functions[index].color.withOpacity(0.1),
    side: BorderSide(color: _functions[index].color),
    deleteIcon: const Icon(Icons.close, size: 16),
    onDeleted: () => setState(() => _functions.removeAt(index)),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Graph Plotter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _zoomLevel = 1.0;
                if (_functions.isNotEmpty) {
                  _plotGraph(_functions.last.expression, replot: true);
                }
              });
            },
            tooltip: 'Reset Zoom',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => setState(() {
              _functions.clear();
              _controller.clear();
              _errorMessage = null;
            }),
            tooltip: 'Clear All',
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter Function',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Try x^2, sin(x), or cos(x)',
                          errorText: _errorMessage,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add_chart),
                            onPressed: () => _plotGraph(_controller.text),
                            tooltip: 'Add Function',
                          ),
                        ),
                        onSubmitted: _plotGraph,
                      ),
                      if (_functions.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Plotted Functions',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (var i = 0; i < _functions.length; i++)
                              _buildFunctionChip(i),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var func in _examples)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ActionChip(
                                  label: Text('y = $func'),
                                  onPressed: () => _plotGraph(func),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.zoom_in),
                          onPressed: () => _handleZoom(true),
                          tooltip: 'Zoom In',
                        ),
                        Container(
                          height: 24,
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                        IconButton(
                          icon: const Icon(Icons.zoom_out),
                          onPressed: () => _handleZoom(false),
                          tooltip: 'Zoom Out',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FadeTransition(
                      opacity: _animation,
                      child: GestureDetector(
                        onDoubleTap: () => _handleZoom(true),
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              for (var function in _functions)
                                LineChartBarData(
                                  spots: function.points,
                                  isCurved: true,
                                  barWidth: 3,
                                  color: function.color,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: function.color.withOpacity(0.1),
                                  ),
                                  preventCurveOverShooting: true,
                                  isStrokeCapRound: true,
                                ),
                            ],
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              horizontalInterval: _zoomLevel * 2,
                              drawVerticalLine: true,
                              verticalInterval: _zoomLevel * 2,
                              getDrawingHorizontalLine: (_) => FlLine(
                                color: Colors.grey.shade300,
                                strokeWidth: 1,
                              ),
                              getDrawingVerticalLine: (_) => FlLine(
                                color: Colors.grey.shade300,
                                strokeWidth: 1,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  interval: _zoomLevel * 2,
                                  getTitlesWidget: (value, _) => Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  interval: _zoomLevel * 2,
                                  getTitlesWidget: (value, _) => Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            minX: _minX,
                            maxX: _maxX,
                            minY: _minY,
                            maxY: _maxY,
                            clipData:const FlClipData.all(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlottedFunction {
  final String expression;
  final List<FlSpot> points;
  final Color color;

  const PlottedFunction({
    required this.expression,
    required this.points,
    required this.color,
  });
}
