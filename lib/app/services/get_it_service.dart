import 'package:get_it/get_it.dart';
import 'package:simple_accounting/src/accounting_seat/application/accounting_seat_service.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat_repository.dart';
import 'package:simple_accounting/src/accounting_seat/infrastructure/firestore_accounting_seat_repository.dart';
import 'package:simple_accounting/src/auth/application/auth_service.dart';
import 'package:simple_accounting/src/auth/domain/auth_repository.dart';
import 'package:simple_accounting/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:simple_accounting/src/financial_account/application/financial_account_service.dart';
import 'package:simple_accounting/src/financial_account/domain/financial_account_repository.dart';
import 'package:simple_accounting/src/financial_account/infrastructure/firestore_financial_account_repository.dart';

GetIt getIt = GetIt.instance;

void setUpGetIt() {
  // Singletons
  getIt.registerSingleton<IAuthRepository>(const FirebaseAuthRepository());
  getIt.registerSingleton<IFinancialAccountRepository>(
    const FirestoreFinancialAccountRepository(),
  );
  getIt.registerSingleton<IAccountingSeatRepository>(
    const FirestoreAccountingSeatRepository(),
  );
  // Lazy singletons
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<IAuthRepository>()),
  );
  // Factory
  getIt.registerFactory<FinancialAccountService>(
    () => FinancialAccountService(
      getIt<IFinancialAccountRepository>(),
    ),
  );
  getIt.registerFactory<AccountingSeatService>(
    () => AccountingSeatService(
      getIt<IAccountingSeatRepository>(),
    ),
  );
}
