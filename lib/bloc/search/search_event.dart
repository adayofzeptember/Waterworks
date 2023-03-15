part of 'search_bloc.dart';

// get values from UI
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchNumber extends SearchEvent {
  var context;
  String searchNumber;
  SearchNumber({
    required this.searchNumber,
  });
}

class ClearSearch extends SearchEvent {
  // var context;
  ClearSearch();
}
