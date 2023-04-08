import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat.dart';
import 'package:simple_accounting/src/accounting_seat/domain/accounting_seat_repository.dart';
import 'package:simple_accounting/src/accounting_seat_detail/domain/accounting_seat_detail.dart';
import 'package:simple_accounting/src/financial_account/domain/account_type_enum.dart';

class FirestoreAccountingSeatRepository implements IAccountingSeatRepository {
  const FirestoreAccountingSeatRepository();

  @override
  Future<AccountingSeat> save(AccountingSeat entity, String uid) async {
    final List<AccountingSeatDetail> details = [];
    AccountingSeat saved = AccountingSeat(date: DateTime.now());
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Save the seat.
      final DocumentReference<Map<String, dynamic>> seatDoc =
          _collection(uid).doc();
      saved = AccountingSeat(
        date: entity.date,
        description: entity.description,
        id: seatDoc.id,
        total: entity.total,
        type: entity.type,
      );
      // Read the first data for update accounts.
      final DocumentSnapshot<Map<String, dynamic>> assets =
          await _summaryCollection(uid).doc(AccountTypeEnum.assets.name).get();
      final DocumentSnapshot<Map<String, dynamic>> liabilities =
          await _summaryCollection(uid)
              .doc(AccountTypeEnum.liabilities.name)
              .get();
      final DocumentSnapshot<Map<String, dynamic>> patrimony =
          await _summaryCollection(uid)
              .doc(AccountTypeEnum.patrimony.name)
              .get();
      final DocumentSnapshot<Map<String, dynamic>> incomes =
          await _summaryCollection(uid).doc(AccountTypeEnum.incomes.name).get();
      final DocumentSnapshot<Map<String, dynamic>> expenses =
          await _summaryCollection(uid)
              .doc(AccountTypeEnum.expenses.name)
              .get();
      // Get the debit and credit for each account.
      // Assets
      Decimal assetsDebit = assets.exists
          ? Decimal.parse(assets.get('debit').toString())
          : Decimal.zero;
      Decimal assetsCredit = assets.exists
          ? Decimal.parse(assets.get('credit').toString())
          : Decimal.zero;
      // Liabilities
      Decimal liabilitiesDebit = liabilities.exists
          ? Decimal.parse(liabilities.get('debit').toString())
          : Decimal.zero;
      Decimal liabilitiesCredit = liabilities.exists
          ? Decimal.parse(liabilities.get('credit').toString())
          : Decimal.zero;
      // Patrimony
      Decimal patrimonyDebit = patrimony.exists
          ? Decimal.parse(patrimony.get('debit').toString())
          : Decimal.zero;
      Decimal patrimonyCredit = patrimony.exists
          ? Decimal.parse(patrimony.get('credit').toString())
          : Decimal.zero;
      // Incomes
      Decimal incomesDebit = incomes.exists
          ? Decimal.parse(incomes.get('debit').toString())
          : Decimal.zero;
      Decimal incomesCredit = incomes.exists
          ? Decimal.parse(incomes.get('credit').toString())
          : Decimal.zero;
      // Expenses
      Decimal expensesDebit = expenses.exists
          ? Decimal.parse(expenses.get('debit').toString())
          : Decimal.zero;
      Decimal expensesCredit = expenses.exists
          ? Decimal.parse(expenses.get('credit').toString())
          : Decimal.zero;
      // Save the account details
      for (final AccountingSeatDetail element in entity.accountDetails) {
        final DocumentReference<Map<String, dynamic>> detailDoc =
            _detailCollection(uid).doc();
        final AccountingSeatDetail detailSaved = AccountingSeatDetail(
          account: element.account,
          credit: element.credit,
          debit: element.debit,
          id: detailDoc.id,
          seat: saved,
        );
        switch (element.account.accountType) {
          case AccountTypeEnum.assets:
            assetsDebit += Decimal.parse(element.debit);
            assetsCredit += Decimal.parse(element.credit);
            break;
          case AccountTypeEnum.liabilities:
            liabilitiesCredit += Decimal.parse(element.credit);
            liabilitiesDebit += Decimal.parse(element.debit);
            break;
          case AccountTypeEnum.patrimony:
            patrimonyCredit += Decimal.parse(element.credit);
            patrimonyDebit += Decimal.parse(element.debit);
            break;
          case AccountTypeEnum.incomes:
            incomesCredit += Decimal.parse(element.credit);
            incomesDebit += Decimal.parse(element.debit);
            break;
          case AccountTypeEnum.expenses:
            expensesCredit += Decimal.parse(element.credit);
            expensesDebit += Decimal.parse(element.debit);
            break;
        }
        transaction.set(detailDoc, detailSaved.toJson());
        details.add(detailSaved);
      }
      transaction.set(seatDoc, saved.toJson());
      // Save assets
      transaction.set(
        assets.reference,
        {
          'credit': '${assetsCredit.toDouble()}',
          'debit': '${assetsDebit.toDouble()}',
        },
      );
      // Save liabilities.
      transaction.set(
        liabilities.reference,
        {
          'credit': '${liabilitiesCredit.toDouble()}',
          'debit': '${liabilitiesDebit.toDouble()}',
        },
      );
      // Save patrimony
      transaction.set(
        patrimony.reference,
        {
          'credit': '${patrimonyCredit.toDouble()}',
          'debit': '${patrimonyDebit.toDouble()}',
        },
      );
      // Save incomes
      transaction.set(
        incomes.reference,
        {
          'credit': '${incomesCredit.toDouble()}',
          'debit': '${incomesDebit.toDouble()}',
        },
      );
      // Save expenses
      transaction.set(
        expenses.reference,
        {
          'credit': '${expensesCredit.toDouble()}',
          'debit': '${expensesDebit.toDouble()}',
        },
      );
    });
    // Save the details
    return saved.copyWith(accountDetails: details);
  }

  @override
  Future<AccountingSeat> update(AccountingSeat entity, String uid) {
    // TODO: implement update
    throw UnimplementedError();
  }

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountseats');
  }

  CollectionReference<Map<String, dynamic>> _detailCollection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountseatdetails');
  }

  CollectionReference<Map<String, dynamic>> _summaryCollection(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('accountsummary');
  }
}
