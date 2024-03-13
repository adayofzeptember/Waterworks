// ignore_for_file: must_be_immutable

part of 'search_bloc.dart';

// เก็บค่าไว้เปลี่ยนแปลง
class SearchState extends Equatable {
  List searchResult;
  bool isLoading;
  String statusSearch;
  String error;
  SearchState(
      {required this.searchResult,
      required this.isLoading,
      required this.statusSearch,
      required this.error});

  SearchState copyWith(
      {List? searchResult,
      bool? isLoading,
      String? statusSearch,
      String? error}) {
    return SearchState(
        searchResult: searchResult ?? this.searchResult,
        isLoading: isLoading ?? this.isLoading,
        statusSearch: statusSearch ?? this.statusSearch,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [searchResult, isLoading, statusSearch];
}

// class SearchInitial extends SearchState {}
