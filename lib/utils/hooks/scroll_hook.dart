import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preload_page_view/preload_page_view.dart';

ScrollController usePagination(
  VoidCallback fetchData,
  bool Function() canLoadMore, {
  double scrollLevel = 0.8,
}) {
  final scrollController = useScrollController();

  void scrollListener() {
    if (canLoadMore() &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * scrollLevel) {
      fetchData();
    }
  }

  useEffect(() {
    scrollController.addListener(scrollListener);
    return null;
  }, [scrollController]);

  return scrollController;
}

PageController usePagePagination(
  VoidCallback fetchData,
  bool Function() canLoadMore, {
  double scrollLevel = 0.7,
  int? initialPage,
}) {
  final pageController = usePageController(initialPage: initialPage ?? 0);

  void scrollListener() {
    if (canLoadMore() &&
        pageController.position.pixels >=
            pageController.position.maxScrollExtent * scrollLevel) {
      fetchData();
    }
  }

  useEffect(() {
    pageController.addListener(scrollListener);
    return null;
  }, [pageController]);

  return pageController;
}

PreloadPageController usePreloadPagination(
  VoidCallback fetchData,
  bool Function() canLoadMore, {
  double scrollLevel = 0.7,
  int? initialPage,
}) {
  final pageController = PreloadPageController(initialPage: initialPage ?? 0);

  void scrollListener() {
    if (canLoadMore() &&
        pageController.position.pixels >=
            pageController.position.maxScrollExtent * scrollLevel) {
      fetchData();
    }
  }

  useEffect(() {
    pageController.addListener(scrollListener);
    return null;
  }, [pageController]);

  return pageController;
}
