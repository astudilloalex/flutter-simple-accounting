import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/accounting_seat_detail/application/accounting_seat_detail_service.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';

class SeatDetailCubit extends Cubit<SeatDetail> {
  SeatDetailCubit(this.id) : super(const SeatDetail()) {
    _loadById(id);
  }

  final String id;

  final AccountingSeatDetailService _service =
      getIt<AccountingSeatDetailService>();

  Future<void> _loadById(String id) async {
    final List<AccountingSeatDetail> details = [];
    try {
      details.addAll(await _service.getBySeatId(id));
      details.sort((a, b) {
        if (a.credit != b.credit) {
          return Decimal.parse(a.credit).compareTo(Decimal.parse(b.credit));
        }
        return Decimal.parse(a.debit).compareTo(Decimal.parse(b.debit));
      });
      emit(state.copyWith(details: details));
    } finally {}
  }
}

class SeatDetail {
  const SeatDetail({
    this.details = const [],
  });

  final List<AccountingSeatDetail> details;

  SeatDetail copyWith({
    List<AccountingSeatDetail>? details,
  }) {
    return SeatDetail(
      details: details ?? this.details,
    );
  }
}
