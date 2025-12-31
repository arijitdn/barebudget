import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart' as app_models;
import '../services/database_service.dart';
import '../widgets/balance_card.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/quick_stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<app_models.Transaction> _todayTransactions = [];
  List<app_models.Transaction> _recentTransactions = [];
  double _totalBalance = 0;
  double _todayExpenses = 0;
  double _monthlyIncome = 0;
  double _monthlyExpenses = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0);

    // Get today's transactions
    final todayTransactions = await DatabaseService.getTransactionsByDateRange(
      today,
      tomorrow.subtract(const Duration(milliseconds: 1)),
    );

    // Get this month's transactions
    final monthlyTransactions =
        await DatabaseService.getTransactionsByDateRange(monthStart, monthEnd);

    // Get recent transactions (last 10)
    final allTransactions = await DatabaseService.getTransactions();
    final recentTransactions = allTransactions.take(10).toList();

    // Calculate totals
    double totalIncome = allTransactions
        .where((t) => t.type == 'income')
        .fold(0, (sum, t) => sum + t.amount);
    double totalExpenses = allTransactions
        .where((t) => t.type == 'expense')
        .fold(0, (sum, t) => sum + t.amount);

    double todayExpenses = todayTransactions
        .where((t) => t.type == 'expense')
        .fold(0, (sum, t) => sum + t.amount);

    double monthlyIncome = monthlyTransactions
        .where((t) => t.type == 'income')
        .fold(0, (sum, t) => sum + t.amount);
    double monthlyExpenses = monthlyTransactions
        .where((t) => t.type == 'expense')
        .fold(0, (sum, t) => sum + t.amount);

    setState(() {
      _todayTransactions = todayTransactions;
      _recentTransactions = recentTransactions;
      _totalBalance = totalIncome - totalExpenses;
      _todayExpenses = todayExpenses;
      _monthlyIncome = monthlyIncome;
      _monthlyExpenses = monthlyExpenses;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('BareBudget'),
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Card
                    BalanceCard(
                      balance: _totalBalance,
                      todayExpenses: _todayExpenses,
                    ),

                    const SizedBox(height: 24),

                    // Quick Stats
                    QuickStats(
                      monthlyIncome: _monthlyIncome,
                      monthlyExpenses: _monthlyExpenses,
                      todayTransactions: _todayTransactions.length,
                    ),

                    const SizedBox(height: 24),

                    // Recent Transactions
                    RecentTransactions(
                      transactions: _recentTransactions,
                      onRefresh: _loadData,
                    ),

                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
    );
  }
}
