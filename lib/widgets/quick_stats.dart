import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../utils/currency_utils.dart';

class QuickStats extends StatefulWidget {
  final double monthlyIncome;
  final double monthlyExpenses;
  final int todayTransactions;

  const QuickStats({
    super.key,
    required this.monthlyIncome,
    required this.monthlyExpenses,
    required this.todayTransactions,
  });

  @override
  State<QuickStats> createState() => _QuickStatsState();
}

class _QuickStatsState extends State<QuickStats> {
  String _currency = 'INR';

  @override
  void initState() {
    super.initState();
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final currency = await DatabaseService.getDefaultCurrency();
    setState(() {
      _currency = currency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Income',
            value: CurrencyUtils.formatAmount(widget.monthlyIncome, _currency),
            icon: Icons.trending_up,
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF10B981).withOpacity(0.1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Expenses',
            value: CurrencyUtils.formatAmount(
              widget.monthlyExpenses,
              _currency,
            ),
            icon: Icons.trending_down,
            color: const Color(0xFFEF4444),
            backgroundColor: const Color(0xFFEF4444).withOpacity(0.1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Today',
            value: '${widget.todayTransactions}',
            icon: Icons.receipt_long,
            color: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF6366F1).withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
