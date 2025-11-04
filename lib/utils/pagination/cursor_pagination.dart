// ignore_for_file: depend_on_referenced_packages, implementation_imports, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:core';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:riverpod/src/async_notifier.dart';

import '../../core/services/services.dart';
import '../../core/shared/providers/auth_status_provider.dart';

// ignore: invalid_use_of_internal_member
mixin CursorPaginationController<T>
    // ignore: invalid_use_of_internal_member
    on AsyncNotifierBase<CursorPaginatedResponse<T>> {
  /// set to know if it enbles caching
  bool enableCache = false;

  /// load data
  FutureOr<CursorPaginatedResponse<T>> loadData(CursorPaginatedRequest request);

  /// load more data and insert it to the beginning of the current data list
  Future<void> loadMore() async {
    final oldState = state;
    if (oldState.requireValue.isCompleted) return;
    state = AsyncLoading<CursorPaginatedResponse<T>>().copyWithPrevious(
      oldState,
    );
    state = await AsyncValue.guard<CursorPaginatedResponse<T>>(() async {
      final res = await loadData(oldState.requireValue.nextPage());
      res.dataList.insertAll(0, oldState.requireValue.dataList);
      return res;
    });
  }

  /// check if there is more data to load
  bool canLoadMore() {
    if (state.isLoading) return false;
    if (!state.hasValue) return false;
    if (state.requireValue.isCompleted) return false;
    return true;
  }

  /// listen to network state and refresh provider if network is back and there is an error
  void onNetworkStateChanged() {
    InternetConnection().onStatusChange.listen((status) {
      // log.d('NETWORK STATE: ${status.toString()}');
      if (status == InternetStatus.connected && state.hasError) {
        log.d('REFRESH PROVIDER:${state.runtimeType} ');
        ref.invalidateSelf(); // Refresh provider if network is back
      }
    });
  }

  /// listen to auth state and refresh provider if user is authenticated

  void onAuthStateChanged({bool canRefreshSelf = false}) {
    ref.listen(authStateProvider, (p, n) {
      if (n == false) {
        log.d('UNAUTHENTICATED: REFRESH PROVIDER:${state.runtimeType} ');

        /// reset provider to initial state
        reset();
      } else {
        log.d('AUTHENTICATED: REFRESH PROVIDER:${state.runtimeType} ');
        if (canRefreshSelf) ref.invalidateSelf();
      }
    });
  }

  void onAuthStateRefresh() {
    ref.listen(authStateProvider, (p, n) {
     if(p != n){
       ref.invalidateSelf();
     }
    });
  }

  void reset() {
    state = AsyncValue.data(CursorPaginatedResponse.emptyPaginatedResponse());
  }

  /// update the list by finding and replacing  used mostly during updating
  void findAndReplace({
    required T model,
    bool Function(T)? test,
    bool? addAnyWhere = false,
  }) {
    if (state.valueOrNull == null) {
      ref.invalidateSelf();
      return;
    }
    final values = state.requireValue.dataList;
    final index = values.indexWhere(
      test ?? (s) => (s as dynamic).id == (model as dynamic).id,
    );
    if (index != -1) {
      values[index] = model;
      state = AsyncData(state.requireValue.copyWith(dataList: values));
    } else {
      log.d('unable to find item');
      if (addAnyWhere == true) {
        values.add(model);
        state = AsyncData(state.requireValue.copyWith(dataList: values));
      }
    }
  }

  /// update list by adding to top new created item
  void addTop(T model) {
    if (state.valueOrNull == null) {
      ref.invalidateSelf();
      return;
    }
    final values = state.requireValue.dataList;
    values.insert(0, model);
    state = AsyncData(state.requireValue.copyWith(dataList: values));
  }

  /// update list by adding to top new created item
  void addBottom(T model) {
    if (state.valueOrNull == null) {
      ref.invalidateSelf();
      return;
    }
    final values = state.requireValue.dataList;
    values.add(model);
    state = AsyncData(state.requireValue.copyWith(dataList: values));
  }

  void findAndDelete(String id, [bool Function(T)? test]) {
    if (state.valueOrNull == null) {
      ref.invalidateSelf();
      return;
    }
    final values = state.requireValue.dataList;
    values.removeWhere(test ?? (s) => (s as dynamic).id == id);
    state = AsyncData(state.requireValue.copyWith(dataList: values));
  }

  /// update with test functions
  void findAndUpdate({
    required bool Function(T item) where,
    required T Function(T item) update,
  }) {
    if (state.valueOrNull == null ||
        state.valueOrNull?.dataList.isEmpty == true) {
      ref.invalidateSelf();
      return;
    }
    final list = state.requireValue.dataList;
    final newList =
        list.map((item) {
          if (where(item)) {
            return update(item);
          } else {
            return item;
          }
        }).toList();
    state = AsyncData(state.requireValue.copyWith(dataList: newList));
  }
}

