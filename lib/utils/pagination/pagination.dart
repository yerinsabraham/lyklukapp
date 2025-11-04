// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/shared/providers/auth_status_provider.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:riverpod/src/async_notifier.dart';

// ignore: invalid_use_of_internal_member
mixin PaginationController<T> on AsyncNotifierBase<PaginatedResponse<T>> {
  FutureOr<PaginatedResponse<T>> loadData(PaginatedRequest request);
  bool hasMore = true;

  Future<void> loadMore() async {
    final oldState = state;
    if (!oldState.hasValue || oldState.requireValue.isCompleted) return;

    state = AsyncLoading<PaginatedResponse<T>>().copyWithPrevious(oldState);
    state = await AsyncValue.guard<PaginatedResponse<T>>(() async {
      final res = await loadData(oldState.requireValue.nextPage());
      res.dataList.insertAll(0, state.requireValue.dataList);
      return res;
    });
  }

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

  void reset() {
    state = AsyncValue.data(PaginatedResponse.empty());
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

class PaginatedRequest {
  final int? page;
  final int? limit;
  final int? total;
  final int? pages;
  final Map<String, dynamic>? filter;

  PaginatedRequest({
    this.page,
    this.limit,
    this.total,
    this.pages,
    this.filter,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      ...?filter,
    }.removeNullValues;
  }
 
}

class PaginatedResponse<T> {
  List<T> dataList;
  String? fieldName;
  int? limit;
  int page;
  int pages;
  int? total;
  Map<String, dynamic>? filters; // <FilterType, dynamic

  PaginatedResponse({
    required this.dataList,
    this.limit=10,
    this.page=1,
    this.total =0,
    this.pages = 1,
     this.fieldName,
    this.filters,
  });

  PaginatedResponse<T> copyWith({
    int? limit,
    int? page,
    int? total,
    String? fieldName,
    List<T>? dataList,
    int? totalElements,
    int? numberOfElements,
    Map<String, dynamic>? filters,
    int? pages,
  }) {
    return PaginatedResponse<T>(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      dataList: dataList ?? this.dataList,
      fieldName: fieldName ?? this.fieldName,
      total: total ?? this.total,
      pages: pages ?? this.pages,
      filters: filters ?? this.filters,
    );
  }

  bool get isCompleted => page >= (pages);
  PaginatedRequest nextPage() => PaginatedRequest(
    page: (page) + 1,
    limit: limit,
    total: total,
    pages: pages,
    filter:  filters,
  );
  factory PaginatedResponse.fromJson({
    int? totalElements,
    int? numberOfElements,
    bool Function(T)? filter,
    required String fieldName,
    String? paginationField,
    required Map<String, dynamic> json,
    required T Function(Object?) dataFromJson,
    Map<String, dynamic>? filters,
  }) => PaginatedResponse(
    fieldName: fieldName,
    dataList:
        filter == null
            ? (json[fieldName] as List<dynamic>).map(dataFromJson).toList()
            : (json[fieldName] as List<dynamic>)
                .map(dataFromJson)
                .toList()
                .where(filter)
                .toList(),
    page: json[paginationField]?['page']?? 1,
    limit: json[paginationField]?['limit']?? 20,
    total: json[paginationField]?['total']?? 0,
    pages: json[paginationField]?['totalPages']?? 0,
   
    filters: filters,
  );

  factory PaginatedResponse.empty() => PaginatedResponse(
    page: 0,
    limit: 10,
    dataList: [],
    total: 0,
    pages : 1,
    fieldName: 'data',
  );
}
