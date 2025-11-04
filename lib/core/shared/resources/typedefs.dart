import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/response_data.dart';

typedef FutureEitherVoid = Future<Either<Failure, void>>;
typedef FutureEitherString<T> = Future<Either<Failure<T>, String>>;
typedef FutureEither<T> = Future<Either<Failure<T>, T>>;
typedef FutureResponse<T> = FutureEither<ResponseData<T>>;


typedef LikeCallback = void Function(String reelId);
typedef CommentCallback = void Function(String reelId);
typedef ShareCallback = void Function(String reelId);
typedef FollowCallback = void Function(String authorId);
typedef IndexChangedCallback = void Function(int index);

typedef StringMap<T> = Map<String, T>;
