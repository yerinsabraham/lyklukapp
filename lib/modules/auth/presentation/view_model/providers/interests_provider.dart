import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/auth/data/models/user_interest_model.dart';
import 'package:lykluk/modules/auth/data/repository/impl/auth_repo_impl.dart';

final interestProvider= FutureProvider<List<UserInterestModel>>((ref)async{
   final result = await ref.read(authRepoProvider).getInterests();
    return result.fold(
      (l) => Future.error(l),
      (r) =>  r.data
    );
});