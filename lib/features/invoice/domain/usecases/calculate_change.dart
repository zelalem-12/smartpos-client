/// Calculates the cash change owed to a buyer.
class CalculateChange {
  const CalculateChange();

  /// Returns [cashTendered] - [total] when [cashTendered] is at least [total],
  /// otherwise zero.
  double call(double total, double cashTendered) {
    if (cashTendered <= total) return 0.0;
    return cashTendered - total;
  }
}
