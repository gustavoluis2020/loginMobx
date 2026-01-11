import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/widgets/privacy_policy_link.dart';
import '../../../../injection_container.dart';
import '../stores/statistics_store.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final StatisticsStore store = sl<StatisticsStore>();

  @override
  void initState() {
    super.initState();
    store.loadStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1D525E), Color(0xFF43767E)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Estatísticas'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Observer(
                        builder: (_) {
                          if (store.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          double totalLettNum = (store.lettersCount + store.numbersCount).toDouble();
                          double lettersY = totalLettNum > 0 ? (store.lettersCount / totalLettNum) * 100 : 0;
                          double numbersY = totalLettNum > 0 ? (store.numbersCount / totalLettNum) * 100 : 0;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Detalhes',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                              const SizedBox(height: 20),
                              _buildStatRow('Quantidade de linhas:', store.lineCount.toString()),
                              const SizedBox(height: 10),
                              _buildStatRow('Quantidade de edições:', store.totalEdits.toString()),
                              const SizedBox(height: 10),
                              _buildStatRow('Caracteres:', store.totalChars.toString()),
                              const SizedBox(height: 10),
                              _buildStatRow('Caracteres (sem espaços):', store.totalCharsNoSpaces.toString()),
                              const SizedBox(height: 10),
                              _buildStatRow('Palavras:', store.wordCount.toString()),
                              const SizedBox(height: 10),
                              _buildStatRow(
                                'Média de caracteres por nota:',
                                store.averageCharsPerNote.toStringAsFixed(1),
                              ),
                              const SizedBox(height: 40),
                              Expanded(
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceEvenly,
                                    maxY: 100,
                                    barTouchData: BarTouchData(
                                      enabled: false,
                                      touchTooltipData: BarTouchTooltipData(
                                        getTooltipColor: (_) => Colors.transparent,
                                        tooltipPadding: EdgeInsets.zero,
                                        tooltipMargin: 15,
                                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                          return BarTooltipItem(
                                            '${rod.toY.round()}%',
                                            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                          );
                                        },
                                      ),
                                    ),
                                    barGroups: [
                                      BarChartGroupData(
                                        x: 0,
                                        showingTooltipIndicators: [0],
                                        barRods: [
                                          BarChartRodData(
                                            toY: lettersY,
                                            color: const Color(0xFF8B0000),
                                            width: 40,
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: const BorderSide(color: Colors.black, width: 2),
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 1,
                                        showingTooltipIndicators: [0],
                                        barRods: [
                                          BarChartRodData(
                                            toY: numbersY,
                                            color: const Color(0xFFEB7D31),
                                            width: 40,
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: const BorderSide(color: Colors.black, width: 2),
                                          ),
                                        ],
                                      ),
                                    ],
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (double value, TitleMeta meta) {
                                            const style = TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            );
                                            Widget text;
                                            switch (value.toInt()) {
                                              case 0:
                                                text = const Text('Letras', style: style);
                                                break;
                                              case 1:
                                                text = const Text('Números', style: style);
                                                break;
                                              default:
                                                text = const Text('', style: style);
                                                break;
                                            }
                                            return SideTitleWidget(meta: meta, space: 4, child: text);
                                          },
                                        ),
                                      ),
                                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    gridData: const FlGridData(show: false),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const PrivacyPolicyLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}
