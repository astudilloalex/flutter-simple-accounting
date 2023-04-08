import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/accounting_seat/application/accounting_seat_service.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/ui/pages/accounting_seat/cubits/accounting_seat.dart';

class AccountingSeatCubit extends Cubit<AccountingSeatData> {
  AccountingSeatCubit() : super(const AccountingSeatData());

  final AccountingSeatService _service = getIt<AccountingSeatService>();

  Future<String?> addSeat(AccountingSeat seat) async {
    await _service.add(seat);
    return null;
  }
}
