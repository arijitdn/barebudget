class Transaction {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final String type; // 'income' or 'expense'
  final DateTime date;
  final String? description;
  final String currency;
  final bool isRecurring;
  final String? recurringType; // 'daily', 'weekly', 'monthly', 'yearly'

  Transaction({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.description,
    this.currency = 'INR',
    this.isRecurring = false,
    this.recurringType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'type': type,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'currency': currency,
      'isRecurring': isRecurring ? 1 : 0,
      'recurringType': recurringType,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      type: map['type'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      description: map['description'],
      currency: map['currency'] ?? 'INR',
      isRecurring: map['isRecurring'] == 1,
      recurringType: map['recurringType'],
    );
  }

  Transaction copyWith({
    int? id,
    String? title,
    double? amount,
    String? category,
    String? type,
    DateTime? date,
    String? description,
    String? currency,
    bool? isRecurring,
    String? recurringType,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      type: type ?? this.type,
      date: date ?? this.date,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringType: recurringType ?? this.recurringType,
    );
  }
}
