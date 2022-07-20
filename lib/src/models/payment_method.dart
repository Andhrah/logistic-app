class PaymentMethods {
  PaymentMethods({
    required this.key,
    required this.value,
  });

  final String key;
  final String value;
  
}

List paymentMethods = [
  'Debit Cards',
  'bank transfer',
  'wallet',
  'Zebrra',
  'Pay on delivery',
];