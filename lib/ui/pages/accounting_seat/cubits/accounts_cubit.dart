import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accounting/app/services/get_it_service.dart';
import 'package:simple_accounting/src/financial_account/application/financial_account_service.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account.dart';

class AccountsCubit extends Cubit<List<FinancialAccount>> {
  AccountsCubit() : super([]);

  final FinancialAccountService _service = getIt<FinancialAccountService>();

  Future<void> loadByType(AccountTypeEnum type) async {
    emit(await _service.getByType(type));
  }
}