class CursorPaginatedRequest {
  final int? cursor;
  final bool stop;
  final Map<String, dynamic>? extraMap;
  final String? keyword;

  CursorPaginatedRequest({
    this.extraMap,
    this.cursor,
    this.stop = false,
    this.keyword,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "keyword": keyword,
      "cursor": cursor,
      ...?extraMap,
    }.removeNullValues;
  }
}

class CursorPaginatedResponse<T> {
  List<T> dataList;
  String? keyword;
  int totalItems;
  int? cursor;
  bool? stop;
  Map<String, dynamic>? extraMap;

  CursorPaginatedResponse({
    required this.dataList,
    this.cursor,
    this.extraMap,
    this.totalItems = 0,
    this.keyword,
    this.stop,
  });

  CursorPaginatedResponse<T> copyWith({
    List<T>? dataList,
    Map<String, dynamic>? extraMap,
    String? keyword,
    int? cursor,
    bool? stop,
  }) {
    return CursorPaginatedResponse<T>(
      dataList: dataList ?? this.dataList,
      stop: stop ?? this.stop,
      cursor: cursor ?? this.cursor,
      extraMap: extraMap ?? this.extraMap,
      keyword: keyword ?? this.keyword,
      totalItems: totalItems,
    );
  }

  bool get isCompleted => (stop ?? true) == true;
  CursorPaginatedRequest nextPage() => CursorPaginatedRequest(
    cursor: cursor,
    stop: stop ?? false,
    extraMap: extraMap,
    keyword: keyword,
  );

  factory CursorPaginatedResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(Object?) dataFromJson,
    required String paginationfieldName,
    required String dataFieldName,
    String? keyword,
    bool Function(T)? filter,
    Map<String, dynamic>? lastEvaluatedKey,
    int? totalItems,
    Map<String, dynamic>? extraMap,
    bool fromCache = false,
  }) => CursorPaginatedResponse(
    totalItems: totalItems ?? (json[dataFieldName] as List).length,
    // totalItems: totalItems ?? 0,
    dataList:
        filter == null
            ? ((json[dataFieldName] ?? []) as List<dynamic>)
                .map(dataFromJson)
                .toList()
            : ((json[dataFieldName] ?? []) as List<dynamic>)
                .map(dataFromJson)
                .toList()
                .where(filter)
                .toList(),

    keyword: keyword,
    cursor: json[paginationfieldName] as int?,
    extraMap: extraMap,
    stop: json['stop'] ?? true,
  );

  factory CursorPaginatedResponse.emptyPaginatedResponse() =>
      CursorPaginatedResponse<T>(dataList: [], extraMap: null, totalItems: 0);
}

extension PaginationExt on Map<String, dynamic> {
  /// remove page values
  Map<String, dynamic> get removePageValues {
    final value = this;
    value.remove('pageSize');
    value.remove('lastEvaluatedKey');
    return value;
  }
}
